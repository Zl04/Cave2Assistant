local Result = {} 
function Result.createmodelLayer() 

    local result = {} 

    local modelLayer = UI.Component:create()
    modelLayer:init()
    modelLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    modelLayer:setReflectPos(180, 50)
    modelLayer:setReflectSize(760, 560)
    modelLayer:computePosition()
    modelLayer:setName("modelLayer")
    result.modelLayer = modelLayer

    local tree = UI.Image:create()
    tree:init("ui_gemshop_rattan0.png")
    tree:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    tree:setReflectPos(737, 32)
    tree:setLocalZOrder(-1)
    tree:computePosition()
    modelLayer:addChild(tree)
    tree:setName("tree")
    result.tree = tree

    local bg = UI.Image:create()
    bg:init("ui_rune_bg.png")
    -- bg:init("ui_bg_box1.png")
    bg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bg:computePosition()
    modelLayer:addChild(bg)
    bg:setName("bg")
    result.bg = bg

    local titleImage = UI.Image:create()
    titleImage:init("ui_bg_title.png")
    titleImage:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    titleImage:setReflectPos(-10, -21)
    titleImage:computePosition()
    bg:addChild(titleImage)
    titleImage:setName("titleImage")
    result.titleImage = titleImage

    local titleStr = UI.Text:create()
    titleStr:initWithLanguageId(1111264, UI.FONT_BOLD, 26, {r=170,g=170,b=170})
    titleStr:setLayoutType(UI.LayoutDefaultType.CENTER)
    titleStr:setReflectPos(10, 0)
    titleStr:computePosition()
    titleImage:addChild(titleStr)
    titleStr:setName("titleStr")
    result.titleStr = titleStr

    local paper = UI.Image:create()
    paper:init("ui_bg_paper1.png")
    paper:center(0,15)
    bg:addChild(paper)
    paper:setName("paper")
    result.paper = paper

    local contentLayer1 = UI.Component:create()
    contentLayer1:init()
    contentLayer1:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentLayer1:setReflectPos(28, 50)
    contentLayer1:setReflectSize(200, 265)
    contentLayer1:computePosition()
    paper:addChild(contentLayer1)
    contentLayer1:setName("contentLayer1")
    result.contentLayer1 = contentLayer1

    local contentLayer2 = UI.Component:create()
    contentLayer2:init()
    contentLayer2:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentLayer2:setReflectPos(235, 50)
    contentLayer2:setReflectSize(200, 265)
    contentLayer2:computePosition()
    paper:addChild(contentLayer2)
    contentLayer2:setName("contentLayer2")
    result.contentLayer2 = contentLayer2

    local contentLayer3 = UI.Component:create()
    contentLayer3:init()
    contentLayer3:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentLayer3:setReflectPos(442, 50)
    contentLayer3:setReflectSize(200, 265)
    contentLayer3:computePosition()
    paper:addChild(contentLayer3)
    contentLayer3:setName("contentLayer3")
    result.contentLayer3 = contentLayer3

    local leftAnimation = UI.Animation:create()
    leftAnimation:init("effect_ui_town_gem_shelf.json", "effect_ui_town_gem_shelf.atlas", 1)
    leftAnimation:setAnimation("idle", true)
    leftAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    leftAnimation:setReflectPos(-13, 535 + 30)
    leftAnimation:setReflectSize(0, 0)
    leftAnimation:computePosition()
    bg:addChild(leftAnimation,10)
    leftAnimation:setName("leftAnimation")
    result.leftAnimation = leftAnimation

    local tree2 = UI.Image:create()
    tree2:init("ui_shop_rattan2.png")
    tree2:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    tree2:setReflectPos(491, 377)
    tree2:computePosition()
    bg:addChild(tree2)
    tree2:setName("tree2")
    result.tree2 = tree2

    local rightAnimation = UI.Animation:create()
    rightAnimation:init("effect_ui_town_gem_right.json", "effect_ui_town_gem_right.atlas", 1)
    rightAnimation:setAnimation("idle", true)
    rightAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    rightAnimation:setReflectPos(739, 506 + 30)
    rightAnimation:setLocalZOrder(10)
    rightAnimation:setReflectSize(0, 0)
    rightAnimation:computePosition()
    bg:addChild(rightAnimation,10)
    rightAnimation:setName("rightAnimation")
    result.rightAnimation = rightAnimation

    local toastImg = UI.Image:create()
    toastImg:init("ui_shopping_banner_prompt.png")
    toastImg:leftBottom(330, 3)
    bg:addChild(toastImg,20)

    local toastText = UI.Text:create()
	toastText:init(UI.TEXT_223902, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 200, g = 200, b = 200})
	toastText:leftBottom(330 + 15, 3)
    bg:addChild(toastText)

    --预览下级产出
    local nextGemBtn = UI.Button:create()
    nextGemBtn:init("ui_rune_magnifier.png", "ui_rune_magnifier.png", "ui_rune_magnifier.png", {x=0, y=0})
    nextGemBtn._clickScale = true
    nextGemBtn._baseline = 1
    nextGemBtn:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    nextGemBtn:setReflectPos(75, 45)
    nextGemBtn:computePosition()
    bg:addChild(nextGemBtn)
    nextGemBtn:setName("nextGemBtn")
    result.nextGemBtn = nextGemBtn

    local nextDesText = UI.Text:create()
	nextDesText:init(UI.TEXT_223904, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 200, g = 200, b = 200})
	nextDesText:leftUp(75 + 30, 46)
    bg:addChild(nextDesText)

    --符文洞窟等级相关
    local progressTimerBg = UI.Image:create()
    progressTimerBg:init("ui_rune_schedulebg.png")
    progressTimerBg:leftBottom(130,448)
    bg:addChild(progressTimerBg)
    result.progressTimerBg = progressTimerBg

    local centerBg = cc.Sprite:createWithSpriteFrameName("ui_rune_schedule.png")
    local ptimer = cc.ProgressTimer:create(centerBg)
    ptimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    ptimer:setMidpoint(cc.p(0, 0))
    ptimer:setBarChangeRate(cc.p(1, 0))
    ptimer:setPercentage(0)
    ptimer:setPosition(130,448)
    ptimer:setAnchorPoint(0,0)
    bg:addChild(ptimer)
    result.ptimer = ptimer

    -- local expMaxSp = UI.Animation:create()
    -- expMaxSp:init("effect_ui_starmap_levelup_experience.json", "effect_ui_starmap_levelup_experience.atlas", 1);
    -- expMaxSp:leftBottom(580,446)
    -- expMaxSp:setAnimation("idle", true)
    -- bg:addChild(expMaxSp,11)
    -- expMaxSp:hide()
    -- result.expMaxSp = expMaxSp

    local levelTextBg = UI.Image:create()
    levelTextBg:init("ui_rune_lvbg.png")
    levelTextBg:leftBottom(110,440)
    bg:addChild(levelTextBg)
    result.levelTextBg = levelTextBg

    local levelText = UI.Text:create()
    levelText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r=220,g=182,b=80})
    levelText:center(-5)
    levelTextBg:addChild(levelText)
    result.levelText = levelText

    local expText = UI.Text:create()
    expText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r=45,g=45,b=45})
    expText:leftBottom(586,446)
    bg:addChild(expText)
    result.expText = expText


    result.root = modelLayer 
    return result 
