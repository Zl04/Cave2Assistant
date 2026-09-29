local Result = {} 
function Result.createmakeEquipNode() 

    local result = {} 

    local makeEquipNode = UI.Component:create()
    makeEquipNode:init()
    makeEquipNode:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    makeEquipNode:setReflectSize(350, 640)
    makeEquipNode:computePosition()
    makeEquipNode:setName("makeEquipNode")
    result.makeEquipNode = makeEquipNode

    local fireAnimation = UI.Animation:create()
    fireAnimation:init("effect_ui_town_blacksmith_di.json", "effect_ui_town_blacksmith.atlas", 1)
    fireAnimation:setAnimation("begin", false)
    fireAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    fireAnimation:setReflectPos(170, 230)
    fireAnimation:setLocalZOrder(-1)
    fireAnimation:setReflectSize(0, 0)
    fireAnimation:computePosition()
    makeEquipNode:addChild(fireAnimation)
    fireAnimation:setName("fireAnimation")
    result.fireAnimation = fireAnimation

    local makeEquipBg = UI.Image:create()
    makeEquipBg:init("ui_blacksmith_fireplace1.png")
    makeEquipBg:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    makeEquipBg:computePosition()
    makeEquipNode:addChild(makeEquipBg)
    makeEquipBg:setName("makeEquipBg")
    result.makeEquipBg = makeEquipBg

    local titleStr = UI.Text:create()
    titleStr:init("装备名字", UI.FONT_BOLD, 20, {r=155,g=155,b=155})
    titleStr:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    titleStr:setReflectPos(0, 14)
    titleStr:computePosition()
    makeEquipBg:addChild(titleStr)
    titleStr:setName("titleStr")
    result.titleStr = titleStr

    local btnBg = UI.Image:create()
    btnBg:init("ui_blacksmith_occlusion.png")
    btnBg:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    btnBg:setReflectPos(41, 132)
    btnBg:computePosition()
    makeEquipBg:addChild(btnBg)
    btnBg:setName("btnBg")
    btnBg:hide()
    result.btnBg = btnBg

    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_stone1_0.png", "ui_btn_stone1_1.png", "ui_btn_stone1_2.png", {x=0, y=0})
    executeButton._clickScale = false
    executeButton._baseline = 1
    executeButton:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    executeButton:setReflectPos(0, 35)
    executeButton:computePosition()
    makeEquipBg:addChild(executeButton)
    executeButton:setName("executeButton")
    result.executeButton = executeButton

    local priceLayer = UI.Component:create()
    priceLayer:init()
    priceLayer:setLayoutType(UI.LayoutDefaultType.CENTER)
    priceLayer:setReflectPos(0, 2)
    priceLayer:setLocalZOrder(10)
    priceLayer:setReflectSize(80, 50)
    priceLayer:computePosition()
    executeButton:addChild(priceLayer)
    priceLayer:setName("priceLayer")
    result.priceLayer = priceLayer

    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_diamond.png")
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

    local executeButtonLabel = UI.Text:create()
    executeButtonLabel:initWithLanguageId(1110407, UI.FONT_BOLD, 20, {r=220,g=182,b=80})
    executeButtonLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    executeButtonLabel:setVisible(false)
    executeButtonLabel:setLocalZOrder(10)
    executeButtonLabel:computePosition()
    executeButton:addChild(executeButtonLabel)
    executeButtonLabel:setName("executeButtonLabel")
    result.executeButtonLabel = executeButtonLabel
