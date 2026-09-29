# 识图任务管线

项目现在提供一套轻量的 MAA 风格识图管线，入口是 `Infrastructure/Automation/VisionPipeline.cs`。所有主动的图片模板识别都使用 OpenCV：PNG 模板通过 `Cv2.MatchTemplate` 搜索；地图节点通过 OpenCV HSV 掩码和连通组件定位；OCR 通过主进程内的 PaddleOCR SDK 调用。

## 支持的输入

实时截图和 PNG 文件走同一条识别路径：

```csharp
var task = new VisionTask
{
    Name = "入口按钮",
    Algorithm = VisionAlgorithm.MatchTemplate,
    TemplatePath = "icons/entry.png",
    TemplateThreshold = .80,
    Roi = new Rectangle(0, 0, 1280, 720)
};

var result = await pipeline.RecognizeFileAsync(task, "screen.png");
```

实际运行时，`DungeonEntryAutomation` 使用 `AdbClient.CaptureScreenForAutomationAsync()` 得到实时截图；离线回归可以用 `RecognizeFileAsync` 直接读取 PNG。

## 任务 JSON

发布包中的 `vision/tasks.json` 支持以下字段：

- `algorithm`: `JustReturn`、`MatchTemplate`、`TemplateMatch`、`OcrDetect`、`OCR` 或 `FeatureMatch`；其中 `FeatureMatch` 使用 OpenCV ORB + BFMatcher + RANSAC；
- `template`: 模板 PNG 路径，按任务 JSON 所在目录解析；
- `text`: OCR 目标文本或文本数组；
- `roi`: 以 1280×720 为基准的 `[x, y, width, height]`；
- `templThreshold`: 模板命中阈值；
- `minFeatureMatches`: OpenCV 通过比率测试后要求的最少匹配数，默认 6；
- `featureRatio`: ORB KNN 比率测试阈值，默认 0.75；
- `featureCount`: ORB 最大特征点数，默认 800；
- `fullMatch`: OCR 是否要求完整文本匹配。

模板任务会直接读取并匹配可见的 PNG 图片，透明区域会作为 OpenCV mask 排除；OCR 任务复用已部署的 PaddleOCR SDK 和 PP-OCRv5 inference 模型。`FeatureMatch` 仍作为显式配置的可选算法，使用 OpenCV ORB、BFMatcher 和 RANSAC，但当前入口、地图标题、玩家按钮和地图节点流程均已切换到 OpenCV 模板/掩码处理，不再依赖旧的采样数组匹配。

例如：

```json
{
  "DungeonBannerFeature": {
    "algorithm": "FeatureMatch",
    "template": "../icons/dungeon_banner.png",
    "roi": [240, 80, 800, 560],
    "minFeatureMatches": 8,
    "featureRatio": 0.78,
    "featureCount": 1200
  }
}
```

OpenCV 的托管程序集和 Windows 原生运行库会随主程序一起复制到 `publish/`，部署时不需要单独安装 Python 或 OpenCV。

## 当前接入点

- 入口流程的通用 OCR 查找已通过 `VisionPipeline` 执行；
- `挑战` 按钮优先读取 `vision/tasks.json` 的 `ChallengeButton` 任务；配置缺失或非法时自动回退到内置任务；
- 入口图标、地图标题和小地图按钮继续使用已有的实战模板目录，避免降低现有识别稳定性；
- `tests/VisionPipelineRegression` 覆盖 PNG 模板、OpenCV ORB 特征匹配、OCR ROI 坐标回映射和任务配置解析。
- 入口标定会把选中的截图区域保存到 `entry-templates/map-{mapId}.png`，并在 `entry-templates.json` 中只保存 PNG 路径和缩放比例；旧版只含 `Pixels/Weights` 的抽象模板不会继续参与识别，重新标定即可生成可查看模板。
