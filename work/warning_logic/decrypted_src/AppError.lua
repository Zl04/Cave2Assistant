function showAppError()
    local filepath = cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Hotfix/project.manifest"
    if not cc.FileUtils:getInstance():isFileExist(filepath) then
        printWarn("dev mode,wont show this tips")
        return
    end
    local scene = cc.Director:getInstance():getRunningScene()
    if not scene then
        scene = cc.Scene:create() 
        cc.Director:getInstance():replaceScene(scene)
    end
    



    local winSize = cc.Director:getInstance():getWinSize()
    local bg = cc.Sprite:create("clientError/ui_setup_banner_box.png")
    bg:setPosition(winSize.width/2,winSize.height/2)
    scene:addChild(bg,100000)

    local text = "游戏文件发生错误！点击确认尝试自动修复。如果自动修复失败，请重新下载游戏。"
    local localLan = cc.Application:getInstance():getCurrentLanguage()
    if localLan ~= cc.LANGUAGE_CHINESE  then
        text = "Game files are corrupted! Press Confirm to try to repair the files. If repair fails, please uninstall and reinstall the game from your preffered app store. We are sorry for the inconvenience it brings and thanks for the support as always."
    end
    local lable = ccui.Text:create(text,"Arial",20)    
    lable:setTextAreaSize(cc.size(340,180))
    lable:setPosition(bg:getContentSize().width/2 ,200)
    lable:setTextHorizontalAlignment(1)
    lable:setTextVerticalAlignment(1)
    lable:setTextColor(cc.c4b(255,0,0,255))
    bg:addChild(lable)

    local button1 = ccui.Button:create("clientError/ui_btn_yes1_1.png")
    button1:setPosition(bg:getContentSize().width/2 + 100,50)
    bg:addChild(button1)

    local button2 = ccui.Button:create("clientError/ui_btn_no1_0.png")
    button2:setPosition(bg:getContentSize().width/2 - 100,50)
    bg:addChild(button2)

    button1:addClickEventListener(function ()
        bg:removeSelf()
        local scheduler=cc.Director:getInstance():getScheduler()
        local mSchedulerID = scheduler:scheduleScriptFunc(function ()
            cc.FileUtils:getInstance():removeDirectory(cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Lua/")
            cc.FileUtils:getInstance():removeDirectory(cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Res/")
            cc.FileUtils:getInstance():removeDirectory(cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Hotfix/")
            cc.FileUtils:getInstance():removeDirectory(cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Cache/")
            cc.FileUtils:getInstance():removeDirectory(cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Log/")
            cc.Director:getInstance():restart()
        end,0.3,false)
    end)

    button2:addClickEventListener(function ()
        bg:removeSelf()
        -- 颜色是反的, 用Confirm做取消
        -- cc.Director:getInstance():endToLua()
        -- os.exit()

        require "app.utils.ToolsUtil"
        ToolsUtil:exitApp()
    end)
    
end