--
    local executeButtonRep = UI.Button:create()
    executeButtonRep:init("ui_btn_yellow7_0.png", "ui_btn_yellow7_1.png", "ui_btn_yellow7_2.png", {x=0, y=0})
    executeButtonRep._baseline = 1
    executeButtonRep:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    executeButtonRep:setReflectPos(0, 35)
    executeButtonRep:computePosition()
    makeEquipBg:addChild(executeButtonRep)
    executeButtonRep:setName("executeButtonRep")
    result.executeButtonRep = executeButtonRep
    executeButtonRep:hide()
    executeButtonRep:disable()
    executeButtonRep:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)

    local executeButtonContiue = UI.Button:create()
    executeButtonContiue:init("ui_btn_yellow7_0.png", "ui_btn_yellow7_1.png", "ui_btn_yellow7_2.png", {x=0, y=0})
    executeButtonContiue._baseline = 1
    executeButtonContiue:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    executeButtonContiue:setReflectPos(0, 35)
    executeButtonContiue:computePosition()
    makeEquipBg:addChild(executeButtonContiue)
    executeButtonContiue:setName("executeButtonContiue")
    result.executeButtonContiue = executeButtonContiue
    executeButtonContiue:hide()
    executeButtonContiue:disable()

    local priceLayer = UI.Component:create()
    priceLayer:init()
    priceLayer:setLayoutType(UI.LayoutDefaultType.CENTER)
    priceLayer:setReflectPos(0, 0)
    priceLayer:setLocalZOrder(10)
    priceLayer:setReflectSize(80, 50)
    priceLayer:computePosition()
    executeButtonContiue:addChild(priceLayer)
    priceLayer:setName("ContiuePriceLayer")
    result.contiuePriceLayer = priceLayer

    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_diamond.png")
    executeButtonIcon:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    executeButtonIcon:setLocalZOrder(10)
    executeButtonIcon:computePosition()
    priceLayer:addChild(executeButtonIcon)
    executeButtonIcon:setName("executeButtonIcon")

    local executeButtonRepPrice = UI.NumberText:create("1,234", UI.FONT_BOLD, 20, {r=220,g=182,b=80}, 5)
    executeButtonRepPrice:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    executeButtonRepPrice:setReflectPos(0, -1)
    executeButtonRepPrice:setLocalZOrder(10)
    executeButtonRepPrice:computePosition()
    priceLayer:addChild(executeButtonRepPrice)
    executeButtonRepPrice:setName("executeButtonRepPrice")
    result.executeButtonRepPrice = executeButtonRepPrice
--
    local splitLine2 = UI.Image9:create()
    splitLine2:init("ui_scale9image_banner_line_dark.png",{x=0,y=0,width=0,height=0})
    splitLine2:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    splitLine2:setReflectPos(0, 464)
    splitLine2:setReflectSize(265, 1)
    splitLine2:computePosition()
    makeEquipBg:addChild(splitLine2)
    splitLine2:setName("splitLine2")
    result.splitLine2 = splitLine2

    local splitLine1 = UI.Image9:create()
    splitLine1:init("ui_scale9image_banner_line_dark.png",{x=0,y=0,width=0,height=0})
    splitLine1:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    splitLine1:setReflectPos(0, 219)
    splitLine1:setReflectSize(265, 1)
    splitLine1:computePosition()
    makeEquipBg:addChild(splitLine1)
    splitLine1:setName("splitLine1")
    result.splitLine1 = splitLine1



    -- local selectCoinButton = UI.Button:create()
    -- selectCoinButton:init("ui_btn_blacksmith_gold_0.png", "ui_btn_blacksmith_gold_1.png", "ui_btn_blacksmith_gold_1.png", {x=0, y=0})
    -- selectCoinButton._clickScale = false
    -- selectCoinButton._baseline = 1
    -- selectCoinButton:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    -- selectCoinButton:setReflectPos(-60, 105)
    -- selectCoinButton:computePosition()
    -- makeEquipBg:addChild(selectCoinButton)
    -- selectCoinButton:setName("selectCoinButton")
    -- result.selectCoinButton = selectCoinButton

    -- local selectDiamondButton = UI.Button:create()
    -- selectDiamondButton:init("ui_btn_blacksmith_crystal_0.png", "ui_btn_blacksmith_crystal_1.png", "ui_btn_blacksmith_crystal_1.png", {x=0, y=0})
    -- selectDiamondButton._clickScale = false
    -- selectDiamondButton._baseline = 1
    -- selectDiamondButton:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    -- selectDiamondButton:setReflectPos(60, 105)
    -- selectDiamondButton:computePosition()
    -- makeEquipBg:addChild(selectDiamondButton)
    -- selectDiamondButton:setName("selectDiamondButton")
    -- result.selectDiamondButton = selectDiamondButton




    local fireAnimationFront = UI.Animation:create()
    fireAnimationFront:init("effect_ui_town_blacksmith_chui.json", "effect_ui_town_blacksmith.atlas", 1)
    fireAnimationFront:setAnimation("begin", false)
    fireAnimationFront:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    fireAnimationFront:setReflectPos(161, 216)
    fireAnimationFront:setLocalZOrder(10)
    fireAnimationFront:setReflectSize(0, 0)
    fireAnimationFront:computePosition()
    makeEquipNode:addChild(fireAnimationFront)
    fireAnimationFront:setName("fireAnimationFront")
    result.fireAnimationFront = fireAnimationFront

    result.root = makeEquipNode 
    return result 
