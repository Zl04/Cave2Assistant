local Result = {} 
function Result.createbg() 

    local result = {} 

    local bg = UI.Image:create()
    bg:init("ui_enchanting_banner_board.png")
    bg:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    bg:computePosition()
    bg:setName("bg")
    result.bg = bg

    local triangleBg = UI.Animation:create()
    triangleBg:init("effect_ui_gaming_enchanting_di.json", "effect_ui_gaming_enchanting_di.atlas", 1)
    triangleBg:setAnimation("begin", false)
    triangleBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    triangleBg:setReflectPos(177, 183)
    triangleBg:setReflectSize(0, 0)
    triangleBg:computePosition()
    bg:addChild(triangleBg)
    triangleBg:setName("triangleBg")
    result.triangleBg = triangleBg

    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_stone2_0.png", "ui_btn_stone2_1.png", "ui_btn_stone2_2.png", {x=0, y=0})
    executeButton._clickScale = false
    executeButton._baseline = 1
    executeButton:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    executeButton:setReflectPos(-35, 45)
    executeButton:computePosition()
    bg:addChild(executeButton)
    executeButton:setName("executeButton")
    result.executeButton = executeButton

    local priceLayout = UI.Component:create()
    priceLayout:init()
    priceLayout:setLayoutType(UI.LayoutDefaultType.CENTER)
    priceLayout:setReflectPos(0, 1)
    priceLayout:setLocalZOrder(10)
    priceLayout:setReflectSize(110, 50)
    priceLayout:computePosition()
    executeButton:addChild(priceLayout)
    priceLayout:setName("priceLayout")
    result.priceLayout = priceLayout

    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_maxmp_ban.png")
    executeButtonIcon:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    executeButtonIcon:setLocalZOrder(10)
    executeButtonIcon:computePosition()
    priceLayout:addChild(executeButtonIcon)
    executeButtonIcon:setName("executeButtonIcon")
    result.executeButtonIcon = executeButtonIcon

    local executeButtonPrice = UI.NumberText:create("222.22K", UI.FONT_BOLD, 20, {r=220,g=182,b=80}, 5)
    executeButtonPrice:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    executeButtonPrice:setLocalZOrder(10)
    executeButtonPrice:computePosition()
    priceLayout:addChild(executeButtonPrice)
    executeButtonPrice:setName("executeButtonPrice")
    result.executeButtonPrice = executeButtonPrice

    local executeButtonLabel = UI.Text:create()
    executeButtonLabel:initWithLanguageId(1110212, UI.FONT_BOLD, 20, {r=220,g=182,b=80})
    executeButtonLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    executeButtonLabel:setVisible(false)
    executeButtonLabel:setLocalZOrder(10)
    executeButtonLabel:computePosition()
    executeButton:addChild(executeButtonLabel)
    executeButtonLabel:setName("executeButtonLabel")
    result.executeButtonLabel = executeButtonLabel

    local attImage1 = UI.Image:create()
    attImage1:init("ui_enchanting_banner_pink.png")
    attImage1:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attImage1:setReflectPos(120, 497)
    attImage1:computePosition()
    bg:addChild(attImage1)
    attImage1:setName("attImage1")
    result.attImage1 = attImage1

    local attImage2 = UI.Image:create()
    attImage2:init("ui_enchanting_banner_green.png")
    attImage2:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attImage2:setReflectPos(120, 466)
    attImage2:computePosition()
    bg:addChild(attImage2)
    attImage2:setName("attImage2")
    result.attImage2 = attImage2

    local attImage3 = UI.Image:create()
    attImage3:init("ui_enchanting_banner_blue.png")
    attImage3:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attImage3:setReflectPos(120, 435)
    attImage3:computePosition()
    bg:addChild(attImage3)
    attImage3:setName("attImage3")
    result.attImage3 = attImage3

    local attImage4 = UI.Image:create()
    attImage4:init("ui_enchanting_banner_yellow.png")
    attImage4:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attImage4:setReflectPos(120, 404)
    attImage4:computePosition()
    bg:addChild(attImage4)
    attImage4:setName("attImage4")
    result.attImage4 = attImage4

    local attImage5 = UI.Image:create()
    attImage5:init("ui_enchanting_banner_orange.png")
    attImage5:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attImage5:setReflectPos(120, 373)
    attImage5:computePosition()
    bg:addChild(attImage5)
    attImage5:setName("attImage5")
    result.attImage5 = attImage5

    local attImage6 = UI.Image:create()
    attImage6:init("ui_enchanting_banner_red.png")
    attImage6:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attImage6:setReflectPos(120, 342)
    attImage6:computePosition()
    bg:addChild(attImage6)
    attImage6:setName("attImage6")
    result.attImage6 = attImage6

    local resultCompinent = UI.Component:create()
    resultCompinent:init()
    resultCompinent:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    resultCompinent:setReflectPos(114, 538)
    resultCompinent:setReflectSize(179, 28)
    resultCompinent:computePosition()
    bg:addChild(resultCompinent)
    resultCompinent:setName("resultCompinent")
    result.resultCompinent = resultCompinent

    local resultLabel = UI.Text:create()
    resultLabel:init("Text", UI.FONT_STANDARD, 16, {r=220,g=182,b=80})
    resultLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    resultLabel:computePosition()
    resultCompinent:addChild(resultLabel)
    resultLabel:setName("resultLabel")
    result.resultLabel = resultLabel

    local leftBg = UI.Image:create()
    leftBg:init("ui_enchanting_banner_testtube.png")
    leftBg:setLayoutType(UI.LayoutDefaultType.LEFT_BOTTOM)
    leftBg:setReflectPos(55, 124)
    leftBg:computePosition()
    bg:addChild(leftBg)
    leftBg:setName("leftBg")
    result.leftBg = leftBg

    local numberEffect = UI.Animation:create()
    numberEffect:init("effect_ui_gaming_enchanting_shuzhi.json", "effect_ui_gaming_enchanting_shuzhi.atlas", 1)
    numberEffect:setAnimation("begin", false)
    numberEffect:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    numberEffect:setReflectPos(202, 554)
    numberEffect:setLocalZOrder(10)
    numberEffect:setReflectSize(0, 0)
    numberEffect:computePosition()
    bg:addChild(numberEffect)
    numberEffect:setName("numberEffect")
    result.numberEffect = numberEffect

    result.root = bg 
    return result 
end 

function Result.createattLabel() 

    local result = {} 

    local attLabel = UI.Text:create()
    attLabel:init("Text", UI.FONT_STANDARD, 16, {r=17,g=17,b=17})
    attLabel:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attLabel:setReflectPos(460, 427)
    attLabel:computePosition()
    attLabel:setName("attLabel")
    result.attLabel = attLabel

    result.root = attLabel 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "bg" 
    if modelName == "bg" then 
        return Result.createbg()
    elseif modelName == "attLabel" then 
        return Result.createattLabel()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_common_symbol.plist", 
    [2] = "ui_gaming_enchanting.plist", 
    [3] = "ui_common_btn.plist", 
}

return Result 
