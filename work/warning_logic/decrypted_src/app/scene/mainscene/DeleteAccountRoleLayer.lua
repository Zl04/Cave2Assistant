------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/14
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
require("app.utils.ServerConfigUtil")

UI = UI or {}
local DeleteAccountRoleLayer = class("DeleteAccountRoleLayer", UI.BaseWin)
UI.DeleteAccountRoleLayer = DeleteAccountRoleLayer

local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
    "ui_login.plist",
}

local COM_WIDTH = 489
local COM_HEIGHT = 307

function DeleteAccountRoleLayer:ctor(showType,roleList,nowTime,minDeleteTime,maxDeleteTime, avalonLoginToken)
    self._showType = showType -- 1 = 没有角色或者有角色,提示谨慎删除操作的内容     2 = 处理角色删除中, 登录失败时弹出的对话框(包含立即删除、解除删除和取消 3个按钮)
    self._roleList = roleList
    self._nowTime = nowTime
    self._minDeleteTime = minDeleteTime
    self._maxDeleteTime = maxDeleteTime
    self._avalonLoginToken = avalonLoginToken
    self._cTime = 30


    self._deleteRoleCallBack = nil
    self._immediatelyDeleteCallBack = nil
    self._liftCallBack = nil
    self._closeCallBack = nil
    DeleteAccountRoleLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:init()
    self:bindModel()
end

function DeleteAccountRoleLayer:init( ... )
    DeleteAccountRoleLayer.super.init(self, ... )

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:setCloseFinishCallBack(handler(self, function()
        
    end))
end

function DeleteAccountRoleLayer:dtor()
    DeleteAccountRoleLayer.super.dtor(self)
    self:unbindModel()
    -- reload_script_file_mvc("app.modules.deleteaccountrole.DeleteAccountRoleLayer")
end


function DeleteAccountRoleLayer:onInitView()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 背景图片
    local innerImg  = UI.Image:create()
    innerImg:init("ui_setup_banner_paper.png")
    innerImg:center()
    contentLayout:addChild(innerImg)
    self._bg = innerImg

    local title = UI.Text:create()
    title:init(UI.TEXT_222300, UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 54, g = 53, b = 55})
    title:centerUp(13)
    contentLayout:addChild(title)

    self:createContentDes()

    self:createBottomBtn()

end

function DeleteAccountRoleLayer:setDeleteRoleCallBack(callback)
    self._deleteRoleCallBack = callback
end

function DeleteAccountRoleLayer:setImmediatelyDeleteCallBack(callback)
    self._immediatelyDeleteCallBack = callback
end

function DeleteAccountRoleLayer:setLiftCallBack(callback)
    self._liftCallBack = callback
end

function DeleteAccountRoleLayer:setCloseCallBack(callback)
    self._closeCallBack = callback
end