end 

function Result.createConvertNode() 
local result = {} 

    local strengLayer = UI.Component:create()
    strengLayer:init()
    strengLayer:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    strengLayer:setReflectPos(-398, 4)
    strengLayer:setReflectSize(150, 150)
    strengLayer:computePosition()
    strengLayer:setName("strengLayer")
    result.strengLayer = strengLayer

    local rightMateralNode = UI.Image:create()
    rightMateralNode:init("ui_blacksmith_box2.png")
    rightMateralNode:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    rightMateralNode:setReflectPos(97, 73)
    rightMateralNode:computePosition()
    strengLayer:addChild(rightMateralNode)
    rightMateralNode:setName("rightMateralNode")
    result.rightMateralNode = rightMateralNode

    local rightMateralIcon = UI.Image:create()
    rightMateralIcon:init("ui_blacksmith_hammer.png")
    rightMateralIcon:setLayoutType(UI.LayoutDefaultType.CENTER)
    rightMateralIcon:computePosition()
    rightMateralNode:addChild(rightMateralIcon)
    rightMateralIcon:setName("rightMateralIcon")
    result.rightMateralIcon = rightMateralIcon

    local arrowIcon = UI.Image:create()
    arrowIcon:init("ui_blacksmith_arrow0.png")
    arrowIcon:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    arrowIcon:setReflectPos(64, 107)
    arrowIcon:computePosition()
    strengLayer:addChild(arrowIcon)
    arrowIcon:setName("arrowIcon")
    result.arrowIcon = arrowIcon

    local strengChanceBg = UI.Image:create()
    strengChanceBg:init("ui_blacksmith_title.png")
    strengChanceBg:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    strengChanceBg:setReflectPos(0, 225)
    strengChanceBg:computePosition()
    strengLayer:addChild(strengChanceBg)
    strengChanceBg:setName("strengChanceBg")
    result.strengChanceBg = strengChanceBg

    local chanceDesLayer = UI.Component:create()
    chanceDesLayer:init()
    chanceDesLayer:setLayoutType(UI.LayoutDefaultType.CENTER)
    chanceDesLayer:setReflectSize(150, 20)
    chanceDesLayer:computePosition()
    strengChanceBg:addChild(chanceDesLayer)
    chanceDesLayer:setName("chanceDesLayer")
    result.chanceDesLayer = chanceDesLayer


    local chanceDesLabel = UI.Text:create()
    chanceDesLabel:initWithLanguageId("转换规则", UI.FONT_BOLD, 18, {r=194,g=194,b=194})
    chanceDesLabel:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    chanceDesLabel:computePosition()
    chanceDesLayer:addChild(chanceDesLabel)
    chanceDesLabel:setName("chanceDesLabel")
    result.chanceDesLabel = chanceDesLabel

    
    local chanceDesLabel = UI.Text:create()
    chanceDesLabel:initWithLanguageId(1110406, UI.FONT_BOLD, 18, {r=194,g=194,b=194})
    chanceDesLabel:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    chanceDesLabel:computePosition()
    chanceDesLayer:addChild(chanceDesLabel)
    chanceDesLabel:setName("chanceDesLabel")
    result.chanceDesLabel = chanceDesLabel

    local chanceNumberLbale = UI.Text:create()
    chanceNumberLbale:init("75%", UI.FONT_BOLD, 18, {r=220,g=182,b=80})
    chanceNumberLbale:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    chanceNumberLbale:computePosition()
    chanceDesLayer:addChild(chanceNumberLbale)
    chanceNumberLbale:setName("chanceNumberLbale")
    result.chanceNumberLbale = chanceNumberLbale

    local leftMateralNode = UI.Image:create()
    leftMateralNode:init("ui_blacksmith_box2.png")
    leftMateralNode:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    leftMateralNode:setReflectPos(-24, 73)
    leftMateralNode:setLocalZOrder(1)
    leftMateralNode:computePosition()
    strengLayer:addChild(leftMateralNode)
    leftMateralNode:setName("leftMateralNode")
    result.leftMateralNode = leftMateralNode

    local leftMateralIcon = UI.Image:create()
    leftMateralIcon:init("ui_blacksmith_platform.png")
    leftMateralIcon:setLayoutType(UI.LayoutDefaultType.CENTER)
    leftMateralIcon:computePosition()
    leftMateralNode:addChild(leftMateralIcon)
    leftMateralIcon:setName("leftMateralIcon")
    result.leftMateralIcon = leftMateralIcon

    local strengAnimation = UI.Animation:create()
    strengAnimation:init("effect_ui_town_blacksmith_strengthen.json", "effect_ui_town_blacksmith_strengthen.atlas", 1)
    strengAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    strengAnimation:setReflectPos(75, 228)
    strengAnimation:setLocalZOrder(10)
    strengAnimation:setReflectSize(0, 0)
    strengAnimation:computePosition()
    strengLayer:addChild(strengAnimation)
    strengAnimation:setName("strengAnimation")
    result.strengAnimation = strengAnimation

    result.root = strengLayer 
    return result 
