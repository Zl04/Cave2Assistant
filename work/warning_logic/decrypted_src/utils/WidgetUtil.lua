require "app.ui.baglayer.RoleShow.RoleAnimation"

local WidgetUtil = {}
Avalon.WidgetUtil = WidgetUtil

WidgetUtil.headDataList = {}
WidgetUtil.headLoadSuccess = false

-- 在textureSprite上根据maskSpriteList进行剔除
function WidgetUtil:minusAlpha(textureSprite,maskSpriteList)
    local rt = cc.RenderTexture:create(textureSprite:getContentSize().width, textureSprite:getContentSize().height);

    textureSprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_ALPHA , gl.ZERO))

    rt:begin()
    for k,v in pairs(maskSpriteList) do
    	v:visit()
    end

    textureSprite:visit();
    rt:endToLua()

    local retval = cc.Sprite:createWithTexture(rt:getSprite():getTexture());
    retval:setFlipY(true);

    return retval
end

function WidgetUtil:getHeadByData(parent,sex,faceDecodeID, heroIDList, obj,callfunc,clipperPic)
    -- print("WidgetUtil:getHeadByData",parent,sex,faceDecodeID)
    -- print(debug.traceback())
    if sex == nil and faceDecodeID == nil then
        print("!!error!!  WidgetUtil:getHeadByData",sex,faceDecodeID)
        return
    end
    local wearEquipmentDataArr = {}
    for k,v in pairs(heroIDList) do
        -- add by zp 这里统一把幻化ID装换为幻化后具体的装备ID
        local equipmentID = ToolsUtil:handleNoMasterEquipmentID(v)
        if v ~= 0 and equipmentID ~= 0 then
            local goodsData = GoodsDataManager:createLocalGoodsData(equipmentID)
            if(goodsData) then
                goodsData:setWearPosition(goodsData:getEquipmentType())
                table.insert(wearEquipmentDataArr,goodsData)
            end
        end
    end

    local heroData = Data.HeroData:create()
    heroData:setSex(sex)
    heroData:setFaceDecodeID(faceDecodeID)
    heroData:setLooks(0)
    Avalon.WidgetUtil:getHead(parent,heroData,wearEquipmentDataArr,obj,callfunc,false,clipperPic)
end

--获取头像
function WidgetUtil:getHead(parent,heroData, wearEquipmentDataArr,obj,callfunc,userParent,clipperPic, scale, pos, refreshHeroRenderEquipmentChange)
    -- print("WidgetUtil:getHead")
    local _obj = obj
    local _callfunc = callfunc
    local _wearEquipmentData = wearEquipmentDataArr
    local _heroData = heroData

    local headData = {}
    headData.heroData = heroData
    headData.sex = heroData:getSex()
    headData.faceDecodeID = heroData:getFaceDecodeID()
    headData.wearEquipmentDataArr = wearEquipmentDataArr
    headData._callfunc = callfunc
    headData.clipperPic = clipperPic or "ui_playerstate_me_black_up.png"
    headData._scale = scale or 0.6
    headData._obj = obj
    headData.pos = pos or cc.p(0,0)
    headData.refreshHeroRenderEquipmentChange = refreshHeroRenderEquipmentChange
    if userParent then
        headData.parent = parent
    else
        headData.parent = UI.UIManager:getRootNode()
    end
    headData.isHideHelmet = heroData:getIsHideHelmet()
    table.insert(self.headDataList,headData)
    if #self.headDataList == 1 then
        -- print("WidgetUtil:getHead 1")
        -- printInfo(debug.traceback())
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            self:exportHead()
        end, 1)
    end

end


