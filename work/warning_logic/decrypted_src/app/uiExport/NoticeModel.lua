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
    noticeTitle:initWithLanguageId(1110587, UI.FONT_BOLD, 26, {r=170,g=170,b=170})
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
    noticeContentTitle:initWithLanguageId(1111086, UI.FONT_STANDARD, 24, {r=41,g=41,b=45})
    noticeContentTitle:setLayoutType(UI.LayoutDefaultType.CENTER)
    noticeContentTitle:computePosition()
    noticeContentTitleBg:addChild(noticeContentTitle)
    noticeContentTitle:setName("noticeContentTitle")
    result.noticeContentTitle = noticeContentTitle

    local leftArrow = UI.Image:create()
    leftArrow:init("ui_general_notice_progressbar_line.png")
    leftArrow:setLayoutType(UI.LayoutDefaultType.CENTER_LEFT)
    leftArrow:setReflectPos(-150, 0)
    leftArrow:computePosition()
    noticeContentTitleBg:addChild(leftArrow)
    leftArrow:setName("leftArrow")
    result.leftArrow = leftArrow

    local rightArrow = UI.Image:create()
    rightArrow:init("ui_general_notice_progressbar_line.png")
    rightArrow:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    rightArrow:setScale(-1, 1)
    rightArrow:setReflectPos(-150, 0)
    rightArrow:computePosition()
    noticeContentTitleBg:addChild(rightArrow)
    rightArrow:setName("rightArrow")
    result.rightArrow = rightArrow

    local contentLayer = UI.Component:create()
    contentLayer:init()
    contentLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentLayer:setReflectPos(140, 125)
    contentLayer:setReflectSize(623, 330)
    contentLayer:computePosition()
    Notice:addChild(contentLayer)
    contentLayer:setName("contentLayer")
    result.contentLayer = contentLayer

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
    [1] = "ui_general_notice.plist", 
}

return Result 