end 


function Result.createstrengLayer() 

    local result = {} 

    local strengLayer = UI.Component:create()
    strengLayer:init()
    strengLayer:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    strengLayer:setReflectPos(-398, 4)
    strengLayer:setReflectSize(150, 150)
    strengLayer:computePosition()
    strengLayer:setName("strengLayer")
    result.strengLayer = strengLayer

    local rightMateralNode = UI.Image:create()
    rightMateralNode:init("ui_blacksmith_box2.png")
    rightMateralNode:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    rightMateralNode:setReflectPos(97, 73)
    rightMateralNode:computePosition()
    strengLayer:addChild(rightMateralNode)
    rightMateralNode:setName("rightMateralNode")
    result.rightMateralNode = rightMateralNode

    local rightMateralIcon = UI.Image:create()
    rightMateralIcon:init("ui_blacksmith_hammer.png")
    rightMateralIcon:setLayoutType(UI.LayoutDefaultType.CENTER)
    rightMateralIcon:computePosition()
    rightMateralNode:addChild(rightMateralIcon)
    rightMateralIcon:setName("rightMateralIcon")
    result.rightMateralIcon = rightMateralIcon

    local arrowIcon = UI.Image:create()
    arrowIcon:init("ui_blacksmith_arrow0.png")
    arrowIcon:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    arrowIcon:setReflectPos(64, 107)
    arrowIcon:computePosition()
    strengLayer:addChild(arrowIcon)
    arrowIcon:setName("arrowIcon")
    result.arrowIcon = arrowIcon

    local strengChanceBg = UI.Image:create()
    strengChanceBg:init("ui_blacksmith_typing.png")
    strengChanceBg:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    strengChanceBg:setReflectPos(0, 225)
    strengChanceBg:computePosition()
    strengLayer:addChild(strengChanceBg)
    strengChanceBg:setName("strengChanceBg")
    result.strengChanceBg = strengChanceBg

    local chanceDesLayer = UI.Component:create()
    chanceDesLayer:init()
    chanceDesLayer:setLayoutType(UI.LayoutDefaultType.CENTER)
    chanceDesLayer:setReflectSize(150, 20)
    chanceDesLayer:computePosition()
    strengChanceBg:addChild(chanceDesLayer)
    chanceDesLayer:setName("chanceDesLayer")
    result.chanceDesLayer = chanceDesLayer

    local chanceDesLabel = UI.Text:create()
    chanceDesLabel:initWithLanguageId(1110406, UI.FONT_BOLD, 18, {r=194,g=194,b=194})
    chanceDesLabel:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    chanceDesLabel:computePosition()
    chanceDesLayer:addChild(chanceDesLabel)
    chanceDesLabel:setName("chanceDesLabel")
    result.chanceDesLabel = chanceDesLabel

    local chanceNumberLbale = UI.Text:create()
    chanceNumberLbale:init("75%", UI.FONT_BOLD, 18, {r=220,g=182,b=80})
    chanceNumberLbale:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    chanceNumberLbale:computePosition()
    chanceDesLayer:addChild(chanceNumberLbale)
    chanceNumberLbale:setName("chanceNumberLbale")
    result.chanceNumberLbale = chanceNumberLbale

    local leftMateralNode = UI.Image:create()
    leftMateralNode:init("ui_blacksmith_box2.png")
    leftMateralNode:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    leftMateralNode:setReflectPos(-24, 73)
    leftMateralNode:setLocalZOrder(1)
    leftMateralNode:computePosition()
    strengLayer:addChild(leftMateralNode)
    leftMateralNode:setName("leftMateralNode")
    result.leftMateralNode = leftMateralNode

    local leftMateralIcon = UI.Image:create()
    leftMateralIcon:init("ui_blacksmith_platform.png")
    leftMateralIcon:setLayoutType(UI.LayoutDefaultType.CENTER)
    leftMateralIcon:computePosition()
    leftMateralNode:addChild(leftMateralIcon)
    leftMateralIcon:setName("leftMateralIcon")
    result.leftMateralIcon = leftMateralIcon

    local strengAnimation = UI.Animation:create()
    strengAnimation:init("effect_ui_town_blacksmith_strengthen.json", "effect_ui_town_blacksmith_strengthen.atlas", 1)
    strengAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    strengAnimation:setReflectPos(75, 228)
    strengAnimation:setLocalZOrder(10)
    strengAnimation:setReflectSize(0, 0)
    strengAnimation:computePosition()
    strengLayer:addChild(strengAnimation)
    strengAnimation:setName("strengAnimation")
    result.strengAnimation = strengAnimation

    result.root = strengLayer 
    return result 
