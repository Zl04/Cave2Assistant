-- RichTextTest.lua
-- Author:ydli
-- 2017年9月04日
-- Using:富文本 测试   用于聊天功能
UI = UI or {}

local RichTextTest = class("RichTextTest", UI.HWBtnComponent)
UI.RichTextTest = RichTextTest

-- private:
local winSize = cc.Director:getInstance():getWinSize()
-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
-- 背包资源
local COM_RES_LIST = {
    "ui_town_guild_skill.plist"
}

-- 图片名字
local TEST_PANEL_SPRITE = {
    
}

-- 构造函数
function RichTextTest:ctor()
    RichTextTest.super.ctor(self,0, COM_RES_LIST, winSize.width / 2, winSize.height)
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self:setTouchEnable(true)
    self:registerListener()
end

-- 析构函数
function RichTextTest:dtor()
    RichTextTest.super.dtor(self)
    self:unRegisterListener()
    reload_script_file("app.tests.RichTextTest")
end

-- 初始化
function RichTextTest:init()
    RichTextTest.super.init(self)
end

-- 初始化视图
function RichTextTest:onInitView()
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onTouchBegan)
    self.rootLayer = cc.LayerColor:create(cc.c4b(255,255,255,255))
    self.rootLayer:setContentSize(winSize.width / 2, winSize.height)
    self.rootLayer:setPosition(0,0)
    self:addChild(self.rootLayer)
    self:enableDebugDraw()
    


    -- local tip1 = UI.Text:create()
    -- tip1:init("聊天测试：", UI.FONT_ARIAL, 22, UI.FONT_COLOR_42_31_1)
    -- tip1:leftBottom(20, 100)
    -- self.rootLayer:addChild(tip1)
    -- local libIDEdit = cc.EditBox:create({width = 300, height = 40}, cc.Scale9Sprite:createWithSpriteFrameName("ui_btn_button_determine_0.png"), cc.Scale9Sprite:createWithSpriteFrameName("ui_btn_button_determine_2.png"), cc.Scale9Sprite:createWithSpriteFrameName("ui_btn_button_determine_3.png"))
    -- libIDEdit:setFontSize(22)
    -- libIDEdit:setPlaceHolder("请输入聊天内容")
    -- libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
    -- libIDEdit:setPosition(260, 110)
    -- libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    -- self.rootLayer:addChild(libIDEdit)
    -- self.libIDEdit = libIDEdit

    -- self.confireBtn = UI.Button:create()
    -- self.confireBtn:init("ui_btn_button_determine_0.png","ui_btn_button_determine_2.png","ui_btn_button_determine_3.png")
    -- self.confireBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
    --    self:onSendClick(true)
    -- end)
    -- self.confireBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_229_177)
    -- self.confireBtn:setOutline(UI.FONT_COLOR_OUTLINE_67_39_15)
    -- self.confireBtn:setText("+")
    -- self.rootLayer:addChild(self.confireBtn)
    -- self.confireBtn:leftBottom(150, 40)
    -- -- self.confireBtn:setPosition(300, 40)

    -- local confireBtn2 = UI.Button:create()
    -- confireBtn2:init("ui_btn_button_determine_0.png","ui_btn_button_determine_2.png","ui_btn_button_determine_3.png")
    -- confireBtn2:addEventListener(UIEvent.BUTTON_CLICK,self, function()
    --     self:onSendClick(false)
    -- end)
    -- confireBtn2:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_229_177)
    -- confireBtn2:setOutline(UI.FONT_COLOR_OUTLINE_67_39_15)
    -- confireBtn2:setText("-")
    -- self.rootLayer:addChild(confireBtn2)
    -- confireBtn2:leftBottom(300, 40)


    -- self.message = UI.Text:create()
    -- self.message:init("message", UI.FONT_ARIAL, 22, UI.FONT_COLOR_42_31_1)
    -- self.message:leftBottom(20, 400)
    -- self.rootLayer:addChild(self.message)

     --RichText
    -- local _richText = ccui.RichText:createWithXML("And this link will redirect you to google: <a href='http://www.google.com'>click me</a>")
    -- local richText = "<img src='ui_btn_button_prop_cat.png' text='imgtest' face='standard.ttf'></img><click color='#00ff00' data='http://www.google.com'>click me</click>"
    -- local _richText = ccui.RichText:createWithXML("AAnd this link will redirect you to google::And this link will redirect you to google::And this link will redirect you to google::And this link will redirect you to google::And this link will redirect you to google::<click color='#00ff00' data='http://www.google.com'>click me</click>")
        -- _richText = RichText::createWithXML("<font size='20' face='fonts/Marker Felt.ttf'>Marker Felt 20.<font face='fonts/arial.ttf'>Arial 20.</font></font><font face='font/Thonburi.ttf' size='24' color='#0000ff'>Thonburi 24 blue</font>");

    -- _richText:ignoreContentAdaptWithSize(false)
    -- _richText:setContentSize(500, 10)
    -- _richText:setPosition(250, 450)
    -- -- _richText:setEnabled(true)
    -- _richText:setName("json test...")
    -- self.rootLayer:addChild(_richText)
    -- local richText = "<font size='14' color='#ffffff'>aaaa\na\na\n    link will redirect you to google::And this link will redirect you to google::And this link will redirect you to google::And this link will redirect you to google::And this link will redirect </font><font size='16' color='#ffff00'>bbbbbbb</font><font size='20' color='#00ff00'>cc需要等\n \n \n \n \n \n     待一段时间才能使用需要等待一段时间才能使用需要等待一段时间才能使用 oh ! this is my  word!!</font><font size='20' color='#000000'>dddddd</font>"
    -- local richText = "<font size='14' color='#ffffff'>aaaaaaaa\n    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</font><font size='16' color='#ffff00'>bbbbbbb</font><font size='20' color='#00ff00'>cc需要等\n待一段时间才能使用需要等待一段时间才能使用需要等待一段时间才能使用 oh ! this is my  word!!</font><font size='20' color='#000000'>dddddd</font>"
       -- local richText = "<font size='14' color='#ffffff'>a\na\na\n   bbbbbbb</font>"
    -- local richText = "<font size='14' color='#ffffff'>aaaaaaaa\n\n\n    20世纪70年代中期，。\n    他使用过Simula和ALGOL，接触过C。</font><font size='24' color='#ffffff'>行效率的意义。既要编程简单、正确可靠，又要运行高效、，</font><font size='16' color='#ffff00'>bbbbbbb</font><font size='20' color='#00ff00'>cc需要等\n   \n\n待一段时间才能使用需要等待一段时间才能使用需要等待一段时间才能使用 oh ! this is my  word!!</font><font size='20' color='#000000'>dddddd</font>"
    -- local richText = "<font size='14' color='#ffffff'>aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n\n\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</font>"
