-- ArchiveLayer.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:图集 
require("utils.ObserverVariable")
require("app.config.ConfigManager")
require "app.datas.PublicDefine"
require("app.ui.baglayer.Archive.ArchiveCell")
require("app.ui.baglayer.Archive.ArchiveProBar")
local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local COM_WIDTH = 852
local COM_HEIGHT = 534
local ArchiveLayer = class("ArchiveLayer", UI.HWBtnComponent)
UI.ArchiveLayer = ArchiveLayer
local winSize = cc.Director:getInstance():getWinSize()

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_package_log.plist",
}

local CAVE_MODE = PublicDefine.CAVE_MODE
-- 处理测试怪物大小表现 add by zp

function ArchiveLayer:ctor(isPlayTableAct)
    if(UI.ShowArch) then 
        table.insert(COM_RES_LIST, "ui_town_guild_task.plist")
    end 
    ArchiveLayer.super.ctor(
        self,
        UIType.ARCHIVE_LAYER,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.rootLayer = nil;           --root节点

    -- 这里的数据排列顺序
    self.data = {
        {
            name = LanguageManager:getInstance():getLocalString(1110657),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_NORMAL,
            height = 440,  -- 滑动条的高度
            resData = {1,31,61,91,121,151,180},  -- 滑动条的数据点数
            scene ={LanguageManager:getInstance():getLocalString(1150002),
            LanguageManager:getInstance():getLocalString(1150003),
            LanguageManager:getInstance():getLocalString(1150004),
            LanguageManager:getInstance():getLocalString(1150005),
            LanguageManager:getInstance():getLocalString(1150006),
            LanguageManager:getInstance():getLocalString(1150032)}
        },
        {
            name = LanguageManager:getInstance():getLocalString(1111411),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_HERO,
            height = 440,
            resData = {1,31,61,91,121,151,180},
            scene ={LanguageManager:getInstance():getLocalString(1150002),
            LanguageManager:getInstance():getLocalString(1150003),
            LanguageManager:getInstance():getLocalString(1150004),
            LanguageManager:getInstance():getLocalString(1150005),
            LanguageManager:getInstance():getLocalString(1150006),
            LanguageManager:getInstance():getLocalString(1150032)}
        },
        {
            name = LanguageManager:getInstance():getLocalString(1150035),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_DESERT_EYES,
            height = 440,  -- 滑动条的高度
            intervalNum = 15,
            resData = {1,30},  -- 滑动条的数据点数
            scene ={
                [8]=LanguageManager:getInstance():getLocalString(1150035),
            }
        },
        {
            name = LanguageManager:getInstance():getLocalString(1150037),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_DISTORTED_SPACE,
            height = 440,  -- 滑动条的高度
            resData = {1,10,20,30,40,50,60,70},  -- o
            intervalNum = 8,
            scene ={
                [9]=LanguageManager:getInstance():getLocalString(1150038),
                [10]=LanguageManager:getInstance():getLocalString(1150042),
                [11]=LanguageManager:getInstance():getLocalString(1150044),
                [12]=LanguageManager:getInstance():getLocalString(1150047),
                [13]=LanguageManager:getInstance():getLocalString(1150049),
                [14]=LanguageManager:getInstance():getLocalString(1150055),
                [15]=LanguageManager:getInstance():getLocalString(1150061),
            }
        },  
        {
            name = LanguageManager:getInstance():getLocalString(1150040),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2,
            model = CAVE_MODE.MODE_DISTORTED_SPACE,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20,30,40,50,60,70},  -- o
            scene ={
                [9]=LanguageManager:getInstance():getLocalString(1150038),
                [10]=LanguageManager:getInstance():getLocalString(1150042),
                [11]=LanguageManager:getInstance():getLocalString(1150044),
                [12]=LanguageManager:getInstance():getLocalString(1150047),
                [13]=LanguageManager:getInstance():getLocalString(1150049),
                [14]=LanguageManager:getInstance():getLocalString(1150055),
                [15]=LanguageManager:getInstance():getLocalString(1150061),
            }
        },  
        {
            name = UI.TEXT_1325500,
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_INFERNO,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20,30,40,50},  -- o
            scene ={
                [16] = UI.TEXT_1325508,
                [17] = UI.TEXT_1325510,
                [18] = UI.TEXT_1325511,
                [19] = UI.TEXT_1325512,
                [20] = UI.TEXT_1325513,
            }
        },  
        {
            name = UI.TEXT_1325500.. "(".. LanguageManager:getInstance():getLocalString(1112460)..")",
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2,
            model = CAVE_MODE.MODE_INFERNO,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20,30,40,50},  -- o
            scene ={
                [16] = UI.TEXT_1325508,
                [17] = UI.TEXT_1325510,
                [18] = UI.TEXT_1325511,
                [19] = UI.TEXT_1325512,
                [20] = UI.TEXT_1325513,
            }
        },  
        {
            name = UI.TEXT_1325500.. "(".. UI.TEXT_1325502..")",
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3,
            model = CAVE_MODE.MODE_INFERNO,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20,30,40,50},  -- o
            scene ={
                [16] = UI.TEXT_1325508,
                [17] = UI.TEXT_1325510,
                [18] = UI.TEXT_1325511,
                [19] = UI.TEXT_1325512,
                [20] = UI.TEXT_1325513,
            }
        },
        {
            name = UI.TEXT_222100,
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_VOID_RIFT,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20},  -- o
            scene ={
                [21] = UI.TEXT_222103,
                [22] = UI.TEXT_222104,
                -- [18] = UI.TEXT_222105,
                -- [19] = UI.TEXT_222106,
                -- [20] = UI.TEXT_222107,
            }
        },  
        {
            name = UI.TEXT_222100.. "(".. LanguageManager:getInstance():getLocalString(1112460)..")",
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2,
            model = CAVE_MODE.MODE_VOID_RIFT,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20},  -- o
            scene ={
                [21] = UI.TEXT_222103,
                [22] = UI.TEXT_222104,
                -- [18] = UI.TEXT_222105,
                -- [19] = UI.TEXT_222106,
                -- [20] = UI.TEXT_222107,
            }
        },  
        {
            name = UI.TEXT_222100.. "(".. UI.TEXT_1325502..")",
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3,
            model = CAVE_MODE.MODE_VOID_RIFT,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20},  -- o
            scene ={
                [21] = UI.TEXT_222103,
                [22] = UI.TEXT_222104,
                -- [18] = UI.TEXT_222105,
                -- [19] = UI.TEXT_222106,
                -- [20] = UI.TEXT_222107,
            }
        },
        {
            name = UI.TEXT_223800,
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_VIKING,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20},  -- o
            scene ={
                [23] = UI.TEXT_223803,
                [24] = UI.TEXT_223804,
                -- [18] = UI.TEXT_222105,
                -- [19] = UI.TEXT_222106,
                -- [20] = UI.TEXT_222107,
            }
        },  
        {
            name = UI.TEXT_223800.. "(".. LanguageManager:getInstance():getLocalString(1112460)..")",
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2,
            model = CAVE_MODE.MODE_VIKING,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20},  -- o
            scene ={
                [23] = UI.TEXT_223803,
                [24] = UI.TEXT_223804,
                -- [18] = UI.TEXT_222105,
                -- [19] = UI.TEXT_222106,
                -- [20] = UI.TEXT_222107,
            }
        },  
        {
            name = UI.TEXT_223800.. "(".. UI.TEXT_1325502..")",
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3,
            model = CAVE_MODE.MODE_VIKING,
            height = 440,  -- 滑动条的高度
            intervalNum = 9,
            resData = {1,10,20},  -- o
            scene ={
                [23] = UI.TEXT_223803,
                [24] = UI.TEXT_223804,
                -- [18] = UI.TEXT_222105,
                -- [19] = UI.TEXT_222106,
                -- [20] = UI.TEXT_222107,
            }
        },
        {
            name = LanguageManager:getInstance():getLocalString(1115678),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_TITAN_ROAD,
            height = 440,  -- 滑动条的高度
            resData = {1,31,61,91,121,151,180},  -- 滑动条的数据点数
            scene ={[24] = LanguageManager:getInstance():getLocalString(1150080),
            [25] = LanguageManager:getInstance():getLocalString(1150081),
            [26] = LanguageManager:getInstance():getLocalString(1150082),
            [27] = LanguageManager:getInstance():getLocalString(1150083),
            [28] = LanguageManager:getInstance():getLocalString(1150084),
            [29] = LanguageManager:getInstance():getLocalString(1150085)}
        },
        {
            name = LanguageManager:getInstance():getLocalString(1115679),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_TITAN_ROAD_HERO,
            height = 440,
            resData = {1,31,61,91,121,151,180},
            scene ={[30] = LanguageManager:getInstance():getLocalString(1150080),
            [31] = LanguageManager:getInstance():getLocalString(1150081),
            [32] = LanguageManager:getInstance():getLocalString(1150082),
            [33] = LanguageManager:getInstance():getLocalString(1150083),
            [34] = LanguageManager:getInstance():getLocalString(1150084),
            [35] = LanguageManager:getInstance():getLocalString(1150085)}
        },
        {
            name = UI.TEXT_225000,--LanguageManager:getInstance():getLocalString(1150035),
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_DRIED_SPRING,
            height = 440,  -- 滑动条的高度
            intervalNum = 15,
            resData = {1,30},  -- 滑动条的数据点数
            scene ={
                [8]=UI.TEXT_225000--LanguageManager:getInstance():getLocalString(1150035),
            }
        },

        {
            name = UI.TEXT_226500,
            difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            model = CAVE_MODE.MODE_CHAOS,
            height = 440,  -- 滑动条的高度
            intervalNum = 4,
            resData = {1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130},  -- o
            scene ={
                [39] = LanguageManager:getInstance():getLocalString(1150096),
                [40] = LanguageManager:getInstance():getLocalString(1150097),
                [41] = LanguageManager:getInstance():getLocalString(1150098),
                [42] = LanguageManager:getInstance():getLocalString(1150099),
                [43] = LanguageManager:getInstance():getLocalString(1150106),
                [44] = LanguageManager:getInstance():getLocalString(1150110),
                [45] = LanguageManager:getInstance():getLocalString(1150112),
                [46] = LanguageManager:getInstance():getLocalString(1150116),
                [47] = LanguageManager:getInstance():getLocalString(1150118),
                [48] = LanguageManager:getInstance():getLocalString(1150122),
                [49] = LanguageManager:getInstance():getLocalString(1150124),
                [50] = LanguageManager:getInstance():getLocalString(1150128),
                [51] = LanguageManager:getInstance():getLocalString(1150130),
            }
        },
        -- {
        --     name = UI.TEXT_226500.. "(".. LanguageManager:getInstance():getLocalString(1112460)..")",
        --     difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2,
        --     model = CAVE_MODE.MODE_CHAOS,
        --     height = 440,  -- 滑动条的高度
        --     intervalNum = 9,
        --     resData = {1,10,20},  -- o
        --     scene ={
        --         [36] = UI.TEXT_223803,
        --         [37] = UI.TEXT_223804,
        --     }
        -- },  
    }
    self._isPlayTableCellAct = {}

    if isPlayTableAct == nil then
        for k, v in pairs(self.data) do
            self._isPlayTableCellAct[k] = true
        end
    else
        for k, v in pairs(self.data) do
            self._isPlayTableCellAct[k] = false
        end
    end
    self.lastIdx = self:getLocalIdx()
    self.modelIndex = self.lastIdx or 1
    -- print("wwwwww=", self.modelIndex, self.lastIdx)
    self._selectMonster = 1
    self:initData(self.data[self.modelIndex])
    self.mDifficultyBtnList = {};     --难度btn列表
    self._barHeight = 440
    self:init();
    self:registerListener();
