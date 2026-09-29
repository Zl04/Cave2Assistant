local Result = {} 
function Result.createFriend() 

    local result = {} 

    local Friend = UI.Image:create()
    Friend:init("ui_friends_banner_plate.png")
    Friend:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    Friend:setReflectPos(116, 52)
    Friend:computePosition()
    Friend:setName("Friend")
    result.Friend = Friend

    local guildButtonLayer = UI.Component:create()
    guildButtonLayer:init()
    guildButtonLayer:setLayoutType(UI.LayoutDefaultType.LEFT_BOTTOM)
    guildButtonLayer:setVisible(false)
    guildButtonLayer:setReflectSize(286, 107)
    guildButtonLayer:computePosition()
    Friend:addChild(guildButtonLayer)
    guildButtonLayer:setName("guildButtonLayer")
    result.guildButtonLayer = guildButtonLayer

    local guildButton = UI.Button:create()
    guildButton:init("ui_friends_btn_guild_0.png", "ui_friends_btn_guild_1.png", "ui_friends_btn_guild_1.png", {x=0, y=0})
    guildButton._clickScale = false
    guildButton._baseline = 1
    guildButton:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    guildButton:setReflectPos(63, 12)
    guildButton:computePosition()
    guildButtonLayer:addChild(guildButton)
    guildButton:setName("guildButton")
    result.guildButton = guildButton

    local guildBtnLabel = UI.Text:create()
    guildBtnLabel:initWithLanguageId(1110547, UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    guildBtnLabel:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    guildBtnLabel:setReflectPos(0, 52)
    guildBtnLabel:computePosition()
    guildButton:addChild(guildBtnLabel)
    guildBtnLabel:setName("guildBtnLabel")
    result.guildBtnLabel = guildBtnLabel

    local friendButton = UI.Button:create()
    friendButton:init("ui_friends_btn_friends_0.png", "ui_friends_btn_friends_1.png", "ui_friends_btn_friends_1.png", {x=0, y=0})
    friendButton._clickScale = false
    friendButton._baseline = 1
    friendButton:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    friendButton:setReflectPos(181, 12)
    friendButton:computePosition()
    guildButtonLayer:addChild(friendButton)
    friendButton:setName("friendButton")
    result.friendButton = friendButton

    local friendBtnLabel = UI.Text:create()
    friendBtnLabel:initWithLanguageId(1110739, UI.FONT_STANDARD, 18, {r=41,g=41,b=45})
    friendBtnLabel:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    friendBtnLabel:setReflectPos(0, 52)
    friendBtnLabel:computePosition()
    friendButton:addChild(friendBtnLabel)
    friendBtnLabel:setName("friendBtnLabel")
    result.friendBtnLabel = friendBtnLabel

    local inviteFriendLabel = UI.Text:create()
    inviteFriendLabel:init("Text", UI.FONT_STANDARD, 20, {r=41,g=41,b=45})
    inviteFriendLabel:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    inviteFriendLabel:setReflectPos(0, 10)
    inviteFriendLabel:setVisible(false)
    inviteFriendLabel:computePosition()
    Friend:addChild(inviteFriendLabel)
    inviteFriendLabel:setName("inviteFriendLabel")
    result.inviteFriendLabel = inviteFriendLabel

    local selfInfoLayer = UI.Component:create()
    selfInfoLayer:init()
    selfInfoLayer:setLayoutType(UI.LayoutDefaultType.LEFT_BOTTOM)
    selfInfoLayer:setVisible(false)
    selfInfoLayer:setReflectSize(286, 107)
    selfInfoLayer:computePosition()
    Friend:addChild(selfInfoLayer)
    selfInfoLayer:setName("selfInfoLayer")
    result.selfInfoLayer = selfInfoLayer

    local selfHeadIcon = UI.Image:create()
    selfHeadIcon:init("ui_friends_banner_head.png")
    selfHeadIcon:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    selfHeadIcon:setReflectPos(30, 6)
    selfHeadIcon:computePosition()
    selfInfoLayer:addChild(selfHeadIcon)
    selfHeadIcon:setName("selfHeadIcon")
    result.selfHeadIcon = selfHeadIcon

    local myIdLabel = UI.Text:create()
    myIdLabel:init("我的ID: 123", UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    myIdLabel:setLayoutType(UI.LayoutDefaultType.RIGHT_BOTTOM)
    myIdLabel:setReflectPos(19, 6)
    myIdLabel:computePosition()
    selfInfoLayer:addChild(myIdLabel)
    myIdLabel:setName("myIdLabel")
    result.myIdLabel = myIdLabel

    local confirmLayer = UI.Component:create()
    confirmLayer:init()
    confirmLayer:setLayoutType(UI.LayoutDefaultType.LEFT_BOTTOM)
    confirmLayer:setReflectSize(286, 107)
    confirmLayer:computePosition()
    Friend:addChild(confirmLayer)
    confirmLayer:setName("confirmLayer")
    result.confirmLayer = confirmLayer

    local okbtn = UI.Button:create()
    okbtn:init("ui_btn_yes2_1.png", "ui_btn_yes2_2.png", "ui_btn_yes2_0.png", {x=0, y=0})
    okbtn._clickScale = false
    okbtn._baseline = 1
    okbtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    okbtn:setReflectPos(160, 45)
    okbtn:computePosition()
    confirmLayer:addChild(okbtn)
    okbtn:setName("okbtn")
    result.okbtn = okbtn

    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_btn_no2_0.png", "ui_btn_no2_2.png", "ui_btn_no2_0.png", {x=0, y=0})
    cancelBtn._clickScale = false
    cancelBtn._baseline = 1
    cancelBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cancelBtn:setReflectPos(36, 45)
    cancelBtn:computePosition()
    confirmLayer:addChild(cancelBtn)
    cancelBtn:setName("cancelBtn")
    result.cancelBtn = cancelBtn

    local confirmInfoLabel = UI.Text:create()
    confirmInfoLabel:init("[玩家姓名共八个字]想加你为好友", UI.FONT_ARIAL, 14, {r=41,g=41,b=45})
    confirmInfoLabel:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    confirmInfoLabel:setDimensions(260,0)
    confirmInfoLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    confirmInfoLabel:setReflectPos(0, -30)
    confirmInfoLabel:computePosition()
    confirmLayer:addChild(confirmInfoLabel)
    confirmInfoLabel:setName("confirmInfoLabel")
    result.confirmInfoLabel = confirmInfoLabel

    local firendNumberLayer = UI.Component:create()
    firendNumberLayer:init()
    firendNumberLayer:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    firendNumberLayer:setVisible(false)
    firendNumberLayer:setReflectSize(286, 47)
    firendNumberLayer:computePosition()
    Friend:addChild(firendNumberLayer)
    firendNumberLayer:setName("firendNumberLayer")
    result.firendNumberLayer = firendNumberLayer

    local openAddFriendBtn = UI.Button:create()
    openAddFriendBtn:init("ui_friends_btn_examine_0.png", "ui_friends_btn_examine_1.png", "ui_friends_btn_examine_1.png", {x=0, y=0})
    openAddFriendBtn._clickScale = true
    openAddFriendBtn._baseline = 1
    openAddFriendBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    openAddFriendBtn:setReflectPos(15, 10)
    openAddFriendBtn:computePosition()
    firendNumberLayer:addChild(openAddFriendBtn)
    openAddFriendBtn:setName("openAddFriendBtn")
    result.openAddFriendBtn = openAddFriendBtn

    local friendCountLabel = UI.Text:create()
    friendCountLabel:init("9/99", UI.FONT_STANDARD, 16, {r=41,g=41,b=45})
    friendCountLabel:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    friendCountLabel:setReflectPos(10, 14)
    friendCountLabel:computePosition()
    firendNumberLayer:addChild(friendCountLabel)
    friendCountLabel:setName("friendCountLabel")
    result.friendCountLabel = friendCountLabel

    local friendCountIcon = UI.Image:create()
    friendCountIcon:init("ui_friends_banner_ficon.png")
    friendCountIcon:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    friendCountIcon:setReflectPos(70, 10)
    friendCountIcon:computePosition()
    firendNumberLayer:addChild(friendCountIcon)
    friendCountIcon:setName("friendCountIcon")
    result.friendCountIcon = friendCountIcon

    local addFriendLayer = UI.Component:create()
    addFriendLayer:init()
    addFriendLayer:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    addFriendLayer:setReflectSize(286, 47)
    addFriendLayer:computePosition()
    Friend:addChild(addFriendLayer)
    addFriendLayer:setName("addFriendLayer")
    result.addFriendLayer = addFriendLayer

    local editBoxBg = UI.Image:create()
    editBoxBg:init("ui_friends_banner_yellow.png")
    editBoxBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    editBoxBg:setReflectPos(25, 13)
    editBoxBg:computePosition()
    addFriendLayer:addChild(editBoxBg)
    editBoxBg:setName("editBoxBg")
    result.editBoxBg = editBoxBg

    local addFriendBtn = UI.Button:create()
    addFriendBtn:init("ui_friends_btn_examine_0.png", "ui_friends_btn_examine_1.png", "ui_friends_btn_examine_0.png", {x=0, y=0})
    addFriendBtn._clickScale = true
    addFriendBtn._baseline = 1
    addFriendBtn:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    addFriendBtn:setReflectPos(15, 10)
    addFriendBtn:setLocalZOrder(1)
    addFriendBtn:computePosition()
    addFriendLayer:addChild(addFriendBtn)
    addFriendBtn:setName("addFriendBtn")
    result.addFriendBtn = addFriendBtn

    local backBtn = UI.Button:create()
    backBtn:init("ui_friends_btn_arrow_0.png", "ui_friends_btn_arrow_1.png", "ui_friends_btn_arrow_0.png", {x=0, y=0})
    backBtn._clickScale = true
    backBtn._baseline = 1
    backBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    backBtn:setReflectPos(15, 10)
    backBtn:setLocalZOrder(1)
    backBtn:computePosition()
    addFriendLayer:addChild(backBtn)
    backBtn:setName("backBtn")
    result.backBtn = backBtn

    local notHaveFrindInfo = UI.Text:create()
    notHaveFrindInfo:initWithLanguageId(1111030, UI.FONT_STANDARD, 16, {r=41,g=41,b=45})
    notHaveFrindInfo:setTextAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.TOP)
    notHaveFrindInfo:setDimensions(240,0)
    notHaveFrindInfo:setLayoutType(UI.LayoutDefaultType.CENTER)
    notHaveFrindInfo:setReflectPos(0, -30)
    notHaveFrindInfo:computePosition()
    Friend:addChild(notHaveFrindInfo)
    notHaveFrindInfo:setName("notHaveFrindInfo")
    result.notHaveFrindInfo = notHaveFrindInfo

    local listViewLayer = UI.Component:create()
    listViewLayer:init()
    listViewLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    listViewLayer:setReflectPos(0, 48)
    listViewLayer:setReflectSize(286, 353)
    listViewLayer:computePosition()
    Friend:addChild(listViewLayer)
    listViewLayer:setName("listViewLayer")
    result.listViewLayer = listViewLayer

    local modeDeleteBtn = UI.Button:create()
    modeDeleteBtn:init("ui_friends_btn_delete_0.png", "ui_friends_btn_delete_1.png", "ui_friends_btn_delete_1.png", {x=0, y=0})
    modeDeleteBtn._clickScale = true
    modeDeleteBtn._baseline = 1
    modeDeleteBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    modeDeleteBtn:setReflectPos(14, 458)
    modeDeleteBtn:computePosition()
    firendNumberLayer:addChild(modeDeleteBtn)
    modeDeleteBtn:setName("modeDeleteBtn")
    result.modeDeleteBtn = modeDeleteBtn

    local modeBlockListBtn = UI.Button:create()
    modeBlockListBtn:init("ui_friends_btn_1.png", "ui_friends_btn_0.png", "ui_friends_btn_0.png", {x=0, y=0})
    modeBlockListBtn._clickScale = true
    modeBlockListBtn._baseline = 1
    modeBlockListBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    modeBlockListBtn:setReflectPos(72, 458)
    modeBlockListBtn:computePosition()
    firendNumberLayer:addChild(modeBlockListBtn)
    modeBlockListBtn:setName("modeBlockListBtn")
    result.modeBlockListBtn = modeBlockListBtn

    local delAllOkBtn = UI.Button:create()
    delAllOkBtn:init("ui_btn_yes1_0.png", "ui_btn_yes1_2.png", "ui_btn_yes1_0.png", {x=0, y=0})
    delAllOkBtn._clickScale = true
    delAllOkBtn._baseline = 1
    delAllOkBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    delAllOkBtn:setReflectPos(85, 420)
    delAllOkBtn:computePosition()
    firendNumberLayer:addChild(delAllOkBtn)
    delAllOkBtn:setName("delAllOkBtn")
    result.delAllOkBtn = delAllOkBtn

    result.root = Friend 
    return result 
end 

function Result.createfriendItemModel() 

    local result = {} 

    local friendItemModel = UI.Component:create()
    friendItemModel:init()
    friendItemModel:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    friendItemModel:setReflectPos(576, 157)
    friendItemModel:setReflectSize(286, 95)
    friendItemModel:computePosition()
    friendItemModel:setName("friendItemModel")
    result.friendItemModel = friendItemModel

    local friendName = UI.Text:create()
    friendName:init("玩家姓名共八个字", UI.FONT_ARIAL, 16, {r=41,g=41,b=45})
    friendName:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    friendName:setReflectPos(109, 19)
    friendName:computePosition()
    friendItemModel:addChild(friendName)
    friendName:setName("friendName")
    result.friendName = friendName

    local spliteLine1 = UI.Image9:create()
    spliteLine1:init("ui_friends_banner_name.png",{x=0,y=0,width=20,height=20})
    spliteLine1:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    spliteLine1:setReflectPos(106, 47)
    spliteLine1:setReflectSize(157, 1.1)
    spliteLine1:computePosition()
    friendItemModel:addChild(spliteLine1)
    spliteLine1:setName("spliteLine1")
    result.spliteLine1 = spliteLine1

    local spliteLine12 = UI.Image9:create()
    spliteLine12:init("ui_friends_banner_name.png",{x=0,y=0,width=20,height=20})
    spliteLine12:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
    spliteLine12:setReflectSize(250, 1.1)
    spliteLine12:computePosition()
    friendItemModel:addChild(spliteLine12)
    spliteLine12:setName("spliteLine12")
    result.spliteLine12 = spliteLine12

    -- local friendStatus = UI.Text:create()
    -- friendStatus:init("战斗中", UI.FONT_STANDARD, 14, {r=41,g=41,b=45})
    -- friendStatus:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    -- friendStatus:setReflectPos(109, 52)
    -- friendStatus:computePosition()
    -- friendItemModel:addChild(friendStatus)
    -- friendStatus:setName("friendStatus")
    -- result.friendStatus = friendStatus

    local friendStatus = UI.Image:create()
    friendStatus:init("ui_manor_peddler_idle.png")
    friendStatus:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    friendStatus:setReflectPos(19, 12)
    friendStatus:computePosition()
    friendItemModel:addChild(friendStatus,10)
    friendStatus:setName("friendStatus")
    result.friendStatus = friendStatus


    local friendInviteStatus = UI.Text:create()
    friendInviteStatus:initWithLanguageId(1110741, UI.FONT_STANDARD, 12, {r=215,g=181,b=52})
    friendInviteStatus:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    -- friendInviteStatus:setReflectPos(109, 72)
    friendInviteStatus:setReflectPos(40, 79)
    friendInviteStatus:computePosition()
    friendItemModel:addChild(friendInviteStatus,10)
    friendInviteStatus:setName("friendInviteStatus")
    result.friendInviteStatus = friendInviteStatus

    local frendInviteTeamBtn = UI.Button:create()
    frendInviteTeamBtn:init("ui_btn_button_invite_0.png", "ui_btn_button_invite_1.png", "ui_btn_button_invite_3.png", {x=0, y=0})
    frendInviteTeamBtn._clickScale = true
    frendInviteTeamBtn._baseline = 1
    frendInviteTeamBtn:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    frendInviteTeamBtn:setReflectPos(20, 52)
    frendInviteTeamBtn:computePosition()
    friendItemModel:addChild(frendInviteTeamBtn)
    frendInviteTeamBtn:setName("frendInviteTeamBtn")
    result.frendInviteTeamBtn = frendInviteTeamBtn

    local friendDeleteBtn = UI.Button:create()
    friendDeleteBtn:init("ui_btn_button_delete_0.png", "ui_btn_button_delete_1.png", "ui_btn_button_delete_3.png", {x=0, y=0})
    friendDeleteBtn._clickScale = true
    friendDeleteBtn._baseline = 1
    friendDeleteBtn:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    friendDeleteBtn:setReflectPos(20, 52)
    friendDeleteBtn:computePosition()
    friendItemModel:addChild(friendDeleteBtn)
    friendDeleteBtn:setName("friendDeleteBtn")
    result.friendDeleteBtn = friendDeleteBtn

    local friendMsgBtn = UI.Button:create()
    friendMsgBtn:init("ui_btn_button_chat_0.png", "ui_btn_button_chat_1.png", "ui_btn_button_chat_3.png", {x=0, y=0})
    friendMsgBtn._clickScale = true
    friendMsgBtn._baseline = 1
    friendMsgBtn:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    friendMsgBtn:setReflectPos(57, 52)
    friendMsgBtn:computePosition()
    friendItemModel:addChild(friendMsgBtn)
    friendMsgBtn:setName("friendMsgBtn")
    result.friendMsgBtn = friendMsgBtn

    local blockDelBtn = UI.Button:create()
    blockDelBtn:init("ui_friends_btn_delete_0_0.png", "ui_friends_btn_delete_1_1.png", "ui_friends_btn_delete_2_2.png", {x=0, y=0})
    blockDelBtn._clickScale = true
    blockDelBtn._baseline = 1
    blockDelBtn:setLayoutType(UI.LayoutDefaultType.RIGHT_UP)
    blockDelBtn:setReflectPos(20, 52)
    blockDelBtn:computePosition()
    friendItemModel:addChild(blockDelBtn)
    blockDelBtn:setName("blockDelBtn")
    result.blockDelBtn = blockDelBtn

    local friendHeadBtn = UI.Button:create()
    friendHeadBtn:init("ui_information_headframe_bottom.png", "ui_information_headframe_bottom.png", "ui_information_headframe_bottom.png", {x=0, y=0})
    friendHeadBtn._clickScale = true
    friendHeadBtn._baseline = 1
    friendHeadBtn:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    friendHeadBtn:setReflectPos(24, 12)
    friendHeadBtn:computePosition()
    friendItemModel:addChild(friendHeadBtn)
    friendHeadBtn:setName("friendHeadBtn")
    result.friendHeadBtn = friendHeadBtn

    local friendHeadMask = UI.Image:create()
    friendHeadMask:init("ui_information_headframe_box.png")
    friendHeadMask:setLayoutType(UI.LayoutDefaultType.CENTER)
    friendHeadMask:setLocalZOrder(10)
    friendHeadMask:computePosition()
    friendHeadBtn:addChild(friendHeadMask)
    friendHeadMask:setName("friendHeadMask")
    result.friendHeadMask = friendHeadMask

    local friendLevelBg = UI.Image:create()
    friendLevelBg:init("ui_information_headframe_grade.png")
    friendLevelBg:setLayoutType(UI.LayoutDefaultType.LEFT_BOTTOM)
    friendLevelBg:setReflectPos(-4, -3)
    friendLevelBg:computePosition()
    friendHeadMask:addChild(friendLevelBg)
    friendLevelBg:setName("friendLevelBg")
    result.friendLevelBg = friendLevelBg

    local friendLevelLabel = UI.Text:create()
    friendLevelLabel:init("60", UI.FONT_STANDARD, 16, {r=189,g=167,b=136})
    friendLevelLabel:enableShadow({r=50,g=45,b=42},{x=0,y=-1})
    friendLevelLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    friendLevelLabel:computePosition()
    friendLevelBg:addChild(friendLevelLabel)
    friendLevelLabel:setName("friendLevelLabel")
    result.friendLevelLabel = friendLevelLabel

    local choiceButton = UI.Button:create()
    choiceButton:init("ui_information_box_01.png", "ui_information_box_01.png", "ui_information_box_01.png", {x=0, y=0})
    choiceButton._clickScale = true
    choiceButton._baseline = 1
    choiceButton:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    choiceButton:setReflectPos(235, 2)
    choiceButton:computePosition()
    friendItemModel:addChild(choiceButton)
    choiceButton:setName("choiceButton")
    result.choiceButton = choiceButton

    local choiceLogo = UI.Image:create()
    choiceLogo:init("ui_btn_choice_1.png")
    choiceLogo:setLayoutType(UI.LayoutDefaultType.CENTER)
    choiceLogo:setLocalZOrder(20)
    choiceLogo:setReflectPos(110, -36)
    choiceLogo:computePosition()
    friendItemModel:addChild(choiceLogo)
    choiceLogo:setName("choiceLogo")
    result.choiceLogo = choiceLogo


    --行商模块
    local peddlerBg = UI.Image:create()
    peddlerBg:init("ui_manor_peddler_bg_1.png")
    peddlerBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    peddlerBg:setReflectPos(102, 47.5)
    peddlerBg:computePosition()
    friendItemModel:addChild(peddlerBg)
    peddlerBg:setName("peddlerBg")
    result.peddlerBg = peddlerBg

    -- -- local peddlerGoodsIcon = UI.Image:create()
    -- -- peddlerGoodsIcon:init("ui_manor_peddler_idle.png")
    -- local peddlerGoodsIcon = UI.GoodsGrid:create()
    -- peddlerGoodsIcon:center(-40)
    -- peddlerBg:addChild(peddlerGoodsIcon)
    -- result.peddlerGoodsIcon = peddlerGoodsIcon

    -- -- local currencyIcon = UI.Image:create()
    -- -- currencyIcon:init("ui_manor_peddler_idle.png")
    -- local currencyIcon = UI.GoodsGrid:create()
    -- currencyIcon:center()
    -- peddlerBg:addChild(currencyIcon)
    -- result.currencyIcon = currencyIcon

    local currencyNumberText = UI.Text:create()
    currencyNumberText:init(AvalonUtil:getSimpleNumber(0, 4), UI.FONT_ARIAL, 16, {r=41,g=41,b=45})
    currencyNumberText:centerLeft(78.5 + 10)
    peddlerBg:addChild(currencyNumberText)
    result.currencyNumberText = currencyNumberText


    result.root = friendItemModel 
    return result 
end 

function Result.create(modelName) 

    modelName = modelName or "Friend" 
    if modelName == "Friend" then 
        return Result.createFriend()
    elseif modelName == "friendItemModel" then 
        return Result.createfriendItemModel()
    end 
    return nil 

end 

Result.res = {
    [1] = "ui_common_information.plist", 
    [2] = "ui_general_friends.plist", 
    [3] = "ui_common_btn.plist", 
}

return Result 
