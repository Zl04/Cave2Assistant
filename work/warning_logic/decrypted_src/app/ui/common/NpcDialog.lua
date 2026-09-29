-- NpcDialog.lua
-- Author:ydli
-- 2017年12月04日
-- Using:npc对话框
require "cocos.framework.audio"
require "app.utils.PlaceholderUtil"
require "utils.Scheduler"
require "utils.IrregularShapeScreenUtil"
require "utils.AvalonUtil"

UI = UI or {}

local NpcDialog = class("NpcDialog", UI.HWBtnComponent)
UI.NpcDialog = NpcDialog
local RES_LIST = {
    "ui_common_npcIcon.plist",
    "ui_general_comment.plist",
    "ui_common_information.plist",
}

local winSize = cc.Director:getInstance():getWinSize()











---------------- 生命周期 ------------------
-- existingRolePicFrameAndId结构
-- npcImage 和 npcPicture 二选一, npcPicture 优先于 npcImage
-- npcImage:        0-无图片, 1-自身人物动画截图, npc动画文件名字-npc人物动画截图
-- npcPicture:      图片资源名字-直接使用图片资源
-- rolePicFrame:    已经截图或缓存完成并且遮蔽完成的图片Node

-- 构造函数
function NpcDialog:ctor(id, callback, beginID, existingRolePicFrameAndId, isCameraMoved, defaultMoveCameraDuration, isSwallowTouch)
    NpcDialog.super.ctor(self, 0, RES_LIST, winSize.width, winSize.height)
    self.id = id
    self.beginID = beginID and beginID or self.id
    self.callback = callback
    self.data = nil
    self.txtNum = 1
    self.bClose = false --能否关闭
    self.playingSoundHandle = nil
    self.dialog = nil
    self.existingRolePicFrameAndId = existingRolePicFrameAndId
    self.moveCameraDuration = defaultMoveCameraDuration
    self.isCameraMoved = isCameraMoved
    self.isSwallowTouch = isSwallowTouch
    self:init()
    -- 强制添加硬件按钮反应标签
    self:setForceListenBackKey(true)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, self)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FORCE_REMOVE_NPC_DIALOG, self, self.forceClose)
end

-- 析构函数
function NpcDialog:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FORCE_REMOVE_NPC_DIALOG, self, self.forceClose)
    -- 1. 打开方向按钮
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self)
    if not self.isForceClose and self.data and self.data.nextDialogue ~= 0 then
        -- 如果有下一个对话, , 新对话框判断使用或释放后创建新NPC头像
        -- 1. 把这次对话的NPC头像卸下
        if (self.existingRolePicFrameAndId and self.existingRolePicFrameAndId.rolePicFrame) then
            self.rootLayer:removeChild(self.existingRolePicFrameAndId.rolePicFrame)
        end
        -- 2. 然后把已经创建的NPC头像传递给下一个对话框使用, 下一个对话框会判断使用或释放
        local npcDialog = UI.NpcDialog:create(
            self.data.nextDialogue,
            self.callback,
            self.beginID,
            self.existingRolePicFrameAndId,
            self.isCameraMoved,
            self.data.moveCameraDuration)
        npcDialog:center(0)
        npcDialog:setName("NpcDialog")
        self:getParent():addChild(npcDialog,999)
    else
        -- 2. 如果指示了关闭黑圈, 关闭黑圈
        if (self.data and self.data.clickEnd == 1) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REMOVE_INDICATE_UI)
        end
        -- 3. 调用回调
        if (self.callback) then self.callback() end

        -- 如果没有下一个关联对话了
        -- 4. 完结新手引导并且重新打开方向按钮
        Avalon.MessageCenter:notice(AvalonMessage.MC_FINISH_NPC_DIALOG, self.beginID)

        -- 5. 把镜头移动回主角
        self:moveCameraBackToMaster()
    end

    -- 始终释放rolePicFrame因为创建的时候retain了一次, 如果下一个对话框有使用它, 下个对话框就已经retain了这里只管自己就行
    if (self.existingRolePicFrameAndId and self.existingRolePicFrameAndId.rolePicFrame) then
        self.existingRolePicFrameAndId.rolePicFrame:release()
    end

    self.callback = nil
    self.dialog = nil
    NpcDialog.super.dtor(self)
