# 全屏 OCR 能否压到 100 ms：本机验证

2026-10-13，i7-9700 / GTX 1650 4 GB，Windows，ONNX Runtime DirectML 1.24.4。结论：**热运行完整全屏 OCR 的中位数和本次 P95 可以低于 100 ms，但当前是需要准确率验收的候选方案，尚未替换正式程序。**

## 最终候选与复测

采用 PP-OCRv6 tiny 检测 + tiny 识别，两者均 FP32。完整图像检测最长边仍为 960，识别高 48。未使用 ROI、关键词跳过识别或相同帧缓存。完整计时包括检测预处理、检测推理、DB 后处理、透视裁剪、识别预处理、全部文字框的识别、CTC 解码和结果组装；不含 ADB 截图、PNG/磁盘解码、首次模型加载与 GPU 会话编译，也尚未测 C# 集成开销。

每张图先热身 2 次，再测 100 次，串行运行，共 300 次。固定 OpenCV 1 线程，ORT CPU 线程 8，DirectML 顺序执行、关闭 memory pattern，计时期间关闭 profiler。

| 完整截图 | 中位数 | P95 | 最大值 | 超过 100 ms | 检测框数 |
|---|---:|---:|---:|---:|---:|
| 角色页 source.png | 68.5 ms | 88.3 ms | 102.2 ms | 2/100 | 40 |
| 下一层确认 | 68.2 ms | 81.0 ms | 105.6 ms | 2/100 | 27 |
| 贪婪选择混合弹窗 | 67.3 ms | 82.3 ms | 86.3 ms | 0/100 | 40 |

这个结果支持“通常小于 100 ms”，不支持“每一次都小于 100 ms”。更早的默认 OpenCV 线程、每图 50 次测试中，混合弹窗 P95 为 133 ms。两轮背景负载未完全隔离，不能将全部改善严格归因于线程设置。

阶段中位数（ms；各阶段中位数相加不等于总计中位数）：

| 截图 | 检测预处理 | 检测推理 | DB 后处理及识别预处理 | 识别推理及结果归约 | CTC 解码 |
|---|---:|---:|---:|---:|---:|
| 角色页 | 6.9 | 17.2 | 22.3 | 19.5 | 0.8 |
| 下一层确认 | 7.1 | 17.0 | 17.4 | 24.4 | 0.8 |
| 混合弹窗 | 6.1 | 16.5 | 20.1 | 22.4 | 0.8 |

第一张图初始化各输入规格的会话并执行两次热身合计约 1.67 秒，第二张首次遇到新增规格约 0.68 秒。100 ms 结论只适用于已经初始化和预热的规格；首次出现新宽度/批次规格也可能触发会话创建，生产实现需要提前预热常见规格并限制缓存数量。

## 真正有效的优化

1. 模型改为 v6 tiny。仅更换识别模型，保留动态输入与旧预处理时仍约 177–194 ms；单独换模型还不够。
2. 识别按宽高比排序，输入宽度按实际内容向上取 64 的倍数，最小宽 32，不再让每个短文字框至少补到 320。最多 8 个框一批，尾批向上取 1/2/4/8 个输入，减少虚假填充行。每个规格使用固定输入尺寸并复用 ORT 会话，不固定整张检测图的输入图。输入高度与文字内容没有主动裁剪缩短。
3. 在识别 ONNX 图尾部追加 ArgMax + ReduceMax，仅返回逐时间步的字符索引和最高概率，保留 CTC 所需信息与字符平均置信度。识别原始概率矩阵不再全部回传 CPU。静态尺寸使识别图由 DirectML 融合执行：独立的不计时探针，每个规格只有一个 DmlExecutionProvider 执行事件，无 CPU 算子回退；动态 tiny 检测探针为 157 个 DirectML 执行事件。
4. 检测预处理改用 OpenCV blobFromImage 做缩放、均值减法和布局变换，再原地除标准差；仍为 BGR、相同均值/标准差。预处理由约 19 ms 降到约 6–7 ms。

额外一致性核对：三张图的旧/新预处理张量使用 `allclose(atol=1e-6)` 均通过，并且同一 tiny 检测模型输出的检测框完全相同；同一 tiny 识别模型、相同批次输入，原概率矩阵在 CPU 做 argmax/max 与新图的 GPU 归约输出，字符索引逐项相同，置信度使用 `allclose(atol=1e-5)` 均通过。该核对只验证这些计算优化的等价性，不证明 tiny 与旧 v4/v5 模型准确率相同。