end 

function Result.createmodelShop()
    local result = {} 

    local modelLayer = UI.Component:create()
    modelLayer:init()
    modelLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    modelLayer:setReflectPos(180, 50)
    modelLayer:setReflectSize(760, 560)
    modelLayer:computePosition()
    modelLayer:setName("modelLayer")
    result.modelLayer = modelLayer

    local tree = UI.Image:create()
    tree:init("ui_gemshop_rattan0.png")
    tree:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    tree:setReflectPos(737, 32)
    tree:setLocalZOrder(-1)
    tree:computePosition()
    modelLayer:addChild(tree)
    tree:setName("tree")
    result.tree = tree

    local bg = UI.Image:create()
    bg:init("ui_rune_bg.png")
    bg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bg:computePosition()
    modelLayer:addChild(bg)
    bg:setName("bg")
    result.bg = bg

    local titleImage = UI.Image:create()
    titleImage:init("ui_bg_title.png")
    titleImage:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    titleImage:setReflectPos(-10, -21)
    titleImage:computePosition()
    bg:addChild(titleImage)
    titleImage:setName("titleImage")
    result.titleImage = titleImage

    local titleStr = UI.Text:create()
    titleStr:init(UI.TEXT_223901, UI.FONT_BOLD, 26, {r=170,g=170,b=170})
    titleStr:setLayoutType(UI.LayoutDefaultType.CENTER)
    titleStr:setReflectPos(10, 0)
    titleStr:computePosition()
    titleImage:addChild(titleStr)
    titleStr:setName("titleStr")
    result.titleStr = titleStr

    local leftAnimation = UI.Animation:create()
    leftAnimation:init("effect_ui_town_gem_shelf.json", "effect_ui_town_gem_shelf.atlas", 1)
    leftAnimation:setAnimation("idle", true)
    leftAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    leftAnimation:setReflectPos(-13, 535 + 30)
    leftAnimation:setReflectSize(0, 0)
    leftAnimation:computePosition()
    bg:addChild(leftAnimation,10)
    leftAnimation:setName("leftAnimation")
    result.leftAnimation = leftAnimation

    local tree2 = UI.Image:create()
    tree2:init("ui_shop_rattan2.png")
    tree2:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    tree2:setReflectPos(491, 377)
    tree2:computePosition()
    bg:addChild(tree2)
    tree2:setName("tree2")
    result.tree2 = tree2

    local rightAnimation = UI.Animation:create()
    rightAnimation:init("effect_ui_town_gem_right.json", "effect_ui_town_gem_right.atlas", 1)
    rightAnimation:setAnimation("idle", true)
    rightAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    rightAnimation:setReflectPos(739, 506 + 30)
    rightAnimation:setLocalZOrder(10)
    rightAnimation:setReflectSize(0, 0)
    rightAnimation:computePosition()
    bg:addChild(rightAnimation,10)
    rightAnimation:setName("rightAnimation")
    result.rightAnimation = rightAnimation

    local toastImg = UI.Image:create()
    toastImg:init("ui_shopping_banner_prompt.png")
    toastImg:leftBottom(330, 3)
    bg:addChild(toastImg,20)

    local toastText = UI.Text:create()
	toastText:init(UI.TEXT_223902, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 200, g = 200, b = 200})
	toastText:leftBottom(330 + 15, 3)
    bg:addChild(toastText)

    result.root = modelLayer 
    return result
