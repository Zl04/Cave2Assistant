local SplashLayer = class("SplashLayer", UI.Component)
UI.SplashLayer = SplashLayer

--构造函数
function SplashLayer:ctor()
    local size = cc.Director:getInstance():getWinSize()
    SplashLayer.super.ctor(self, UIType.MAIN_LAYER, {},size.width, size.height)
    self._logoTextPath = ""
end

--析构函数
function SplashLayer:dtor()
    SplashLayer.super.dtor(self)
    local textureCache = cc.Director:getInstance():getTextureCache()
    textureCache:removeTextureForKey("logo/avalon_logo_bg.png")
    textureCache:removeTextureForKey("logo/avalon_logo_cave2.png")
    -- textureCache:removeTextureForKey("logo/logo_cn_text.png")
    textureCache:removeTextureForKey(self._logoTextPath)
end
-- 初始化视图
function SplashLayer:onInitView()
    local framesize = cc.Director:getInstance():getWinSize()
    local hasLogo = false

    local bg = cc.Sprite:create("logo/avalon_logo_bg.png")
    bg:setAnchorPoint(cc.p(0.5,0.5))
    bg:setPosition(cc.p(framesize.width / 2,framesize.height / 2))
    self:addChild(bg)
    self.bg = bg

    require "app.utils.ImageDownLoadUtil"
    local logoPos = nil
    if ImageDownLoadUtil.getSplashFileName then
        local splashFileName, _logoPos = ImageDownLoadUtil:getSplashFileName()
        logoPos = _logoPos
        if splashFileName ~= nil and splashFileName ~= "" then
            ImageDownLoadUtil:downLoadImage(splashFileName, self.bg, function(imgName, localUrl)
                if(not tolua.isnull(self.bg) and localUrl and localUrl ~= "") then
                    self.bg:setTexture(localUrl)
                end
            end, nil, true)
        end
    end
    
    local framesize = cc.Director:getInstance():getWinSize()
    local autoscale = "FIXED_WIDTH"

    if framesize.width / framesize.height >= CONFIG_SCREEN_WIDTH / CONFIG_SCREEN_HEIGHT then
        autoscale = "FIXED_WIDTH"
    else
        autoscale = "FIXED_HEIGHT"
    end
    local scale = 1
    if autoscale == "FIXED_WIDTH" then
        scale = framesize.width / CONFIG_SCREEN_WIDTH
        print("缩放比例  ",scale ,"裁剪 ",framesize.height - framesize.height * scale)

    elseif autoscale == "FIXED_HEIGHT" then
        scale = framesize.height / CONFIG_SCREEN_HEIGHT
        print("缩放比例  ",scale ,"裁剪 ",framesize.width - framesize.width * scale)
    end

    bg:setScale(scale)

    self._logoTextPath = "logo/logo_cn_text.png"
    local SdkBox = require("utils.sdkbox.SdkBox")
    local channel = SdkBox:getInstance():getVersionChannel()
    channel = checkint(channel)

    print(" channel channelchannelchannel ==== ",channel)
    if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_HUAWEI or
       channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_OPPO then
        self._logoTextPath = "logo/logo_cn_text_huawei.png"
    end

    local logo_text = cc.Sprite:create(self._logoTextPath)
    if logo_text then
        hasLogo = true
        logo_text:setPosition(framesize.width / 2,60)
        self:addChild(logo_text)
        
        --抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。
        local desText =cc.Label:createWithSystemFont(UI.TEXT_221302, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
        desText:setTextColor(UI.FONT_COLOR_247_245_232)
        desText:setPosition(framesize.width / 2,15)
        self:addChild(desText)
    end
    local logo_cave2 = cc.Sprite:create("logo/avalon_logo_cave2.png")
    if logo_cave2 then
        self:addChild(logo_cave2)
        logo_cave2:setAnchorPoint(cc.p(0.5, 0.5))
        local size = logo_cave2:getContentSize()
        --[[1 左上 
        2 右上 
        3 左下 
        4 右下]]
        print("------logoPos-----", logoPos)
        if logoPos == 1 then
            logo_cave2:setPosition(size.width / 2 , framesize.height - size.height / 2)
        elseif logoPos == 2 then
            logo_cave2:setPosition(framesize.width - size.width / 2 , framesize.height - size.height / 2)
        elseif logoPos == 3 then
            logo_cave2:setPosition(size.width / 2 , size.height / 2)
        elseif logoPos == 4 then
            logo_cave2:setPosition(framesize.width - size.width / 2, size.height / 2)
        else
            logo_cave2:setPosition(size.width / 2 , size.height / 2)
        end
    end

    local fadeTime = 0.5
    local duringTime = 2.0

    if (device.platform == "windows") or (device.platform == "mac") then
        fadeTime = 0.1
        duringTime = 5.1
    end


    self:runAction(cc.Sequence:create(cc.DelayTime:create(duringTime), cc.FadeTo:create(fadeTime, fadeTime), cc.CallFunc:create(function()
        Game.Manager:enterLogin()    
    end)))

    
    self:setOpacity(0)
    local fo = cc.FadeTo:create(fadeTime, 255)
    self:runAction(cc.Sequence:create(fo))
end

return SplashLayer