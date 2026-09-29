--[[
    游戏错误处理管理器
    -- 场景切换管理
    -- 玩家状态数据
    -- 战斗时间戳
]]--

require "app.ui.common.Dialog.ScrollBar" 
require "app.ui.tips.TipsLayer"


GameErrorManager = GameErrorManager or {}


function GameErrorManager:showError(errorID, isSkill)
    --对一些错误做特殊表现, 比如金币不足弹窗和钻石不足弹窗.
    --对另外的错误提示做普通的飘动文字显示
    if(errorID == nil) then
        assert(false,"GameErrorManager:showError errorID is nil.")
        return
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)

    if errorID == 1 then
        --成功不处理
    elseif errorID == 88 and not isSkill then
        --副本扫荡条件不满足
        UI.ScrollBar:createByTextID(UI.TEXT_220000)
    elseif errorID == 101 then
        --金币不足
        UI.TipsLayer:onGlodNotEnough()
    elseif errorID == 102 then
        --钻石不足
        UI.TipsLayer:onDiamondNotEnough()
    -- elseif errorID == 2 then
        --位置错误,不处理
    elseif errorID == 192 then
        Avalon.MessageCenter:notice(AvalonMessage.MC_LEVEL_SELECT_UNLOCK_BTN)
        UI.ScrollBar:createByErrorID(errorID)
    elseif errorID == 998 or errorID == 999 then
        require "app.utils.AntiAddictionUtil"
        AntiAddictionUtil:showLoginError(errorID)
    elseif errorID > 1000 then
        --大于1000的不处理
    elseif errorID == 88 and isSkill then
        --无效目标不通知
    else
        --根据错误ID飘动文字显示错误
        UI.ScrollBar:createByErrorID(errorID)
    end
end