-- local richText = "<font size='18' color='#b27b7b' face='PingFangSC-Light' isEncode='1'>YXNkYXNkYXNk8J+Yjg==</font>"--"<font size='18' color='#000000' face='PingFangSC-Light' isEncode='1'>OmFzZGFzZGFzZPCfmI0=</font>"
    local richText = "<font size='18' color='#98f5ff' face='PingFangSC-Light' isEncode='1'>5oiR</font><font size='18' color='#ffffff' face='PingFangSC-Light' isEncode='1'>Og==</font><font size='18' color='#b27b7b' face='PingFangSC-Light' isEncode='1'>YXNkYXNkYfCfmJ0=</font>"
    local _richText = UI.RichText:create()
    -- local richText = "And this link will redirect you to"
    -- local richText = "And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google::<click color='#00ff00' data='http://www.google.com'>click me</click>"
        -- local richText = "And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google:And this link will redirect you to google<click size='14' color='#00ff00' face='standard.ttf' data='table: 0x1598c220'>暴脾气富亨利</click>"
    -- local richText = ":<font size='14' color='#00ff00' face='standard.ttf'>asfasdfdsfdsgasdfsdfdgsdgfggasgdfgafsdfsdafadsfsdfasdfasdfsdfasdfsfd</font><click size='14' color='#00ff00' face='standard.ttf' data='table: 0x1598c220'>暴脾气富亨利</click>"
    --    local richText = "asfasdfdsfdsgasdfsdfdgsdgfggasgdfgafsdfsdafadsfsdfasdfasdfsdfasdfsfd<click size='14' color='#00ff00' face='standard.ttf' data='table: 0x1598c220'>暴脾气富亨利</click>"
    -- local richText = "<click size='14' color='#00ff00' face='standard.ttf' data='table: 0x1598c220'>暴脾气富亨利</click>And this link will redirect you to google:And this link will redirect you And this link will redirect you to google:And this link will redirect you"
    _richText:init(richText, 180, 10, true)
    -- _richText:ignoreContentAdaptWithSize(true)
    _richText:leftBottom(0, 450)
    self.rootLayer:addChild(_richText)
    _richText:enableDebugDraw()


    -- dump(UI.RichText, "UI.RichText = ")
    -- dump(ccui.RichText, "ccui.RichText = ")

    -- local testLabel = cc.Label:createWithSystemFont("label test", UI.FONT_STANDARD, 20)
    -- testLabel:setAlignment(cc.TEXT_ALIGNMENT_LEFT, cc.TEXT_ALIGNMENT_LEFT)
    -- testLabel:setPosition(0, 650)
    -- self.rootLayer:addChild(testLabel)


    -- self:onShowClockList()

    -- require "utils.WidgetUtil"
    -- local laser = UI.Image:create()
    -- laser:init("laser.png")
    -- laser:center()
    -- self.rootLayer:addChild(laser, 100)
    -- -- laser:useShader(UI.COMPONENT_LIGHT)
    -- -- local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_LIGHT)
    -- -- laser._sprite:setGLProgramState(shader)
    -- self:addBlinkLight(laser._sprite)
    -- -- laser:useShader(UI.COMPONENT_GRAY_SHADER)