end

function ArchiveLayer:getLocalIdx()
    local idx = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastNewShowArhMode, 1) 
    local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    if not unLockHeroMode then
        return 1
    end
    if(self.data[idx] == nil) then 
        idx = 1
    end
    return idx
end
function ArchiveLayer:getNextModelIndex(isReverse)
    if isReverse then
        local reverseIdx = self.lastIdx - 1
        if reverseIdx < 1 then
            return #self.data
        end
        return reverseIdx
    else
        local idx = self.lastIdx + 1
        if idx > #self.data then
            return 1
        end
        return idx
    end
end
function ArchiveLayer:saveLocalIdx()
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastNewShowArhMode, self.lastIdx)
end

function ArchiveLayer:initData(data)
    self:initArchiveBar(data)
    -- ProfileMonstersAttribute_
    local monsterList = ConfigManager:getMonsterListConfig(data.model, data.difficulty)
    self.monsterList = {}
    self.data1 = {}
    for k,v in pairs(data.scene) do
        local monsterData = {}
        monsterData.type = 1        --1为场景名称,2为怪物
        monsterData.data = v
        monsterData.index = self:makeSortIndex(k, 0)
        table.insert(self.monsterList,monsterData)
        self.data1[k] = 0
    end

    local pokedexData = MasterDataManager:getPokedexData()
    for k,v in pairs(monsterList) do 
        if type(v) == "table" then
            if v.illustrationSerialNumber ~= 0 then
                local monsterData = {}
                monsterData.type = 2
                monsterData.data = v
                monsterData.state = 0

                local difficulty = data.difficulty
                if pokedexData[data.model] and pokedexData[data.model][difficulty] and pokedexData[data.model][difficulty][v.illustrationSerialNumber] then
                    monsterData.state = 1
                end

                if(UI.ShowArch) then
                    monsterData.state = 1
                end
                monsterData.select = false
                monsterData.index = self:makeSortIndex(v.scenesID, v.illustrationSerialNumber)

                table.insert(self.monsterList,monsterData)
                -- print("===>>>", v.scenesID, v.illustrationSerialNumber, v.name)
                if(self.data1[v.scenesID]) then
                    self.data1[v.scenesID] = self.data1[v.scenesID] + 1
                else
                    printError("===>>>", v.scenesID, v.illustrationSerialNumber, v.name)
                end
            end
        end
    end

    table.sort(self.monsterList,function(a,b)
        if a ~= b then
            if a.index == b.index  then
                return a.data.id < b.data.id
            else
                return a.index < b.index
            end
        end
    end)

    self.monsterList[2].state = 1 --默认解锁第一个
    for k,v in ipairs(self.monsterList) do
        if v.type == 2 and v.state == 1 then
            self._selectMonster = k - 1
            v.select = true
            break
        end
    end

    self.mOpenDifficulty = data.difficulty;
    -- for i = 1,#data.difficulty do
    --     local _checkpointData = RoleDataManager:getCheckpointData(data.model,i)
    --     if(_checkpointData:getUnlockLevel() ~= 0) then
    --         self.mOpenDifficulty = i;
    --     else
    --         break;
    --     end
    -- end
