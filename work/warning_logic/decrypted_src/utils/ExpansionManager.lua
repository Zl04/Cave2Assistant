local SdkBox = require("utils.sdkbox.SdkBox")

Avalon = Avalon or {}

local ExpansionManager = {}
Avalon.ExpansionManager = ExpansionManager

local downloadStarted = false

function ExpansionManager:checkAndNoticeDownload(text, onNoNeedToDownload, onDownloadCompleted)
	text = text or "Downloading resource expansion"
	if (CONFIG_SKIP_EXPANSION_CHECK or SdkBox:getInstance():checkLocalExpansionExists()) then
		-- 文件存在, 可能是下载完成或者是本身就存在
		if (downloadStarted == false) then
			if (onNoNeedToDownload) then onNoNeedToDownload() end
		else
			if (onDownloadCompleted) then onDownloadCompleted() end
		end
	else
		-- 文件不存在, 抛出提示并开始下载
		-- downloadStarted = true
		-- SdkBox:getInstance():onExpansionDownloadSuccess(onDownloadCompleted)
		-- SdkBox:getInstance():downloadExpansion()
	 --    local expDlNotice = UI.Tips:createTips(
	 --    	text,
  --       	UI.TipsType.CONFIRM, 
  --       	UI.TipsUiType.NORMAL)

  --       expDlNotice:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
  --           self:checkAndNoticeDownload(text, onNoNeedToDownload, onDownloadCompleted)
  --       end)

  		-- 屏蔽掉自动下载分包功能
  		downloadStarted = true
  	    local expDlNotice = UI.Tips:createTips(
	    	"Data pack has been deleted, please uninstall Cave Online and reinstall it from the Google Play Store(Play Store might need some permissions to download data pack).",
        	UI.TipsType.CONFIRM, 
        	UI.TipsUiType.NORMAL)

        expDlNotice:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            self:checkAndNoticeDownload(text, onNoNeedToDownload, onDownloadCompleted)
        end)
	end
end

return ExpansionManager