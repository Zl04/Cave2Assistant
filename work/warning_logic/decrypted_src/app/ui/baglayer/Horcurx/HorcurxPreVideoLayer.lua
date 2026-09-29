------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/21
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require 'app.game.LanguageManager'
local languageManagerInstance = LanguageManager:getInstance()
local HorcurxPreVideoLayer = class('HorcurxPreVideoLayer', UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local layoutUtil
function HorcurxPreVideoLayer:ctor()
    HorcurxPreVideoLayer.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
end

function HorcurxPreVideoLayer:dtor()
    HorcurxPreVideoLayer.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc('app.ui.baglayer.Horcurx.HorcurxPreVideoLayer')
end

function HorcurxPreVideoLayer:onInitView()
    local itemBG = UI.Image:create()
    itemBG:init('ui_horcrux_video_paper.png')
    itemBG:center()
    self:addChild(itemBG)
    
    local closeBtn = UI.Button:create()
    closeBtn:init('ui_horcrux_video_close_0.png', 'ui_horcrux_video_close_1.png')
    closeBtn:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function()
            self:removeFromParent()
        end
    )
    closeBtn:rightUp(65, 40)
    self:addChild(closeBtn, 1001)


    local loadEffect = UI.Animation:create()
    loadEffect:init("effect_ui_town_horcruxes_loading.json", "effect_ui_town_horcruxes_loading.atlas", 1);
    loadEffect:center()
    loadEffect:setAnimation("idle", true)
    self:addChild(loadEffect, 20)

    self:showVideo()
end

function HorcurxPreVideoLayer:showVideo()
    if (device.platform == "mac" or device.platform == "windows") then
        print("-!!!!!! please use iphone or android~")
        return
    end
    local function onVideoEventCallback(sener, eventType)
        if eventType == ccexp.VideoPlayerEvent.PLAYING then
            print('PLAYING')
        elseif eventType == ccexp.VideoPlayerEvent.PAUSED then
            print('PAUSED')
        elseif eventType == ccexp.VideoPlayerEvent.STOPPED then
            print('STOPPED')
            -- local loadEffect = UI.Animation:create()
            -- loadEffect:init("effect_ui_town_horcruxes_loading.json", "effect_ui_town_horcruxes_loading.atlas", 1);
            -- loadEffect:center()
            -- loadEffect:setAnimation("idle", true)
            -- self:addChild(loadEffect, 20)
            -- Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function()
            --     loadEffect:removeFromParent()
            -- end, 0.2)
        elseif eventType == ccexp.VideoPlayerEvent.COMPLETED then
            print('COMPLETED')
            self:runAction(cc.RemoveSelf:create())
        end
    end
    local videoPlayer = ccexp.VideoPlayer:create()
    videoPlayer:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    videoPlayer:setAnchorPoint(cc.p(0.5, 0.5))
    videoPlayer:setContentSize(cc.size(642, 362))
    videoPlayer:addEventListener(onVideoEventCallback)
    self:addChild(videoPlayer, 100)

    local url = ServerConfigUtil:getAssetsUrl()
    if url == "" or not url then
        return
    end
    
    if nil ~= videoPlayer then
        print(url .. self.url)
        videoPlayer:setURL(url .. self.url)
        videoPlayer:play()
    end
end
function HorcurxPreVideoLayer:setURL(url)
    self.url = url
end
function HorcurxPreVideoLayer:bindModel()
end

function HorcurxPreVideoLayer:unbindModel()
end

return HorcurxPreVideoLayer