end 

function Result.createattChangeModel() 

    local result = {} 

    local attChangeModel = UI.Component:create()
    attChangeModel:init()
    attChangeModel:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attChangeModel:setReflectPos(372, 538)
    attChangeModel:setReflectSize(240, 20)
    attChangeModel:computePosition()
    attChangeModel:setName("attChangeModel")
    result.attChangeModel = attChangeModel

    local attNameLabel = UI.Text:create()
    attNameLabel:init("最小攻击", UI.FONT_STANDARD, 16, {r=41,g=41,b=45})
    attNameLabel:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    attNameLabel:computePosition()
    attChangeModel:addChild(attNameLabel)
    attNameLabel:setName("attNameLabel")
    result.attNameLabel = attNameLabel

    local attNumberLabel = UI.Text:create()
    attNumberLabel:init("1800", UI.FONT_STANDARD, 16, {r=41,g=41,b=45})
    attNumberLabel:setLayoutType(UI.LayoutDefaultType.LEFT_BOTTOM)
    attNumberLabel:setReflectPos(70, 0)
    attNumberLabel:computePosition()
    attNameLabel:addChild(attNumberLabel)
    attNumberLabel:setName("attNumberLabel")
    result.attNumberLabel = attNumberLabel

    local attUpIcon = UI.Image:create()
    attUpIcon:init("ui_information_arrow_up.png")
    attUpIcon:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    attUpIcon:setReflectPos(0, -1)
    attUpIcon:computePosition()
    attChangeModel:addChild(attUpIcon)
    attUpIcon:setName("attUpIcon")
    result.attUpIcon = attUpIcon

    local attChangeNumber = UI.Text:create()
    attChangeNumber:init("x", UI.FONT_STANDARD, 16, {r=36,g=181,b=118})
    attChangeNumber:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    attChangeNumber:setReflectPos(25, 0)
    attChangeNumber:computePosition()
    attChangeModel:addChild(attChangeNumber)
    attChangeNumber:setName("attChangeNumber")
    result.attChangeNumber = attChangeNumber

    local attDownIcon = UI.Image:create()
    attDownIcon:init("ui_information_arrow_dwon.png")
    attDownIcon:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    attDownIcon:setVisible(false)
    attDownIcon:computePosition()
    attChangeModel:addChild(attDownIcon)
    attDownIcon:setName("attDownIcon")
    result.attDownIcon = attDownIcon

    result.root = attChangeModel 
    return result 
end 

function Result.createAttRemouldModel() 

    local result = {} 

    local AttRemouldModel = UI.Button:create()
    AttRemouldModel:init("ui_btn_mosaic1_0.png", "ui_btn_mosaic1_1.png", "ui_btn_mosaic1_2.png", {x=0, y=0})
    AttRemouldModel._clickScale = true
    AttRemouldModel._baseline = 1
    AttRemouldModel:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    AttRemouldModel:setReflectPos(363, 569)
    AttRemouldModel:computePosition()
    AttRemouldModel:setName("AttRemouldModel")
    result.AttRemouldModel = AttRemouldModel

    local attRemouldDes = UI.Text:create()
    attRemouldDes:init("Text", UI.FONT_BOLD, 20, {r=50,g=50,b=44})
    attRemouldDes:setLayoutType(UI.LayoutDefaultType.CENTER)
    attRemouldDes:setReflectPos(-18, 0)
    attRemouldDes:setLocalZOrder(10)
    attRemouldDes:computePosition()
    AttRemouldModel:addChild(attRemouldDes)
    attRemouldDes:setName("attRemouldDes")
    result.attRemouldDes = attRemouldDes

    local attBuildIndicator = UI.Image:create()
    attBuildIndicator:init("ui_btn_hammer1_0.png")
    attBuildIndicator:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    attBuildIndicator:setReflectPos(211, 13)
    attBuildIndicator:setLocalZOrder(10)
    attBuildIndicator:computePosition()
    AttRemouldModel:addChild(attBuildIndicator)
    attBuildIndicator:setName("attBuildIndicator")
    result.attBuildIndicator = attBuildIndicator

    result.root = AttRemouldModel 
    return result 
