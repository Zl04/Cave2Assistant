--[[
    画册数据
]]

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
require "app.datas.PublicDefine"
PictureAlbumManager = PictureAlbumManager or {}

local DEBUG = false


function PictureAlbumManager:init()
    self._albumDataList = {}
end

function PictureAlbumManager:clear()
    table.clear(self._albumDataList)
end

function PictureAlbumManager:updateAllData(data)
    --{data = {{baseData = {albumId = 1, tasks = {1001}}, pets = {{petId = 102}, {petId = 119}}}}}
    -- required uint32     petId = 1;
    -- optional uint32     maxStar = 2;                        // 最高星级
    -- optional bool       mutated = 3;                        // 有过变异宠
    table.clear(self._albumDataList)
    local svData = data.data
    -- print("PictureAlbumManager   data === ",data)

    -- print("PictureAlbumManager   svData === ",svData)
    for k, v in pairs(svData) do
        if (v.baseData) then
            if not self._albumDataList[v.baseData.albumId] then
                self._albumDataList[v.baseData.albumId] = {}
            end

            if self._albumDataList[v.baseData.albumId] then
                self._albumDataList[v.baseData.albumId].tasks = v.baseData.tasks
            end
        end

        if (v.pets) then
            if self._albumDataList[v.baseData.albumId] and not self._albumDataList[v.baseData.albumId].pets then
                self._albumDataList[v.baseData.albumId].pets = {}
            end

            for m, petData in pairs(v.pets) do
                local pd = {
                    petId = 0,
                    maxStar = 0,
                    mutated = false
                }
                if petData.petId then
                    pd.petId = petData.petId
                end
                if petData.maxStar then
                    pd.maxStar = petData.maxStar
                end
                if petData.mutated then
                    pd.mutated = petData.mutated
                end

                self._albumDataList[v.baseData.albumId].pets[petData.petId] = pd

                -- table.insert(self._albumDataList[v.baseData.albumId].pets,pd)
            end 
        end

    end

end

--服务器推送, 并处理红点
function PictureAlbumManager:addData(data)
    -- PET_ALBUM_DETAIL_SYNC_MESSAGE   {notifications = {{}, {type = 1, pet = {petId = 119}, albumId = 1}}}
    local svData = data.notifications
    for k,v in pairs(svData) do
        if not self._albumDataList[v.albumId] then
            self._albumDataList[v.albumId] = {}
        end

        if self._albumDataList[v.albumId] and not self._albumDataList[v.albumId].tasks then
            self._albumDataList[v.albumId].tasks = {}
        end

        if v.type == PublicDefine.AlbumNotificationType.AlbumNotificationPetUpdate then
            -- 宠物获得或数据更新

            if self._albumDataList[v.albumId] and not self._albumDataList[v.albumId].pets then
                self._albumDataList[v.albumId].pets = {}
            end

            local petData = v.pet
            local pd = {
                petId = 0,
                maxStar = 0,
                mutated = false
            }
            if petData.petId then
                pd.petId = petData.petId
            end
            if petData.maxStar then
                pd.maxStar = petData.maxStar
            end
            if petData.mutated then
                pd.mutated = petData.mutated
            end

            if not self._albumDataList[v.albumId].pets[petData.petId] then
                --新获得宠物,需要打点
                self:addLocalRedDotData(1,v.albumId,petData.petId)

            end

            self._albumDataList[v.albumId].pets[petData.petId] = pd

        elseif v.type == PublicDefine.AlbumNotificationType.AlbumNotificationTargetUpdate then
            -- 画册目标状态更新
            local haveTask = false
            for m,n in pairs(self._albumDataList[v.albumId].tasks) do
                if n == v.targetId then
                    haveTask = true
                    break
                end
            end

            if not haveTask then
                table.insert(self._albumDataList[v.albumId].tasks,v.targetId)
            end

            --解锁新属性词条, 需要打红点
            self:addLocalRedDotData(2,v.albumId,v.targetId)
        end

    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_TASK_POINT_RED_POINT)
end

--图册对应的宠物图片是否激活
function PictureAlbumManager:picturePetActivation(albumId, petPictureId)
    -- print("picturePetActivation !!!!!!!!!!!! ",albumId,petPictureId)
    -- print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ",self._albumDataList)
    -- print("@@@@@@@@@@@@@@@@@@@@@@@@@@ ", self._albumDataList[albumId])
    local isActivation = false
    if self._albumDataList[albumId] 
    and self._albumDataList[albumId].pets 
    and self._albumDataList[albumId].pets[petPictureId] then
        isActivation = true
    end
    return isActivation
end

--图册对应的宠物图片是否激活(变异)
function PictureAlbumManager:picturePetMutatedActivation(albumId, petPictureId)
    local isActivation = false
    if self._albumDataList[albumId] 
    and self._albumDataList[albumId].pets 
    and self._albumDataList[albumId].pets[petPictureId] 
    and self._albumDataList[albumId].pets[petPictureId].mutated then
        isActivation = true
    end
    return isActivation
end

--图册对应的词条是否激活
function PictureAlbumManager:pictureEntryActivation(albumId, targetId)
    local isActivation = false
    if self._albumDataList[albumId] 
    and self._albumDataList[albumId].tasks then
        for k,v in pairs(self._albumDataList[albumId].tasks) do
            if v == targetId then
                isActivation = true
            end
        end
    end
    return isActivation
