
-- 外部库 登记
local package_list = package_list or {
    bit = true,
    lfs = true,
    cjson = true,
    pb = true,
    socket = true,
}
 
-- 全局性质类/或禁止重新加载的文件记录
local ignored_file_list = ignored_file_list or {
    global = true ,
    "app.game.LanguageManager"
}
 
--已重新加载的文件记录
local loaded_file_list = loaded_file_list or {}
 
--视图排版控制
function leading_tag( indent )
    -- body
    if indent < 1 then
        return ''
    else
        return string.rep( '    |',  indent - 1  ) .. '    '
    end
end
 
--关键递归重新加载函数(android存在问题,android不能通过io.open打开文件)
--filename 文件名
--indent   递归深度, 用于控制排版显示
function recursive_reload( filename, indent )
    -- body
    print("recursive_reload==>"..filename)
    indent = indent or 0
    if indent == 0 then
        loaded_file_list = {}
    end

    if package_list[ filename] then 
        --对于 外部库, 只进行重新加载, 不做递归子文件
        --卸载旧文件
        package.loaded[ filename] = nil
 
        --装载信文件
        require( filename )
 
        --标记"已被重新加载"
        loaded_file_list[ filename] = true
 
        --print( leading_tag(indent) .. filename .. "... done" )
        return true
    end
 
    --普通文件
    --进行 "已被重新加载" 检测
    if loaded_file_list[ filename] then 
        --print( leading_tag(indent) .. filename .. "...already been reloaded IGNORED" )
        return true
    end
 
    local fullPath = cc.FileUtils:getInstance():fullPathForFilename(string.gsub(filename, '%.', '/') .. '.lua');
    -- print("11111"..fullPath)
    --读取当前文件内容, 以进行子文件递归重新加载
    local file, err = io.open( fullPath )
    if file == nil then 
        local fullPath = cc.FileUtils:getInstance():fullPathForFilename(string.gsub(filename, '%.', '/') .. '.luac');
        -- print("2222"..fullPath)
        --读取当前文件内容, 以进行子文件递归重新加载
        file, err = io.open( fullPath )
        if file == nil then 
            print( string.format( "failed to reaload file(%s), with error:%s", fullPath, err or "unknown" ))
            return false
        end
    end
 
    -- print( leading_tag(indent) .. filename)
 
    -- 缓存文件内容，及时关闭文件，否则文件不可写入
    local data = {}
    local comment = false
    for line in file:lines() do
        line = string.trim(line);
        if string.find(line, '%-%-%[%[%-%-') ~= nil then
            comment = true;
        end
 
        if comment and (string.find(line, '%]%]') ~= nil or string.find(line, '%-%-%]%]%-%-') ~= nil) then
            comment = false;
        end
 
        -- 被注释掉的，和持有特殊标志的require文件不重新加载
        local linecomment = (line[1] == '-' and line[2] == '-')
        if not comment and not linecomment and string.find(line, '%-%- Ignore Reload') == nil  then
            table.insert(data, line);
        end
    end
 
    io.close(file)
 
    local function getFileName(line)
        local begIndex = string.find(line, "'");
        local endIndex = string.find(line, "'", (begIndex or 1) + 1)
       
        if begIndex == nil or endIndex == nil then
            begIndex = string.find(line, '"');
            endIndex = string.find(line, '"', (begIndex or 1) + 1)
        end
 
        if begIndex == nil or endIndex == nil then
            return nil;
        end
        local filename = string.sub(line, begIndex + 1, endIndex - 1)
        local flagIndex = string.find(line, "%%") --排除动态拼接： require(string.format("profiles/commonProfile/ProfileMonstersAttribute_%d_%d", model, diffculty))
        if flagIndex ~= nil then
            filename = nil
        end
        return filename
    end
 
    -- 先解析文件，加载里面的子文件
    for _,line in ipairs(data) do
        -- 去除空白符
        --line = string.gsub( line, '%s', '' )
        local subFileName = nil 
        if string.find(line, 'require') ~= nil then
            subFileName = getFileName(line);
        elseif string.find(line, 'import') ~= nil then
            -- TODO 兼容import 通过fullPath进行解析
            subFileName = nil
        end
 
        if subFileName then
            --printInfo('file: %s     subFile: %s', line, subFileName)
            --进行递归 
            if ignored_file_list[ filename] then
                return true
            end

            if loaded_file_list[ filename] then
                return true
            end

            local success = recursive_reload( subFileName, indent + 1 )
            if not success then 
                print( string.format( "failed to reload sub file of (%s)", filename ) )
                return false
            end
        end
    end    
 
 
    -- "后序" 处理当前文件...
    if ignored_file_list[ filename] then
        --忽略 "禁止被重新加载"的文件
        print( leading_tag(indent) .. filename .. "... IGNORED" )
        return true
    else
 
        --卸载旧文件
        package.loaded[ filename] = nil
        
        --装载新文件
        require( filename )
 
        --设置"已被重新加载" 标记
        loaded_file_list[ filename] = true
        --print( leading_tag(indent) .. filename .. "... done" )
        return true
    end
end
 
--主入口函数
function reload_script_files()
     
    print( "[reload_script_files...]")
 
    loaded_file_list = {}
 
    --本项目是以 main.lua 为主文件
    recursive_reload( "main", 0 )
     
    print( "[reload_script_files...done]")
 
    return "reload ok"
end

function reload_script_file_mvc(refileName)
    if not (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        return
    end

    local cls = reload_script_file(refileName)
    if cls and mvc[checkObjName(cls.__cname)] then
        setglobal(checkObjName(cls.__cname), cls) 
    end
end

function reload_module_mvc(moduleName)
    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        --reload controller
        for k, events in pairs(mvc.facade.observerMap_) do
            local rmIdx = {}
            for idx, v in ipairs(events) do
                if v.name == moduleName then

                table.insert(rmIdx, idx)
                end
            end

            table.sort(
                rmIdx,
                function(a, b)
                    return a < b
                end
            )
            -- print(k,rmIdx)
            for i = #rmIdx, 1, -1 do
                local idx = rmIdx[i]
                table.remove(events, idx)
            end
        end

        reload_script_file("app.mvc.core.MVCConfig")

        reload_script_file_mvc(
            mvc.PACKAGE_APP_MODULES .. "." .. string.lower(moduleName) .. "." .. moduleName .. "Controller"
        )
        local configs = require(mvc.PACKAGE_APP_CORE .. ".MVCConfig") --获取模块配置文件
        local config = configs[moduleName]
        mvc.facade.loadedModules_[moduleName] = nil
        mvc.facade:registerEvents(moduleName, config.events)
        mvc.facade:registerModule(moduleName)
    end
end

function reload_script_file(refileName)
    -- if refileName == "ProfileLanguage" then
    --      dump(package.loaded[refileName], "reload begin")
    -- end
    -- print("reload_script_file"..refileName)
    local path,n = string.gsub(refileName, "%.", "/")
    -- if package.loaded[refileName] ~= nil then
    --     print("---have the old file!!!! "..refileName)
    -- else
    --     print("---not have old file!!!! "..refileName)
    -- end
    package.loaded[refileName] = nil

    -- if package.loaded[refileName] == nil then
    --     print("unload old file success!!!! "..refileName)
    -- else
    --     print("unload old file fail!!!! "..refileName)
    -- end
    -- dump(package.loaded)
    --装载新文件
    local result = require( refileName )
    -- if result == nil then
    --     print("require file fail!!!! "..refileName)
    -- end
    -- if refileName == "ProfileLanguage" then
    --      dump(package.loaded[refileName], "reload end ----------")
    -- end
    return result;
end


