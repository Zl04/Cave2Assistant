local avalon = require "app.mapkit.MapHelper"
local Grid = require ("app.vendor.jumper.grid") -- The grid class
local Pathfinder = require ("app.vendor.jumper.pathfinder") -- The pathfinder lass

local TestLayer = class("TestLayer", function ()
	print "TestLayer create layer"
    local layer = cc.Layer:create()
    return layer
end)

function TestLayer:ctor()
    self:createFadeTest()
    -- self:createOverlayers()
       -- self:createOverlayRenderTest()
       -- self:createPahtFinderTest()
       -- self:createAnnotatedPathing()
end

function TestLayer:createFadeTest()
    local duration = 5

    local texture = cc.Director:getInstance():getTextureCache():addImage("map/map2.png")
    local tileSize = {width = 180, height = 136}
    local gap = 10
    local maxOpacity = 255
    local minOpacity = 0

    local function createWallAt(x, y)
        local frameBottom1 = cc.SpriteFrame:createWithTexture(texture, {x = 380, y = 339, width = 180, height = 159})
        local frameTop1 = cc.SpriteFrame:createWithTexture(texture, {x = 190, y = 146, width = 180, height = 183})

        local frameBottom2 = cc.SpriteFrame:createWithTexture(texture, {x = 380, y = 532, width = 180, height = 159})
        local frameTop2 = cc.SpriteFrame:createWithTexture(texture, {x = 190, y = 339, width = 180, height = 183})

        -- bottom
        local bottom = cc.Sprite:createWithSpriteFrame(frameBottom1)
        self:addChild(bottom)
        bottom:setPosition(x, y)

        local bottom1 = cc.Sprite:createWithSpriteFrame(frameBottom1)
        self:addChild(bottom1)
        bottom1:setPosition(x, y)

        local fo = cc.FadeTo:create(duration, minOpacity)
        local fi = cc.FadeTo:create(duration, maxOpacity)
        local focb = cc.CallFunc:create(function() bottom:setSpriteFrame(frameBottom2) end)
        local ficb = cc.CallFunc:create(function() bottom:setSpriteFrame(frameBottom1) end)
        local seq = cc.Sequence:create(fo, focb, fi, ficb)
        local rf = cc.RepeatForever:create(seq)
        bottom1:runAction(rf)

        local bottom2 = cc.Sprite:createWithSpriteFrame(frameBottom2)
        self:addChild(bottom2)
        bottom2:setPosition(x, y)
        bottom2:setOpacity(minOpacity)
        local fo2 = cc.FadeTo:create(duration, minOpacity)
        local fi2 = cc.FadeTo:create(duration, maxOpacity)
        local seq2 = cc.Sequence:create(fi2, fo2)
        local rf2 = cc.RepeatForever:create(seq2)
        bottom2:runAction(rf2)

        -- top
        local top = cc.Sprite:createWithSpriteFrame(frameTop1)
        self:addChild(top)
        top:setPosition(x, y + 50)
        -- bottom:addChild(top)
        -- top:setPosition(90, bottom:getContentSize().height - 45)
        -- top:setAnchorPoint(0.5, 45 / top:getContentSize().height)

        local top1 = cc.Sprite:createWithSpriteFrame(frameTop1)
        self:addChild(top1)
        top1:setPosition(x, y + 50)
        -- bottom1:addChild(top1)
        -- top1:setPosition(90, bottom:getContentSize().height - 45)
        -- top1:setAnchorPoint(0.5, 45 / top1:getContentSize().height)

        local fotop = cc.FadeTo:create(duration, minOpacity)
        local fitop = cc.FadeTo:create(duration, maxOpacity)
        local focbtop = cc.CallFunc:create(function() top:setSpriteFrame(frameTop2) end)
        local ficbtop = cc.CallFunc:create(function() top:setSpriteFrame(frameTop1) end)
        local seqtop = cc.Sequence:create(fotop, focbtop, fitop, ficbtop)
        local rftop = cc.RepeatForever:create(seqtop)
        top1:runAction(rftop)

        
        local top2 = cc.Sprite:createWithSpriteFrame(frameTop2)
        -- bottom2:addChild(top2)
        -- top2:setPosition(90, bottom:getContentSize().height - 45)
        -- top2:setAnchorPoint(0.5, 45 / top2:getContentSize().height)
        self:addChild(top2)
        top2:setPosition(x, y + 50)
        top2:setOpacity(minOpacity)
        local fo2top = cc.FadeTo:create(duration, minOpacity)
        local fi2top = cc.FadeTo:create(duration, maxOpacity)
        local seq2top = cc.Sequence:create(fi2top, fo2top)
        local rf2top = cc.RepeatForever:create(seq2top)
        top2:runAction(rf2top)
    end

    local function createGroundAt(x, y, fromIndex, toIndex, z)
        local spriteFrame = cc.SpriteFrame:createWithTexture(texture, {x = (fromIndex - 1) * (tileSize.width + gap), y = 0, width = tileSize.width, height = tileSize.height})
        local spriteFrame2 = cc.SpriteFrame:createWithTexture(texture, {x = (toIndex - 1) * (tileSize.width + gap), y = 0, width = tileSize.width, height = tileSize.height})

        local bottom = cc.Sprite:createWithSpriteFrame(spriteFrame)
        self:addChild(bottom)
        bottom:setPosition(x, y)
        -- bottom:setLocalZOrder(z)
        
        local tile1 = cc.Sprite:createWithSpriteFrame(spriteFrame)
        self:addChild(tile1)
        tile1:setPosition(x, y)
        -- tile1:setLocalZOrder(z + 1)
        -- local fo = cc.FadeOut:create(duration)
        -- local fi = cc.FadeIn:create(duration)
        local fo = cc.FadeTo:create(duration, minOpacity)
        local fi = cc.FadeTo:create(duration, maxOpacity)
        local focb = cc.CallFunc:create(function() bottom:setSpriteFrame(spriteFrame2) end)
        local ficb = cc.CallFunc:create(function() bottom:setSpriteFrame(spriteFrame) end)
        -- local focb = cc.CallFunc:create(function() tile1:setLocalZOrder(z + 1) bottom:setSpriteFrame(spriteFrame2) end)
        -- local ficb = cc.CallFunc:create(function() tile1:setLocalZOrder(z + 2) 
        --     bottom:setSpriteFrame(spriteFrame) end)
        local seq = cc.Sequence:create(fo, focb, fi, ficb)
        -- local seq = cc.Sequence:create(fo, fi)
        local rf = cc.RepeatForever:create(seq)
        tile1:runAction(rf)

        
        local tile2 = cc.Sprite:createWithSpriteFrame(spriteFrame2)
        self:addChild(tile2)
        tile2:setPosition(x, y)
        -- tile2:setLocalZOrder(2)
        -- local fi2 = cc.FadeIn:create(duration)
        -- local fo2 = cc.FadeOut:create(duration)
        tile2:setOpacity(minOpacity)
        local fo2 = cc.FadeTo:create(duration, minOpacity)
        local fi2 = cc.FadeTo:create(duration, maxOpacity)
        -- local focb2 = cc.CallFunc:create(function() tile2:setLocalZOrder(z + 1) end)
        -- local ficb2 = cc.CallFunc:create(function() tile2:setLocalZOrder(z + 2) end)
        -- local seq2 = cc.Sequence:create(fi2, ficb2, fo2, focb2)
        local seq2 = cc.Sequence:create(fi2, fo2)
        local rf2 = cc.RepeatForever:create(seq2)
        tile2:runAction(rf2)
    end
    

    -- createGroundAt(91, 180, 1, 5, 1)
    -- createGroundAt(270, 180, 1, 5, 1)
    -- createGroundAt(180, 136, 1, 5, 2)

    createWallAt(90, 180)
    createWallAt(270, 180)
    createWallAt(180, 136)
