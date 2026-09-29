local Result = {} 
function Result.createConfirmDialog() 

    local result = {} 

    local ConfirmDialog = UI.Image:create()
    ConfirmDialog:init("ui_setup_banner_box3.png")
    ConfirmDialog:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    ConfirmDialog:setReflectPos(22, 21)
    ConfirmDialog:computePosition()
    ConfirmDialog:setName("ConfirmDialog")
    result.ConfirmDialog = ConfirmDialog

    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_btn_no1_0.png", "ui_btn_no1_2.png", "ui_btn_no1_2.png", {x=0, y=0})
    cancelBtn._clickScale = false
    cancelBtn._baseline = 1
    cancelBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cancelBtn:setReflectPos(55, 212)
    cancelBtn:computePosition()
    ConfirmDialog:addChild(cancelBtn)
    cancelBtn:setName("cancelBtn")
    result.cancelBtn = cancelBtn

    local okButton = UI.Button:create()
    okButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png", {x=0, y=0})
    okButton._clickScale = false
    okButton._baseline = 1
    okButton:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    okButton:setReflectPos(258, 212)
    okButton:computePosition()
    ConfirmDialog:addChild(okButton)
    okButton:setName("okButton")
    result.okButton = okButton

    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_setup_banner_box_up.png",{x=0,y=0,width=20,height=20})
    contentBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentBg:setReflectPos(29, 35)
    contentBg:setReflectSize(370, 127)
    contentBg:computePosition()
    ConfirmDialog:addChild(contentBg)
    contentBg:setName("contentBg")
    result.contentBg = contentBg

    local contentTopLine = UI.Image9:create()
    contentTopLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLine:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    contentTopLine:setReflectSize(370, 2)
    contentTopLine:computePosition()
    contentBg:addChild(contentTopLine)
    contentTopLine:setName("contentTopLine")
    result.contentTopLine = contentTopLine

    local contentLabel = UI.Text:create()
    contentLabel:init("test", UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    contentLabel:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    contentLabel:setDimensions(350,0)
    contentLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    contentLabel:computePosition()
    contentBg:addChild(contentLabel)
    contentLabel:setName("contentLabel")
    result.contentLabel = contentLabel

    local confirmButton = UI.Button:create()
    confirmButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png", {x=0, y=0})
    confirmButton._clickScale = false
    confirmButton._baseline = 1
    confirmButton:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    confirmButton:setReflectPos(0, 212)
    confirmButton:computePosition()
    ConfirmDialog:addChild(confirmButton)
    confirmButton:setName("confirmButton")
    result.confirmButton = confirmButton

    result.root = ConfirmDialog 
    return result 
end 

function Result.createBackTownConfirmDialog() 

    local result = {} 

    local BackTownConfirmDialog = UI.Image:create()
    BackTownConfirmDialog:init("ui_setup_banner_box2.png")
    BackTownConfirmDialog:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    BackTownConfirmDialog:setReflectPos(597, 42)
    BackTownConfirmDialog:computePosition()
    BackTownConfirmDialog:setName("BackTownConfirmDialog")
    result.BackTownConfirmDialog = BackTownConfirmDialog

    local cancelBtnBackTown = UI.Button:create()
    cancelBtnBackTown:init("ui_btn_no1_0.png", "ui_btn_no1_2.png", "ui_btn_no1_2.png", {x=0, y=0})
    cancelBtnBackTown._clickScale = false
    cancelBtnBackTown._baseline = 1
    cancelBtnBackTown:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cancelBtnBackTown:setReflectPos(107, 301)
    cancelBtnBackTown:computePosition()
    BackTownConfirmDialog:addChild(cancelBtnBackTown)
    cancelBtnBackTown:setName("cancelBtnBackTown")
    result.cancelBtnBackTown = cancelBtnBackTown

    local okButtonBackTown = UI.Button:create()
    okButtonBackTown:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png", {x=0, y=0})
    okButtonBackTown._clickScale = false
    okButtonBackTown._baseline = 1
    okButtonBackTown:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    okButtonBackTown:setReflectPos(311, 301)
    okButtonBackTown:computePosition()
    BackTownConfirmDialog:addChild(okButtonBackTown)
    okButtonBackTown:setName("okButtonBackTown")
    result.okButtonBackTown = okButtonBackTown

    local moneyBg = UI.Image9:create()
    moneyBg:init("ui_setup_banner_box4.png",{x=0,y=0,width=20,height=20})
    moneyBg:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    moneyBg:setReflectPos(170, 27)
    moneyBg:setReflectSize(197, 27)
    moneyBg:computePosition()
    BackTownConfirmDialog:addChild(moneyBg)
    moneyBg:setName("moneyBg")
    result.moneyBg = moneyBg

    local moneyContentNode = UI.Component:create()
    moneyContentNode:init()
    moneyContentNode:setLayoutType(UI.LayoutDefaultType.CENTER)
    moneyContentNode:setReflectSize(80, 27)
    moneyContentNode:computePosition()
    moneyBg:addChild(moneyContentNode)
    moneyContentNode:setName("moneyContentNode")
    result.moneyContentNode = moneyContentNode

    local moneyIcon = UI.Image:create()
    moneyIcon:init("symbol_gaming_money.png")
    moneyIcon:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    moneyIcon:computePosition()
    moneyContentNode:addChild(moneyIcon)
    moneyIcon:setName("moneyIcon")
    result.moneyIcon = moneyIcon

    local moneyCountLabel = UI.NumberText:create("1", UI.FONT_STANDARD, 18, {r=41,g=41,b=45}, 0)
    moneyCountLabel:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    moneyCountLabel:setReflectPos(30, 0)
    moneyCountLabel:computePosition()
    moneyContentNode:addChild(moneyCountLabel)
    moneyCountLabel:setName("moneyCountLabel")
    result.moneyCountLabel = moneyCountLabel

    local scrollViewLayer = UI.Component:create()
    scrollViewLayer:init()
    scrollViewLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    scrollViewLayer:setReflectPos(65, 63)
    scrollViewLayer:setReflectSize(408, 140)
    scrollViewLayer:computePosition()
    BackTownConfirmDialog:addChild(scrollViewLayer)
    scrollViewLayer:setName("scrollViewLayer")
    result.scrollViewLayer = scrollViewLayer

    local noGoodsText = UI.Text:create()
    noGoodsText:initWithLanguageId(1111286, UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    noGoodsText:setLayoutType(UI.LayoutDefaultType.CENTER)
    noGoodsText:setReflectPos(0, -54)
    noGoodsText:computePosition()
    BackTownConfirmDialog:addChild(noGoodsText)
    noGoodsText:setName("noGoodsText")
    result.noGoodsText = noGoodsText

    local scrollViewMask = UI.Image9:create()
    scrollViewMask:init("ui_setup_banner_mask2.png",{x=250,y=36,width=20,height=20})
    scrollViewMask:setLayoutType(UI.LayoutDefaultType.CENTER)
    scrollViewMask:setReflectSize(408, 36)
    scrollViewMask:computePosition()
    BackTownConfirmDialog:addChild(scrollViewMask)
    scrollViewMask:setName("scrollViewMask")
    result.scrollViewMask = scrollViewMask

    local contentTopLinebackTown2 = UI.Image9:create()
    contentTopLinebackTown2:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLinebackTown2:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    contentTopLinebackTown2:setReflectPos(65, 62)
    contentTopLinebackTown2:setLocalZOrder(1)
    contentTopLinebackTown2:setReflectSize(408, 2)
    contentTopLinebackTown2:computePosition()
    BackTownConfirmDialog:addChild(contentTopLinebackTown2)
    contentTopLinebackTown2:setName("contentTopLinebackTown2")
    result.contentTopLinebackTown2 = contentTopLinebackTown2

    local contentBgbackTown = UI.Image9:create()
    contentBgbackTown:init("ui_scale9image_setup_banner_box_up.png",{x=0,y=0,width=20,height=20})
    contentBgbackTown:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentBgbackTown:setReflectPos(64, 202)
    contentBgbackTown:setLocalZOrder(1)
    contentBgbackTown:setReflectSize(408, 83)
    contentBgbackTown:computePosition()
    BackTownConfirmDialog:addChild(contentBgbackTown)
    contentBgbackTown:setName("contentBgbackTown")
    result.contentBgbackTown = contentBgbackTown

    local contentTopLinebackTown = UI.Image9:create()
    contentTopLinebackTown:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLinebackTown:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    contentTopLinebackTown:setReflectSize(408, 2)
    contentTopLinebackTown:computePosition()
    contentBgbackTown:addChild(contentTopLinebackTown)
    contentTopLinebackTown:setName("contentTopLinebackTown")
    result.contentTopLinebackTown = contentTopLinebackTown

    local contentLabelbackTown = UI.Text:create()
    contentLabelbackTown:init("test", UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    contentLabelbackTown:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    contentLabelbackTown:setLineSpacing(-3)
    contentLabelbackTown:setDimensions(350,0)
    contentLabelbackTown:setLayoutType(UI.LayoutDefaultType.CENTER)
    contentLabelbackTown:setReflectPos(0, 2)
    contentLabelbackTown:computePosition()
    contentBgbackTown:addChild(contentLabelbackTown)
    contentLabelbackTown:setName("contentLabelbackTown")
    result.contentLabelbackTown = contentLabelbackTown

    result.root = BackTownConfirmDialog 
    return result 
end 

function Result.createGoodsSelectDialog() 

    local result = {} 

    local BackTownConfirmDialog = UI.Image:create()
    BackTownConfirmDialog:init("ui_iteminfo_role_banner_box1.png")
    BackTownConfirmDialog:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    BackTownConfirmDialog:setReflectPos(597, 42)
    BackTownConfirmDialog:computePosition()
    BackTownConfirmDialog:setName("BackTownConfirmDialog")
    result.BackTownConfirmDialog = BackTownConfirmDialog


    local GRID_SIZE_WIDTH  = 74 
    local GRID_SIZE_HEIGHT = 74 
    local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
    local left = 16
     -- 道具名称
    local nameOffsetX = 100
    local goodsName  = UI.Text:create()
    goodsName:init("fafafafa",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsName:leftUp(nameOffsetX, 16)
    goodsName:setTextLeft()
    -- goodsName:setWidth(200)
    goodsName:setLineSpacing(-5)
    BackTownConfirmDialog:addChild(goodsName)
    result.goodsName = goodsName

    
    local goodsDes = UI.Text:create()
    goodsDes:init("dadadad", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsDes:leftUp(nameOffsetX, 66)
    goodsDes:setTextLeft()
    BackTownConfirmDialog:addChild(goodsDes)
    result.goodsDes = goodsDes
    -- goodsDes:setText(desStr)
    
    -- 物品图标背景底框
    local spriteBg1 =  UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(left, 16)
    spriteBg1:setSize(GRID_SIZE_WIDTH, GRID_SIZE_HEIGHT)
    BackTownConfirmDialog:addChild(spriteBg1) 

    -- 物品图标背景
    local spriteBg =  UI.Image:create()
    spriteBg:init(SPRITE_GRID_RARE_1)
    spriteBg:center()
    spriteBg1:addChild(spriteBg) 
    result.spriteBg = spriteBg

    -- 物品图标
    local iconSprite = UI.Image:create()
    iconSprite:init()
    iconSprite:center()
    spriteBg:addChild(iconSprite)
    result.iconSprite = iconSprite
    -- 分割线
    local line1 = UI.Image9:create()
    line1:init("ui_scale9image_banner_line_light.png",{x=0,y=0,width=20,height=20})
    line1:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    line1:setReflectPos(21, 94)
    line1:setLocalZOrder(1)
    line1:setReflectSize(283, 2)
    line1:computePosition()
    BackTownConfirmDialog:addChild(line1)
    line1:setName("line1")
    result.line1 = line1


    -- 分割线
    local line1 = UI.Image9:create()
    line1:init("ui_scale9image_banner_line_light.png",{x=0,y=0,width=20,height=20})
    line1:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    line1:setReflectPos(21, 336)
    line1:setLocalZOrder(1)
    line1:setReflectSize(283, 2)
    line1:computePosition()
    BackTownConfirmDialog:addChild(line1)
    line1:setName("line1")
    result.line1 = line1


    local buttonUse = UI.Button:create()
    buttonUse:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_2.png", "ui_btn_yellow3_2.png", {x=0, y=0})
    buttonUse._clickScale = false
    buttonUse._baseline = 1
    buttonUse:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    buttonUse:setReflectPos(97, 352)
    buttonUse:computePosition()
    buttonUse:setFontColor({r=50,g=50,b=44})
    buttonUse:setText(UI.TEXT_111169)
    BackTownConfirmDialog:addChild(buttonUse)
    buttonUse:setName("buttonUse")
    result.buttonUse = buttonUse

    local buttonCancelCenter = UI.Button:create()
    buttonCancelCenter:init("ui_btn_no2_1.png", "ui_btn_no2_2.png", "ui_btn_no2_2.png", {x=0, y=0})
    buttonCancelCenter._clickScale = false
    buttonCancelCenter._baseline = 1
    buttonCancelCenter:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    buttonCancelCenter:setReflectPos(118, 355)
    buttonCancelCenter:computePosition()
    BackTownConfirmDialog:addChild(buttonCancelCenter)
    buttonCancelCenter:setName("buttonCancelCenter")
    result.buttonCancelCenter = buttonCancelCenter


    local cancelBtnBackTown = UI.Button:create()
    cancelBtnBackTown:init("ui_btn_no2_0.png", "ui_btn_no2_2.png", "ui_btn_no2_2.png", {x=0, y=0})
    cancelBtnBackTown._clickScale = false
    cancelBtnBackTown._baseline = 1
    cancelBtnBackTown:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cancelBtnBackTown:setReflectPos(42, 355)
    cancelBtnBackTown:computePosition()
    BackTownConfirmDialog:addChild(cancelBtnBackTown)
    cancelBtnBackTown:setName("cancelBtnBackTown")
    result.cancelBtnBackTown = cancelBtnBackTown

    local okButtonBackTown = UI.Button:create()
    okButtonBackTown:init("ui_btn_yes2_1.png", "ui_btn_yes2_2.png", "ui_btn_yes2_2.png", {x=0, y=0})
    okButtonBackTown._clickScale = false
    okButtonBackTown._baseline = 1
    okButtonBackTown:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    okButtonBackTown:setReflectPos(197, 355)
    okButtonBackTown:computePosition()
    BackTownConfirmDialog:addChild(okButtonBackTown)
    okButtonBackTown:setName("okButtonBackTown")
    result.okButtonBackTown = okButtonBackTown


    local scrollViewLayer = UI.Component:create()
    scrollViewLayer:init()
    scrollViewLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    scrollViewLayer:setReflectPos(21, 130)
    scrollViewLayer:setReflectSize(280, 171)
    scrollViewLayer:computePosition()
    BackTownConfirmDialog:addChild(scrollViewLayer)
    scrollViewLayer:setName("scrollViewLayer")
    result.scrollViewLayer = scrollViewLayer


    

    

    result.root = BackTownConfirmDialog 
    return result 
end 

function Result.createConfirmDialogBtnWithText() 

    local result = {} 

    local ConfirmDialog = UI.Image:create()
    ConfirmDialog:init("ui_setup_banner_box3.png")
    ConfirmDialog:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    ConfirmDialog:setReflectPos(22, 21)
    ConfirmDialog:computePosition()
    ConfirmDialog:setName("ConfirmDialog")
    result.ConfirmDialog = ConfirmDialog

    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", {x=0, y=0})
    cancelBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    cancelBtn:setText(UI.TEXT_1170211)
    cancelBtn._clickScale = false
    cancelBtn._baseline = 1
    cancelBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cancelBtn:setReflectPos(5, 212)
    cancelBtn:computePosition()
    ConfirmDialog:addChild(cancelBtn)
    cancelBtn:setName("cancelBtn")
    result.cancelBtn = cancelBtn
    cancelBtn:setScale(0.8)

    local okButton = UI.Button:create()
    okButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png", {x=0, y=0})
    okButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    okButton:setText(UI.TEXT_221015)
    okButton._clickScale = false
    okButton._baseline = 1
    okButton:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    okButton:setReflectPos(208, 212)
    okButton:computePosition()
    ConfirmDialog:addChild(okButton)
    okButton:setName("okButton")
    result.okButton = okButton
    okButton:setScale(0.8)

    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_setup_banner_box_up.png",{x=0,y=0,width=20,height=20})
    contentBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentBg:setReflectPos(29, 35)
    contentBg:setReflectSize(370, 127)
    contentBg:computePosition()
    ConfirmDialog:addChild(contentBg)
    contentBg:setName("contentBg")
    result.contentBg = contentBg

    local contentTopLine = UI.Image9:create()
    contentTopLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLine:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    contentTopLine:setReflectSize(370, 2)
    contentTopLine:computePosition()
    contentBg:addChild(contentTopLine)
    contentTopLine:setName("contentTopLine")
    result.contentTopLine = contentTopLine

    local contentLabel = UI.Text:create()
    contentLabel:init("test", UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    contentLabel:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    contentLabel:setDimensions(350,0)
    contentLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    contentLabel:computePosition()
    contentBg:addChild(contentLabel)
    contentLabel:setName("contentLabel")
    result.contentLabel = contentLabel

    local confirmButton = UI.Button:create()
    confirmButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png", {x=0, y=0})
    confirmButton._clickScale = false
    confirmButton._baseline = 1
    confirmButton:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    confirmButton:setReflectPos(0, 212)
    confirmButton:computePosition()
    ConfirmDialog:addChild(confirmButton)
    confirmButton:setName("confirmButton")
    result.confirmButton = confirmButton

    result.root = ConfirmDialog 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "ConfirmDialog" 
    if modelName == "ConfirmDialog" then 
        return Result.createConfirmDialog()
    elseif modelName == "BackTownConfirmDialog" then 
        return Result.createBackTownConfirmDialog()
    elseif modelName == "GoodsSelectDialog" then 
        return Result.createGoodsSelectDialog()
    elseif modelName == "ConfirmDialogBtnWithText" then
        return Result.createConfirmDialogBtnWithText()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_common_symbol.plist", 
    [2] = "ui_general_tips.plist", 
    [3] = "ui_common_scale9image.plist", 
    [4] = "ui_common_btn.plist", 
}

return Result 