固定尺寸有助于 DirectML 优化的依据是 [ORT 官方性能说明](https://onnxruntime.ai/docs/execution-providers/DirectML-ExecutionProvider.html#performance-tuning)。但不是所有固定尺寸都更快：把本机 v5 检测图也固定后，检测阶段从约 29 ms 变成约 122–137 ms，因此最终检测仍使用动态图。

## 准确率边界

换 tiny 检测后，框数由旧 v5 流程的 36/31/43 变为 40/27/40。框数变化既可能来自误检，也可能来自漏检，不能把更少框直接当成更好的检测；没有像素级标注集，尚不能报告检测准确率。

手工查看两张弹窗截图，并核对候选识别结果：

- “是否进入下一层”、警告说明的三行正文均可识别；问号等标点可能不同。
- “返回城镇”“继续探险”“前往下一层”“安全回城”“再考虑一下”均能匹配。其中图标被识别成前缀，例如“凤前往下一层”“过安全回城”，不能宣称所有按钮文本完全正确。
- 标题“贪婪抉择”识别成“含婪块择”，字符平均置信度约 0.85，严格关键文字检查未通过。旧 v4 也有标题错字，但这不能作为新模型免验收的理由。
- 角色页没有逐字人工标注；它的关键文字检查为空，不能把程序返回 true 理解为准确率通过。

因此，当前达成的是性能可行性，尚未同时满足“100 ms + 全屏准确率验收”。建议把该候选接入独立可切换后端，保留原后端兜底，并补充完整截图文字标注、弹窗坐标与点击行为回归。需要更强准确率时，应优先尝试游戏字体/文本微调或明确触发的局部识别复核；复核耗时必须计入最终延迟，不能预先承诺仍为 100 ms。

## 未采用的路线

- FP16 没有稳定比 FP32 更快，且检测文字框会变化。例如 v5 检测的角色页框数从 36 变为 39，下一层从 31 变为 34；最终候选不用 FP16。
- 单纯增大批次或固定检测输入没有达到目标。一次 v4 batch 16 测试进程异常退出，尚未定位，未纳入候选；本机显存背景占用也较高，测试时观测到约 3.0–3.3 GB / 4 GB 总占用，不能直接归因于显存耗尽。
- 保留 v5 检测、tiny 识别及紧凑输出时，某些长文本批次仍使下一层截图约 139 ms，三张图不能稳定达标。

## 模型与复现

官方模型链接来自 [PaddleOCR 识别模型文档](https://github.com/PaddlePaddle/PaddleOCR/blob/main/docs/version3.x/module_usage/text_recognition.en.md) 与官方 Paddle 模型仓库。下载地址：

- [v6 tiny 识别模型](https://paddle-model-ecology.bj.bcebos.com/paddlex/official_inference_model/paddle3.0.0/PP-OCRv6_tiny_rec_infer.tar)
- [v6 tiny 检测模型](https://paddle-model-ecology.bj.bcebos.com/paddlex/official_inference_model/paddle3.0.0/PP-OCRv6_tiny_det_infer.tar)

inference.pdiparams SHA256：

- rec: `BB2F8F54D1E25F28C71B6FA4FE23F5940E159CAE27FBEE96155C99F822156E57`
- det: `853F7ED317D4F2F80DE646842E5BBC32F9D39C601562CBE466CDA42E4BAFB1B1`

保留源码：`outputs/adb_map_controller/tools/benchmark_ocr_speed.py` 与 `ocr_benchmark_pipeline.py`。旧后端对照脚本共用同一预处理模块，默认参数保留旧流程。实验环境、模型与原始 JSON 仅在 `publish/.ocr-speed/` 生成，记录结论后清理。

Python 3.12，依赖 paddlepaddle 3.1.1、Paddle2ONNX 2.1.0、onnx 1.17.0、onnxruntime-directml 1.24.4、OpenCV headless 5.0.0.93、PyYAML 6.0.3、pyclipper 1.4.0；模型转换需 setuptools。FP16 实验另需 onnxconverter-common。

将四个模型按旧报告的导出命令（opset 17、optimize_tool None）导出到 `publish/.ocr-speed/` 的 det.onnx、rec.onnx、tiny-det.onnx、tiny-rec.onnx；其中 det/rec 为现有 v5/v4，tiny 为本次下载模型；tiny YAML 保存在 `publish/.ocr-speed/models/PP-OCRv6_tiny_rec_infer/`。先跑 `--variants v4-dynamic-b6` 生成对照基线，再跑 `--variants tiny-single-cv-thread --samples 100 --output stable.json`。用 `PYTHONDONTWRITEBYTECODE=1` 避免在源码目录生成缓存。

该性能实验没有构建应用、切换生产模型或改动自动点击流程。下一步若接入 C#，必须重新测包含实际图像入口、坐标转换和业务调用的完整路径。