-- 
    -- local sprite = Avalon.WidgetUtil:generalOutlineWithFileName("fragment/ui_task_banner_fragment01_1.png")
    -- sprite:setPosition(218, 290)
    -- self:addChild(sprite, 1000)



    -- local _ckipperSprite = cc.Sprite:create()
    -- _ckipperSprite:initWithFile("image/fragment/ui_task_banner_fragment01_1.png")

    -- local bottomSprite = cc.Sprite:create()
    -- bottomSprite:initWithFile("image/fragment/ui_task_banner_fragment01_1.png")

    -- local node = cc.Node:create()
    -- node:setContentSize(_ckipperSprite:getContentSize().width, _ckipperSprite:getContentSize().height)
    -- _ckipperSprite:setScale(0.970)
    --  node:addChild(_ckipperSprite)
    -- local _clipper = cc.ClippingNode:create()
    -- _clipper:setStencil(node)
    -- _clipper:setPosition(218, 290)
    -- _clipper:setAlphaThreshold(0.5)
    -- _clipper:setInverted(true)
    -- self:addChild(_clipper, 1000)
    -- _clipper:addChild(bottomSprite)


    -- local color = cc.vec4(1.0, 0, 0, 1.0)
    -- local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    -- glProgramState:setUniformVec4("u_lightColor", color)
    -- _clipper:setGLProgramState(glProgramState)

    -- local _ckipperSprite = cc.Sprite:create()
    -- _ckipperSprite:initWithSpriteFrameName("ui_guild_skill_icon_30020050_dark.png")
    -- _ckipperSprite:setPosition(300, 500)
    -- self:addChild(_ckipperSprite, 1000)


    -- local _ckipperSprite1 = cc.Sprite:create()
    -- _ckipperSprite1:initWithSpriteFrameName("ui_guild_skill_icon_30020050.png")
    -- _ckipperSprite1:setPosition(100, 500)
    -- self:addChild(_ckipperSprite1, 1000)
    

    -- local _ckipperSprite2 = cc.Sprite:create()
    -- _ckipperSprite2:initWithSpriteFrameName("ui_guild_skill_icon_30020050.png")
    -- _ckipperSprite2:setPosition(180, 400)
    -- self:addChild(_ckipperSprite2, 1000)
    -- local color = cc.vec4(21/255, 14/255, 6/255, 1.0)
    -- local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    -- glProgramState:setUniformVec4("u_lightColor", color)
    -- _ckipperSprite2:setGLProgramState(glProgramState)


    -- local _ckipperSprite3 = cc.Sprite:create()
    -- _ckipperSprite3:initWithSpriteFrameName("ui_guild_skill_icon_30020050.png")
    -- _ckipperSprite3:setPosition(280, 300)
    -- self:addChild(_ckipperSprite3, 1000)
    -- local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureTurnGray.vert", "shaders/TextureTurnGray.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    -- _ckipperSprite3:setGLProgramState(glProgramState)

    -- local _ckipperSprite4 = cc.Sprite:create()
    -- _ckipperSprite4:initWithSpriteFrameName("ui_guild_skill_icon_30020050.png")
    -- _ckipperSprite4:setPosition(380, 200)
    -- self:addChild(_ckipperSprite4, 1000)

    -- local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,100))
    -- colorLayer:setPosition(0,0)
    -- colorLayer:setContentSize(_ckipperSprite4:getContentSize().width, _ckipperSprite4:getContentSize().height)
    -- _ckipperSprite4:addChild(colorLayer,2)     