end

function ArchiveLayer:makeSortIndex(scene, illustrationSerialNumber)
    return scene * 10000000 + illustrationSerialNumber
end

function ArchiveLayer:dtor()
    ArchiveLayer.super.dtor(self)

    self:unRegisterListener();
    reload_script_file("app.ui.baglayer.Archive.ArchiveLayer")
end

-- public:
-- 初始化
function ArchiveLayer:init()
    ArchiveLayer.super.init(self)
end


--上一模式
function ArchiveLayer:onLastMode()
    self.lastIdx = self:getNextModelIndex(true)
    self.modelIndex = self.lastIdx
    self:saveLocalIdx()
    self:initData(self.data[self.modelIndex])
    self.m_pItemTableView:stopScrolling()
    if self._isPlayTableCellAct[self.modelIndex] then
        self.m_pItemTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    else
        self.m_pItemTableView:reloadData(false)
    end
    self._isPlayTableCellAct[self.modelIndex] = false

    self.mTxtModeName:setText(self.data[self.modelIndex].name)
    if self._selectMonster == -1 then
        self:refreshMonsterInfo(self.monsterList[2].data) 
    else
        self:refreshMonsterInfo(self.monsterList[self._selectMonster + 1].data) 
    end
end

--下一模式
function ArchiveLayer:onNextMode()
    
    self.lastIdx = self:getNextModelIndex()
    self.modelIndex = self.lastIdx
    self:saveLocalIdx()
    print("_selectMonstersss", self._selectMonster)

    self:initData(self.data[self.modelIndex])
    self.m_pItemTableView:stopScrolling()
    if self._isPlayTableCellAct[self.modelIndex] then
        self.m_pItemTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    else
        self.m_pItemTableView:reloadData(false)
    end 
    self._isPlayTableCellAct[self.modelIndex] = false
    self.mTxtModeName:setText(self.data[self.modelIndex].name)
    if self._selectMonster == -1 then
        self:refreshMonsterInfo(self.monsterList[2].data) 
    else
        self:refreshMonsterInfo(self.monsterList[self._selectMonster + 1].data) 
    end
end

