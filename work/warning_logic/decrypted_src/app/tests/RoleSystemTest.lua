

local RoleSystemTest = class("RoleSystemTest")


function RoleSystemTest:testMonster()
    local data = {
        monsterID = 1001,
        coordX = 1,
        coordY = 1
    }

    local monsterData = RoleDataManager:handleMonsterData(data)
    print("RoleSystemTest:testMonster  icon="..monsterData.icon)
end

function RoleSystemTest:testAttrChange( ... )
    local HeroData = require("app.datas.role.HeroData")
    --测试属性改变

    local data = {
        uid = 1,
        attrChange = {
            {
                curValue = 234,
                preValue = 235,
                changeValue = -1,
                changeType = 10,
                changeReason = 2,
            },
            {
                curValue = 233,
                preValue = 235,
                changeValue = -2,
                changeType = 11,
                changeReason = 2,
            }
        }
    }

    RoleDataManager:handleHeroData({pk=1})

    RoleDataManager:attrChange(data)


    print(" one exp="..heroData.exp.."  two exp="..heroData2.exp)
    
    print(" one exp="..heroData.exp.."  two exp="..heroData2.exp)
end


function RoleSystemTest:testConfig()
    require("app.config.ConfigManager")

    local heroConfig = ConfigManager:getRoleConfigByType(Config.RoleType.HERO,{occupation = 1})

    for k,v in pairs(heroConfig) do
        print("heroConfig k="..k.." v="..v)
    end

    local monsterConfig = ConfigManager:getRoleConfigByType(Config.RoleType.MONSTER,{monsterID = 1003,difficulty = 1})
    if monsterConfig then
        for k,v in pairs(monsterConfig) do
            print("monsterConfig k="..k.." v="..v)
        end
    end


end

function RoleSystemTest:loadScene()
    Avalon.MessageCenter:notice(AvalonMessage.COMMON_LOAD_SCENE, {mn=12})
end

function RoleSystemTest:createMaster()
    local initHeroMessage = {
        temp = 1,
        heroData = {
            pk = 1,
            spriteID = 1,
            nickName = "frist name",
            occupation = 1,
            coordX = 11,
            coordY = 15,
        }
    }

    RoleDataManager:initHero(initHeroMessage)
    local heroData = RoleDataManager:getMaster()
    Avalon.MessageCenter:notice(AvalonMessage.MC_COMMON_SHOW_MASTER, heroData)
end

function RoleSystemTest:createMonster()
    local monsterMessage = {
        spriteID = 1,
        monsterID = 1001,
        coordX = 3,
        coordY = 4,
    }
    local num = 100000
    for i =7,15,1 do
        for j = 9,20,1 do
            num = num +1
            monsterMessage.spriteID = num
            monsterMessage.coordX = i
            monsterMessage.coordY = j
            print("add monster x="..i.."  y="..j)
            RoleDataManager:handleMonsterData(monsterMessage)
        end
    end
end

function RoleSystemTest:removeMonster(spriteIDs)
    local mesData = {
        spriteID = {
            
        }
    }
    table.insert(mesData.spriteID,spriteIDs)
    Avalon.MessageCenter:notice(AvalonMessage.BATTLE_REMOVE_SCREEN_MONSTER, mesData)
end

function RoleSystemTest:createHero()
    local num = 2
   for i =7,15,1 do
        for j = 9,20,1 do
             num = num +1

            local localData = {
                pk = 1,
                spriteID = 1,
                nickName = "frist name",
                occupation = 1,
                coordX = 11,
                coordY = 15,
            }

            localData.pk = num
            localData.spriteID = num
            localData.coordX = i
            localData.coordY = j

            Avalon.MessageCenter:notice(AvalonMessage.BATTLE_SCREEN_HERO, localData)
        end
    end
end

function RoleSystemTest:heroDie(spriteID)
    local mesData = {}
    mesData.spriteID = spriteID
    Avalon.MessageCenter:notice(AvalonMessage.BATTLE_HERO_DIE, mesData)
end

function RoleSystemTest:monsterDie(spriteID)
    local mesData = {}
    mesData.spriteID = spriteID
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MONSTER_DIE, mesData)
end



return RoleSystemTest