function DeleteAccountRoleLayer:createBottomBtn()
    if self._showType == 1 then
        if table.nums(self._roleList) > 0 then
            local leftBtn = UI.Button:create()
            leftBtn:init('ui_setup_btn_select.png', 'ui_setup_btn_select.png', 'ui_setup_btn_normal.png')
            leftBtn:centerBottom(18, -125)
            leftBtn:setText(UI.TEXT_1213433 .. "(30s)")
            leftBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            leftBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                --确认删除消息
                ServerConfigUtil:deleteAccountRoleData(function(response)
                    -- -- 解开JSON并设置获取到的数据
                    -- local data = json.decode(response)
                    -- printInfo("ServerConfigUtil:queryGameLogin, 获得Web返回数据:", data)

                    if self._deleteRoleCallBack then
                        self._deleteRoleCallBack()
                    end

                    self:close()
                    
                end)

            end)
            self._contentLayout:addChild(leftBtn)
            leftBtn:disable()

            leftBtn:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(function()    
                self._cTime = self._cTime - 1
                if self._cTime > 0 then
                    leftBtn:setText(UI.TEXT_1213433 .. "(" .. self._cTime .. "s)")
                else
                    leftBtn:setText(UI.TEXT_1213433)
                    leftBtn:enable()
                end
            end))))

            local rightBtn = UI.Button:create()
            rightBtn:init('ui_setup_btn_select.png', 'ui_setup_btn_select.png', 'ui_setup_btn_normal.png')
            rightBtn:centerBottom(18, 125)
            rightBtn:setText(UI.TEXT_110012)
            rightBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            rightBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                --关闭界面
                self:close()
            end)
            self._contentLayout:addChild(rightBtn)


        else
            local okBtn = UI.Button:create()
            okBtn:init('ui_setup_btn_select.png', 'ui_setup_btn_select.png', 'ui_setup_btn_select.png')
            okBtn:centerBottom(18)
            okBtn:setText(UI.TEXT_1213433)
            okBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                self:close()
            end)
            self._contentLayout:addChild(okBtn)
        end
    elseif self._showType == 2 then

        local leftBtn = UI.Button:create()
        leftBtn:init('ui_setup_btn_select.png', 'ui_setup_btn_select.png', 'ui_setup_btn_normal.png')
        leftBtn:centerBottom(18, -156)
        leftBtn:setText(UI.TEXT_222301)
        leftBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        leftBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            --立即删除消息
            ServerConfigUtil:immediatelyDeleteAccountRoleData(self._avalonLoginToken, function()

                if self._immediatelyDeleteCallBack then
                    self._immediatelyDeleteCallBack()
                end

                self:close()
                
            end)

        end)
        self._contentLayout:addChild(leftBtn)
        leftBtn:disable()

        local leftText = UI.Text:create()
        leftText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 54, g = 53, b = 55})
        leftText:centerBottom(0, -156)
        self._contentLayout:addChild(leftText)
        
        local timeLeft = math.floor( (self._minDeleteTime - self._nowTime) / 1000)
        local hour = math.floor(timeLeft / 3600)
        local minute = math.floor( (timeLeft - hour*3600) / 60)
        local second = timeLeft - hour*3600 - minute*60
        local hourStr = string.format("%02d",hour)
        local minuteStr = string.format("%02d",minute)
        local secondStr = string.format("%02d",second)
        leftText:setText("(" .. hourStr .. ":" .. minuteStr .. ":" .. secondStr .. ")")

        leftBtn:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(function()    
            timeLeft = timeLeft - 1
            if timeLeft > 0 then
                local hour = math.floor(timeLeft / 3600)
                local minute = math.floor( (timeLeft - hour*3600) / 60)
                local second = timeLeft - hour*3600 - minute*60
                local hourStr = string.format("%02d",hour)
                local minuteStr = string.format("%02d",minute)
                local secondStr = string.format("%02d",second)

                leftText:setText("(" .. hourStr .. ":" .. minuteStr .. ":" .. secondStr .. ")")
            else
                leftText:setText("")
                leftBtn:enable()
            end
        end))))

        local centerBtn = UI.Button:create()
        centerBtn:init('ui_setup_btn_select.png', 'ui_setup_btn_select.png', 'ui_setup_btn_normal.png')
        centerBtn:centerBottom(18)
        centerBtn:setText(UI.TEXT_222302)
        centerBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        centerBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            --解除删除消息

            ServerConfigUtil:liftDeleteAccountRoleData(self._avalonLoginToken, function()

                if self._liftCallBack then
                    self._liftCallBack()
                end

                self:close()
                
            end)

        end)
        self._contentLayout:addChild(centerBtn)


        local rightBtn = UI.Button:create()
        rightBtn:init('ui_setup_btn_select.png', 'ui_setup_btn_select.png', 'ui_setup_btn_normal.png')
        rightBtn:centerBottom(18, 156)
        rightBtn:setText(UI.TEXT_110012)
        rightBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        rightBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            

            if self._closeCallBack then
                self._closeCallBack()
            end

            --关闭界面
            self:close()
        end)
        self._contentLayout:addChild(rightBtn) 


    end

end

function DeleteAccountRoleLayer:createContentDes()
    local str = ""

    if self._showType == 1 then
        if table.nums(self._roleList) > 0 then
            str = UI.TEXT_222304
        else
            str = UI.TEXT_222303
        end
    elseif self._showType == 2 then
        local day = math.floor( (self._maxDeleteTime - self._nowTime) / 86400000)
        if day < 0 then
            day = 0
        end
        str = string.format(UI.TEXT_222305,day)
    end

    local desText = UI.Text:create()
    desText:init(str, UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 54, g = 53, b = 55})
    
    desText:setWidth(420)
    desText:setTextCenter()

    if desText:getContentSize().height > 165 then
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(420, desText:getContentSize().height)

        desText:center()
        layout:addChild(desText)
        layout:center()

        local view = UI.ScrollView:create()
        view:setSize(420, 165)
        view:init(0,0,0,0)
        view:leftBottom(26, 78)
        view:addInnerNode(layout)
        view:setScrollType(UI.ScrollType.VERTICAL)
        self._contentLayout:addChild(view)
    else
        desText:center(0,-15)
        self._contentLayout:addChild(desText)
    end

end

function DeleteAccountRoleLayer:bindModel()

end


function DeleteAccountRoleLayer:unbindModel()

end





return DeleteAccountRoleLayer