-- 模版函数：初始化组建的视图
function ArchiveLayer:onInitView()
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(COM_WIDTH,COM_HEIGHT))
    self:addChild(self.rootLayer)

    local bg =  cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", CCRectMake(303,136,4,2))
    bg:setContentSize(COM_WIDTH, COM_HEIGHT)
    bg:setAnchorPoint(0, 0)
    bg:setPosition(0, 0)
    self.rootLayer:addChild(bg)

    local btnLeftArrow = UI.Button:create()
    btnLeftArrow:init("ui_activity_left_0.png",
        "ui_activity_left_1.png","ui_activity_left_2.png")
    btnLeftArrow:leftBottom(4,510 - 37)
    btnLeftArrow:addEventListener(UIEvent.BUTTON_CLICK, self, self.onLastMode)
    self.rootLayer:addChild(btnLeftArrow,100)

    self.mTxtModeName = UI.Text:create()
    self.mTxtModeName:init(self.data[self.modelIndex].name, UI.FONT_BOLD,UI.FONT_SIZE_18PX)
    self.mTxtModeName:leftBottom(58, 466)
    self.mTxtModeName:setFontColor(UI.FONT_COLOR_41_41_45)
    self.mTxtModeName:setSize(204, 70)
    self.mTxtModeName:setLineSpacing(-8)
    self.mTxtModeName:setTextCenter()
    self.rootLayer:addChild(self.mTxtModeName)

    local btnRightArrow = UI.Button:create()
    btnRightArrow:init("ui_activity_right_0.png",
        "ui_activity_right_1.png","ui_activity_right_2.png")
    btnRightArrow:leftBottom(258 ,510 - 37)
    btnRightArrow:addEventListener(UIEvent.BUTTON_CLICK, self, self.onNextMode)
    -- btnRightArrow:setScaleX(-1)
    self.rootLayer:addChild(btnRightArrow,100)

    if table.nums(self.data) == 1 then
        -- btnLeftArrow:disable()
        btnRightArrow:disable()
        btnLeftArrow:hide()
        btnRightArrow:hide()
    end

    self.leftLayer = cc.Layer:create()
    self.leftLayer:setPosition(cc.p(-32,-2))
    self.leftLayer:setContentSize(cc.size(885,565))
    self.rootLayer:addChild(self.leftLayer)

    -- 分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(322, 1.1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(38  + lineUpImage:getContentSize().width/2 , 476 ))
    self.leftLayer:addChild(lineUpImage)


    self.m_pItemTableView = cc.TableView:create(cc.size(320,455))
    self.m_pItemTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.m_pItemTableView:setPosition(cc.p(47,15))
    self.m_pItemTableView:setDelegate()
    self.m_pItemTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.leftLayer:addChild(self.m_pItemTableView)
    --registerScriptHandler functions must be before the reloadData funtion
    self.m_pItemTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.m_pItemTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self.m_pItemTableView:setScrollBarEnabled(false)

    local _txtFloor = UI.Text:create()
    _txtFloor:init(UI.TEXT_110034,UI.FONT_STANDARD,UI.FONT_SIZE_18PX)
    _txtFloor:leftBottom(340,444)
    _txtFloor:setFontColor(UI.FONT_COLOR_41_41_45)
    _txtFloor:setSize(40, 30)
    _txtFloor:setTextCenter()
    self.leftLayer:addChild(_txtFloor,10)

    self:initArchiveBar(self.data[self.modelIndex])

    if self._isPlayTableCellAct[1] then
        self.m_pItemTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    else
        self.m_pItemTableView:reloadData()
    end
    self._isPlayTableCellAct[1] = false

    self.rightLayer = cc.Layer:create()
    self.rightLayer:setPosition(cc.p(0,0))
    self.rightLayer:setContentSize(cc.size(885,565))
    self.rootLayer:addChild(self.rightLayer,200)

    self:createDifficultyBtn()
    self:createMonsterInfo()
    if self._selectMonster == -1 then
        self:refreshMonsterInfo(self.monsterList[2].data) 
    else
        self:refreshMonsterInfo(self.monsterList[self._selectMonster + 1].data) 
    end

    local cap = UI.Image:create()
    cap:init("ui_log_button_mask1.png")
    cap:leftBottom(0,1)
    self.rootLayer:addChild(cap, 20)

    local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    if UI.ShowArch then
        unLockHeroMode = true
    end
    if not unLockHeroMode then
        btnLeftArrow:disable()
        btnRightArrow:disable()
    end
end

