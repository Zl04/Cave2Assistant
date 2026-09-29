require "utils.AvalonUtil"


local CommondUtilTest = {}

function CommondUtilTest:test()
    local version = AvalonUtil.getMyVersion()
    print("CommondUtilTest:test version=",version)

    local isInstall = AvalonUtil.checkIsInstalled("avalon.")
    print("CommondUtilTest:test isInstall=",isInstall)

    local openSuccess = AvalonUtil.openUrl("http://www.baidu.com")
    print("CommondUtilTest:test openSuccess=",openSuccess)
end

return CommondUtilTest