end

-- public:
-- 初始化
function NpcDialog:init()
    NpcDialog.super.init(self)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    if (self.isSwallowTouch ~= nil and tonumber(self.isSwallowTouch) ~= 1) then
        self:setSwallowTouches(false)
    end
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onClickHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        if (self.arrowDown) then self.arrowDown:setBtnStatus(ButtonState.ACTIVE) end
    end)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        if (self.arrowDown) then self.arrowDown:setBtnStatus(ButtonState.NORMAL) end
    end)
end

function NpcDialog:handleKeyBackUp()
    self:dispatchEvent(UIEvent.COMPONENT_CLICK, self)
    return true
end


-- 初始化视图
function NpcDialog:onInitView()
    GameManager:stopMoveHandler()
    local data = ConfigManager:getNpcDialogConfigById(self.id)
    if (not data) then 
        self:forceClose() 
        return
    end

    self.data = data
    self:moveCameraToCoord()

    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width,winSize.height))
    self:addChild(self.rootLayer)

    self:drawDialog()
    self:drawRolePic()
end

-- 模版函数：更新组建的视图(必备)
function NpcDialog:onUpdateView()
end
---------------- eo 生命周期 ------------------
















---------------- 程序逻辑 ------------------
-- 从人物动画中制作截图
function NpcDialog:createClippedImageFromAnimation(animation)
    -- 创建人物截图
    local _RenderTexture = cc.RenderTexture:create(400,400, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
    animation:setVisible(true)
    _RenderTexture:begin()
    animation:visit()
    _RenderTexture:endToLua()
    animation:setVisible(false)

    local _pic = cc.Sprite:createWithTexture(_RenderTexture:getSprite():getTexture())
    _pic:setPosition(0, 400)
    _pic:setAnchorPoint(0,0)
    _pic:setScaleY(-1)

    -- 创建遮挡
    local _clipperSprite = cc.Sprite:createWithSpriteFrameName("ui_scale9image_white.png")
    _clipperSprite:setScaleX(800)
    _clipperSprite:setScaleY(800)
    local _clipper = cc.ClippingNode:create(_clipperSprite)
    _clipper:setAlphaThreshold(0.05)
    _clipper:addChild(_pic,100)
    return _clipper
end


-- 显示对话框本身
function NpcDialog:drawDialog()
    -- 默认类型背景
    local contentWidth = 555
    local contentHeight = 112
    local contentOffsetX = 135
    local contentOffsetY = 45
    local fontSize = UI.FONT_SIZE_20PX
    local fontColor = UI.FONT_COLOR_170_170_170
    local bgImage = "ui_comment_banner_paper.png"
    local bgScaleY = 1
    local lineSpacing = nil
    
    -- 小类型对话框
    if (self.data.dialogBox == 2) then 
        contentWidth = 380
        contentHeight = 85
        contentOffsetX = 35
        contentOffsetY = 5
        fontSize = UI.FONT_SIZE_18PX
        fontColor = UI.FONT_COLOR_41_41_45
        bgImage = "ui_chat_paperbox.png"
        bgScaleY = 1.2
        lineSpacing = -5
    end

    -- 对话框背景
    local dialog = UI.Image:create()
    dialog:init(bgImage)
    dialog:setImageScaleY(bgScaleY)
    local box = dialog:getBoundingBox()
    local dialogWidth, dialogHeight = box.width, box.height
    -- 把对话框横向限制在屏幕里面
    local dialogX = winSize.width/2 - dialogWidth/2 + self.data.dialoguenLocation[1]
    local minX = Avalon.issUtil:getLeftMargin()
    local maxX = winSize.width - Avalon.issUtil:getWidthOffset()
    dialogX = dialogX >= minX and dialogX or minX
    dialogX = dialogX + dialogWidth <= maxX and dialogX or maxX - dialogWidth
    -- 把对话框纵向限制在屏幕里面
    local dialogY = winSize.height/2 - dialogHeight/2 + self.data.dialoguenLocation[2]
    local minY = Avalon.issUtil:getBottomMargin()
    local maxY = winSize.height - Avalon.issUtil:getHeightOffset()
    dialogY = dialogY >= minY and dialogY or minY
    dialogY = dialogY + dialogHeight <= maxY and dialogY or maxY - dialogHeight
    dialog:leftBottom(dialogX, dialogY)
    self.rootLayer:addChild(dialog, 2)
    self.dialog = dialog

    -- 内容
    local LanguageManager = require("app.game.LanguageManager")
    self._txtDialogue = LanguageManager:getInstance():getLocalString(self.data.dialogue)
    self._txtDialogue = PlaceholderUtil:parseMasterName(self._txtDialogue)
    printInfo("NpcDialog:drawDialog(), dialogId:" .. tostring(self.data.dialogue))
    local content = UI.Text:create()
    content:init(string.sub(self._txtDialogue,1,self.txtNum) , UI.FONT_STANDARD, fontSize, fontColor)
    content:setSize(contentWidth, contentHeight)
    content:setWidth(contentWidth)
    content:setTextLeft()
    if (lineSpacing) then
        content:setLineSpacing(lineSpacing)
    end
    content:leftBottom(contentOffsetX, contentOffsetY)
    dialog:addChild(content)
    self._content = content

    -- 对话框种类1有箭头
    if (self.data.nextDialogue ~= 0 and self.data.dialogBox == 1) then
        self.arrowDown = UI.Button:create()
        self.arrowDown:init("ui_comment_btn_arrow_0.png", "ui_comment_btn_arrow_1.png", "ui_comment_btn_arrow_0.png")
        self.arrowDown:leftBottom(693, 32)
        self.arrowDown:closeClickScale()
        self.arrowDown:setTouchEnable(false)
        dialog:addChild(self.arrowDown)

        local moveByAction = cc.MoveBy:create(1, cc.p(0, 15))
        local moveByRevAction = moveByAction:reverse()
        self.arrowDown:runAction(cc.RepeatForever:create(cc.Sequence:create(moveByAction, moveByRevAction)))
    end

    -- 逐字显示
    schedule(content, handler(self,self.showText), 0.02)
    self:playSound()
end


-- 显示人物头像
function NpcDialog:drawRolePic(existingRolePicFrame)
    -- 内部调用来展示人物头像的方法
    local function showRolePic(rolePicFrame)
        local roleZOrder = 1
        local rolePicScale = 1
        local dialogX, dialogY = self.dialog:getLeft(), self.dialog:getBottom()
        local box = self.dialog:getBoundingBox()
        local dialogW, dialogH = box.width, box.height
        local rolePicFrameYOffset = -38  -- 让人物图片向下偏移, 为了让人物显示和对话框显示之间没有缝隙
        local rolePicFrameXOffset = 10
    
        -- 根据配置调整头像大小
        if (self.data.dialogBox == 2) then 
            rolePicScale = 0.5
        end

        -- 根据配置调整头像左右
        if (self.data.flipAtX == 0) then
            rolePicFrame:setScale(rolePicScale)
            rolePicFrame:setPosition(dialogX + rolePicFrameXOffset, dialogY + dialogH + rolePicFrameYOffset)
        else
            rolePicFrame:setScaleY(rolePicScale)
            rolePicFrame:setScaleX(-1 * rolePicScale)
            rolePicFrame:setPosition(dialogX + dialogW + rolePicFrameXOffset, dialogY + dialogH + rolePicFrameYOffset)
        end

        -- 根据配置调整Z层级
        if (self.data.rolePicOnTop == 1) then
            roleZOrder = 100
        else
            roleZOrder = 1
        end

        self.rootLayer:addChild(rolePicFrame, roleZOrder)
    end

    -- 检查是否已有制作好的人物头像
    if (existingRolePicFrame) then
        showRolePic(existingRolePicFrame)
    else
        self:createRolePicFrameAsync(self.data.NPCPicture, self.data.NPCImage, self.data.NPCImageSize, self.data.NPCImageLocation, function(rolePicFrame)
            if (rolePicFrame) then showRolePic(rolePicFrame) end
        end)
    end
end


-- 制作人物头像
function NpcDialog:createRolePicFrameAsync(npcPicture, npcImage, scale, location, callback)
    -- npcPicture = "role_npc_function_shop_cave"
    -- scale = 2000
    -- location = {0, 0}

    -- 如果有已经建立好的人物头像, 对比ID, 如果一样就直接使用
    if (self.existingRolePicFrameAndId and 
            ((npcPicture ~= nil and self.existingRolePicFrameAndId.npcPicture == npcPicture) or
            (npcImage ~= nil and self.existingRolePicFrameAndId.npcImage == npcImage)))
    then
        -- 如果这一次使用的和上一次使用的ID一样, retain, 此时是在上一个对话框release它之前.
        self.existingRolePicFrameAndId.rolePicFrame:retain()
        callback(self.existingRolePicFrameAndId.rolePicFrame)
        return
    else
        self.existingRolePicFrameAndId = {}
    end

    -- 如果上面判断没有已有的头像, 就创建新的
    if npcPicture and npcPicture ~= "" and npcPicture ~= "0" then
        -- 如果有图片配置, 使用图片配置
        local rolePicFrame = cc.Node:create()
        local rolePic = cc.Sprite:createWithSpriteFrameName(npcPicture..".png")
        rolePic:setScale(scale/1000)
        rolePic:setPosition(location[1], location[2])
        rolePicFrame:addChild(rolePic)
        self.existingRolePicFrameAndId.npcPicture = npcPicture
        self.existingRolePicFrameAndId.rolePicFrame = rolePicFrame
        self.existingRolePicFrameAndId.rolePicFrame:retain()
        callback(rolePicFrame)
    else
        -- 如果没有图片配置, 使用NPC动画截图
        -- npcImage = "role_npc_function_shop_cave"
        if npcImage == "0" then
            -- 不显示图片
            callback(nil)
        elseif npcImage == "1" then
            -- 主角自己
            local roleAnimation = UI.RoleAnimation:create(false)
            roleAnimation:updataLooks(0)
            roleAnimation:init(RoleDataManager:getMaster())
            -- TODO: 这里+20暂时修复一个动画大小和实际大小有偏差导致裁剪的问题, 需要更完善的解决方法
            roleAnimation:leftBottom(location[1] + 20,location[2])
            roleAnimation:setScaleY(scale/1000 * roleAnimation:getScaleX())
            roleAnimation:setScaleX(scale/-1000 * roleAnimation:getScaleY())
            roleAnimation:setVisible(false)
            self.rootLayer:addChild(roleAnimation)
            roleAnimation:addEventListener(UIEvent.ROLE_LOADED_SPINE_SUCCESS, self, function()
                roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.05),cc.CallFunc:create(function()
                    local rolePicFrame = self:createClippedImageFromAnimation(roleAnimation)
                    self.existingRolePicFrameAndId.npcImage = npcImage
                    self.existingRolePicFrameAndId.rolePicFrame = rolePicFrame
                    self.existingRolePicFrameAndId.rolePicFrame:retain()
                    callback(rolePicFrame)
                end)))
            end)
        else
            -- NPC截图
            require "utils.Animation.AvalonAnimation"
            local roleAnimation = Avalon.Animation:create(npcImage..".json", npcImage..".atlas", 1)
            roleAnimation:setAnimation(0, "idle1", true)
            roleAnimation:setPosition(location[1],location[2])
            roleAnimation:setScale(scale/1000)
            roleAnimation:setVisible(false)
            self.rootLayer:addChild(roleAnimation)
            roleAnimation:setLoadedSpineSuccessCallBack(function ()
                roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.02),cc.CallFunc:create(function()
                    local rolePicFrame = self:createClippedImageFromAnimation(roleAnimation)
                    self.existingRolePicFrameAndId.npcImage = npcImage
                    self.existingRolePicFrameAndId.rolePicFrame = rolePicFrame
                    self.existingRolePicFrameAndId.rolePicFrame:retain()
                    callback(rolePicFrame)
                end)))
            end)
        end
    end
