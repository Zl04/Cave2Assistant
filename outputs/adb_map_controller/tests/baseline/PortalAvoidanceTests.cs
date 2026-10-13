namespace AdbMapController.Tests;

public sealed class PortalAvoidanceTests
{
    static MapDump Room(bool detour = true, bool portalStart = false)
    {
        var tiles = new List<TileInfo>();
        for (var x = 0; x < 5; x++)
            for (var y = 0; y < (detour ? 2 : 1); y++)
                tiles.Add(new TileInfo { X = x, Y = y, Reachable = true, Explored = true });
        tiles.Single(t => t.X == 2 && t.Y == 0).Roles =
            [new RoleInfo { ClassName = "TriggerNpcData", RoleType = 1, MinimapType = 22, TransdoorType = 3 }];
        tiles.Single(t => t.X == 4 && t.Y == 0).Roles = [new RoleInfo { ClassName = "TriggerNpcData", RoleType = 2, TreasureType = 1 }];
        return new MapDump { Player = new PlayerInfo { X = portalStart ? 2 : 0, Y = 0 }, Tiles = [tiles] };
    }

    [Fact]
    public void CollectPotWithoutWalkingIntoRoomPortal()
    {
        var plan = Planner.PlanFull(Room(), new PlanOptions { Pots = true });
        Assert.Contains(plan.Interactions, i => i.Target.Kind == "罐子");
        Assert.DoesNotContain(new Cell(2, 0), plan.Route);
    }

    [Fact]
    public void PotBehindPortalIsNotReachableUntilRoomTransition()
    {
        var map = Room(false);
        var target = new TargetKey(new Cell(4, 0), "罐子");
        Assert.Empty(Planner.ReachableTargets(map, [target]));
        Assert.Empty(Planner.PlanFull(map, new PlanOptions { Pots = true }).Interactions);
    }

    [Fact]
    public void ExplicitPortalRouteStillReachesPortal()
        => Assert.Equal(new Cell(2, 0), Planner.PlanToRoomPortal(Room()).Route.Last());

    [Fact]
    public void CanLeavePortalAfterArrival()
        => Assert.Contains(Planner.PlanFull(Room(portalStart: true), new PlanOptions { Pots = true }).Interactions,
            i => i.Target.Kind == "罐子");

    [Fact]
    public void CollectChestAndPotWithoutCrossingPortal()
    {
        var map = Room();
        map.ByCell[new Cell(4, 1)].Roles =
            [new RoleInfo { ClassName = "TriggerNpcData", RoleType = 2, TreasureType = 3 }];
        var plan = Planner.PlanForFloorRecoveringTemporaryBlocks(map,
            new PlanOptions { Chests = true, Pots = true }, [new Cell(1, 0), new Cell(0, 1)]);
        Assert.Contains(plan.Interactions, i => i.Target.Kind == "木箱");
        Assert.Contains(plan.Interactions, i => i.Target.Kind == "罐子");
        Assert.DoesNotContain(new Cell(2, 0), plan.Route);
    }

    [Fact]
    public void ExplorationAvoidsPortal()
    {
        var map = Room();
        foreach (var tile in map.Tiles.SelectMany(row => row)) tile.Explored = false;
        var plan = Planner.PlanExploration(map, visionRadius: 0);
        Assert.True(plan.Route.Count > 1);
        Assert.DoesNotContain(new Cell(2, 0), plan.Route);
        Assert.DoesNotContain(new Cell(2, 0), Planner.PlanFull(map,
            new PlanOptions { VisionRadius = 0, Pots = true }).Route);
    }

    [Fact]
    public void ClickCannotWalkThroughPortalButCanSelectIt()
    {
        var map = Room(false);
        Assert.Empty(Planner.PlanToTarget(map, new Cell(4, 0), true).Route);
        Assert.Equal(new Cell(2, 0), Planner.PlanToTarget(map, new Cell(2, 0), true).Route.Last());
    }
}