function ArchiveLayer:initArchiveBar(data)
    if(tolua.isnull(self.leftLayer)) then 
        return 
    end

    if(not tolua.isnull(self.pArchiveProBar)) then 
        self.pArchiveProBar:removeFromParent()
        self.pArchiveProBar = nil
    end

    reload_script_file("app.ui.baglayer.Archive.ArchiveProBar")
    self._barHeight = data.height
    self.pArchiveProBar = UI.ArchiveProBar:create(data.height, data.resData, data.intervalNum)
    -- self.pArchiveProBar:leftBottom(340,0)
    self.pArchiveProBar:leftUp(340, self.leftLayer:getContentSize().height - 440)
    self.pArchiveProBar:setName("ArchiveProBar")
    self.leftLayer:addChild(self.pArchiveProBar,10)

    self.pArchiveProBar:addEventListener(UIEvent.PRO_BAR_ARCHIVE_TOUCH, self, function(tag,_y)
        -- print("ArchiveLayer:initArchiveBar", _y)
        self:scrollToCell((#self.monsterList + 1)/self._barHeight * (self._barHeight - _y))
    end)
end

--选择难度
function ArchiveLayer:onSelectedDifficulty(sender)

end

--更新难度按钮
function ArchiveLayer:updataDifficultyBtn(index)

end


--创建难度
function ArchiveLayer:createDifficultyBtn()

    self.difficultyLayer = cc.Layer:create()
    self.difficultyLayer:setPosition(cc.p(0,0))
    self.difficultyLayer:setContentSize(cc.size(885,560))
    self.rightLayer:addChild(self.difficultyLayer)

    self.difficultyLayer:removeAllChildren()
    self.mDifficultyBtnList = {}
end

function ArchiveLayer:createOneAttr(iconName, iconX, iconY, txtOffsetX, txtSetName, iconSetName)
    -- body
    local attrImage = UI.ImageText:create()
    attrImage:init(iconName, "", UI.FONT_STANDARD,UI.FONT_SIZE_16PX)
    -- local icon = cc.Sprite:createWithSpriteFrameName(iconName)
    -- icon:setPosition(iconX,iconY)
    -- if(iconSetName) then 
    attrImage:setSize(100, 30)
    attrImage:leftBottom(iconX, iconY - attrImage:getContentSize().height/2)
    attrImage:setName(txtSetName)
    attrImage:setTextFixLineWidth(110)
    attrImage:setFrameSpace(-attrImage:getSpriteWidth()/2, 19)
    -- end
    self.monsterLayer:addChild(attrImage)

    -- local txtValue = UI.Text:create()
    -- txtValue:init("999",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_41_41_45)
    -- txtValue:leftBottom(iconX + txtOffsetX, iconY - txtValue:getContentSize().height/2)
    -- -- txtValue:setFontColor(UI.FONT_COLOR_41_41_45)
    -- txtValue:setName(txtSetName)
    -- txtValue:setFixLineWidth(110)
    -- self.monsterLayer:addChild(txtValue)
end

--创建怪物属性
function ArchiveLayer:createMonsterInfo()
    self.monsterLayer = cc.Layer:create()
    self.monsterLayer:setPosition(cc.p(-10,39))
    self.monsterLayer:setContentSize(cc.size(885,565))
    self.rightLayer:addChild(self.monsterLayer)

    local _monsterBG = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_scene1.png")
    _monsterBG:setPosition(469,305)
    _monsterBG:setName("monsterBG")
    self.monsterLayer:addChild(_monsterBG,100)

    local txtName = UI.Text:create()
    txtName:init("怪物名字",UI.FONT_BOLD,UI.FONT_SIZE_20PX)
    txtName:leftBottom(550,410)
    txtName:setFontColor(UI.FONT_COLOR_41_41_45)
    txtName:setSize(300, 100)
    txtName:setTextCenter()
    txtName:setName("txtName")
    self.monsterLayer:addChild(txtName)

    local txtOffsetX = 20
    --金币
    self:createOneAttr("symbol_gaming_money.png", 595, 430, txtOffsetX, "txtMoney")
    --经验
    self:createOneAttr("symbol_gaming_xp_cn.png", 740, 430, txtOffsetX, "txtXP", nil)

    
    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(270, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setPosition(cc.p(580  + _picLine:getContentSize().width/2 , 414 ))
    
    self.monsterLayer:addChild(_picLine)

    --血量
    self:createOneAttr("symbol_gaming_blood.png", 595, 400, txtOffsetX, "txtHP", nil)
    --攻击力
    self:createOneAttr("symbol_gaming_atk.png", 595, 368, txtOffsetX, "txtAtk", "_iconAtk")
    --魔法攻击力
    self:createOneAttr("symbol_gaming_maggicatk.png", 595, 368, txtOffsetX, "txtMagicAtk", "_iconMagicAtk")
    --攻击速度
    self:createOneAttr("symbol_gaming_aspd.png", 740, 368, txtOffsetX, "txtAspd")

    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(270, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setPosition(cc.p(580  + _picLine:getContentSize().width/2 , 354 ))
    self.monsterLayer:addChild(_picLine)

    --防御
    self:createOneAttr("symbol_gaming_def.png", 595, 334, txtOffsetX, "txtDef")
    --魔法防御
    self:createOneAttr("symbol_gaming_maggicdef.png", 740, 334, txtOffsetX, "txtMaggicdef")
    --火攻击
    self:createOneAttr("symbol_monsterattribute_fire_1.png", 595, 306, txtOffsetX, "txtFireAtk")
    --火防御
    self:createOneAttr("symbol_monsterattribute_fire_2.png", 740, 306, txtOffsetX, "txtFireDef")
    --水攻击
    self:createOneAttr("symbol_monsterattribute_water_1.png", 595, 272, txtOffsetX, "txtWaterAtk")
    --水防御
    self:createOneAttr("symbol_monsterattribute_water_2.png", 740, 272, txtOffsetX, "txtWaterDef")
    --木攻击
    self:createOneAttr("symbol_monsterattribute_wood_1.png", 595, 240, txtOffsetX, "txtWoodAtk")
    --木防御
    self:createOneAttr("symbol_monsterattribute_wood_2.png", 740, 240, txtOffsetX, "txtWoodDef")
    --光攻击
    self:createOneAttr("symbol_monsterattribute_light_1.png", 595, 208, txtOffsetX, "txtLightAtk")
    --光防御
    self:createOneAttr("symbol_monsterattribute_light_2.png", 740, 208, txtOffsetX, "txtLightDef")
    --暗攻击
    self:createOneAttr("symbol_monsterattribute_dark_1.png", 595, 176, txtOffsetX, "txtDarkAtk")
    --暗防御
    self:createOneAttr("symbol_monsterattribute_dark_2.png", 740, 176, txtOffsetX, "txtDarkDef")

    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(270, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setPosition(cc.p(580  + _picLine:getContentSize().width/2 , 155 ))
    self.monsterLayer:addChild(_picLine)

    --弱点
    local weakCenterY = 140 -2
    local weaknessTitle = UI.Text:create()
    weaknessTitle:init(UI.TEXT_DES_WEAK,UI.FONT_STANDARD,UI.FONT_SIZE_16PX)
    weaknessTitle:leftBottom(595 - 47,weakCenterY - weaknessTitle:getContentSize().height /2)
    weaknessTitle:setTextRight()
    -- weaknessTitle:setSize(150, 100)
    weaknessTitle:setWidth(150)
    weaknessTitle:setText(UI.TEXT_DES_WEAK)
    weaknessTitle:setFontColor(UI.FONT_COLOR_41_41_45)
    self.monsterLayer:addChild(weaknessTitle)

    local _iconWeakness = cc.Sprite:createWithSpriteFrameName("symbol_monsterattribute_dark_2.png")
    _iconWeakness:setPosition(765 - 47, weakCenterY)
    _iconWeakness:setName("_iconWeakness")
    self.monsterLayer:addChild(_iconWeakness)

    local txtWeakness = UI.Text:create()
    txtWeakness:init("---",UI.FONT_STANDARD,UI.FONT_SIZE_16PX)
    txtWeakness:leftBottom(750 - 47,weakCenterY - txtWeakness:getContentSize().height /2)
    txtWeakness:setFontColor(UI.FONT_COLOR_41_41_45)
    txtWeakness:setName("txtWeakness")
    self.monsterLayer:addChild(txtWeakness)

    local _scrollDes = UI.ScrollView:create({},485,130)
    _scrollDes:init()
    _scrollDes:setBounceEnabled(true)
    _scrollDes:leftBottom(373,-17)
    _scrollDes:setName("_scrollDes")
    self.monsterLayer:addChild(_scrollDes)
    _scrollDes:setScrollBarEnabled(true)
    _scrollDes:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    _scrollDes:setCircleVisible(false)
    _scrollDes:setScrollBarWidth(5)
    -- _scrollDes:setScrollBarPositionFromCornerForVertical(cc.p(20,120))


    local upLayout = UI.Layout:create()
    upLayout:init()

    local txtDes = UI.Text:create()
    txtDes:init("",UI.FONT_STANDARD, UI.FONT_SIZE_18PX,UI.FONT_COLOR_41_41_45)
    _scrollDes:addInnerNode(upLayout)
    txtDes:setWidth(460)

    upLayout:addChild(txtDes)
    self._innerNode = upLayout
    self.txtDes_ = txtDes

end

function ArchiveLayer:refreshMonsterInfo(monsterData,originalMonsterData)
    local _monsterBG = self.monsterLayer:getChildByName("monsterBG")
    if monsterData == nil then
        _monsterBG:setSpriteFrame("ui_log_banner_page_scene"..ToolsUtil:getPageSceneID(originalMonsterData)..".png")
    else
        _monsterBG:setSpriteFrame("ui_log_banner_page_scene"..ToolsUtil:getPageSceneID(monsterData)..".png")
    end
    
    _monsterBG:removeAllChildren(true)
    if monsterData ~= nil then
        local roleAnimation = Avalon.Animation:create(monsterData.spine..".json", monsterData.spine..".atlas", 1)
        roleAnimation:setAnimation(0, "idle1", true)
        roleAnimation:setPosition(_monsterBG:getContentSize().width/2, _monsterBG:getContentSize().height/3)
        _monsterBG:addChild(roleAnimation,100)
        roleAnimation:setName("roleAnimation")
        roleAnimation:setScale(monsterData.size/1000.0)
        -- todo 手动调整坐标 解决盖亚位置偏移的问题
        if checkint(monsterData.monsterID) == 10201305 or checkint(monsterData.monsterID) == 10204305 then
            roleAnimation:setPositionX(roleAnimation:getPositionX() + 20)
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 50)
        end  

        if checkint(monsterData.monsterID) == 10205301 or checkint(monsterData.monsterID) == 10206301 then
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 26)
        end 
        roleAnimation:registerSpineEventHandler(function(event)
            if event.animation == "idle1" then
                local roleAnimation = self.monsterLayer:getChildByName("monsterBG"):getChildByName("roleAnimation")
                if math.random() < 0.3 then
                    roleAnimation:setAnimation(0, "idle2", false)
                    roleAnimation:addAnimation(0, "idle1", true)
                end
            end
        end,sp.EventType.ANIMATION_COMPLETE)
    else
        local roleAnimation = Avalon.Animation:create(originalMonsterData.spine..".json", originalMonsterData.spine..".atlas", 1)
        roleAnimation:setAnimation(0, "idle1", true)
        roleAnimation:setPosition(_monsterBG:getContentSize().width/2, _monsterBG:getContentSize().height/3)
        _monsterBG:addChild(roleAnimation,100)
        roleAnimation:setName("roleAnimation")
        roleAnimation:setScale(originalMonsterData.size/1000.0)
        -- todo 手动调整坐标 解决盖亚位置偏移的问题
        if checkint(originalMonsterData.monsterID) == 10201305 or checkint(monsterData.monsterID) == 10204305 then
            roleAnimation:setPositionX(roleAnimation:getPositionX() + 20)
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 50)
        end
        
        roleAnimation:registerSpineEventHandler(function(event)
            if event.animation == "idle1" then
                local roleAnimation = self.monsterLayer:getChildByName("monsterBG"):getChildByName("roleAnimation")
                if math.random() < 0.3 then
                    roleAnimation:setAnimation(0, "idle2", false)
                    roleAnimation:addAnimation(0, "idle1", true)
                end
            end
        end,sp.EventType.ANIMATION_COMPLETE)
    end

    local txtName = self.monsterLayer:getChildByName("txtName")
    if monsterData == nil then
        txtName:setText(originalMonsterData.name)
    else
        txtName:setText(monsterData.name)
    end

    local txtMoney = self.monsterLayer:getChildByName("txtMoney")
    if monsterData == nil then
        txtMoney:setText("???")
    else
        txtMoney:setText(string.split(string.split(monsterData.dropCoin,";")[1],",")[1])
    end

    local txtXP = self.monsterLayer:getChildByName("txtXP")
    if monsterData == nil then
        txtXP:setText("???")
    else
        txtXP:setText(string.split(string.split(monsterData.dropExp,";")[1],",")[1])
    end

    local txtHP = self.monsterLayer:getChildByName("txtHP")
    if monsterData == nil then
        txtHP:setText("???")
    else
        txtHP:setText(string.split(string.split(monsterData.hp,";")[1],",")[1])
    end

    local txtAtk = self.monsterLayer:getChildByName("txtAtk")
    local txtMagicAtk = self.monsterLayer:getChildByName("txtMagicAtk")

    if monsterData == nil then
        txtAtk:setVisible(true)
        txtMagicAtk:setVisible(false)
        txtAtk:setText("???-???")
    else
        if string.split(string.split(monsterData.atkMin,";")[1],",")[1] ~= "0" then
            txtAtk:setVisible(true)
            txtMagicAtk:setVisible(false)
            txtAtk:setText(string.split(string.split(monsterData.atkMin,";")[1],",")[1].."-"..string.split(string.split(monsterData.atkMax,";")[1],",")[1])
        else
            txtAtk:setVisible(false)
            txtMagicAtk:setVisible(true)
            txtMagicAtk:setText(string.split(string.split(monsterData.magicAtkMin,";")[1],",")[1].."-"..string.split(string.split(monsterData.magicAtkMax,";")[1],",")[1])
        end
        -- txtAtk:setText("23232323-34343434")
    end

    local txtAspd = self.monsterLayer:getChildByName("txtAspd")
    if monsterData == nil then
        txtAspd:setText("???")
    else
        -- txtAspd:setText(string.split(string.split(monsterData.atkSpd,";")[1],",")[1])
        txtAspd:setText(string.format("%.1f", tonumber(string.split(string.split(monsterData.atkSpd,";")[1],",")[1])/1000))
    end

    local txtDef = self.monsterLayer:getChildByName("txtDef")
    if monsterData == nil then
        txtDef:setText("???")
    else
        txtDef:setText(string.split(string.split(monsterData.physicDef,";")[1],",")[1])
    end

    local txtMaggicdef = self.monsterLayer:getChildByName("txtMaggicdef")
    if monsterData == nil then
        txtMaggicdef:setText("???")
    else
        txtMaggicdef:setText(string.split(string.split(monsterData.magicDef,";")[1],",")[1])
    end

    local txtFireAtk = self.monsterLayer:getChildByName("txtFireAtk")
    if monsterData == nil then
        txtFireAtk:setText("???")
    else
        local atkFire = string.split(string.split(monsterData.atkFire,";")[1],",")[1]
        if atkFire == "0" then
            txtFireAtk:setText("---")
        else
            txtFireAtk:setText(atkFire)
        end
    end

    local txtFireDef = self.monsterLayer:getChildByName("txtFireDef")
    if monsterData == nil then
        txtFireDef:setText("???")
    else
        local defFire = string.split(string.split(monsterData.defFire,";")[1],",")[1]
        if defFire == "0" then
            txtFireDef:setText("---")
        else
            txtFireDef:setText(defFire)
        end
    end

    local txtWaterAtk = self.monsterLayer:getChildByName("txtWaterAtk")
    if monsterData == nil then
        txtWaterAtk:setText("???")
    else
        local atkWater = string.split(string.split(monsterData.atkWater,";")[1],",")[1]

        if atkWater == "0" then
            txtWaterAtk:setText("---")
        else
            txtWaterAtk:setText(atkWater)
        end
    end

    local txtWaterDef = self.monsterLayer:getChildByName("txtWaterDef")
    if monsterData == nil then
        txtWaterDef:setText("???")
    else
        local defWater = string.split(string.split(monsterData.defWater,";")[1],",")[1]
        if defWater == "0" then
            txtWaterDef:setText("---")
        else
            txtWaterDef:setText(defWater)
        end
    end

    local txtWoodAtk = self.monsterLayer:getChildByName("txtWoodAtk")
    if monsterData == nil then
        txtWoodAtk:setText("???")
    else
        local atkWood = string.split(string.split(monsterData.atkWood,";")[1],",")[1]
        if atkWood == "0" then
            txtWoodAtk:setText("---")
        else
            txtWoodAtk:setText(atkWood)
        end
    end

    local txtWoodDef = self.monsterLayer:getChildByName("txtWoodDef")
    if monsterData == nil then
        txtWoodDef:setText("???")
    else
        local defWood = string.split(string.split(monsterData.defWood,";")[1],",")[1]
        if defWood == "0" then
            txtWoodDef:setText("---")
        else
            txtWoodDef:setText(defWood)
        end
    end

    local txtLightAtk = self.monsterLayer:getChildByName("txtLightAtk")
    if monsterData == nil then
        txtLightAtk:setText("???")
    else
        local atkLight = string.split(string.split(monsterData.atkLight,";")[1],",")[1]
        if atkLight == "0" then
            txtLightAtk:setText("---")
        else
            txtLightAtk:setText(atkLight)
        end
    end

    local txtLightDef = self.monsterLayer:getChildByName("txtLightDef")
    if monsterData == nil then
        txtLightDef:setText("???")
    else
        local defLight = string.split(string.split(monsterData.defLight,";")[1],",")[1]
        if defLight == "0" then
            txtLightDef:setText("---")
        else
            txtLightDef:setText(defLight)
        end
    end

    local txtDarkAtk = self.monsterLayer:getChildByName("txtDarkAtk")
    if monsterData == nil then
        txtDarkAtk:setText("???")
    else
        local atkDark = string.split(string.split(monsterData.atkDark,";")[1],",")[1]
        if atkDark == "0" then
            txtDarkAtk:setText("---")
        else
            txtDarkAtk:setText(atkDark)
        end
    end

    local txtDarkDef = self.monsterLayer:getChildByName("txtDarkDef")
    if monsterData == nil then
        txtDarkDef:setText("???")
    else
        local defDark = string.split(string.split(monsterData.defDark,";")[1],",")[1]
        if defDark == "0" then
            txtDarkDef:setText("---")
        else
            txtDarkDef:setText(defDark)
        end
    end

    local _iconWeakness = self.monsterLayer:getChildByName("_iconWeakness")
    local txtWeakness = self.monsterLayer:getChildByName("txtWeakness")
    _iconWeakness:setVisible(true)
    txtWeakness:setVisible(false)
    if monsterData == nil then
        _iconWeakness:setVisible(false)
        txtWeakness:setVisible(true)
        txtWeakness:setText("???")
    else
        if monsterData.weaknessType == 0 then
            _iconWeakness:setVisible(false)
            txtWeakness:setVisible(true)
            txtWeakness:setText("---")
        elseif monsterData.weaknessType == 1 then
            _iconWeakness:setSpriteFrame("symbol_monsterattribute_fire_0.png")
        elseif monsterData.weaknessType == 2 then
            _iconWeakness:setSpriteFrame("symbol_monsterattribute_water_0.png")
        elseif monsterData.weaknessType == 3 then
            _iconWeakness:setSpriteFrame("symbol_monsterattribute_wood_0.png")
        elseif monsterData.weaknessType == 4 then
            _iconWeakness:setSpriteFrame("symbol_monsterattribute_light_0.png")
        elseif monsterData.weaknessType == 5 then
            _iconWeakness:setSpriteFrame("symbol_monsterattribute_dark_0.png")
        end
    end

    local txtDes = self.txtDes_
    if monsterData == nil then
        txtDes:setText(originalMonsterData.description)
    else
        txtDes:setText(monsterData.description)
    end
    txtDes:setWidth(460)

    local _scrollDes = self.monsterLayer:getChildByName("_scrollDes")
    local _innserNode = self._innerNode
    -- print("txtDes:getContentSize().height",txtDes:getContentSize().height)
    if txtDes:getContentSize().height < 130 then
        _innserNode:setSize(460,130)
        -- txtDes:leftBottom(0,130)
    else
        _innserNode:setSize(460,txtDes:getContentSize().height)
        -- txtDes:leftBottom(0,txtDes:getContentSize().height)
    end

    _scrollDes:scrollToTop(0,false)
end

 
--跳转到指定的cell
--index cell的index
--animated 如果为true则以MoveTo滚动的方式延迟到达指定的cell
function ArchiveLayer:scrollToCell(index)
    local point = self.m_pItemTableView:getContentOffset()
    -- local size = self.m_pItemTableView:getCellSize()
    local height = self.m_pItemTableView:getContentSize().height;
    local viewHeight = self.m_pItemTableView:getViewSize().height;
    local direction = self.m_pItemTableView:getDirection()

    point.y =  -height + viewHeight +((index) * 70)
    if point.y > 0 then
        point.y = 0
    end

    self.m_pItemTableView:setContentOffset(point, false)
end


function ArchiveLayer:numberOfCellsInTableView(table)    
    return #self.monsterList
end


function ArchiveLayer:scrollViewDidScroll(view)
    local offsetY = view:getContentOffset().y
    -- print("ArchiveLayer:scrollViewDidScroll 1", offsetY)
    if offsetY > 0 then
        offsetY = 0;
    end
    local viewHeight = view:getViewSize().height;
    local height = view:getContentSize().height;

    local t = (offsetY - viewHeight)/(height)
    if(t < -1) then
        t = -1;
    elseif t > 0 then
        t = 0
    end
    t = 1 + t
    local _t1 = t * #self.monsterList
    local _h = 0
    local dataNum = #self.data[self.modelIndex].resData -1
    -- print("ArchiveLayer:scrollViewDidScroll 2", offsetY, viewHeight, height, dataNum)
    for k,v in pairs(self.data1) do
        if _t1 < v + 1 then
            if i == dataNum then
                _h = _h + (1+offsetY/((v + 1)*height/#self.monsterList - viewHeight)) * self._barHeight/dataNum
            else
                _h = _h + 1.0 * _t1/(v + 1)*(1.0 * self._barHeight / dataNum)
            end
            break
        else
            _t1 = _t1 - v - 1
            _h = _h + 1.0 * self._barHeight/dataNum
        end
    end

    -- for i = 1,#self.data1 do
    --     if _t1 < self.data1[i] + 1 then
    --         if i == #self.data1 then
    --             _h = _h + (1+offsetY/((self.data1[i] + 1)*height/#self.monsterList - viewHeight)) * self._barHeight/#self.data1
    --         else
    --             _h = _h + 1.0 * _t1/(self.data1[i] + 1)*(1.0 * self._barHeight / #self.data1)
    --         end
    --         break
    --     else
    --         _t1 = _t1 - self.data1[i] - 1
    --         _h = _h + 1.0 * self._barHeight/#self.data1
    --     end
    -- end

    self.pArchiveProBar:updateNowBar(self._barHeight - _h)
end

function ArchiveLayer:scrollViewDidZoom(view)
    print("scrollViewDidZoom")
end

function ArchiveLayer:tableCellTouched(table,cell)
    Avalon.AudioManager:playSound(self.clickAudioID)
    local index = cell:getIdx()
    if self.monsterList[index + 1] then
        if self.monsterList[index + 1].type == 2 then
            if self.monsterList[index + 1].state == 1 then
                if self._selectMonster ~= index then
                    if self._selectMonster ~= -1 then
                        self.monsterList[self._selectMonster + 1].select = false
                        table:updateCellAtIndex(self._selectMonster)
                    end
                    self.monsterList[index + 1].select = true
                    table:updateCellAtIndex(index)
                    local oldMonster = self.monsterList[self._selectMonster + 1]
                    self._selectMonster = index
                    self:updataDifficultyBtn(1)
                    self:refreshMonsterInfo(self.monsterList[index + 1].data, oldMonster)
                end
            end
        end
    end
end

function ArchiveLayer:cellSizeForTable(table,idx)
    if self.monsterList[idx + 1].type == 1 then
        return 350, 39
    end
    return 350, 75
end

function ArchiveLayer:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pArchiveCell = UI.ArchiveCell:create(self.monsterList[idx + 1],idx)
            pArchiveCell:setName("cell")
            cell:addChild(pArchiveCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self.monsterList[idx + 1],idx)
        end
    end, 
    function(e) 
        printError("--------------------ArchiveLayer:tableCellAtIndex---------------------error")
        local data = self.monsterList[idx + 1]
        if data.type == 1 then
            print("ArchiveLayer:tableCellAtIndex 0", idx, data.data)
            local txtName = self.layer4:getChildByName("name")
            txtName:setString(data.data)
        elseif data.type == 2 then
            print("ArchiveLayer:tableCellAtIndex monster=", idx, data.data.name, data.data.monsterID)
        end
    end, 1) 
    return cell;
end

-- 模版函数：更新组建的视图
function ArchiveLayer:onUpdateView()
end

-- 注册监听事件
function ArchiveLayer:registerListener()
end


-- 注销监听事件
function ArchiveLayer:unRegisterListener()
end



