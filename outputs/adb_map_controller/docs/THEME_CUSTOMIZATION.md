# 主题与深色模式维护说明

## 1. 文档目的

本文档记录 ADB 控制器当前的主题实现结构、深色模式处理方式、特殊控件的绘制逻辑，以及后续调整时需要注意的问题。

当前支持三种主题：

- 浅色：当前默认浅色模式
- 深色：使用深色主题调色板
- 跟随系统：根据 Windows 应用主题设置选择浅色或深色

## 2. 代码入口

主题相关代码主要集中在：

- `Presentation/ThemePalette.cs`
  - `ThemePalette`：主题颜色定义
  - `ThemeManager`：递归应用主题
  - `ThemedTabControl`：页签绘制
  - `ThemedTabPage`：页面原生边框处理
  - `ThemedComboBox`：下拉框绘制
  - `ThemedTextBox`：日志框和滚动条绘制
  - `ThemedNumericUpDown`：数字输入框绘制
  - `NativeTheme`：Windows 原生主题、DWM 和滚动条处理
- `Presentation/MainForm.cs`
  - `ApplyTheme()`：主窗体主题刷新入口
  - 运行页和设置页的控件注册

## 3. 调色板结构

`ThemePalette` 使用语义化颜色，不建议在控件代码中直接写颜色值。

主要颜色角色如下：

| 颜色属性 | 用途 |
| --- | --- |
| `WindowBackground` | 窗口和页面基础背景 |
| `Surface` | 工具栏、页签表面 |
| `SurfaceAlt` | 设置区域、悬停区域 |
| `InputBackground` | 输入框、下拉框背景 |
| `Text` | 主要文字 |
| `MutedText` | 次要文字、禁用状态 |
| `AccentText` | 选中状态、强调文字 |
| `SuccessText` | 成功状态 |
| `WarningText` | 警告状态 |
| `Border` | 控件、页签和页面边框 |
| `Button*` | 不同语义按钮的背景色 |
| `Map*` | 地图区域和地图状态颜色 |

当前深色模式的关键中性色：

- 窗口背景：`#11151C`
- 工具栏表面：`#181E27`
- 设置区域：`#1E2631`
- 输入框背景：`#141A22`
- 文字：`#E9EEF5`
- 次要文字：`#9FADBE`
- 边框：`#3D4B5C`
- 地图背景：`#0C1118`

后续普通配色调整，优先修改 `ThemePalette.Dark` 和 `ThemePalette.Light`，不要在 `MainForm` 或控件绘制代码中重复写色值。

## 4. 主题应用流程

主题切换流程如下：

1. `MainForm.ApplyTheme()` 获取当前 `ThemeMode`。
2. `ThemePalette.Resolve()` 返回浅色或深色调色板。
3. `ThemeManager.Apply(this, palette)` 递归遍历主窗体控件。
4. 控件根据 `ThemeRole` 设置背景、文字、按钮和输入状态。
5. 特殊控件调用自己的 `ApplyTheme()` 和重绘逻辑。
6. `NativeTheme` 处理 DWM 标题栏、Windows 原生控件主题和原生滚动条主题。

新增普通控件时，优先设置正确的 `ThemeRole`。只有系统默认绘制无法满足深色模式时，才新增 `Themed*` 控件。

## 5. 特殊控件处理

### 5.1 页签和页面边框

`ThemedTabControl` 使用 OwnerDraw 绘制页签文字、背景、选中下划线和主题边框。

需要特别注意：WinForms `TabControl` 除了控件自身边框，还会绘制一圈原生页面框架。这个页面框架不是普通的 `BorderStyle`，直接修改 `Border` 颜色不会完全覆盖它。

当前处理方式：

- 移除 `TabControl` 的原生窗口边框。
- 使用 `DisplayRectangle` 定位原生页面框架。
- 在 `PaintPageFrame()` 中覆盖原生页面框架环。
- 由主题调色板重新绘制唯一的页面边框。
- 运行页和设置页使用 `ThemedTabPage`，避免页面句柄重建后恢复系统边框。

如果后续调整页签边框，重点检查：

