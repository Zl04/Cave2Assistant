local Result = {} 
function Result.createbg() 

    local result = {} 

    local bg = UI.Image:create()
    bg:init("ui_gem_bg.png")
    bg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bg:setReflectPos(21, 5)
    bg:computePosition()
    bg:setName("bg")
    result.bg = bg

    local contentBg = UI.Image:create()
    contentBg:init("ui_gem_paper.png")
    contentBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentBg:setReflectPos(38, 174)
    contentBg:computePosition()
    bg:addChild(contentBg)
    contentBg:setName("contentBg")
    result.contentBg = contentBg

    local executeButtonGem = UI.Button:create()
    executeButtonGem:init("ui_btn_stone1_0.png", "ui_btn_stone1_1.png", "ui_btn_stone1_2.png", {x=0, y=0})
    executeButtonGem._clickScale = false
    executeButtonGem._baseline = 1
    executeButtonGem:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    executeButtonGem:setReflectPos(0, 35)
    executeButtonGem:computePosition()
    bg:addChild(executeButtonGem)
    executeButtonGem:setName("executeButtonGem")
    result.executeButtonGem = executeButtonGem

    local executeButtonLabelGem = UI.Text:create()
    executeButtonLabelGem:initWithLanguageId(1111262, UI.FONT_BOLD, 20, {r=220,g=182,b=80})
    executeButtonLabelGem:setLayoutType(UI.LayoutDefaultType.CENTER)
    executeButtonLabelGem:setLocalZOrder(10)
    executeButtonLabelGem:computePosition()
    executeButtonGem:addChild(executeButtonLabelGem)
    executeButtonLabelGem:setName("executeButtonLabelGem")
    result.executeButtonLabelGem = executeButtonLabelGem


    local priceLayer = UI.Component:create()
    priceLayer:init()
    priceLayer:setLayoutType(UI.LayoutDefaultType.CENTER)
    priceLayer:setReflectPos(0, 2)
    priceLayer:setLocalZOrder(10)
    priceLayer:setReflectSize(80, 50)
    priceLayer:computePosition()
    executeButtonGem:addChild(priceLayer)
    priceLayer:setName("priceLayer")
    result.priceLayer = priceLayer

    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_money.png")
    executeButtonIcon:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    executeButtonIcon:setLocalZOrder(10)
    executeButtonIcon:computePosition()
    priceLayer:addChild(executeButtonIcon)
    executeButtonIcon:setName("executeButtonIcon")
    result.executeButtonIcon = executeButtonIcon

    local executeButtonPrice = UI.NumberText:create("1,234", UI.FONT_BOLD, 20, {r=220,g=182,b=80}, 5)
    executeButtonPrice:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    executeButtonPrice:setReflectPos(0, -1)
    executeButtonPrice:setLocalZOrder(10)
    executeButtonPrice:computePosition()
    priceLayer:addChild(executeButtonPrice)
    executeButtonPrice:setName("executeButtonPrice")
    result.executeButtonPrice = executeButtonPrice

    

    local circleShadow = UI.Image:create()
    circleShadow:init("ui_gem_shadow.png")
    circleShadow:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    circleShadow:setReflectPos(2, -5)
    circleShadow:computePosition()
    bg:addChild(circleShadow)
    circleShadow:setName("circleShadow")
    result.circleShadow = circleShadow

    local circleNode = UI.Image:create()
    circleNode:init("ui_gem_round.png")
    circleNode:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    circleNode:setReflectPos(5, -12)
    circleNode:computePosition()
    bg:addChild(circleNode)
    circleNode:setName("circleNode")
    result.circleNode = circleNode

    local gemSynthesisAnimation = UI.Animation:create()
    gemSynthesisAnimation:init("effect_ui_town_gem_di_synthetise.json", "effect_ui_town_gem_di_synthetise.atlas", 1)
    gemSynthesisAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    gemSynthesisAnimation:setReflectPos(173, 148)
    gemSynthesisAnimation:setReflectSize(0, 0)
    gemSynthesisAnimation:computePosition()
    bg:addChild(gemSynthesisAnimation)
    gemSynthesisAnimation:setName("gemSynthesisAnimation")
    result.gemSynthesisAnimation = gemSynthesisAnimation

    local gridLay = UI.Component:create()
    gridLay:init()
    gridLay:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    gridLay:setReflectSize(150, 150)
    gridLay:computePosition()
    bg:addChild(gridLay)
    gridLay:setName("gridLay")
    result.gridLay = gridLay

    local topGrid = UI.Animation:create()
    topGrid:init("effect_ui_town_gem_kuang_xiao.json", "effect_ui_town_gem_kuang_xiao.atlas", 1)
    topGrid:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    topGrid:setReflectPos(171, 40)
    topGrid:setReflectSize(0, 0)
    topGrid:computePosition()
    gridLay:addChild(topGrid)
    topGrid:setName("topGrid")
    result.topGrid = topGrid

    local leftGrid = UI.Animation:create()
    leftGrid:init("effect_ui_town_gem_kuang_xiao.json", "effect_ui_town_gem_kuang_xiao.atlas", 1)
    leftGrid:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    leftGrid:setReflectPos(67, 145)
    leftGrid:setReflectSize(0, 0)
    leftGrid:computePosition()
    gridLay:addChild(leftGrid)
    leftGrid:setName("leftGrid")
    result.leftGrid = leftGrid

    local rightGrid = UI.Animation:create()
    rightGrid:init("effect_ui_town_gem_kuang_xiao.json", "effect_ui_town_gem_kuang_xiao.atlas", 1)
    rightGrid:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    rightGrid:setReflectPos(275, 145)
    rightGrid:setReflectSize(0, 0)
    rightGrid:computePosition()
    gridLay:addChild(rightGrid)
    rightGrid:setName("rightGrid")
    result.rightGrid = rightGrid

    local bottomGrid = UI.Animation:create()
    bottomGrid:init("effect_ui_town_gem_kuang_xiao.json", "effect_ui_town_gem_kuang_xiao.atlas", 1)
    bottomGrid:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bottomGrid:setReflectPos(171, 249)
    bottomGrid:setReflectSize(0, 0)
    bottomGrid:computePosition()
    gridLay:addChild(bottomGrid)
    bottomGrid:setName("bottomGrid")
    result.bottomGrid = bottomGrid

    local centerGridAnimation = UI.Animation:create()
    centerGridAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas", 1)
    centerGridAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    centerGridAnimation:setReflectPos(171, 145)
    centerGridAnimation:setLocalZOrder(10)
    centerGridAnimation:setReflectSize(0, 0)
    centerGridAnimation:computePosition()
    gridLay:addChild(centerGridAnimation)
    centerGridAnimation:setName("centerGridAnimation")
    result.centerGridAnimation = centerGridAnimation

    local scrollLayout = UI.Layout:create()
    scrollLayout:init()
    scrollLayout:setSize(207, 236)
    result.scrollLayout = scrollLayout

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(207, 200)
    scrollView:init()
    scrollView:centerBottom(110)
    scrollView:addInnerNode(scrollLayout)
    scrollView:useDefaultScrollBar()
    bg:addChild(scrollView) 
    result.scrollView = scrollView

    local desStr = UI.Text:create()
    desStr:initWithLanguageId(1111263, UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    desStr:autoAdapt()
    desStr:centerUp(0)
    desStr:setWidth(207)
    scrollLayout:addChild(desStr)
    desStr:setName("desStr")
    result.desStr = desStr
    scrollLayout:setSize(207, desStr:getContentSize().height)
    desStr:computePosition()
    scrollLayout:centerUp(0)
    scrollLayout:computePosition()

    result.root = bg 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "bg" 
    if modelName == "bg" then 
        return Result.createbg()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_common_btn.plist", 
    [2] = "ui_town_gem.plist", 
}

return Result 
