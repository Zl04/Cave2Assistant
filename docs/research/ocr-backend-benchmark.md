# OCR 后端实测：同模型、全屏、CPU 与 DirectML

测试日期：2026-10-13。机器：i7-9700（8 核），GTX 1650。目的是验证 MAA 的 ONNX Runtime 路线能否减少本项目 OCR 本身的耗时。

## 已确认的结论

同一 PP-OCRv5 mobile 检测模型、PP-OCRv4 mobile 识别模型，ONNX Runtime CPU 的完整 OCR 对照流程比 Paddle Python Inference 快约 24%–33%；DirectML GPU 则达到约 463–596 ms。无需更换轻量模型，也没有把全屏改成局部区域。优先推进 DirectML，并保留 CPU 后端兜底。

## 对照方法与边界

- 模型来自本项目 `Resources/OcrModels`，通过 Paddle2ONNX 2.1.0 导出 opset 17，禁用转换工具的 Polygraphy 优化；ORT 启用全部运行时图优化。
- SDK 原始基线：发布目录 PaddleOCRSDK 4.5.3 / Paddle native 3.4.0。它与 Python Paddle 不是同一运行时版本，不能把 SDK 与 ORT 的差值全部归因于后端。
- 严格相同输入的模型对照：Paddle Python 3.1.1 + oneDNN，与 ONNX Runtime CPU 1.31.0。两者输入张量、识别批次与解码代码完全相同。检测最长边 960，识别高 48、最小宽 320、batch 6、关闭方向分类。两种引擎均初始化复用，不用缓存跳过推理。
- 每项先预热 2 次，再计时 5 次，表格使用中位数。串行运行，未并行启动 OCR 基准；背景负载未完全隔离，5 次样本不足以代表长期 P95。
- 第一组复用 SDK 返回的文字框，统一矩形裁剪，隔离模型推理差异。不能把矩形裁剪当成 SDK 内部透视裁剪的精确复现。
- 第二组从完整图像开始，包含检测预处理、推理、DB 检测后处理、透视裁剪、识别预处理、识别推理、CTC 解码。两种后端共用同一份 Python/OpenCV 实现。计时不含 ADB 截图、磁盘读图、C# 调度、SDK PNG 解码。
- 第二组与 SDK 的框数分别为 36/37、31/32、43/44，因此目前不能声称这个流程已完全复现生产 SDK。它用于验证后端收益，不能直接当作已验收的生产替换。

## 相同张量，3 与 8 线程

单位 ms，det 为检测推理，rec 为整张图所有文字框的识别推理。

| 截图 | 框数 | 线程 | Paddle det | Paddle rec | ORT det | ORT rec |
|---|---:|---:|---:|---:|---:|---:|
| 角色页 source.png | 37 | 3 | 250 | 1111 | 160 | 781 |
| 下一层确认 | 32 | 3 | 188 | 1114 | 149 | 829 |
| 贪婪选择混合弹窗 | 44 | 3 | 173 | 1290 | 163 | 932 |
| 角色页 source.png | 37 | 8 | 178 | 1084 | 137 | 746 |
| 下一层确认 | 32 | 8 | 206 | 1330 | 147 | 903 |
| 贪婪选择混合弹窗 | 44 | 8 | 197 | 1263 | 136 | 809 |

3 线程没有稳定超过 8 线程，不宜直接复制 MAA 的线程分档。113 个文字框在各自线程对照中，两个后端的解码文本均完全相同。该结果只说明后端转换的一致性，不说明文本都识别正确。

## 8 线程完整 OCR 流程

| 截图 | Paddle | ORT CPU | 耗时减少 | 两后端框及文本一致 |
|---|---:|---:|---:|---|
| 角色页 | 1477 ms | 983 ms | 33.4% | 是，36 框 |
| 下一层确认 | 1412 ms | 1067 ms | 24.4% | 是，31 框 |
| 贪婪选择混合弹窗 | 1526 ms | 1159 ms | 24.1% | 是，43 框 |

最后一次 ORT 完整流程的阶段计时显示预处理、DB 后处理及裁剪、CTC 解码均为毫秒到几十毫秒量级，识别推理仍是主要成本。这些阶段数值不是各阶段独立采样的中位数。