- `ThemedTabControl.PaintTabChrome()`
- `ThemedTabControl.PaintPageFrame()`
- `ThemedTabPage.OnHandleCreated()`
- `NativeTheme.RemoveClientFrame()`

### 5.2 日志框和滚动条

右侧日志框使用 `ThemedTextBox`，而不是普通 `TextBox`。

它负责：

- 日志背景和文字颜色
- 日志框边框
- 深色垂直滚动条
- 滚动条箭头、轨道和滑块

滚动条绘制前会通过 `GetScrollInfo()` 判断是否真的可滚动：

- 内容不足时：只保持深色背景，不绘制箭头和滑块
- 内容超出时：绘制深色轨道、箭头和滑块

这样可以避免“当前有内容但还不能滚动时，右侧出现错误滚动条”的问题。

### 5.3 下拉框和数字输入框

- `ThemedComboBox` 使用 OwnerDraw 绘制下拉框背景、箭头和边框。
- `ThemedNumericUpDown` 使用自定义编辑框和箭头区域。
- 上下箭头、下拉箭头和边框都使用当前主题调色板。

### 5.4 复选框和按钮

按钮和复选框统一使用扁平样式，并应用：

- `palette.Border`
- `palette.SurfaceHover`
- 选中、悬停、按下和禁用状态颜色

## 6. 已解决的典型问题

### 页签切换后日志滚动条恢复为系统样式

原因：页签曾经调用递归版 `UseCustomTheme()`，该方法会清理所有子窗口主题，连日志框的 `DarkMode_Explorer` 滚动条主题也被清除。

规则：

- 页签只使用 `UseCustomWindowTheme()`，只处理页签自身。
- 不要对包含日志框的父控件递归调用 `UseCustomTheme()`。

### 原生白色页面边框无法改色

原因：亮线来自 `TabControl` 原生页面框架，不是普通控件的 `Border` 属性。

解决：使用 `DisplayRectangle` 定位并覆盖页面框架环，再绘制 `palette.Border`。

### 不可滚动状态显示错误滚动条

原因：滚动条绘制逻辑只判断了 `ScrollBars` 属性，没有判断内容是否超过可视区域。

解决：使用 `GetScrollInfo()` 计算 `range - page`，只有结果大于零时才绘制箭头和滑块。

## 7. 后续调整建议

### 只调整颜色

修改 `ThemePalette.Dark` 或 `ThemePalette.Light` 中的颜色值，然后检查：

- 普通页面背景
- 设置区域层次
- 输入框和下拉框
- 页签边框
- 日志框和滚动条
- 按钮的语义颜色

### 调整边框

按目标控件选择入口：

- 全局边框：`ThemePalette.Border`
- 页签页面边框：`ThemedTabControl.PaintPageFrame()`
- 日志框边框：`ThemedTextBox.PaintChrome()`
- 下拉框边框：`ThemedComboBox.PaintChrome()`
- 数字输入框边框：`ThemedNumericUpDown.PaintChrome()`
- 窗口标题栏和窗口边缘：`NativeTheme.Apply()` 中的 DWM 属性

### 新增控件

建议按以下顺序处理：

1. 设置正确的 `ThemeRole`。
2. 设置控件的 `BackColor`、`ForeColor` 和 `FlatStyle`。
3. 让 `ThemeManager` 递归应用主题。
4. 如果仍有系统白色边框、箭头或滚动条，再创建对应的 `Themed*` 控件。
5. 同时验证浅色、深色、跟随系统三种模式。

## 8. 验证清单

- [ ] 切换到深色后运行页和设置页都保持深色
- [ ] 切换页签后主题不会恢复
- [ ] 标题栏和窗口边缘颜色正确
- [ ] 页签四周没有白色原生边框
- [ ] 日志内容较少时不显示多余滚动条箭头和滑块
- [ ] 日志内容较多时滚动条仍为深色
- [ ] 下拉框箭头和边框为主题色
- [ ] 数字输入框上下箭头为主题色
- [ ] 浅色模式没有被深色自绘逻辑污染
- [ ] 发布目录只保留最终可运行文件和依赖

## 9. 发布位置

最终程序位于：

`outputs/adb_map_controller/publish/洞窟地图控制器.exe`

构建产生的临时 `.build` 目录在交付前应清理。
