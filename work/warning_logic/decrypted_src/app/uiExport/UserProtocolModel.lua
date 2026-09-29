local Result = {} 
function Result.createNotice() 

    local result = {} 

    local Notice = UI.Image:create()
    Notice:init("ui_general_notice_box.png")
    Notice:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    Notice:setReflectPos(83, 33)
    Notice:computePosition()
    Notice:setName("Notice")
    result.Notice = Notice

    local noticeTitle = UI.Text:create()
    noticeTitle:initWithLanguageId(1111299, UI.FONT_BOLD, 26, {r=170,g=170,b=170})
    noticeTitle:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    noticeTitle:setReflectPos(-7, 12)
    noticeTitle:computePosition()
    Notice:addChild(noticeTitle)
    noticeTitle:setName("noticeTitle")
    result.noticeTitle = noticeTitle

    local noticeContentTitleBg = UI.Image9:create()
    noticeContentTitleBg:init("ui_general_notice_progressbar_lookup.png",{x=100,y=23,width=20,height=20})
    noticeContentTitleBg:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    noticeContentTitleBg:setReflectPos(-7, 86)
    noticeContentTitleBg:setReflectSize(177, 23)
    noticeContentTitleBg:computePosition()
    Notice:addChild(noticeContentTitleBg)
    noticeContentTitleBg:setName("noticeContentTitleBg")
    result.noticeContentTitleBg = noticeContentTitleBg

    local noticeContentTitle = UI.Text:create()
    noticeContentTitle:initWithLanguageId(1111216, UI.FONT_STANDARD, 24, {r=41,g=41,b=45})
    noticeContentTitle:setLayoutType(UI.LayoutDefaultType.CENTER)
    noticeContentTitle:computePosition()
    noticeContentTitleBg:addChild(noticeContentTitle)
    noticeContentTitle:setName("noticeContentTitle")
    result.noticeContentTitle = noticeContentTitle

    local leftArrow = UI.Image:create()
    leftArrow:init("ui_general_notice_progressbar_line.png")
    leftArrow:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    leftArrow:setReflectPos(-144, 0)
    leftArrow:computePosition()
    noticeContentTitleBg:addChild(leftArrow)
    leftArrow:setName("leftArrow")
    result.leftArrow = leftArrow

    local rightArrow = UI.Image:create()
    rightArrow:init("ui_general_notice_progressbar_line.png")
    rightArrow:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    rightArrow:setScale(-1, 1)
    rightArrow:setReflectPos(-144, 0)
    rightArrow:computePosition()
    noticeContentTitleBg:addChild(rightArrow)
    rightArrow:setName("rightArrow")
    result.rightArrow = rightArrow

    local buttonLayer = UI.Component:create()
    buttonLayer:init()
    buttonLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    buttonLayer:setReflectPos(117, 460)
    buttonLayer:setReflectSize(660, 50)
    buttonLayer:computePosition()
    Notice:addChild(buttonLayer)
    buttonLayer:setName("buttonLayer")
    result.buttonLayer = buttonLayer

    local okButton = UI.Button:create()
    okButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png", {x=0, y=0})
    okButton:setTextFont(UI.FONT_BOLD, 20, {r=50,g=50,b=44})
    okButton:setTextById(1110910)
    okButton._clickScale = true
    okButton._baseline = 1
    okButton:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    okButton:setReflectPos(423, 5)
    okButton:computePosition()
    buttonLayer:addChild(okButton)
    okButton:setName("okButton")
    result.okButton = okButton

    local cancelButton = UI.Button:create()
    cancelButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png", {x=0, y=0})
    cancelButton:setTextFont(UI.FONT_BOLD, 20, {r=50,g=50,b=44})
    cancelButton:setTextById(1111301)
    cancelButton._clickScale = true
    cancelButton._baseline = 1
    cancelButton:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cancelButton:setReflectPos(54, 5)
    cancelButton:computePosition()
    buttonLayer:addChild(cancelButton)
    cancelButton:setName("cancelButton")
    result.cancelButton = cancelButton

    local confrimButton = UI.Button:create()
    confrimButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png", {x=0, y=0})
    confrimButton:setTextFont(UI.FONT_BOLD, 20, {r=50,g=50,b=44})
    confrimButton:setTextById(1110645)
    confrimButton._clickScale = true
    confrimButton._baseline = 1
    confrimButton:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    confrimButton:setReflectPos(1, 5)
    confrimButton:setVisible(false)
    confrimButton:computePosition()
    buttonLayer:addChild(confrimButton)
    confrimButton:setName("confrimButton")
    result.confrimButton = confrimButton

    local contentLayer = UI.Component:create()
    contentLayer:init()
    contentLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentLayer:setReflectPos(140, 130)
    contentLayer:setReflectSize(623, 320)
    contentLayer:computePosition()
    Notice:addChild(contentLayer)
    contentLayer:setName("contentLayer")
    result.contentLayer = contentLayer

    local mask = UI.Image:create()
    mask:init("ui_general_notice_box_mask.png")
    mask:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    mask:setReflectPos(91, 408)
    mask:computePosition()
    Notice:addChild(mask)
    mask:setName("mask")
    result.mask = mask

    result.root = Notice 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "Notice" 
    if modelName == "Notice" then 
        return Result.createNotice()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_common_btn.plist", 
    [2] = "ui_general_notice.plist", 
}

return Result 