end

function RichTextTest:onSendClick(isadd)
	-- body
	-- local messageStr = self.libIDEdit:getText()
	-- messageStr = string.gsub("<fonttetstaaaa", "<font", "")
-- print("----------------------------1")

--   local zip=require("zlib")     
-- --   print("----------------------------2")
--   -- local v,mv,pv=zip.version()
--   -- print(v .. "  " .. mv .. "  " .. pv)
--   local compress=zip.deflate()
--   print("----------------------------3")
--   -- local uncompress=zip.inflate()
-- --   -- dump(compress, "compress")
-- --   -- dump(uncompress, "uncompress")
-- -- --   -- 压缩字符串
-- -- print("----------------------------4")
--   local deflated, eof, bytes_in,bytes_out = compress(messageStr, 'finish')
--   print("----------------------------5")
--   -- print("deflated = "..Base64Encode(deflated))
--   local base64Str = Base64Encode(deflated)
--   local str = Base64Decode(base64Str)
-- --   -- print("eof = "..eof)
-- --   print("bytes_in = "..bytes_in)
-- --   print("bytes_out = "..bytes_out)
  
-- --   -- 解压字符串
--   local uss,ret,getin,getout=uncompress(str)    
--   print("uss = "..uss)
--   -- print("ret = "..ret)
--   print("getin = "..getin)
--   print("getout = "..getout)

    -- self.message:setText(messageStr)



    -- require"app.ui.social.chat.DialogLayout"
    -- local dialogLayout = self:getChildByName("DialogLayout")
    -- if dialogLayout == nil then
    --     dialogLayout = UI.DialogLayout:create()
    --     dialogLayout:init()
    --     dialogLayout:setSize(100,100)
    --     dialogLayout:rightBottom(-200, 200)
    --     dialogLayout:setName("DialogLayout")
    --     self:addChild(dialogLayout)
    --     dialogLayout:enableDebugDraw()


    --     local textLabel = UI.Text:create()
    --     textLabel:init("test0001", UI.FONT_STANDARD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_81_61_27)
    --     dialogLayout:addChild(textLabel)
    --     textLabel:centerBottom(100)
    -- else
    --     if isadd then
    --         dialogLayout:addHeight(false, 30)
    --     else
    --         dialogLayout:addHeight(false, -30)
    --     end
    -- end


    -- self:addBlinkLight(self)