关键文本“是否进入下一层”“返回城镇”“继续探险”“前往下一层”“安全回城”“再考虑一下”可识别；“贪婪抉择”仍被识别成“贪婪执择”，Paddle 与 ORT 都相同。后端更换不会解决原模型的识别错误。

ORT 优化图仍保留大量 Mul/Add：识别图中有 86 个 Mul、69 个 Add，因此不能宣称 oneDNN trace 中的 affine 热点已全部融合。速度改善是实测结果，具体算子收益仍需单独做可归因的 profiler 对照。

## DirectML GPU 对照

隔离安装 `onnxruntime-directml==1.24.4`，与 CPU 1.31 环境分别加载，不修改生产依赖。DirectML 使用顺序执行、关闭内存模式缓存；计时阶段关闭 profiler。初始化后另做一次不计时的执行探针：检测 258 个节点执行事件均为 DmlExecutionProvider，识别为 283 个 DmlExecutionProvider、2 个 CPUExecutionProvider，确认实际 GPU 执行，而非仅注册了 provider。

| 截图 | ORT DirectML 完整 OCR 中位数 | 5 次采样最小–最大 | 与 Paddle 框及文本一致 |
|---|---:|---:|---|
| 角色页 | 463 ms | 436–495 ms | 是 |
| 下一层确认 | 473 ms | 448–486 ms | 是 |
| 贪婪选择混合弹窗 | 596 ms | 571–618 ms | 是 |

相同 SDK 文字框的张量对照中，37/32/44 个识别文本也分别全部一致。GPU 的每张图全部框识别推理中位数分别为 441/445/493 ms，检测约 28–29 ms。完整流程表使用重新检测、透视裁剪的结果，其框数不同于该张量对照，两个表的数值不可直接相加。

CPU 1.31 与 DirectML 1.24.4 版本不同，因此另行运行同一个 1.24.4 包的 CPUExecutionProvider 对照，保持算法、模型、8 线程及预热/采样方法一致，计时探针不并行运行。结果如下：

| 截图 | ORT 1.24.4 CPU | ORT 1.24.4 DirectML | 耗时减少 |
|---|---:|---:|---:|
| 角色页 | 1029 ms | 463 ms | 55.0% |
| 下一层确认 | 1104 ms | 473 ms | 57.2% |
| 贪婪选择混合弹窗 | 1216 ms | 596 ms | 51.0% |

同版本 CPU 的相同张量识别文本、完整流程的检测框及文本也均与 Paddle 对照一致。三个样本支持 DirectML 比 CPU 更值得优先接入；不代表其它 GPU、冷启动或所有游戏画面也具有同样耗时。

## 复现与交付状态

源码：`outputs/adb_map_controller/tools/benchmark_ocr_backends.py`。临时环境、导出模型及原始日志生成在该项目 `publish/.ocr-benchmark/`，实验结束后清理，不进入生产发布依赖。

独立 Python 3.12 环境依赖：paddlepaddle==3.1.1、paddle2onnx==2.1.0、onnxruntime==1.31.0、onnx==1.17.0、opencv-python-headless==5.0.0.93、numpy==2.5.4、PyYAML==6.0.3、pyclipper==1.4.0。SDK 基线要用未加载 Paddle Python 的独立 Python 进程，避免 DLL 冲突。

导出 det/rec：`paddle2onnx --model_dir <模型源目录> --model_filename inference.json --params_filename inference.pdiparams --save_file <publish/.ocr-benchmark/det.onnx 或 rec.onnx> --opset_version 17 --optimize_tool None`。

先运行 `benchmark_ocr_backends.py --native`，再在独立环境运行 `--tensor --threads 8` 或 `--tensor --threads 3`。原始 JSON 保留全部采样时间、检测框和文本；本报告记录结论。

DirectML 在另一个隔离包目录安装 `onnxruntime-directml==1.24.4 --no-deps`，用 Python `sys.path.insert(0, <隔离包目录>)` 选择该包，然后以 `--tensor --threads 8 --provider DmlExecutionProvider` 运行源码。同版本 CPU 对照仍加载这个包，但使用默认 CPU provider。先打印 `onnxruntime.__version__` 与 `get_available_providers()` 确认加载正确；本次二者均为 1.24.4。

本次没有切换生产 OCR 后端，也未重新构建应用。生产替换应把 ORT 接入现有 `PaddleOcrRecognition` 输出契约，核对 SDK 与新后处理的框、坐标、置信度和关键弹窗行为，再发布。