end 

function Result.createRemouldTipModel() 

    local result = {} 

    local RemouldTipModel = UI.Image:create()
    RemouldTipModel:init("ui_blacksmith_paper.png")
    RemouldTipModel:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    RemouldTipModel:setReflectPos(387, 253)
    RemouldTipModel:computePosition()
    RemouldTipModel:setName("RemouldTipModel")
    result.RemouldTipModel = RemouldTipModel

    local RemouldTipTitle = UI.Text:create()
    RemouldTipTitle:initWithLanguageId(1111129, UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    RemouldTipTitle:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    RemouldTipTitle:setReflectPos(0, 15)
    RemouldTipTitle:computePosition()
    RemouldTipModel:addChild(RemouldTipTitle)
    RemouldTipTitle:setName("RemouldTipTitle")
    result.RemouldTipTitle = RemouldTipTitle

    local remouldTipScrollLayer = UI.Component:create()
    remouldTipScrollLayer:init()
    remouldTipScrollLayer:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    remouldTipScrollLayer:setReflectPos(-2, 52)
    remouldTipScrollLayer:setReflectSize(167, 150)
    remouldTipScrollLayer:computePosition()
    RemouldTipModel:addChild(remouldTipScrollLayer)
    remouldTipScrollLayer:setName("remouldTipScrollLayer")
    result.remouldTipScrollLayer = remouldTipScrollLayer

    local remouldTipMask = UI.Image:create()
    remouldTipMask:init("ui_blacksmith_gradually2.png")
    remouldTipMask:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    remouldTipMask:setReflectPos(5, 170)
    remouldTipMask:setLocalZOrder(1)
    remouldTipMask:computePosition()
    RemouldTipModel:addChild(remouldTipMask)
    remouldTipMask:setName("remouldTipMask")
    result.remouldTipMask = remouldTipMask

    local remouldTipTopLine = UI.Image9:create()
    remouldTipTopLine:init("ui_scale9image_banner_line_dark.png",{x=0,y=0,width=20,height=20})
    remouldTipTopLine:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    remouldTipTopLine:setReflectPos(-2, 50)
    remouldTipTopLine:setLocalZOrder(1)
    remouldTipTopLine:setReflectSize(170, 1)
    remouldTipTopLine:computePosition()
    RemouldTipModel:addChild(remouldTipTopLine)
    remouldTipTopLine:setName("remouldTipTopLine")
    result.remouldTipTopLine = remouldTipTopLine

    local remouldTipBottomLine = UI.Image9:create()
    remouldTipBottomLine:init("ui_scale9image_banner_line_dark.png",{x=0,y=0,width=20,height=20})
    remouldTipBottomLine:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    remouldTipBottomLine:setReflectPos(-2, 30)
    remouldTipBottomLine:setLocalZOrder(2)
    remouldTipBottomLine:setReflectSize(170, 1)
    remouldTipBottomLine:computePosition()
    RemouldTipModel:addChild(remouldTipBottomLine)
    remouldTipBottomLine:setName("remouldTipBottomLine")
    result.remouldTipBottomLine = remouldTipBottomLine

    result.root = RemouldTipModel 
    return result 
end 

function Result.createremouldTipAttMoule() 

    local result = {} 

    local remouldTipAttMoule = UI.Text:create()
    remouldTipAttMoule:init("最小攻击", UI.FONT_STANDARD, 16, {r=41,g=41,b=45})
    remouldTipAttMoule:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    remouldTipAttMoule:setReflectPos(485, 500)
    remouldTipAttMoule:computePosition()
    remouldTipAttMoule:setName("remouldTipAttMoule")
    result.remouldTipAttMoule = remouldTipAttMoule

    local remouldTipAttRightLabel = UI.Text:create()
    remouldTipAttRightLabel:init("18", UI.FONT_STANDARD, 16, {r=41,g=41,b=45})
    remouldTipAttRightLabel:setLayoutType(UI.LayoutDefaultType.LEFT_BOTTOM)
    remouldTipAttRightLabel:setReflectPos(70, 0)
    remouldTipAttRightLabel:computePosition()
    remouldTipAttMoule:addChild(remouldTipAttRightLabel)
    remouldTipAttRightLabel:setName("remouldTipAttRightLabel")
    result.remouldTipAttRightLabel = remouldTipAttRightLabel

    result.root = remouldTipAttMoule 
    return result 
end 

function Result.createForgeMaterialModel() 

    local result = {} 

    local ForgeMaterialModel = UI.Image:create()
    ForgeMaterialModel:init("ui_blacksmith_forging.png")
    ForgeMaterialModel:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    ForgeMaterialModel:setReflectPos(418, 99)
    ForgeMaterialModel:computePosition()
    ForgeMaterialModel:setName("ForgeMaterialModel")
    result.ForgeMaterialModel = ForgeMaterialModel

    local ForgeMaterialName = UI.Text:create()
    ForgeMaterialName:init("材料名字七个字", UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    ForgeMaterialName:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    ForgeMaterialName:setLineSpacing(-2)
    ForgeMaterialName:setDimensions(95,0)
    ForgeMaterialName:setLayoutType(UI.LayoutDefaultType.CENTER)
    ForgeMaterialName:setReflectPos(0, 38)
    ForgeMaterialName:computePosition()
    ForgeMaterialModel:addChild(ForgeMaterialName)
    ForgeMaterialName:setName("ForgeMaterialName")
    result.ForgeMaterialName = ForgeMaterialName

    result.root = ForgeMaterialModel 
    return result 
end 

function Result.createResolveEquipNode() 

    local result = {} 

    local ResolveEquipNode = UI.Component:create()
    ResolveEquipNode:init()
    ResolveEquipNode:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    ResolveEquipNode:setReflectPos(750, 0)
    ResolveEquipNode:setReflectSize(350, 640)
    ResolveEquipNode:computePosition()
    ResolveEquipNode:setName("ResolveEquipNode")
    result.ResolveEquipNode = ResolveEquipNode

    local resolveFireAnimation = UI.Animation:create()
    resolveFireAnimation:init("effect_ui_town_blacksmith_decompose_fire.json", "effect_ui_town_blacksmith_decompose_fire.atlas", 1)
    resolveFireAnimation:setAnimation("begin", false)
    resolveFireAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    resolveFireAnimation:setReflectPos(170, 555)
    resolveFireAnimation:setLocalZOrder(-1)
    resolveFireAnimation:setReflectSize(0, 0)
    resolveFireAnimation:computePosition()
    ResolveEquipNode:addChild(resolveFireAnimation)
    resolveFireAnimation:setName("resolveFireAnimation")
    result.resolveFireAnimation = resolveFireAnimation

    local resolveEquipBg = UI.Image:create()
    resolveEquipBg:init("ui_blacksmith_fireplace2.png")
    resolveEquipBg:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    resolveEquipBg:computePosition()
    ResolveEquipNode:addChild(resolveEquipBg)
    resolveEquipBg:setName("resolveEquipBg")
    result.resolveEquipBg = resolveEquipBg

    local titleStrResolve = UI.Text:create()
    titleStrResolve:initWithLanguageId(1110437, UI.FONT_BOLD, 20, {r=155,g=155,b=155})
    titleStrResolve:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    titleStrResolve:setReflectPos(0, 14)
    titleStrResolve:computePosition()
    resolveEquipBg:addChild(titleStrResolve)
    titleStrResolve:setName("titleStrResolve")
    result.titleStrResolve = titleStrResolve

    local executeButtonResolve = UI.Button:create()
    executeButtonResolve:init("ui_btn_stone1_0.png", "ui_btn_stone1_1.png", "ui_btn_stone1_2.png", {x=0, y=0})
    executeButtonResolve._clickScale = false
    executeButtonResolve._baseline = 1
    executeButtonResolve:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    executeButtonResolve:setReflectPos(0, 35)
    executeButtonResolve:computePosition()
    resolveEquipBg:addChild(executeButtonResolve)
    executeButtonResolve:setName("executeButtonResolve")
    result.executeButtonResolve = executeButtonResolve

    local executeButtonLabelResolve = UI.Text:create()
    executeButtonLabelResolve:initWithLanguageId(1110438, UI.FONT_BOLD, 20, {r=220,g=182,b=80})
    executeButtonLabelResolve:setLayoutType(UI.LayoutDefaultType.CENTER)
    executeButtonLabelResolve:setLocalZOrder(10)
    executeButtonLabelResolve:computePosition()
    executeButtonResolve:addChild(executeButtonLabelResolve)
    executeButtonLabelResolve:setName("executeButtonLabelResolve")
    result.executeButtonLabelResolve = executeButtonLabelResolve

    result.root = ResolveEquipNode 
    return result 
end 

function Result.createRemouldLayer() 

    local result = {} 

    local RemouldLayer = UI.Component:create()
    RemouldLayer:init()
    RemouldLayer:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    RemouldLayer:setReflectPos(-398, 0)
    RemouldLayer:setVisible(false)
    RemouldLayer:setLocalZOrder(1)
    RemouldLayer:setReflectSize(150, 150)
    RemouldLayer:computePosition()
    RemouldLayer:setName("RemouldLayer")
    result.RemouldLayer = RemouldLayer

    local materalNode = UI.Image:create()
    materalNode:init("ui_blacksmith_box2.png")
    materalNode:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    materalNode:setReflectPos(0, 76)
    materalNode:computePosition()
    RemouldLayer:addChild(materalNode)
    materalNode:setName("materalNode")
    result.materalNode = materalNode

    local materalIcon = UI.Image:create()
    materalIcon:init("ui_blacksmith_forge.png")
    materalIcon:setLayoutType(UI.LayoutDefaultType.CENTER)
    materalIcon:computePosition()
    materalNode:addChild(materalIcon)
    materalIcon:setName("materalIcon")
    result.materalIcon = materalIcon

    result.root = RemouldLayer 
    return result 
end 

function Result.createForgeLayer() 

    local result = {} 

    local ForgeLayer = UI.Component:create()
    ForgeLayer:init()
    ForgeLayer:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    ForgeLayer:setReflectPos(-398, 0)
    ForgeLayer:setVisible(false)
    ForgeLayer:setLocalZOrder(2)
    ForgeLayer:setReflectSize(150, 150)
    ForgeLayer:computePosition()
    ForgeLayer:setName("ForgeLayer")
    result.ForgeLayer = ForgeLayer

    local materalNodeForge = UI.Image:create()
    materalNodeForge:init("ui_blacksmith_box2.png")
    materalNodeForge:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    materalNodeForge:setReflectPos(0, 76)
    materalNodeForge:computePosition()
    ForgeLayer:addChild(materalNodeForge)
    materalNodeForge:setName("materalNodeForge")
    result.materalNodeForge = materalNodeForge

    local materalIconForge = UI.Image:create()
    materalIconForge:init("ui_blacksmith_forge.png")
    materalIconForge:setLayoutType(UI.LayoutDefaultType.CENTER)
    materalIconForge:computePosition()
    materalNodeForge:addChild(materalIconForge)
    materalIconForge:setName("materalIconForge")
    result.materalIconForge = materalIconForge

    result.root = ForgeLayer 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "makeEquipNode" 
    if modelName == "makeEquipNode" then 
        return Result.createmakeEquipNode()
    elseif modelName == "strengLayer" then 
        return Result.createstrengLayer()
    elseif modelName == "attChangeModel" then 
        return Result.createattChangeModel()
    elseif modelName == "AttRemouldModel" then 
        return Result.createAttRemouldModel()
    elseif modelName == "RemouldTipModel" then 
        return Result.createRemouldTipModel()
    elseif modelName == "remouldTipAttMoule" then 
        return Result.createremouldTipAttMoule()
    elseif modelName == "ForgeMaterialModel" then 
        return Result.createForgeMaterialModel()
    elseif modelName == "ResolveEquipNode" then 
        return Result.createResolveEquipNode()
    elseif modelName == "RemouldLayer" then 
        return Result.createRemouldLayer()
    elseif modelName == "ForgeLayer" then 
        return Result.createForgeLayer()
    elseif modelName == "EquipConvertLayer" then
        return Result.createConvertNode()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_town_blacksmith.plist", 
    [2] = "ui_common_information.plist", 
    [3] = "ui_common_scale9image.plist", 
    [4] = "ui_common_symbol.plist", 
    [5] = "ui_common_btn.plist", 
}

return Result 