end

function Result.createcellModel() 

    local result = {} 

    local cellModel = UI.Image:create()
    cellModel:init("ui_gemshop_Paper.png")
    cellModel:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cellModel:setReflectPos(253, 143)
    cellModel:computePosition()
    cellModel:setName("cellModel")
    result.cellModel = cellModel

    local cellTitle = UI.Text:create()
    cellTitle:initWithLanguageId(1111230, UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    cellTitle:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    cellTitle:setReflectPos(-4, 10)
    cellTitle:computePosition()
    cellModel:addChild(cellTitle)
    cellTitle:setName("cellTitle")
    result.cellTitle = cellTitle

    local cellDes = UI.Text:create()
    cellDes:initWithLanguageId(1111367, UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    cellDes:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    cellDes:setReflectPos(-4, 36)
    cellDes:computePosition()
    cellModel:addChild(cellDes)
    cellDes:setName("cellDes")
    result.cellDes = cellDes

    local cellRewardDes = UI.Text:create()
    cellRewardDes:init("再探索2次，必得3级符文石", UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    cellRewardDes:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    cellRewardDes:setLineSpacing(-1)
    cellRewardDes:setDimensions(150,0)
    cellRewardDes:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    cellRewardDes:setReflectPos(-4, 212 + 20)
    cellRewardDes:computePosition()
    cellModel:addChild(cellRewardDes)
    cellRewardDes:setName("cellRewardDes")
    result.cellRewardDes = cellRewardDes

    local splitLine1 = UI.Image9:create()
    splitLine1:init("ui_scale9image_banner_line_dark.png",{x=0,y=0,width=20,height=20})
    splitLine1:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    -- splitLine1:setReflectPos(-4, 60)
    splitLine1:setReflectPos(-4, 60 + 2)
    splitLine1:setReflectSize(160, 1)
    splitLine1:computePosition()
    cellModel:addChild(splitLine1)
    splitLine1:setName("splitLine1")
    result.splitLine1 = splitLine1

    local splitLine12 = UI.Image9:create()
    splitLine12:init("ui_scale9image_banner_line_dark.png",{x=0,y=0,width=20,height=20})
    splitLine12:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    splitLine12:setReflectPos(-4, 205 + 20)
    splitLine12:setReflectSize(160, 1)
    splitLine12:computePosition()
    cellModel:addChild(splitLine12)
    splitLine12:setName("splitLine12")
    result.splitLine12 = splitLine12

    local cellDes2 = UI.Text:create()
	cellDes2:init(UI.TEXT_223903, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r=41,g=41,b=45})
    cellDes2:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    cellDes2:setReflectPos(-4, 202)
    cellDes2:computePosition()
    cellModel:addChild(cellDes2)
    cellDes2:setName("cellDes2")
    result.cellDes2 = cellDes2

    local cellIcon = UI.Image:create()
    cellIcon:init("ui_gemshop_icon1.png")
    cellIcon:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    cellIcon:setReflectPos(-4, 67 + 20)
    cellIcon:computePosition()
    cellModel:addChild(cellIcon)
    cellIcon:setName("cellIcon")
    result.cellIcon = cellIcon

    local itemBuyBtn = UI.Button:create()
    itemBuyBtn:init("ui_btn_yellow7_0.png", "ui_btn_yellow7_1.png", "ui_btn_yellow7_2.png", {x=0, y=0})
    itemBuyBtn._clickScale = true
    itemBuyBtn._baseline = 1
    itemBuyBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    itemBuyBtn:setReflectPos(2, 298)
    itemBuyBtn:computePosition()
    cellModel:addChild(itemBuyBtn)
    itemBuyBtn:setName("itemBuyBtn")
    result.itemBuyBtn = itemBuyBtn

    local playAdsBtn = UI.Button:create()
    playAdsBtn:init("ui_btn_advertisement1_2_1.png", "ui_btn_advertisement1_2_2.png", "ui_btn_advertisement1_2_1.png", {x=0, y=0})
    playAdsBtn._clickScale = true
    playAdsBtn._baseline = 1
    playAdsBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    playAdsBtn:setReflectPos(2, 358)
    playAdsBtn:computePosition()
    cellModel:addChild(playAdsBtn)
    playAdsBtn:setName("playAdsBtn")
    result.playAdsBtn = playAdsBtn

    local playAdsDes = UI.Text:create()
    playAdsDes:initWithLanguageId(1111364, UI.FONT_STANDARD, 18, {r=50,g=50,b=44})
    playAdsDes:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    playAdsDes:setReflectPos(60, 1)
    playAdsDes:setLocalZOrder(10)
    playAdsDes:computePosition()
    playAdsDes:setName("PlayAdsDes")
    playAdsBtn:addChild(playAdsDes)
    result.playAdsDes = playAdsDes

    local freeDes = UI.Text:create()
    freeDes:initWithLanguageId(1111364, UI.FONT_STANDARD, 20, {r=50,g=50,b=44})
    freeDes:setLayoutType(UI.LayoutDefaultType.CENTER)
    freeDes:setReflectPos(0, -1)
    freeDes:setVisible(false)
    freeDes:setLocalZOrder(10)
    freeDes:computePosition()
    itemBuyBtn:addChild(freeDes)
    freeDes:setName("freeDes")
    result.freeDes = freeDes

    local diamondBuyBtn = UI.Button:create()
    diamondBuyBtn:init("ui_btn_yellow7_0.png", "ui_btn_yellow7_1.png", "ui_btn_yellow7_2.png", {x=0, y=0})
    diamondBuyBtn._clickScale = true
    diamondBuyBtn._baseline = 1
    diamondBuyBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    diamondBuyBtn:setReflectPos(104, 298)
    diamondBuyBtn:computePosition()
    cellModel:addChild(diamondBuyBtn)
    diamondBuyBtn:setName("diamondBuyBtn")
    result.diamondBuyBtn = diamondBuyBtn

    local timeIcon = UI.Image:create()
    timeIcon:init("ui_information_clock_bg.png")
    timeIcon:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    timeIcon:setReflectPos(-4, 331)
    timeIcon:computePosition()
    cellModel:addChild(timeIcon)
    timeIcon:setName("timeIcon")
    result.timeIcon = timeIcon

    local restTimeStr = UI.Text:create()
    restTimeStr:init("20:20:20", UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    restTimeStr:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    restTimeStr:setReflectPos(35, 5)
    restTimeStr:computePosition()
    timeIcon:addChild(restTimeStr)
    restTimeStr:setName("restTimeStr")
    result.restTimeStr = restTimeStr

    local oneTime = UI.Text:create()
    oneTime:initWithLanguageId(1111362, UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    oneTime:setLayoutType(UI.LayoutDefaultType.CENTER)
    oneTime:setReflectPos(-53, 149)
    oneTime:computePosition()
    cellModel:addChild(oneTime)
    oneTime:setName("oneTime")
    result.oneTime = oneTime

    local tenTime = UI.Text:create()
    tenTime:initWithLanguageId(1111363, UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    tenTime:setLayoutType(UI.LayoutDefaultType.CENTER)
    tenTime:setReflectPos(49, 149)
    tenTime:computePosition()
    cellModel:addChild(tenTime)
    tenTime:setName("tenTime")
    result.tenTime = tenTime

    -- 今日可购买次数 (CO-17181  添加,  范围: 国内版本   目的: 审核内容, 限制次数)
    local remainingTimesText = UI.Text:create()
    remainingTimesText:init(UI.TEXT_221300 .. "999", UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    remainingTimesText:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    remainingTimesText:setReflectPos(102, 336)
    remainingTimesText:computePosition()
    cellModel:addChild(remainingTimesText)
    remainingTimesText:setName("remainingTimesText")
    result.remainingTimesText = remainingTimesText

    result.root = cellModel 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "modelLayer" 
    if modelName == "modelLayer" then 
        return Result.createmodelLayer()
    elseif modelName == "modelShop" then 
        return Result.createmodelShop()
    elseif modelName == "cellModel" then 
        return Result.createcellModel()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_bg_paper3.plist", 
    [2] = "ui_common_btn.plist", 
    [3] = "ui_town_gemshop.plist", 
    [4] = "ui_common_information.plist", 
    [5] = "ui_common_scale9image.plist", 
}

return Result 
