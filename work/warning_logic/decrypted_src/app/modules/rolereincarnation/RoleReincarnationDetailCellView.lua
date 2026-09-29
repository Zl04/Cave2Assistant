------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/03/09
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RoleReincarnationDetailCellView = class("RoleReincarnationDetailCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_package_skill.plist",
}

local COM_WIDTH = 464
local COM_HEIGHT = 36

function RoleReincarnationDetailCellView:ctor(data, index)
    RoleReincarnationDetailCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.data = data
    self.index = index
    self:bindModel()
end

function RoleReincarnationDetailCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.rolereincarnation", "RoleReincarnation", false)
    RoleReincarnationDetailCellView.super.init(self, ... )
end

function RoleReincarnationDetailCellView:dtor()
    RoleReincarnationDetailCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.rolereincarnation.RoleReincarnationDetailCellView")
end


function RoleReincarnationDetailCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_reincarnation_role_list.png")
    bg:center()
    contentLayout:addChild(bg)
    self.bg = bg

    local startX = 95

    -- 文字
    local title = languageManagerInstance:getLocalString(self.data.title)
    local titleText = UI.Text:create()
    titleText:init(title, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText:centerLeft(startX)
    contentLayout:addChild(titleText)
    self.titleText = titleText

    local arrow = UI.Image:create()
    arrow:init("ui_skill_banner_arrow1-1.png")
    arrow:centerLeft(titleText:getContentSize().width+startX+5)
    contentLayout:addChild(arrow)

    local des = languageManagerInstance:getLocalString(self.data.des)
    local offsetX = arrow:getContentSize().width+titleText:getContentSize().width+startX+10
    local desText = UI.Text:create()
    desText:init(des, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desText:centerLeft(offsetX)
    contentLayout:addChild(desText)
    self.desText = desText

    if self.data.detailDes and self.data.detailDes ~= 0 then
        local detailBtn = UI.Button:create() 
        detailBtn:init("ui_shopping_banner_prompt.png", "ui_shopping_banner_prompt.png", "ui_shopping_banner_prompt.png")
        detailBtn:centerLeft(offsetX+desText:getContentSize().width+15)
        contentLayout:addChild(detailBtn)
        detailBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
            self:onClickDetailBtn()
        end)
    end

    self:updateDesView()
end

function RoleReincarnationDetailCellView:updateDesView()
    self.bg:setVisible(self.index%2 ~= 0)
end

function RoleReincarnationDetailCellView:onClickDetailBtn()
    local str = languageManagerInstance:getLocalString(self.data.detailDes)
    local data = {
        tips = str,
        title = UI.TEXT_224302
    }
    mvc.send("RoleReincarnation_Show_Detail_Layer", data)
end

function RoleReincarnationDetailCellView:bindModel()

end


function RoleReincarnationDetailCellView:unbindModel()

end





return RoleReincarnationDetailCellView