end

-- 更新视图
function RichTextTest:onUpdateView()
	-- local _listener = cc.EventListenerCustom:create("game_custom_event_click_name", function(event)
	-- 	print("------------------_listener  success")
	-- 	print("------------------_listener  success")
	-- 	print("------------------_listener  success")
	-- 	print("------------------_listener  success")
	-- 	dump(event, "event")
	-- 	local sender = event:getSender()
	-- 	print("size width = "..sender:getContentSize().width)
	-- 	-- dump(sender:getContentSize().width, "sender")
	-- 	local itemdata = event:getItemData()
	-- 	dump(itemdata, "itemdata")

 --        local bg = sender:getChildByName("test0001")
 --        if bg ~= nil then
 --            bg:removeSelf()
 --        end
	-- 	    bg = UI.Image:create()
	-- 	    bg:setName("test0001")
 --            bg:init("ui_btn_button_iron_reform.png")
 --            -- bg:setPosition(sender:getContentSize().width + 10, sender:getPositionY())
 --            -- sender:getParent():addChild(bg)
 --            -- bg:leftBottom(sender:getPositionX() + sender:getContentSize().width, 0)
 --            bg:leftBottom(sender:getContentSize().width,0)
 --            sender:addChild(bg, 100)
        
	-- end)
 --    local _eventDispatcher = cc.Director:getInstance():getEventDispatcher()
 --    _eventDispatcher:addEventListenerWithFixedPriority(_listener, 1);

end
   
--关闭下拉列表框
function RichTextTest:onClose()
end

-- 注册监听事件(可选)
function RichTextTest:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end


-- 注销监听事件(可选)
function RichTextTest:unRegisterListener()

end

function RichTextTest:onTouchDialogOutsizeHandler()
    -- print("-----------RichTextTest:onTouchDialogOutsizeHandler()")
    self:close()
end

function RichTextTest:onShow()
    local richTextTest = UI.RichTextTest:create()
    richTextTest:init()
    richTextTest:center()
    cc.Director:getInstance():getRunningScene():addChild(richTextTest,100000);

    
end


-----test spine animation
function RichTextTest:onShowClockList()
    self.clockList = {}
    -- for i = 1, 10 do
    --     local clockAnim = UI.Animation:create()
    --     clockAnim:init("effect_ui_task_banner_clock.json", "effect_ui_task_banner_clock.atlas")
    --     clockAnim:centerLeft(200 + 50 * i)
    --     self:addChild(clockAnim)
    --     clockAnim:setAnimation("idle",true)
    --     table.insert(self.clockList, clockAnim)
    -- end


    
    local confireBtn = UI.Button:create()
    confireBtn:init("ui_btn_button_determine_0.png","ui_btn_button_determine_2.png","ui_btn_button_determine_3.png")
    confireBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        self.clockList[1]:destroy()
        table.remove(self.clockList, 1)



        local clockAnim = UI.Animation:create()
        clockAnim:init("effect_ui_task_banner_clock.json", "effect_ui_task_banner_clock.atlas")
        clockAnim:centerLeft(-110)
        self:addChild(clockAnim)
        clockAnim:setAnimation("idle",true)
        table.insert(self.clockList, clockAnim)

        -- body
    end)
    confireBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_229_177)
    confireBtn:setOutline(UI.FONT_COLOR_OUTLINE_67_39_15)
    confireBtn:setText("remove spine")
    self:addChild(confireBtn)
    confireBtn:leftBottom(300, 140)
end
   