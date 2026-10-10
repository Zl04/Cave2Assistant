using System.Collections.Concurrent;
using System.Globalization;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace AdbMapController;

/// <summary>
/// 将现有受限 TaskPipeline handler 适配到完整 MAA 运行时，便于分阶段迁移领域任务。
/// </summary>
public static class MaaPipelineHandlerAdapter
{
    public static IMaaPipelineHandler<TState> FromLegacy<TState>(ITaskPipelineHandler<TState> handler)
    {
        ArgumentNullException.ThrowIfNull(handler);
        return new DelegateMaaPipelineHandler<TState>(
            handler.Name,
            async (_, context, token) =>
            {
                var canRun = await handler.CanRunAsync(
                    new TaskPipelineContext<TState>(context.State, context.RunId, context.TaskName,
                        context.Attempt, 0, new Dictionary<string, int>(context.ExecutionCounts, StringComparer.OrdinalIgnoreCase)), token);
                return canRun ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss();
            },
            async (_, _, context, token) =>
            {
                var result = await handler.ExecuteAsync(
                    new TaskPipelineContext<TState>(context.State, context.RunId, context.TaskName,
                        context.Attempt, 0, new Dictionary<string, int>(context.ExecutionCounts, StringComparer.OrdinalIgnoreCase)), token);
                return result.Succeeded
                    ? MaaPipelineActionResult.Success()
                    : MaaPipelineActionResult.Failure(result.Error ?? "旧任务 handler 执行失败");
            });
    }
}
