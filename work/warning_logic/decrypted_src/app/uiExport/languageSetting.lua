local Result = {} 
function Result.createbg() 

    local result = {} 

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box.png")
    bg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bg:setReflectPos(13, 15)
    bg:computePosition()
    bg:setName("bg")
    result.bg = bg

    local title = UI.Text:create()
    title:initWithLanguageId(1110772, UI.FONT_STANDARD, 18, {r=50,g=50,b=44})
    title:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    title:setReflectPos(0, 15)
    title:computePosition()
    bg:addChild(title)
    title:setName("title")
    result.title = title

    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_light.png",{x=0,y=0,width=20,height=20})
    splitLine:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    splitLine:setReflectPos(0, 50)
    splitLine:setLocalZOrder(1000)
    splitLine:setReflectSize(420, 1)
    splitLine:computePosition()
    bg:addChild(splitLine)
    splitLine:setName("splitLine")
    result.splitLine = splitLine

    result.root = bg 
    return result 
end 

function Result.createEffectBg(titleId) 

    local result = {} 

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box.png")
    bg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bg:setReflectPos(13, 15)
    bg:computePosition()
    bg:setName("bg")
    result.bg = bg

    local title = UI.Text:create()
    title:initWithLanguageId(titleId, UI.FONT_STANDARD, 18, {r=50,g=50,b=44})
    title:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    title:setReflectPos(0, 15)
    title:computePosition()
    bg:addChild(title)
    title:setName("title")
    result.title = title

    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_light.png",{x=0,y=0,width=20,height=20})
    splitLine:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    splitLine:setReflectPos(0, 50)
    splitLine:setLocalZOrder(1000)
    splitLine:setReflectSize(420, 1)
    splitLine:computePosition()
    bg:addChild(splitLine)
    splitLine:setName("splitLine")
    result.splitLine = splitLine

    result.root = bg 
    return result 
end 

function Result.createbindAccount() 

    local result = {} 

    local bindAccount = UI.Image:create()
    bindAccount:init("ui_setup_banner_box.png")
    bindAccount:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bindAccount:setReflectPos(565, 16)
    bindAccount:computePosition()
    bindAccount:setName("bindAccount")
    result.bindAccount = bindAccount

    local titleBindAccount = UI.Text:create()
    titleBindAccount:initWithLanguageId(1110779, UI.FONT_STANDARD, 18, {r=50,g=50,b=44})
    titleBindAccount:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    titleBindAccount:setDimensions(400,0)
    titleBindAccount:setLayoutType(UI.LayoutDefaultType.CENTER)
    titleBindAccount:setReflectPos(0, -80)
    titleBindAccount:computePosition()
    bindAccount:addChild(titleBindAccount)
    titleBindAccount:setName("titleBindAccount")
    result.titleBindAccount = titleBindAccount

    local splitLineBindAccount = UI.Image9:create()
    splitLineBindAccount:init("ui_scale9image_banner_line_light.png",{x=0,y=0,width=20,height=20})
    splitLineBindAccount:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    splitLineBindAccount:setReflectPos(0, 115)
    splitLineBindAccount:setLocalZOrder(1000)
    splitLineBindAccount:setReflectSize(420, 1)
    splitLineBindAccount:computePosition()
    bindAccount:addChild(splitLineBindAccount)
    splitLineBindAccount:setName("splitLineBindAccount")
    result.splitLineBindAccount = splitLineBindAccount

    result.root = bindAccount 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "bg" 
    if modelName == "bg" then 
        return Result.createbg()
    elseif modelName == "backEffectBg" then 
        return Result.createEffectBg(1114640)
    elseif modelName == "rockerShapeBg" then 
        return Result.createEffectBg(1114641)
    elseif modelName == "bindAccount" then 
        return Result.createbindAccount()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_common_scale9image.plist", 
    [2] = "ui_general_tips.plist", 
}

return Result 