function WidgetUtil:exportHead()
    if #self.headDataList < 1 then
        return
    end
    local headData = self.headDataList[1]
    -- print("WidgetUtil:exportHead")
    local parent = headData.parent
    if parent == nil or tolua.isnull(parent) then
        -- print("WidgetUtil:exportHead parent is nil.")
        -- print(debug.traceback())

        table.remove(self.headDataList,1)
        self:changeNextExport()
        return
    end
    local _roleAnimation = parent:getChildByName("roleAnimationHead"..headData.sex)
    if _roleAnimation and self.headLoadSuccess then
        -- _roleAnimation._roleRenderer:restore()
        _roleAnimation:refreshFace(headData.faceDecodeID or 3010101)
        -- print("####",#self.headDataList[1].wearEquipmentDataArr)
        if not headData.refreshHeroRenderEquipmentChange then
            if(headData.isHideHelmet) then
                _roleAnimation:hideHelmet()
            else 
                _roleAnimation:showHelmet()
            end
            _roleAnimation:updateRoleEquipment(headData.wearEquipmentDataArr)
        end
        _roleAnimation:updataLooks(0)
        -- _roleAnimation:getRoleRender():showAnimation("attack_1_0")
        _roleAnimation:getRoleRender():getRoleAnimation():pause()
        _roleAnimation:setScale(headData._scale)

        local _RenderTexture = cc.RenderTexture:create(300, 300, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

        _roleAnimation:setVisible(true)
        _RenderTexture:begin()
        _roleAnimation:visit()
        _RenderTexture:endToLua()
        _roleAnimation:setVisible(false)

        local _pic = cc.Sprite:createWithTexture(_RenderTexture:getSprite():getTexture())
        _pic:setPosition(headData.pos)
        _pic:setName("pic")
        -- _pic:setAnchorPoint(cc.p(0,0))
        _pic:setScaleY(-1)
        _pic:setScaleX(-1)

        local _ckipperSprite = cc.Sprite:createWithSpriteFrameName(headData.clipperPic or "ui_playerstate_me_black_up.png")
        local _clipper = cc.ClippingNode:create(_ckipperSprite)
        _clipper:setPosition(0,0)
        _clipper:setAlphaThreshold(0.05)
        _clipper:addChild(_pic,20)

        table.remove(self.headDataList,1)
        self:changeNextExport()
        if headData._obj and (not tolua.isnull(headData._obj)) and headData._callfunc then
            headData._callfunc(_clipper, headData.faceDecodeID)
        end
    else
        -- print("WidgetUtil:exportHead1111")
        _roleAnimation = UI.RoleAnimation:create(false)
        _roleAnimation:updataLooks(0)
        _roleAnimation:addEventListener(UIEvent.ROLE_LOADED_SPINE_SUCCESS, self, function()
            Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function()
                if tolua.isnull(_roleAnimation) then
                    self:changeNextExport()
                    return
                end
                _roleAnimation:updataLooks(0)

                if not headData.refreshHeroRenderEquipmentChange then
                    if(headData.isHideHelmet) then
                        _roleAnimation:hideHelmet()
                    else 
                        _roleAnimation:showHelmet()
                    end
                    _roleAnimation:updateRoleEquipment(headData.wearEquipmentDataArr)
                end

                _roleAnimation:getRoleRender():showAnimation("attack_1_0")
                _roleAnimation:getRoleRender():getRoleAnimation():pause()
                local _RenderTexture = cc.RenderTexture:create(300, 300, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

                _roleAnimation:setVisible(true)
                _RenderTexture:begin()
                _roleAnimation:visit()
                _RenderTexture:endToLua()
                _roleAnimation:setVisible(false)

                local _pic = cc.Sprite:createWithTexture(_RenderTexture:getSprite():getTexture())
                _pic:setPosition(headData.pos)
                _pic:setName("pic")
                -- _pic:setAnchorPoint(cc.p(0,0))
                _pic:setScaleY(-1)
                _pic:setScaleX(-1)

                -- local _ckipperSprite = cc.Sprite:createWithSpriteFrameName("ui_playerstate_me_black_up.png")
                local _ckipperSprite = cc.Sprite:createWithSpriteFrameName(headData.clipperPic or "ui_playerstate_me_black_up.png")
                local _clipper = cc.ClippingNode:create(_ckipperSprite)
                _clipper:setPosition(0,0)
                _clipper:setAlphaThreshold(0.05)
                _clipper:addChild(_pic,20)

                -- print("WidgetUtil:exportHead$$$$$$$")
                self.headLoadSuccess = true
                table.remove(self.headDataList,1)
                self:changeNextExport()
                if headData._obj and (not tolua.isnull(headData._obj)) and headData._callfunc then
                    -- print("WidgetUtil:exportHead!!!!!!!!")
                    headData._callfunc(_clipper, headData.faceDecodeID)
                end
            end, 1)
        end)
        _roleAnimation:init(headData.heroData)
        _roleAnimation:leftBottom(95,25)
        _roleAnimation:setScale(headData._scale)
        _roleAnimation:setName("roleAnimationHead"..headData.sex)
        parent:addChild(_roleAnimation)
        _roleAnimation:setVisible(false)
    end
end

function WidgetUtil:changeNextExport()
    if #self.headDataList >= 1 then
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            self:exportHead()
        end, 1)
    end
end

function WidgetUtil:getShader(shaderDefine)
    assert(type(shaderDefine) == "table", "Component createShader: shader define is invalid.")

    if (shaderDefine) then
        local shaderKey = shaderDefine.KEY
        local vertShader = shaderDefine.VERT_SHADER
        local fragShader = shaderDefine.FRAG_SHADER

        -- local glProgram = cc.GLProgramCache:getInstance():getGLProgram(shaderKey)
        -- if (not glProgram) then
        --     glProgram = cc.GLProgram:createWithFilenames(vertShader, fragShader)
        --     cc.GLProgramCache:getInstance():addGLProgram(glProgram, shaderKey)
        -- end
        -- if (glProgram) then
        --     return cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
        -- end
        return AvalonUtil:getGLProgramState(vertShader, fragShader, shaderKey)
    else
        assert(false)
    end
    assert(false)
    return nil
end



function WidgetUtil:clippingView(obj,callfunc)
    print("WidgetUtil:clippingView")
 
    local _obj = obj
    local _callfunc = callfunc
    local function afterCaptured(succeed, image)  
        if succeed then  
            local winSize = cc.Director:getInstance():getWinSize()
            local texture = cc.Texture2D:new()
            texture:initWithImage(image)
            local textur = cc.Sprite:createWithTexture(texture)  
            -- textur:setScaleX(textur:getContentSize().width * winSize.width / 1024)
            -- textur:setScaleY(textur:getContentSize().height * winSize.height / 768)
            textur:setPosition(winSize.width / 2, winSize.height / 2)

            local properties = cc.Properties:createNonRefCounted("Materials/2d_effects.material#sample")

            local mat1 = cc.Material:createWithProperties(properties)
            textur:setGLProgramState(mat1:getTechniqueByName("blur"):getPassByIndex(0):getGLProgramState())


            _callfunc(_obj,textur)

        else  
            cclog("Capture screen failed.")  
        end  
    end
    if UI.UIManager.mMainUILayer and (not tolua.isnull(UI.UIManager.mMainUILayer)) then
        UI.UIManager.mMainUILayer:setVisible(false)
    end
    if UI.UIManager.mActivityLayer and (not tolua.isnull(UI.UIManager.mActivityLayer)) then
        UI.UIManager.mActivityLayer:setVisible(false)
    end

    cc.utils:captureScreenToImage(afterCaptured) 
    
    if UI.UIManager.mMainUILayer and (not tolua.isnull(UI.UIManager.mMainUILayer)) then
        UI.UIManager.mMainUILayer:setVisible(true)
    end
    if UI.UIManager.mActivityLayer and (not tolua.isnull(UI.UIManager.mActivityLayer)) then
        UI.UIManager.mActivityLayer:setVisible(true)
    end

    return texturenew ;
end

--png 散图资源名字
function WidgetUtil:generalOutlineWithFileName(fileName, outLineColor)
    local ckipperSprite = cc.Sprite:create()
    ckipperSprite:initWithFile(fileName)

    local bottomSprite = cc.Sprite:create()
    bottomSprite:initWithFile(fileName)
    return self:generalOutline(ckipperSprite, bottomSprite)
end

--png 纹理资源名字
function WidgetUtil:generalOutlineWithFramName(framName, outLineColor)
    local ckipperSprite = cc.Sprite:create()
    ckipperSprite:setSpriteFrame(framName)

    local bottomSprite = cc.Sprite:create()
    bottomSprite:setSpriteFrame(framName)
    return self:generalOutline(ckipperSprite, bottomSprite)
end


function WidgetUtil:generalOutline(modeSprite, bottomSprite, outLineColor)
    local color = outLineColor or cc.vec4(1.0, 0, 0, 1.0)

    local node = cc.Node:create()
    node:setContentSize(bottomSprite:getContentSize().width, bottomSprite:getContentSize().height)
    modeSprite:setScale(0.970)
    node:addChild(modeSprite)

    local _clipper = cc.ClippingNode:create()
    _clipper:setStencil(node)
    _clipper:setPosition(0, 0)
    _clipper:setAlphaThreshold(0.5)
    _clipper:setInverted(true)
    _clipper:addChild(bottomSprite)

    local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    glProgramState:setUniformVec4("u_lightColor", color)
    _clipper:setGLProgramState(glProgramState)

    return _clipper
    -- local _renderTexture = cc.RenderTexture:create(bottomSprite:getContentSize().width, bottomSprite:getContentSize().height, cc.TEXTURE2_D_PIXEL_FORMAT_RG_B565)
    -- -- if _renderTexture.ignoreAnchorPointForPosition then
    -- --     _renderTexture:ignoreAnchorPointForPosition(true);
    -- -- else
    -- --     _renderTexture:setIgnoreAnchorPointForPosition(true);
    -- -- end
    -- _clipper:setPosition(bottomSprite:getContentSize().width / 2, bottomSprite:getContentSize().height / 2)             
    -- _renderTexture:begin()
    -- _clipper:visit()
    -- _renderTexture:endToLua()
    -- local _pic = cc.Sprite:createWithTexture(_renderTexture:getSprite():getTexture())
    -- return _pic
end
  



