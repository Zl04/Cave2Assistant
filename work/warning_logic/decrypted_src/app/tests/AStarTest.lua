
local AStarTest = {}

function AStarTest:testAstar()
    local astar = require "utils.astar.AStar"

    -- 生成测试数据
    local i = 0
    local j = 0
    local dataArr = 
    {
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,1,1,1,1,1,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0},
        {1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
        {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0},
        {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
        {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0},
        {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0},
        {0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0},
        {0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0},
        {0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0},
        {0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,1,1,0,1,0,0,0},
        {0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,0},
        {0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    }   

    local blocks = {}
    local couldCrossNum = 0

    for i = 1, #dataArr do
        local handler = dataArr[i]
        for j = 1,#handler do 
            local block = {}
            block.w = i-1 --在整个地图划分中所处的行
            block.h = j-1 --在整个地图划分中所处的列
            -- block.pos = {x =i-1,y = j-1} --格子的中心点在地图中的坐标     
            block.pos = {}  
            block.pos.x = block.w
            block.pos.y = block.h
            if(handler[j] ==1) then
                block.couldCross = false --表示该格子是否是可以通过的
            else
                block.couldCross = true --表示该格子是否是可以通过的
                couldCrossNum = couldCrossNum + 1
            end
            local key = string.format("%d_%d",block.w,block.h)
            blocks[key] = block
        end
    end

    print (" -------------------------------couldCrossNum ="..couldCrossNum)

    local isFly = false

    local startKey = string.format("%d_%d",2,2)
    local endKey = string.format("%d_%d",15,22)

    local s = os.clock()
    local path = astar.path(blocks[startKey],blocks[endKey],false,function(theBlock)
		return self:neighbors(theBlock,blocks,isFly)
	end)
    local e = os.clock()

    print("AStarTest astar us time="..(e-s))

    -- if path then
    --     for k,v in pairs(path) do
    --         print("AStarTest  k ="..k.."  x="..v.pos.x.."  y="..v.pos.y)
    --     end
    -- else
    --     print("AStarTest:testAstar no find path")
    -- end

end

--判断地块的可通过性
function AStarTest:jugeNeighbor (w,h,nodes,neighbors,isFly)
	local nodeName = string.format("%d_%d",w,h)
	local neighborNode = nodes[nodeName]
	if neighborNode and (isFly or neighborNode.couldCross) then
		table.insert( neighbors,neighborNode )
		return true
	end
	return false
end
--查找地块附近可用的地块
--[[
	theBlock - 需要判定的地块
	blocks - 所有地块
	isFly - 飞行，是否无视障碍物]]
function AStarTest:neighbors(theBlock,blocks,isFly)
	local neighbors = {}
	--首先取出附近的8个节点。
	local left_top = true
	local left_down = true
	local right_top = true
	local right_down = true
	--left
	if not self:jugeNeighbor(theBlock.w-1,theBlock.h,blocks,neighbors,isFly) then
		left_top = false
		left_down = false
	end
	--right
	if not self:jugeNeighbor(theBlock.w+1,theBlock.h,blocks,neighbors,isFly) then
		right_top = false
		right_down = false
	end
	--top
	if not self:jugeNeighbor(theBlock.w,theBlock.h+1,blocks,neighbors,isFly) then
		left_top = false
		right_top = false
	end
	--down
	if not self:jugeNeighbor(theBlock.w,theBlock.h-1,blocks,neighbors,isFly) then
		left_down = false
		right_down = false
	end
	--top-left
	if left_top then
		self:jugeNeighbor(theBlock.w-1,theBlock.h+1,blocks,neighbors,isFly)
	end
	--down-left
	if left_down then
		self:jugeNeighbor(theBlock.w-1,theBlock.h-1,blocks,neighbors,isFly)
	end
	--top-right
	if right_top then
		self:jugeNeighbor(theBlock.w+1,theBlock.h+1,blocks,neighbors,isFly)
	end
	--down-right
	if right_down then
		self:jugeNeighbor(theBlock.w+1,theBlock.h-1,blocks,neighbors,isFly)
	end

	return neighbors
end

return AStarTest