# MAA 全屏 OCR 实现与可参考方案

调查日期：2026-10-13。仅阅读官方源码、资源元数据和训练配置；没有下载模型、构建 MAA 或在本机测量 MAA 吞吐。

固定版本：MAA `dev-v2` 的 `5f003efa12a8c291b53fdc2fff77a5b06a6a0a83`；官方模型训练项目 MaaAI 的 `7250cacc15c3b41c334937576d881845bee1ea71`。当前官方默认分支为 dev-v2。

## 结论

MAA 的桌面全屏 OCR 使用检测文字框、裁剪、识别的两阶段流程。最值得本项目验证的差别是：它的检测资源标记为 PP-OCRv3，官方提供基于 PP-OCRv3 的游戏文本微调识别路线，桌面通过 FastDeploy 使用 ONNX Runtime 后端。当前识别部署图与训练配置是否完全一致仍需核实。不能仅从源码断言 MAA 全屏 OCR 比本项目快，也不能承诺特定毫秒数。

## 调用与输入处理

- `VisionHelper` 默认空 ROI 设置为整图，因此 `OCRer` 支持全屏；`make_roi` 返回 `cv::Mat` 子视图。`OCRer` 根据任务选择 WordOcr/CharOcr，再调用 `recognize`。[VisionHelper.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Vision/VisionHelper.cpp)、[VisionHelper.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Vision/VisionHelper.h)、[OCRer.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Vision/OCRer.cpp)
- `OcrPack::recognize` 直接接收 `cv::Mat`；全流程调用 `PPOCRv3::Predict`，`without_det=true` 时单独调用 `Recognizer::Predict`。源码没有该调用点上的 PNG 编解码，也没有构造方向分类模型。[OcrPack.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Config/Miscellaneous/OcrPack.cpp)
- 任务所需文字的 `required` 过滤在 OCR 推理完成后执行，因此指定目标文字不等于减少本轮网络识别工作量。`RegionOCRer` 的灰度、inRange、boundingRect、直接 rec 属于专用区域/单行路径，不能视为全屏引擎加速。[OCRer.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Vision/OCRer.cpp)、[RegionOCRer.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Vision/RegionOCRer.cpp)
- Controller 的缩放图像缓存使用 `INTER_AREA`；ControlScaleProxy 以 1280×720 为控制基准。缩小截图可能减少后续裁剪图的细节，不能不测小字准确率就照搬。[Controller.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Controller/Controller.cpp)、[ControlScaleProxy.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Controller/ControlScaleProxy.cpp)

## 模型与专用字典

| 项目 | 官方证据 | 限制 |
|---|---|---|
| 中文检测 | version.txt 为 `ch_PP-OCRv3_det_infer`；ONNX 文件约 2.43 MB | 未下载 ONNX 检查逐算子结构 |
| 中文识别 | WordOcr 模型约 10.74 MB，字典实数 6901 行 | rec/version.txt 仅记录训练指标，不能单凭它证明部署图具体结构 |
| 字符识别 | CharOcr 的 version 为 `en_PP-OCRv3_rec_infer`，字典 95 行，模型约 8.96 MB | “Char” 不代表任意中文单字模型；更适合英语、数字、符号 |

来源：[det/version.txt](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/resource/PaddleOCR/det/version.txt)、[中文 keys.txt](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/resource/PaddleOCR/rec/keys.txt)、[Char 版本](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/resource/PaddleCharOCR/rec/version.txt)、[Char 字典](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/resource/PaddleCharOCR/rec/keys.txt)。文件大小来自该固定 commit 的 Git tree 元数据，不代表运行速度。