end

--获取图册变异宠物数量
function PictureAlbumManager:getPictureMutatedNumberAndMaxStarNum(albumId)
    local mNum = 0
    local allMaxStar = 0
    if self._albumDataList[albumId] and self._albumDataList[albumId].pets then
        for k,v in pairs(self._albumDataList[albumId].pets) do
            if v.mutated then
                mNum = mNum + 1
            end
            if v.maxStar then
                allMaxStar = allMaxStar + v.maxStar
            end
        end
    end
    return mNum,allMaxStar
end

--更新红点数据
function PictureAlbumManager:addLocalRedDotData(rType, albumId, objectId)
    
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getPictureAlbumRedDotData()

    if not redDotData[albumId] then
        redDotData[albumId] = {}
    end

    -- print("addLocalRedDotData ==== ",rType, albumId, objectId)

    if rType == 1 then
        if not redDotData[albumId].pets then
            redDotData[albumId].pets = {}
        end

        table.insert(redDotData[albumId].pets,objectId)
    elseif rType == 2 then
        if not redDotData[albumId].tasks then
            redDotData[albumId].tasks = {}
        end
        -- print("redDotData[albumId] ==== ",redDotData[albumId])

        table.insert(redDotData[albumId].tasks,objectId)
    end
    globalUserData:setPictureAlbumRedDotData(redDotData)
end

--画册整体功能是否有红点
function PictureAlbumManager:isRedDot()
    local isRed = false
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getPictureAlbumRedDotData()

    -- print("redDotData ========== ",redDotData)
    if table.nums(redDotData) > 0 then
        isRed = true
    end
    return isRed
end

--指定画册是否有红点
function PictureAlbumManager:specifyPictureIsRedDot(albumId)
    local isRed = false
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getPictureAlbumRedDotData()
    -- print("redDotData ========== ",redDotData)
    -- print("albumId ========== ",albumId)
    if redDotData[albumId] then
        isRed = true
    end

    return isRed
end

--指定画册图片ID是否需要播放开启特效
function PictureAlbumManager:canPlayPictureAnimation(albumId, pId)
    local isRed = false
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getPictureAlbumRedDotData()

    if redDotData[albumId] and redDotData[albumId].pets then
        for k,v in pairs(redDotData[albumId].pets) do
            if v == pId then
                isRed = true
                break
            end
        end
    end

    return isRed
end

--指定画册属性ID是否需要播放开启特效
function PictureAlbumManager:canPlayAttriAnimation(albumId, tasksId)
    local isRed = false
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getPictureAlbumRedDotData()

    -- print("canPlayAttriAnimation ===== ",redDotData,albumId,tasksId)

    if redDotData[albumId] and redDotData[albumId].tasks then
        for k,v in pairs(redDotData[albumId].tasks) do
            if v == tasksId then
                isRed = true
                break
            end
        end
    end

    return isRed
end

--移除指定画册图片ID是否需要播放开启特效的存储
function PictureAlbumManager:removePictureRedData(albumId)
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getPictureAlbumRedDotData()
    -- print("redDotData =======1==== ",redDotData,albumId)
    if redDotData[albumId] and redDotData[albumId].pets then
        -- print("@@@@@@@@@@@@@@@")
        -- for k,v in pairs(redDotData[albumId].pets) do
        --     if v == pId then
        --         redDotData[albumId].pets[k] = nil
        --         break
        --     end
        -- end
        redDotData[albumId].pets = nil
        -- if table.nums(redDotData[albumId].pets) == 0 then
        --     redDotData[albumId].pets = nil
        -- end

        if (not redDotData[albumId].pets or table.nums(redDotData[albumId].pets) == 0) and (not redDotData[albumId].tasks or table.nums(redDotData[albumId].tasks) == 0) then
            redDotData[albumId] = nil
        end

        if table.nums(redDotData) == 0 then
            redDotData = {}
        end
    end

    -- print("redDotData =========== ",redDotData)
    globalUserData:setPictureAlbumRedDotData(redDotData)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_TASK_POINT_RED_POINT)
end

--移除指定画册属性ID是否需要播放开启特效的存储
function PictureAlbumManager:removePictureAttriRedData(albumId, tasksId)
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getPictureAlbumRedDotData()

    if redDotData[albumId] and redDotData[albumId].tasks then
        for k,v in pairs(redDotData[albumId].tasks) do
            if v == tasksId then
                redDotData[albumId].tasks[k] = nil
                break
            end
        end

        if table.nums(redDotData[albumId].tasks) == 0 then
            redDotData[albumId].tasks = nil
        end

        if (not redDotData[albumId].pets or table.nums(redDotData[albumId].pets) == 0) and (not redDotData[albumId].tasks or table.nums(redDotData[albumId].tasks) == 0) then
            redDotData[albumId] = nil
        end

        if table.nums(redDotData) == 0 then
            redDotData = {}
        end
    end

    -- print("redDotData ======2===== ",redDotData)
    globalUserData:setPictureAlbumRedDotData(redDotData)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_TASK_POINT_RED_POINT)
end

--默认初始化
PictureAlbumManager:init()