end 

local groundColors = {
    {r = 201, g = 145, b = 115},
    {r = 178, g = 130, b = 93},
    {r = 170, g = 119, b = 92},
    {r = 145, g = 89, b = 76},
    {r = 116, g = 67, b = 67},
    {r = 81, g = 52, b = 60},
}
local wallColors = {
    {r = 174, g = 143, b = 127},
    {r = 149, g = 126, b = 94},
    {r = 126, g = 100, b = 68},
    {r = 124, g = 88, b = 64},
    {r = 114, g = 74, b = 52},
    {r = 95, g = 53, b = 58},
}


function TestLayer:createOverlayers()
    local TextureAtlasOverlayer = require "app.mapkit.TextureAtlasOverlayer"
    TextureAtlasOverlayer.overlay("map/map.plist", {
        ["map_floor01.png"] = groundColors,
        ["map_wall01.png"] = wallColors,
        ["map_wall02.png"] = wallColors,
    })
end

function TestLayer:createTileCover(color, tileSize, height, scale)
    local w = tileSize.width * scale
    local h = tileSize.height * scale
    local zh = height * scale
    local target = cc.RenderTexture:create(w, h + zh, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
    target:retain()
    target:setPosition(w * 0.5, (h + zh) * 0.5)
    -- self:addChild(target, -1)
    self.target = target

    local drawNode = cc.DrawNode:create()
    target:begin()
    local numberOfPoints = 6
    local numberOfPointsPerSeg = 100
    local poli = {}
    poli[1] = {x = w * 0.5, y = 0}
    poli[2] = {x = w, y = h * 0.5,}
    poli[3] = {x = w, y = h * 0.5 + zh}
    poli[4] = {x = w * 0.5, y = h + zh}
    poli[5] = {x = 0, y = h * 0.5 + zh}
    poli[6] = {x = 0, y = h * 0.5}
    drawNode:drawSolidPoly(poli, numberOfPoints, color)
    -- local newPoli = {}
    -- for i = 1, numberOfPoints do
    --     local src = poli[i]
    --     local dst = {}
    --     if i ~= 4 then
    --         dst = poli[i + 1]
    --     else 
    --         dst = poli[1]
    --     end
    --     for j = 1, numberOfPointsPerSeg do
    --         local p = {x = src.x + (dst.x - src.x) / numberOfPointsPerSeg * j, y = src.y + (dst.y - src.y) / numberOfPointsPerSeg * j}
    --         newPoli[#newPoli + 1] = p 
    --     end
    -- end
    -- drawNode:drawSolidPoly(newPoli, numberOfPoints * numberOfPointsPerSeg, color)
    drawNode:visit()

    target:endToLua()
    -- print("writablePath: " .. writablePath)
    target:saveToFile("tile.png", cc.IMAGE_FORMAT_PNG)

    

    local tex = target:getSprite():getTexture()
    assert(tex ~= nil, "add texture failed")
    local sp = cc.Sprite:createWithTexture(tex)
    assert(sp ~= nil, "create sprite failed")
    -- self:addChild(sp)
    -- sp:setPosition(cc.p(40, 40))
    return sp
end

function TestLayer:getBlender(blendColor, thresholdAlpha)
    -- local glProgram = cc.GLProgram:createWithFilenames("TexturePositionColorShader.vert", "OverlayShader.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    local glProgramState = AvalonUtil:getGLProgramState("TexturePositionColorShader.vert", "OverlayShader.frag")

    glProgramState:setUniformVec4("v_blendColor", blendColor)
    if thresholdAlpha ~= nil then
        glProgramState:setUniformFloat("v_thresholdAlpha", thresholdAlpha)
    end
    return glProgramState
end

function TestLayer:createOverlayRenderTest()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("map/map.plist", "map/map.png")
    local groundColors = {
        {r = 201, g = 145, b = 115},
        {r = 178, g = 130, b = 93},
        {r = 170, g = 119, b = 92},
        {r = 145, g = 89, b = 76},
        {r = 116, g = 67, b = 67},
        {r = 81, g = 52, b = 60},
    }
    local wallColors = {
        {r = 174, g = 143, b = 127},
        {r = 149, g = 126, b = 94},
        {r = 126, g = 100, b = 68},
        {r = 124, g = 88, b = 64},
        {r = 114, g = 74, b = 52},
        {r = 95, g = 53, b = 58},
    }
    local x, y = 0, 100
    for i = 1, #groundColors do
        print ("ground x:" .. x)
        local tile = cc.Sprite:createWithSpriteFrameName("map_floor01.png"):move(x, y):setAnchorPoint(0, 0):addTo(self)
        local color = groundColors[i]
        color.a = 128
        local colorVec4 = MapHelper.c4b_to_vec4(color)
        local glProgramState = self:getBlender(colorVec4, 0.0)
        tile:setGLProgramState(glProgramState)

        x = x + tile:getBoundingBox().width * 0.5
    end

    x, y = 0, 200
    for i = 1, #wallColors do
        print ("wall x:" .. x)
        local tile = cc.Sprite:createWithSpriteFrameName("map_wall02.png"):move(x, y):setAnchorPoint(0, 0):addTo(self)
        local color = wallColors[i]
        color.a = 128
        local colorVec4 = MapHelper.c4b_to_vec4(color)
        local glProgramState = self:getBlender(colorVec4, 0.0)
        tile:setGLProgramState(glProgramState)

        x = x + tile:getBoundingBox().width * 0.5
    end
end

function TestLayer:createPahtFinderTest()
    local map = {
        {0,1,0,1,0},
        {0,1,0,1,0},
        {0,1,1,1,0},
        {0,0,0,0,0},
    }
    -- Value for walkable tiles
    local walkable = 0

    -- Creates a grid object
    local grid = Grid(map) 
    -- Creates a pathfinder object using Jump Point Search
    local myFinder = Pathfinder(grid, 'JPS', walkable) 

    -- Define start and goal locations coordinates
    local startx, starty = 1,1
    local endx, endy = 5,1

    -- Calculates the path, and its length
    local path = myFinder:getPath(startx, starty, endx, endy)
    if path then
      print(('Path found! Length: %.2f'):format(path:getLength()))
        for node, count in path:nodes() do
          print(('Step: %d - x: %d - y: %d'):format(count, node.x, node.y))
        end
    end
end

function TestLayer:createAnnotatedPathing()    
    local map = {
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,1,0},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,1,0,0,0,0,0,0},
        {0,0,1,0,0,0,0,0,2,0},
        {0,0,1,1,1,0,0,2,0,0},
        {0,0,0,1,1,0,2,0,0,2},
        {0,0,0,0,1,0,0,0,0,2},
        {0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0}
    }
    local grid = Grid(map)
    local walkable = function(v) return v~=2 end
    local finder = Pathfinder(grid, 'ASTAR',walkable)
    local finderNames = Pathfinder:getFinders()

    local sx, sy = 1,1
    local ex, ey = 9,9
    local agent_size = 2

    for i = 1,#finderNames do
        finder:setFinder(finderNames[i])
        local path = finder:getPath(sx, sy, ex, ey, agent_size)
        print(('Algorithm used: %s - Path %s')
            :format(finder:getFinder(), path and 'found' or 'not found'))
        if path then
            for node, count in path:nodes() do
                print(('  Step %d. (%d,%d)')
                    :format(count, node.x, node.y))
            end
        end
    end
end

return TestLayer