end


function NpcDialog:showText()
    self.txtNum = self.txtNum + 1
    self:showTextWithLength(self.txtNum)
    if self.txtNum > string.len(self._txtDialogue) then
        Avalon.Scheduler:scheduleUpdateOnce(self, function() self.bClose = true end, 0.2)
        self._content:stopAllActions()
    end
end

function NpcDialog:showTextWithLength(length)
    if (length > self._txtDialogue:len()) then return end

    local function getVisualWidth(text)
        local label = UI.Text:create()
        label:init(text .. "\n", self._content._fontName, self._content._fontSize, self._content._fontColor)

        return label._width
    end

    local function replaceChar(str, pos, r)
        return ("%s%s%s"):format(str:sub(1,pos-1), r, str:sub(pos+1))
    end

    -- 手动换行, 判断下一个单词的长度(空格间隔). 如果现在句子显示宽度加上下个单词宽度大于框宽度,
    -- 在显示下个单词之前就换行, 否则在逐字显示中会出现显示单词到一半跳入下一行的BUG
    local textToDisplay = self._txtDialogue:sub(1, length)
    if (textToDisplay:sub(length, length) == " " and self._txtDialogue:len() > length + 1) then
        local lines = textToDisplay:split("\n")
        local lastLine = lines[#lines]
        local lastLineWidth = getVisualWidth(lastLine)

        local nextWord = self._txtDialogue:sub(length + 1):split(" ")[1]
        local nextWordWidth = getVisualWidth(nextWord) + math.floor(self._content:getFontSize() / 3) --加上空格大小

        -- TODO: 在一行中没有空格的情况下会出现错误换行的情况, 需要修正
        if (lastLineWidth + nextWordWidth > self._content._width) then
            self._txtDialogue = replaceChar(self._txtDialogue, length, "\n")
        end
    end

    self._content:setText(textToDisplay)
    self.txtNum = length
end

 -- 播放音效
function NpcDialog:playSound()
    -- 检查参数
    local sound = nil
    if (self.data.sound and self.data.sound ~= "" and self.data.sound ~= "0") then sound = self.data.sound end
    if (not sound) then return end

    -- 播放对话框音效
    self.playingSoundHandle = Avalon.AudioManager:playSound(sound)
end

-- 停止音效
function NpcDialog:stopSound()
    if (not self.playingSoundHandle) then return end
    Avalon.AudioManager:stopSound(self.playingSoundHandle)
    self.playingSoundHandle = nil
end

-- 镜头移动
function NpcDialog:moveCameraToCoord()
    if (not self.data.moveCameraX or self.data.moveCameraX == 0 or not self.data.moveCameraY or self.data.moveCameraY == 0) then return end
    AvalonUtil:moveCameraToCoord(self.data.moveCameraX, self.data.moveCameraY, self:getMoveCameraDuration() / 1000)
    self.isCameraMoved = true
end

-- 移动回镜头
function NpcDialog:moveCameraBackToMaster()
    if (not self.isCameraMoved) then return end
    AvalonUtil:moveCameraToMaster(self:getMoveCameraDuration() / 1000)
end

-- 获取镜头移动时间
function NpcDialog:getMoveCameraDuration()
    local moveCameraDuration = 1000
    if (self.data.moveCameraDuration ~= nil and self.data.moveCameraDuration ~= 0) then
        -- 如果配置中有设定镜头移动时间, 使用它
        moveCameraDuration = self.data.moveCameraDuration
    elseif (self.moveCameraDuration ~= nil and self.moveCameraDuration ~= 0) then
        -- 如果配置中没有, 但是有从上个连续对话框传递下来的时间, 使用它
        moveCameraDuration = self.moveCameraDuration
    end
    -- 否则使用默认时间
    return moveCameraDuration
end
---------------- eo 程序逻辑 ------------------
















---------------- 事件处理 ------------------
function NpcDialog:forceClose()
    self:stopSound()
    self.isForceClose = true
    self:close()
end

function NpcDialog:onClickHandler()
    if self.bClose then
        self:stopSound()
        self:close()
        return
    end
    
    self:showTextWithLength(string.len(self._txtDialogue))
end
---------------- eo 事件处理 ------------------