官方 MaaAI 说明使用明日方舟文本生成数据集微调识别模型。中文训练配置采用 PP-OCRv3 预训练、`MobileNetV1Enhance scale=0.5`，SVTR neck 为 `dims=64/depth=2/hidden_dims=120`，训练时 Teacher/Student 蒸馏，CTC 与 SAR 多头，输入形状为 3×48×320。[训练配置](https://github.com/MaaAssistantArknights/MaaAI/blob/7250cacc15c3b41c334937576d881845bee1ea71/common/OCR/ch_PP-OCRv3_rec_distillation.yml)、[训练说明](https://github.com/MaaAssistantArknights/MaaAI/blob/7250cacc15c3b41c334937576d881845bee1ea71/common/OCR/README.md)

证据边界：训练配置不能证明当前主仓 ONNX 同时运行 Teacher、Student、SAR，也不能严格证明二进制与该配置完全一致；需要读取部署图核实。不要把训练评估日志的 fps 当成本机全屏吞吐。

字典生成脚本从游戏 JSON 提取文本，保留原始语言字典，再补充游戏字符；并非只保留几十个任务词。想减少类别，必须同步重新训练或修改并验证分类头，只删除 keys.txt 会破坏索引对应关系。[wording.py](https://github.com/MaaAssistantArknights/MaaAI/blob/7250cacc15c3b41c334937576d881845bee1ea71/common/OCR/utils/wording.py)、[steps.sh](https://github.com/MaaAssistantArknights/MaaAI/blob/7250cacc15c3b41c334937576d881845bee1ea71/common/OCR/steps.sh)

## 推理后端、线程与精度

桌面 `OcrPack` 的 det/rec 都显式 `UseOrtBackend()`，以 ONNX 格式加载。Windows 可选 DirectML GPU，否则 CPU；逻辑线程 ≤2/≤4/≤12/更大时分别设置 1/2/3/4 个 CPU 推理线程。模型按需初始化并缓存，后续调用不会每次重建。该源码没有显式启用 INT8 或 FP16，也没有显式设置图优化等级或 rec batch 参数，因此不能宣称 MAA 使用了量化模型或特定批次策略。[OcrPack.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Config/Miscellaneous/OcrPack.cpp)

MaaAI 提供 Paddle2ONNX 转换脚本和 `onnxoptimizer.optimize(model)` 的离线图优化脚本。它证明官方维护这种优化工具，但不能证明当前部署文件必经该脚本，也不能证明本项目中大量 affine 操作已被它消除。[pd2onnx.sh](https://github.com/MaaAssistantArknights/MaaAI/blob/7250cacc15c3b41c334937576d881845bee1ea71/common/OCR/pd2onnx.sh)、[onnx_optimizer.py](https://github.com/MaaAssistantArknights/MaaAI/blob/7250cacc15c3b41c334937576d881845bee1ea71/common/OCR/onnx_optimizer.py)

Android 走 NCNN，与 Windows 不是同一后端；源码关闭 Vulkan 和 FP16，检测最长边限制 960，rec 固定 48×320，各文字框逐一执行。不能拿 Android 该实现的参数直接断言桌面 FastDeploy 的内部行为。[OcrPackNcnn.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/5f003efa12a8c291b53fdc2fff77a5b06a6a0a83/src/MaaCore/Config/Miscellaneous/OcrPackNcnn.cpp)

## 本项目的优先验证顺序

1. 保持同一模型、完整截图、相同文字框和输出要求，比较 Paddle Inference 与 ONNX Runtime CPU，再比较 DirectML。单独计 det/rec/预处理/后处理，记录预热后中位数、P95 和识别差异，才能回答是否解决引擎本身耗时。
2. 验证图优化前后 affine/binary 节点及算子耗时，避免仅凭“用了 ONNX”推断融合成功。已有热点是否仍存在才是关键。
3. 将 v3 系列游戏微调路线作为轻量模型的准确率补救方向；本项目已有 v6 tiny 候选，可优先用洞窟截图、游戏字体及词语微调，不能直接把明日方舟模型当成通用中文模型。
4. CPU 线程比较 3、4、8，控制背景负载，不假定线程越多越快。MAA 的分级策略主要限制 CPU 占用，本机是否最快需实测。
5. 截图到 OCR 的图像接口复用内存，避免中间 PNG；这是端到端成本优化，不能算作模型推理加速。专用数字模型、单行路径适合特定任务，但不替代完整全屏对照实验。

本次没有修改业务 OCR 配置、下载模型或产生临时源码文件。
