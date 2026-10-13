using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
    readonly CheckBox autoEquipmentSale = Box("商人自动售出");
    readonly CheckBox sellBlueWhite = Box("蓝白装备");
    readonly CheckBox sellPurple = Box("紫色装备");
    readonly CheckBox sellDarkGold = Box("暗金装备");
    readonly CheckBox sellGold = Box("金色装备");
    string? soldMerchantMap;

    async Task<bool> HandleMerchantEquipmentSale(MapDump map, CancellationToken token)
    {
        // 地图快照只用于现有跑图入口判断；装备、品质及出售结果全部从截图识别。
        if (!map.MapName.Contains("神秘商人", StringComparison.Ordinal))
        {
            soldMerchantMap = null; return true;
        }
        var key = $"{map.SceneType}:{map.CaveMode}:{map.Level}";
        if (floorPhase is FloorPhase.WaitingReturnTown or FloorPhase.WaitingFloorLoad) return true;
        if (!autoEquipmentSale.Checked || soldMerchantMap == key) return true;
        if (!await RunEquipmentSaleAsync(token)) return false;
        soldMerchantMap = key; return true;
    }

    async Task<bool> RunEquipmentSaleAsync(CancellationToken token)
    {
        var options = new EquipmentSaleOptions(sellBlueWhite.Checked, sellPurple.Checked, sellDarkGold.Checked, sellGold.Checked);
        if (!options.BlueWhite && !options.HasSelective)
        {
            Warn("未选择任何出售品质"); return false;
        }
        popupHandling = true;
        var trace = new MaaPipelineTraceCollector();
        try
        {
            State("识图出售装备");
            var pipeline = new EquipmentSalePipeline(adb, options, AppContext.BaseDirectory,
                runtime.Paths.Pipeline("equipment-sale-pipeline.json"), message => Log(message));
            var result = await pipeline.RunAsync(token, new MaaPipelineTraceMultiplexer([trace, pipelineWebServer]));
            trace.SaveJson(runtime.Paths.Trace($"equipment-sale-{result.RunId}.json"));
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded) Warn($"装备出售停止：{result.Error}");
            return result.Succeeded;
        }
        finally { popupHandling = false; }
    }
}
