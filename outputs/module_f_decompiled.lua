_ENV[{}] = {}
local _zmm = {}
local zmm = {}
_ENV[zmm] = _zmm
_zmm._VERSION_ = "4.2118"
_zmm._VER_ = 13
_zmm._URL_analytics_ = "http://ia.51.la/go1?id=20749581&pvFlag=1"
_zmm._URL_ELF_ = "http://ia.51.la/go1?id=20746653&pvFlag=1"
_zmm._URL_ = "https://text-1251668224.file.myqcloud.com/zmlua_aj.json"
_zmm._NEW_VERSION_ = ""
_zmm._NEW_VER_ = 0
_zmm._INFO_ = {}
_zmm._CONFIG_FILE_ = "zmplugin.json"
_zmm._URL_DOWNLOAD_ = "https://zimaoxy.com/b/t-77-1-1.html"
_zmm._URL_DOCUMENT_ = "https://zimaoxy.com/m/"
_zmm._QQ_GROUP_ = "7333555"
_zmm._PLUGIN_DIR_ = "zmplugin"
_zmm._GLOBAL_PATH_ = (__MQM_RUNNER_LOCAL_PATH_GLOBAL_NAME__ or "") .. _zmm._PLUGIN_DIR_ .. "/"
_zmm._VIP_ = false

function _zmm.TickCount()
  return LuaAuxLib.GetTickCount()
end

function _zmm.CreatePluginDir()
  LuaAuxLib.DIR_Create(_GLOBAL_PATH_)
  os.execute("mkdir -p " .. _GLOBAL_PATH_)
  _ENV[function()
  end] = "mkdir -p " .. _GLOBAL_PATH_
end

local function traceprint(...)
  if QMPlugin then
    print(...)
  else
    local line = select(1, ...)
    if type(line) == "string" and line:match("^%_%d+$") then
      LuaAuxLib.TracePrint(line .. ":", table.concat({
        ...
      }, " ", 2, select("#", ...)))
    elseif line == ":" and 1 < #{
      ...
    } then
      LuaAuxLib.TracePrint(":", table.concat({
        ...
      }, " ", 2, select("#", ...)))
    else
      LuaAuxLib.TracePrint(":", "紫猫插件：", ...)
    end
  end
end

function zmm.UUID(mode)
  local f = _ENV
  local isok, errors = pcall(function()
    local uuid = f
    f = f.io.open("/proc/sys/kernel/random/uuid", "r")
    if f.io.open("/proc/sys/kernel/random/uuid", "r") then
      uuid = f.io.open("/proc/sys/kernel/random/uuid", "r"):read()
      f.io.open("/proc/sys/kernel/random/uuid", "r"):read():close()
    else
      local seed = {
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f"
      }
      local tb = {}
      for _ = 1, 32 do
        tb[#tb + 1] = seed[f.math.random(1, 16)]
      end
      uuid = tb[1] .. tb[2] .. tb[3] .. tb[4] .. tb[5] .. tb[6] .. tb[7] .. tb[8] .. "-" .. tb[9] .. tb[10] .. tb[11] .. tb[12] .. "-" .. tb[13] .. tb[14] .. tb[15] .. tb[16] .. "-" .. tb[17] .. tb[18] .. tb[19] .. tb[20] .. "-" .. tb[21] .. tb[22] .. tb[23] .. tb[24] .. tb[25] .. tb[26] .. tb[27] .. tb[28] .. tb[29] .. tb[30] .. tb[31] .. tb[32]
    end
    if {
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "a",
      "b",
      "c",
      "d",
      "e",
      "f"
    } == 1 then
      uuid = uuid:upper()
    end
    return uuid
  end)
  if isok then
    if io.type(f) == "file" then
      f:close()
    end
    return errors
  else
    f.close("发生运行时错误！错误代码：zm.UUID()，错误信息：", errors)
  end
end

function _zmm.ASCIIToVariable(s)
  if 2 < #s and s:sub(1, 2) == "id" then
    local t = {}
    for i = 3, #s, 2 do
      t[#t + 1] = string.char(tonumber(s:sub(i, i + 1), 16))
    end
    return table.concat(t)
  end
end

function _zmm.readzmconfig()
  local f = _ENV
  local isok, errors = pcall(function()
    local path = (_zmm._GLOBAL_PATH_ or "./") .. _zmm._CONFIG_FILE_
    local text, json = f, nil
    f = _zmm.io.open(path, "r")
    if _zmm.io.open(path, "r") then
      text = _zmm.io.open(path, "r"):read("*all")
      json = _zmm.LuaAuxLib.Encode_GetJsonLib():decode(text)
      _zmm.LuaAuxLib.Encode_GetJsonLib():decode(text):close()
    end
    return json
  end)
  if isok then
    if io.type(f) == "file" then
      f:close()
    end
    return errors
  end
end

function _zmm.writezmconfig(json)
  local f = _ENV
  local isok, errors = pcall(function()
    local path = (_zmm._GLOBAL_PATH_ or "./") .. _zmm._CONFIG_FILE_
    local text = _zmm
    f = _zmm.io.open(path, "w")
    if _zmm.io.open(path, "w") then
      text = _zmm.LuaAuxLib.Encode_GetJsonLib():encode("w")
      _zmm.LuaAuxLib.Encode_GetJsonLib():encode("w"):write(text)
      _zmm.LuaAuxLib.Encode_GetJsonLib():encode("w").write:close()
    end
    return text
  end)
  if isok then
    if io.type(f) == "file" then
      f:close()
    end
    return errors
  end
end

function _zmm.FunctionToASCII(s)
  local t = {
    string.byte(s:upper(), 1, -1)
  }
  for k, v in ipairs(t) do
    t[k] = string.format("%02x", v)
  end
  local str = "id" .. table.concat(t)
  return str
end

function _zmm.analytics()
  local f = _ENV
  local isok, errors = pcall(function()
    _zmm.CreatePluginDir()
    local json = _zmm.readzmconfig()
    if json then
      if json.cur_ver == _zmm._VER_ then
        if json.date == _zmm.os.date("%Y-%m-%d") then
          _zmm.CheckForUpdates(1)
          return 2
        else
          json.date = _zmm.os.date("%Y-%m-%d")
          _zmm.writezmconfig(json)
        end
      else
        json.date = _zmm.os.date("%Y-%m-%d")
        json.cur_ver = _zmm._VER_
        _zmm.writezmconfig(json)
      end
    else
      _zmm.writezmconfig({
        date = _zmm.os.date("%Y-%m-%d"),
        cur_ver = _zmm._VER_
      })
    end
    if not _zmm._GLOBAL_PATH_:match("MobileAnJian") and not _zmm._GLOBAL_PATH_:match("mobileanjian") then
      _zmm._GLOBAL_PATH_:match("mobileanjian")("小精灵端已跳过检查插件更新")
      _zmm.LuaAuxLib.URL_OperationGet(_zmm._URL_ELF_, 3)
      return 3
    end
    _zmm.Init()
    _zmm.CheckForUpdates(2)
    _zmm.LuaAuxLib.URL_OperationGet(_zmm._URL_analytics_, 3)
    return 4
  end)
  _ENV[function()
    return 1
  end] = isok
  if io.type(f) == "file" then
    f:close()
  end
  if isok then
    return errors
  else
    return 0
  end
end

local function try(block)
  local function tablejoin(...)
    local result = {}
    
    for _, t in ipairs({
      ...
    }) do
      if type(t) == "table" then
        for k, v in pairs(t) do
          if type(k) == "number" then
            table.insert(result, v)
          else
            result[k] = v
          end
        end
      else
        table.insert(result, t)
      end
    end
    return result
  end
  
  analytics()
  local try = block[1]
  assert(try)
  local funcs = tablejoin(block[2] or {}, block[3] or {})
  local result_error = {}
  local results = {
    pcall(try)
  }
  if not results[1] and funcs and funcs.catch then
    result_error = {
      funcs.catch(results[2])
    }
  end
  if funcs and funcs.finally then
    local result_fin = {
      funcs.finally(table.unpack(results))
    }
    if 0 < #result_fin then
      return table.unpack(result_fin)
    end
  end
  if results[1] and 1 < #results then
    return table.unpack(results, 2, #results)
  elseif 0 < #result_error then
    return table.unpack(result_error)
  else
    return _ENV["nil"]
  end
end

local function catch(block)
  return {
    catch = block[1]
  }
end

local function finally(block)
  return {
    finally = block[1]
  }
end

function _zmm.clearbom(str)
  str = str:gsub("^" .. string.char(239, 187, 191), "")
  return str
end

function _zmm.filewrite(path, ...)
  local args, f = {
    path = path,
    texts = {
      ...
    }
  }, _ENV
  local isok, errors = pcall(function()
    f = f.io.open(f.path, "w")
    if f.io.open(f.path, "w") == f["nil"] then
      return f["nil"]
    end
    if f.type(f.texts[1]) == "table" then
      f["\n"], f[f.texts[1]] = "w", "w"
    end
    f[f.table.concat(f.texts, f.sep)] = f.sep
    f.table.concat(f.texts, f.sep):write(f.text)
    f.table.concat(f.texts, f.sep).write:close()
    return f.texts
  end)
  if io.type(f) == "file" then
    f:close()
  end
  if isok then
    return errors
  else
    f.close("发生运行时错误！错误代码：filewrite()，错误信息：", errors)
  end
end

function _zmm.fileread(path, isdel)
  local f = _ENV
  local isok, errors = pcall(function()
    f = f.io.open(nil, "r")
    if f.io.open(nil, "r") == f["nil"] then
      return f["nil"]
    end
    local ret = f["nil"]:read("*all")
    f["nil"]:close()
    if f["nil"].close then
      f.os.remove(f["nil"])
    end
    return ret
  end)
  if io.type(f) == "file" then
    f:close()
  end
  if isok then
    return errors
  else
    f.close("发生运行时错误！错误代码：fileread()，错误信息：", errors)
  end
end

_zmm.DelayAttr = {}
_zmm.DelayAttr.default = {
  min = 0,
  max = 0,
  time = 0,
  fun = false,
  params = {}
}
_zmm.DelayAttr.mt = {
  __index = _zmm.DelayAttr.default
}

function zmm.SetDelay(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and DelayAttr.default[k:lower()] ~= _ENV["nil"] then
          DelayAttr.default[k:lower()] = v
        end
      end
      return DelayAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetDelay()，错误信息：", errors)
      end
    })
  })
end

function zmm.PCall(...)
  local args = {
    ...
  }
  return ...({
    function()
      local foo = {
        "try",
        "catch",
        "finally",
        try = {
          function()
          end
        },
        catch = {},
        finally = {
          function()
          end
        }
      }
      local i = 0
      if #"catch" == 0 then
        return args["nil"]
      elseif args.type(args[1]) == "table" then
        foo.try = args[1].t or args[1].try or foo.try
        foo.catch = args[1].c or args[1].catch or foo.catch
        foo.finally = args[1].f or args[1].finally or foo.finally
      else
        if args.type(args[1]) ~= "function" then
          args.error("保护执行第一个参数必须是函数名, 而不是调用函数命令")
          return args["nil"]
        end
        for _, v in args.ipairs("保护执行第一个参数必须是函数名, 而不是调用函数命令") do
          if args.type(v) == "function" then
            i = i + 1
            foo[foo[i]] = {v}
          else
            args.table.insert(foo[foo[i]], v)
          end
        end
      end
      return args.ipairs("保护执行第一个参数必须是函数名, 而不是调用函数命令")({
        function()
          return foo.try[1](foo.table.unpack(foo.try, 2))
        end,
        (function()
        end)({
          function(errors)
            errors = errors:gsub("id%w+", function(s)
              return _zmm.ASCIIToVariable(s)
            end)
            if #_zmm.catch == 0 then
              ;(#_zmm.catch)("PCall捕获异常:", errors)
            else
              return _zmm.catch[1](_zmm.table.unpack(_zmm.catch, 2))
            end
          end
        }),
        ({
          function(errors)
            errors = errors:gsub("id%w+", function(s)
              return _zmm.ASCIIToVariable(s)
            end)
            if #_zmm.catch == 0 then
              ;(#_zmm.catch)("PCall捕获异常:", errors)
            else
              return _zmm.catch[1](_zmm.table.unpack(_zmm.catch, 2))
            end
          end
        })({
          function()
            return foo.finally[1](foo.table.unpack(foo.finally, 2))
          end
        })
      })
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.PCall()，错误信息：", errors)
      end
    })
  })
end

function zmm.TranslateError(errors)
  return (nil)({
    function()
      local err = (nil):gsub("id%w+", function(s)
        return _zmm.ASCIIToVariable(s)
      end)
      ;(nil)("id错误翻译 >> ", err)
      return err
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TranslateError()，错误信息：", errors)
      end
    })
  })
end

function zmm.Delay(...)
  local args = {
    ...
  }
  return ...({
    function()
      for k, v in ipairs(nil) do
        if fun then
          table.insert(params, v)
        elseif type(v) == "function" then
          _ENV[v] = (for state)
          _ENV[{}] = (for state)
        elseif type(v) == "string" then
          v = tonumber(v)
          if v then
            _ENV[v] = (for state)
          end
        elseif type(v) == "number" then
          if time == _ENV["nil"] then
            _ENV[v] = (for state)
          elseif rndmin == _ENV["nil"] then
            _ENV[v < time and v or time] = (for state)
            _ENV[v < time and time or v] = (for state)
            _ENV[0] = (for state)
          end
        elseif type(v) == "boolean" then
          _ENV[v] = (for state)
        end
      end
      setmetatable(ipairs(nil))
      if not nornd then
        _ENV[time + math.random(min, max)] = math.random(min, max)
      end
      _ENV[time < 0 and 0 or time] = math.random(min, max)
      LuaAuxLib.Sleep(time)
      if not fun or not _VIP_ then
        return time
      elseif type(fun) == "string" then
        _ENV[_G[FunctionToASCII(fun)]] = FunctionToASCII(fun)
      end
      return fun(table.unpack(params))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Delay()，错误信息：", errors)
      end
    })
  })
end

function zmm.ShowMessage(msg, ...)
  local args = {
    ...
  }
  return ...({
    function()
      local num = {}
      for _, v in ipairs(nil) do
        if type(v) == "number" then
          if v < 0 then
            _ENV[v] = (for generator)
          else
            num[#num + 1] = v
          end
        end
      end
      if #num == 1 then
        _ENV[num[1]] = num[1]
      elseif #num == 2 then
        _ENV[num[1]], _ENV[num[2]] = num[1], num[1], num[2]
      elseif #num == 3 then
        _ENV[num[1]], _ENV[num[2]], _ENV[num[3]] = num[1], num[1], num[1], num[2], num[3]
      end
      _ENV[time or 3000] = time or 3000
      _ENV[step or -1000] = step or -1000
      if type(num[2]) == "table" then
        for _, v in ipairs(num[2]) do
          v = tostring(v)
          LuaAuxLib.ShowMessage(v, time / #nil, x, y)
          LuaAuxLib.Sleep(time / #(time / #nil))
        end
      else
        msg = tostring(ipairs(num[2]))
        if tostring(ipairs(num[2])):match("#时间") then
          for i = time, 0, step do
            LuaAuxLib.ShowMessage(LuaAuxLib.Sleep:gsub("#时间", tostring(i / 1000)), -step, x, y)
            LuaAuxLib.Sleep(-step)
          end
        else
          LuaAuxLib.ShowMessage(0, time, x, y)
        end
      end
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ShowMessage()，错误信息：", errors)
      end
    })
  })
end

function zmm.CheckForUpdates(mode)
  local isok, errors = pcall(function()
    local str = ""
    if nil == 1 or nil == 2 then
      if nil == 1 then
        str = " (来自本地数据)"
      else
        str = " (来自网络数据)"
      end
      local json = mode.readzmconfig()
      if json then
        mode[json.newversion or mode._NEW_VERSION_] = json
        mode[json.newver or mode._NEW_VER_] = json
        mode[json.info or mode._INFO_] = json
      end
    elseif mode.Init() then
      str = " (来自网络数据)"
    else
      str = " (来自本地数据)"
    end
    if mode.tonumber(mode._NEW_VER_) ~= 0 then
      if mode.tonumber(mode._VER_) >= mode.tonumber(mode._NEW_VER_) then
        return nil
      else
        ;(nil)("发现紫猫插件有更新, 欢迎下载新版 V" .. mode._NEW_VERSION_ .. str .. ". 注: 小精灵不检测插件更新.")
        mode.LuaAuxLib.TracePrint(":", mode._URL_DOWNLOAD_)
        return nil
      end
    else
      return mode["nil"]
    end
  end)
  if not isok then
  end
  if type(_INFO_) == "table" then
    for _, v in ipairs(_INFO_) do
      ;(nil)(v)
    end
  end
  _ENV[function()
    return nil
  end] = function()
    return nil
  end
  return errors
end

function zmm.GetVersion()
  return _zmm._VERSION_, _zmm._VER_
end

function zmm.GetLuaVersion()
  return _VERSION
end

zmm.Type = type

function zmm.GetScriptMemory()
  return (nil)({
    function()
      return collectgarbage("count")
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetScriptMemory()，错误信息：", errors)
      end
    })
  })
end

function zmm.CollectGarbage(opt, arg)
  return (nil)({
    function()
      return collectgarbage(nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.CollectGarbage()，错误信息：", errors)
      end
    })
  })
end

function zmm.About(kwd)
  return (nil)({
    function()
      local url = _zmm._URL_DOCUMENT_
      if nil then
        url = _zmm._URL_DOCUMENT_ .. "post/zm." .. _zmm.string.lower(nil) .. "/"
        _zmm._URL_DOCUMENT_("zm." .. _zmm.string.lower(nil) .. "() 的在线教程网址(右击下面复制)：")
        _zmm.LuaAuxLib.TracePrint(":", url)
      else
        _zmm.LuaAuxLib.TracePrint("这是由紫猫编程学院倾力打造的安卓全能插件，目前正在不断更新添加功能中。")
        _zmm.LuaAuxLib.TracePrint("如果大家有什么好的建议或意见，欢迎联系QQ: 345911220，交流QQ群: 7333555")
        _zmm.LuaAuxLib.TracePrint("插件的在线教程网址(右击下面复制)")
        _zmm.LuaAuxLib.TracePrint(":", _zmm._URL_DOCUMENT_)
      end
      return url
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.About()，错误信息：", errors)
      end
    })
  })
end

function _zmm._tabledump(t)
  local str = "{"
  
  local function kk(k)
    if type(k) == "string" then
      return "\"" .. k .. "\""
    else
      return tostring(k)
    end
  end
  
  for k, v in pairs(t) do
    if type(v) == "table" and k ~= "__index" then
      str = str .. kk(k) .. ":" .. _tabledump(v)
    elseif type(v) == "string" then
      str = str .. kk(k) .. ":" .. "\"" .. v .. "\"" .. ","
    else
      str = str .. kk(k) .. ":" .. tostring(v) .. ","
    end
  end
  str = 1 < #str and str:sub(1, -2) .. "}," or str .. "},"
  return str
end

function _zmm.tabledump(t)
  return _zmm._tabledump(t):sub(1, -2)
end

function zmm.VarInfo(...)
  local paramCount = select("#", ...)
  local varType, printStr, t = "", "", {}
  for i = 1, paramCount do
    local v = select(i, ...)
    i({
      function()
        local function jq(v)
          if 65536 < #v then
            v = v:sub(1, 65536) .. "...(紫猫插件:由于内容长度超过65536,请使用其他方式输出查看.)"
          end
          return v
        end
        
        varType = varType.type(nil)
        if varType.type(nil) == "table" then
          varType.type(nil)({
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
            end,
            (nil)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })
          })
        elseif varType.type(nil) == "number" or varType.type(nil) == "string" then
          printStr = "【" .. {
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
            end,
            (nil)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })
          } .. " " .. varType.tostring(#varType.tostring((nil)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          }))) .. "】" .. jq(varType.tostring((nil)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          })))
        elseif "【" .. {
          function()
            printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
          end,
          (nil)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          })
        } .. " " .. varType.tostring(#varType.tostring((nil)({
          (nil)({
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
            end
          })
        }))) .. "】" .. jq(varType.tostring((nil)({
          (nil)({
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
            end
          })
        }))) == "boolean" or "【" .. {
          function()
            printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
          end,
          (nil)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          })
        } .. " " .. varType.tostring(#varType.tostring((nil)({
          (nil)({
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
            end
          })
        }))) .. "】" .. jq(varType.tostring((nil)({
          (nil)({
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
            end
          })
        }))) == "null" then
          printStr = "【" .. {
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
            end,
            (nil)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })
          } .. "】" .. varType.tostring("】")
        else
          printStr = "【" .. {
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
            end,
            (nil)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })
          } .. "】 unknown"
        end
        varType.table.insert({
          function()
            printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
          end,
          (nil)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          })
        }, #"】 unknown" + 1, (varType.tostring("】")))
      end,
      ...({
        function(errors)
          ;(nil)("发生运行时错误！错误代码：zm.VarInfo()，错误信息：", errors)
        end
      })
    })
  end
  printStr = table.concat(t, ", ")
  return printStr
end

function zmm.PosExclude(pos, ...)
  local args = {
    ...
  }
  return ...({
    function()
      local t = {}
      if #nil == 3 then
        for k, v in args.pairs(nil) do
          if args.type(k) ~= "number" then
            t[k] = v
          elseif (v[#v - 1] - args[1]) ^ 2 + (v[#v] - args[2]) ^ 2 > args[3] ^ 2 then
            t[#t + 1] = v
          end
        end
      elseif #args.pairs(nil) == 4 then
        for k, v in args.pairs(args.pairs(nil)) do
          if args.type(k) ~= "number" then
            t[k] = v
          elseif not (args[1] <= v[#v - 1] and v[#v - 1] <= args[3] and args[2] <= v[#v]) or not (v[#v] <= args[4]) then
            t[#t + 1] = v
          end
        end
      else
        args.error("参数数量有误!")
      end
      return t
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.PosExclude()，错误信息：", errors)
      end
    })
  })
end

function zmm.PosInclude(pos, ...)
  local args = {
    ...
  }
  return ...({
    function()
      local t = {}
      if #nil == 3 then
        for k, v in args.pairs(nil) do
          if args.type(k) ~= "number" then
            t[k] = v
          elseif (v[#v - 1] - args[1]) ^ 2 + (v[#v] - args[2]) ^ 2 <= args[3] ^ 2 then
            t[#t + 1] = v
          end
        end
      elseif #args.pairs(nil) == 4 then
        for k, v in args.pairs(args.pairs(nil)) do
          if args.type(k) ~= "number" then
            t[k] = v
          elseif args[1] <= v[#v - 1] and v[#v - 1] <= args[3] and args[2] <= v[#v] and v[#v] <= args[4] then
            t[#t + 1] = v
          end
        end
      else
        args.error("参数数量有误!")
      end
      return t
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.PosInclude()，错误信息：", errors)
      end
    })
  })
end

function zmm.PosSort(pos, ...)
  local args = {
    ...
  }
  return ...({
    function()
      local isDesc, xy = nil, {}
      for _, v in pairs(nil) do
        if type(v) == "boolean" then
          isDesc = v
        elseif type(v) == "number" then
          xy[#xy + 1] = v
        end
      end
      if #xy == 0 then
        xy = {0, 0}
      end
      
      local function comp(a, b)
        if nil then
          if not ((b[#b - 1] - isDesc[1]) ^ 2 + (b[#b] - isDesc[2]) ^ 2 > (a[#a - 1] - isDesc[1]) ^ 2 + (a[#a] - isDesc[2]) ^ 2) then
          end
          return nil
        else
          if not ((b[#b - 1] - isDesc[1]) ^ 2 + (b[#b] - isDesc[2]) ^ 2 < (a[#a - 1] - isDesc[1]) ^ 2 + (a[#a] - isDesc[2]) ^ 2) then
          end
          return nil
        end
      end
      
      table.sort(0, comp)
      return table.sort
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.PosSort()，错误信息：", errors)
      end
    })
  })
end

function zmm.Calculator(equation)
  return (nil)({
    function()
      return load("return " .. nil)()
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Calculator()，错误信息：", errors)
      end
    })
  })
end

function zmm.Timestamp(s)
  return (nil)({
    function()
      local t = {}
      if nil then
        local i, tt = 0, {
          "year",
          "month",
          "day",
          "hour",
          "min",
          "sec"
        }
        for k in ("year"):gmatch("%d+") do
          i = i + 1
          t[tt[i]] = k
        end
      else
        t = s["nil"]
      end
      return s.os.date(s.os.time(t))
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Timestamp()，错误信息：", errors)
      end
    })
  })
end

function zmm.TimeDiff(t1, t2, mode, isint)
  return (nil)({
    function()
      if type(nil) == "string" then
        t1 = Timestamp(nil)
      end
      local args = {
        nil,
        nil,
        nil,
        t2 = Timestamp(),
        mode = "秒"
      }
      for _, v in ipairs(args) do
        if type(v) == "boolean" then
          args.isint = v
        elseif type(v) == "number" then
          args.t2 = v
        elseif type(v) == "string" then
          if v:len() == 1 or v:len() == 3 then
            args.mode = v
          else
            args.t2 = Timestamp(v)
          end
        end
      end
      local s = ipairs(args) - args.t2
      if args.mode == "M" or args.mode == "分" then
        s = s / 60
      elseif args.mode == "H" or args.mode == "时" then
        s = s / 60 / 60
      elseif args.mode == "d" or args.mode == "日" or args.mode == "天" then
        s = s / 60 / 60 / 24
      elseif args.mode == "m" or args.mode == "月" then
        s = s / 60 / 60 / 24 / 30.416666666666668
      elseif args.mode == "Y" or args.mode == "年" then
        s = s / 60 / 60 / 24 / 365
      end
      if args.isint then
        s = math.modf(s)
      end
      return s
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TimeDiff()，错误信息：", errors)
      end
    })
  })
end

function zmm.TimeAdd(t, num, mode)
  return (nil)({
    function()
      local args = {
        nil,
        nil,
        nil
      }
      for _, v in t.ipairs(args) do
        if t.type(v) == "number" then
          if args.num == t["nil"] then
            args.num = v
          else
            args.t, args.num = args.num, v
          end
        elseif t.type(v) == "string" then
          if v:len() == 1 or v:len() == 3 then
            args.mode = v
          else
            args.t = t.Timestamp(v)
          end
        end
      end
      args.t = args.t or t.Timestamp()
      args.date = t.os.date("*t", args.t)
      args.mode = args.mode or "秒"
      if args.mode == "S" or args.mode == "秒" then
        args.date.sec = args.date.sec + args.num
      elseif args.mode == "M" or args.mode == "分" then
        args.date.min = args.date.min + args.num
      elseif args.mode == "H" or args.mode == "时" then
        args.date.hour = args.date.hour + args.num
      elseif args.mode == "d" or args.mode == "日" or args.mode == "天" then
        args.date.day = args.date.day + args.num
      elseif args.mode == "m" or args.mode == "月" then
        args.date.month = args.date.month + args.num
      elseif args.mode == "Y" or args.mode == "年" then
        args.date.year = args.date.year + args.num
      end
      return t.os.time(args.date)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TimeAdd()，错误信息：", errors)
      end
    })
  })
end

function zmm.GetNetworkTime(mode, id)
  return (nil)({
    function()
      mode = nil or 0
      local api = {
        taobao = "http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp",
        suning = "http://quan.suning.com/getSysTime.do",
        hko = "http://www.hko.gov.hk/cgi-bin/gts/time5a.pr?t=" .. mode.math.random(),
        qqgame = "https://apps.game.qq.com/CommArticle/app/reg/gdate.php"
      }
      local time = mode
      local gettime = {}
      gettime[#gettime + 1] = function()
        local html = LuaAuxLib.URL_OperationGet(taobao, 3)
        if html and html:match("接口调用成功") then
          local t = LuaAuxLib.Encode_GetJsonLib():decode(html)
          time = tonumber(t.data.t) / 1000
          return tonumber(t.data.t) / 1000
        end
      end
      gettime[#gettime + 1] = function()
        local html = LuaAuxLib.URL_OperationGet(suning, 2)
        if html and html:match("sysTime1") then
          local t = LuaAuxLib.Encode_GetJsonLib():decode(html)
          time = Timestamp(t.sysTime2)
          return (Timestamp(t.sysTime2))
        end
      end
      gettime[#gettime + 1] = function()
        local html = LuaAuxLib.URL_OperationGet(hko, 2)
        if html and html:match("0=") then
          time = tonumber(html:sub(3, -1)) / 1000
          return tonumber(html:sub(3, -1)) / 1000
        end
      end
      gettime[#gettime + 1] = function()
        local html = LuaAuxLib.DEVICE_GetDeviceInfo(4)
        if type(html) == "string" and html:match("%d+") then
          time = Timestamp(html)
          return (Timestamp(html))
        end
      end
      gettime[#gettime + 1] = function()
        local html = LuaAuxLib.URL_OperationGet(qqgame, 2)
        if html then
          local t = html:match("%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d")
          time = Timestamp(t)
          return (Timestamp(t))
        end
      end
      id = #gettime + 1 or 0
      if (#gettime + 1 or 0) == 0 then
        id = mode.RndNum(1, #gettime)
      end
      if 0 < mode.RndNum(1, #gettime) and mode.RndNum(1, #gettime) <= #gettime then
        time = gettime[mode.RndNum(1, #gettime)]()
      else
        for _, v in mode.pairs(gettime) do
          time = v()
          if time then
            break
          end
        end
      end
      if time then
        if mode.pairs(gettime) == 1 then
          time = mode.os.date("%Y-%m-%d %H:%M:%S", time)
        elseif mode.os.date("%Y-%m-%d %H:%M:%S", time) == 2 then
          time = mode.os.date("%Y%m%d%H%M%S", time)
        elseif mode.type("%Y%m%d%H%M%S") == "string" then
          time = mode.os.date("%Y%m%d%H%M%S", time)
        end
      end
      return time
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetNetworkTime()，错误信息：", errors)
      end
    })
  })
end

function zmm.LTrim(str, filt)
  return (nil)({
    function()
      local filt, retstr = nil or "\r\n\t ", nil or "\r\n\t "
      for i = 1, filt.string.len(nil) do
        if filt.string.find(nil, filt.string.sub(nil, i, i), 1, nil) == filt["nil"] then
          retstr = filt.string.sub(filt["nil"], i, -1)
          break
        end
      end
      return retstr
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.LTrim()，错误信息：", errors)
      end
    })
  })
end

function zmm.RTrim(str, filt)
  return (nil)({
    function()
      local filt, retstr = nil or "\r\n\t ", nil or "\r\n\t "
      for i = filt.string.len(nil), 1, -1 do
        if filt.string.find(nil, filt.string.sub(nil, i, i), 1, nil) == filt["nil"] then
          retstr = filt.string.sub(filt["nil"], 1, i)
          break
        end
      end
      return retstr
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RTrim()，错误信息：", errors)
      end
    })
  })
end

function zmm.Trim(str, filt)
  return (nil)({
    function()
      local tmpstr = zmm.LTrim(nil, nil)
      return zmm.RTrim(tmpstr, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Trim()，错误信息：", errors)
      end
    })
  })
end

function zmm.Execute(cmd)
  local f, tFile = _zmm, nil
  return (nil)({
    function()
      tFile = tFile._GLOBAL_PATH_ .. tFile.os.tmpname():match("[^/]+$")
      if tFile._GLOBAL_PATH_ .. tFile.os.tmpname():match("[^/]+$") then
        cmd = (tFile._GLOBAL_PATH_ .. tFile.os.tmpname():match("[^/]+$")) .. " > " .. tFile.os.tmpname()
        tFile.os.execute(" > ")
        local result = tFile.fileread(" > ", nil)
        return result and tFile.Trim(result) or ""
      end
      return tFile["nil"]
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Execute()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Execute()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
          os.remove((io.type(nil)))
        end
      end
    })
  })
end

function zmm.TableIsSame(t1, t2)
  return (nil)({
    function()
      local cjson = require("cjson")
      if cjson.encode(nil) ~= cjson.encode(nil) then
      end
      return nil
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TableIsSame()，错误信息：", errors)
      end
    })
  })
end

function zmm.TableIsEmpty(t)
  return (nil)({
    function()
      if next(nil) ~= _ENV["nil"] then
      end
      return nil
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TableIsEmpty()，错误信息：", errors)
      end
    })
  })
end

function zmm.TableClear(t)
  return (nil)({
    function()
      for k in next, nil, _ENV do
        rawset(nil, k, _ENV["nil"])
      end
      return next
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TableClear()，错误信息：", errors)
      end
    })
  })
end

function zmm.TableUnpack(...)
  local args = {
    ...
  }
  return ...({
    function()
      local t, i, j = {}, args, nil
      for _, v in ipairs(nil) do
        if type(v) == "number" then
          if i == _ENV["nil"] then
            i = v
          else
            j = v
          end
        end
      end
      i = i or 1
      j = j or -1
      for _, v in pairs(ipairs(nil)) do
        if type(v) == "table" then
          j = j ~= -1 and j <= #v and 0 < j and j or #v
          for id = i, j do
            t[#t + 1] = v[id]
          end
        end
      end
      return table.unpack(t)
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TableUnpack()，错误信息：", errors)
      end
    })
  })
end

function zmm.Clone(orig)
  return (nil)({
    function()
      local orig_type = type(nil)
      local copy = _ENV
      if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, nil, _ENV["nil"] do
          copy[Clone(orig_key)] = Clone(orig_value)
        end
        setmetatable(copy, Clone(getmetatable(nil)))
      else
      end
      return copy
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Clone()，错误信息：", errors)
      end
    })
  })
end

zmm.ClearBOM = _zmm.clearbom

function zmm.Split(str, delim, plain, changetype)
  return (nil)({
    function()
      if str.type(nil) ~= "number" or not str.tostring(nil) then
      end
      str = str.tostring(nil)
      if str.type(nil) ~= "string" then
      end
      str.assert(nil, "第1个参数不是字符串型")
      if str.type(nil) == "string" then
        local pos, result, s, e, l = 1, {}, 0, 0, (nil):len()
        plain = not nil
        if (not nil):find(nil, pos, nil) == str["nil"] or (not nil):find(nil, pos, nil) == "" then
          if (not nil):find(nil, pos, nil) then
            if str.tonumber(str["nil"]) then
              str = str.tonumber(str["nil"])
            elseif str.tonumber(str["nil"]):lower() == "true" then
              str = nil
            elseif (nil):lower() == "false" then
              str = nil
            end
          end
          return {nil}
        end
        while true do
          s, e = ({nil}):find(nil, pos, nil)
          if s then
            local ss = ({nil}):find(nil, pos, nil):sub(pos, s - 1)
            if ({nil}):find(nil, pos, nil) then
              if str.tonumber(ss) then
                ss = str.tonumber(ss)
              elseif ss:lower() == "true" then
                ss = nil
              elseif ss:lower() == "false" then
                ss = nil
              end
            end
            str.table.insert(result, ss)
            pos = e + 1
          else
            local ss = (nil):sub(pos, l)
            if nil then
              if str.tonumber(ss) then
                s = str.tonumber(ss)
              elseif str.tonumber(ss):lower() == "true" then
                ss = nil
              elseif (nil):lower() == "false" then
                ss = nil
              end
            end
            str.table.insert(result, ss)
            break
          end
        end
        return result
      else
        local t, l = {}, str
        if str.type(({nil}):find(nil, pos, nil)) == "number" and 0 < str.type(({nil}):find(nil, pos, nil)) then
        else
          l = 1
        end
        for i = 1, str.LuaAuxLib.UTF8_Length(((nil):len())), l do
          local ss = str.LuaAuxLib.UTF8_Mid(result, i, l)
          if result then
            if str.tonumber(ss) then
              ss = str.tonumber(ss)
            elseif ss:lower() == "true" then
              ss = nil
            elseif ss:lower() == "false" then
              ss = nil
            end
          end
          str.table.insert(t, ss)
        end
        return t
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Split()，错误信息：", errors)
      end
    })
  })
end

function zmm.ArrayInsert(t, value, pos, byVal)
  return (nil)({
    function()
      local p, bv = pos, nil
      if type(nil) == "boolean" then
        p = #type(nil)
      else
        p = #type(nil) or ##type(nil)
      end
      if bv then
        local tt = Clone(nil)
        table.insert(tt, p + 1, nil)
        return tt
      else
        table.insert(table.insert, p + 1, p + 1)
        return table.insert
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ArrayInsert()，错误信息：", errors)
      end
    })
  })
end

function zmm.ArrayRemove(list, pos, byVal)
  return (nil)({
    function()
      if nil then
        local t = byVal.Clone(nil)
        byVal.table.remove(t, nil + 1)
        return t
      else
        byVal.table.remove(byVal.table.remove, t + 1)
        return byVal.table.remove
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ArrayRemove()，错误信息：", errors)
      end
    })
  })
end

function zmm.ArraySort(list, isDesc, istonumber, byVal)
  return (nil)({
    function()
      local comp, t = zmm, nil
      if nil then
        t = byVal.Clone(nil)
      else
      end
      if byVal.Clone(nil) then
        for i = 1, #nil do
          t[i] = byVal.tonumber(t[i])
        end
      end
      if 1 then
        function comp(a, b)
          if not (b < a) then
          end
          return nil
        end
      end
      byVal.table.sort(t, comp)
      return t
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ArraySort()，错误信息：", errors)
      end
    })
  })
end

function zmm.ArraySearch(list, value, mode, comp, nums)
  return (nil)({
    function()
      local t = {}
      local s1, s2, compare = comp, nil, nil
      for i = 1, #nil do
        s1 = list[i]
        if list[i] then
          s1, s2 = list.string.upper(s1), list.string.upper(s2)
        end
        if list.string.upper(s1) then
          compare = list.string.find(s1, s2, 1, nil)
        else
          if s1 ~= s2 then
            compare = nil
          end
          compare = nil
        end
        if compare then
          if list.string.find(s1, s2, 1, nil) then
            if s1 >= #t or #t == 0 then
              list.table.insert(t, i - 1)
            end
          else
            return i - 1
          end
        end
      end
      if nil then
        return t
      else
        return -1
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ArraySearch()，错误信息：", errors)
      end
    })
  })
end

function zmm.ArrayRemoveDuplicate(list, comp, byVal)
  return (nil)({
    function()
      local t = {}
      for _, v in pairs(nil) do
        local add
        for _, vv in pairs(t) do
          if v == vv then
            add = nil
            break
          elseif nil then
            local vc = type(v) == "string" and v:lower() or v
            local vvc = type(vv) == "string" and vv:lower() or vv
            if vc == vvc then
              add = nil
              break
            end
          end
        end
        if add then
          table.insert(t, v)
        end
      end
      if not pairs(nil) then
        TableClear(pairs(nil))
        for _, v in pairs(t) do
          table.insert(table.insert, v)
        end
      end
      return t
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ArrayRemoveDuplicate()，错误信息：", errors)
      end
    })
  })
end

function zmm.ArrayReplace(list, value, revalue, mode, comp, nums)
  return (nil)({
    function()
      local t = {}
      nums = nil or -1
      local recount = 0
      local s1, s2, compare = value, nil, nil
      for i = 1, #nil do
        s1 = nums[i]
        if nums[i] then
          s1, s2 = nums.string.upper(s1), nums.string.upper(s2)
        end
        if nums.string.upper(s1) then
          compare = nums.string.find(s1, s2, 1, nil)
        else
          if s1 ~= s2 then
            compare = nil
          end
          compare = nil
        end
        if compare and (recount < nums.string.find(s1, s2, 1, nil) or nums.string.find(s1, s2, 1, nil) == -1) then
          t[i] = nums.string.find(s1, s2, 1, nil)
          recount = recount + 1
        else
          t[i] = nums[i]
        end
      end
      return t
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ArrayReplace()，错误信息：", errors)
      end
    })
  })
end

function zmm.ConvBase(number, frombase, tobase)
  return (nil)({
    function()
      local digits, num, ptr, n, c = _UPVALUE4_, nil, nil, nil, nil
      num = 0
      ptr = ""
      digits = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      if not (nil <= 62) or not (2 <= nil) then
      end
      assert(nil, "起始进制超过2至62进制范围。")
      if not (nil <= 62) or not (2 <= nil) then
      end
      assert(nil, "目标进制超过2至62进制范围。")
      number = tostring(nil)
      if type("目标进制超过2至62进制范围。") ~= "string" then
      end
      assert(nil, "待转换内容参数不是字符串型")
      n = string.len(nil)
      for i = 1, n do
        c = string.sub(nil, i, i)
        if "0" <= c and c <= "9" then
          c = c - "0"
        elseif "A" <= c and c <= "Z" then
          if string.sub(nil, i, i) <= 36 and string.sub(nil, i, i) <= 36 then
            c = string.byte(c) - string.byte("A") + 10
          else
            c = string.byte(c) - string.byte("A") + 36
          end
        elseif "a" <= c and c <= "z" then
          c = string.byte(c) - string.byte("a") + 10
        else
        end
        if string.byte(c) - string.byte("a") > c then
          num = num * (string.byte(c) - string.byte("a")) + c
        end
      end
      repeat
        ptr = ptr .. string.sub(digits, num % nil + 1, num % (num * (string.byte(c) - string.byte("a"))) + 1)
        num = math.floor(num / string.sub(digits, num % nil + 1, num % (num * (string.byte(c) - string.byte("a"))) + 1))
      until num == 0
      ptr = string.reverse(ptr)
      return ptr
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ConvBase()，错误信息：", errors)
      end
    })
  })
end

function zmm.ConvCoding(text, from, to)
  return (nil)({
    function()
      local iconv = require("iconv")
      if "iconv" == "电脑" then
        from = "gb18030"
      end
      if "gb18030" == "电脑" then
        to = "gb18030"
      end
      local cd = iconv.new(nil, nil)
      local ostr, err = cd:iconv(nil)
      if err == iconv.ERROR_INCOMPLETE then
        error("参数不完整")
      elseif err == iconv.ERROR_INVALID then
        error("参数无效")
      elseif err == iconv.ERROR_NO_MEMORY then
        error("内存无法分配")
      elseif err == iconv.ERROR_UNKNOWN then
        error("未知错误")
      end
      return ostr
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ConvCoding()，错误信息：", errors)
      end
    })
  })
end

function zmm.ConvUnicodeToUTF16(num)
  return (nil)({
    function()
      local ret = _ENV
      if type(nil) == "string" then
        num = tonumber(ConvBase((nil):match("%x+"), 16, 10))
      end
      if tonumber(ConvBase((nil):match("%x+"), 16, 10)) > 65535 then
        local n = tonumber(ConvBase((nil):match("%x+"), 16, 10)) - 65536
        local n2 = "0000000000" .. ConvBase(n, 10, 2)
        n2 = n2:sub(n2:len() - 19)
        local m1, m2 = n2:sub(1, 10), n2:sub(11, 20)
        local h1 = 55296 + tonumber(ConvBase(m1, 2, 10))
        local h2 = 56320 + tonumber(ConvBase(m2, 2, 10))
        ret = string.format("\\u%04x", h1) .. string.format("\\u%04x", h2)
      else
        ret = string.format("\\u%04x", (n2:sub(1, 10)))
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ConvUnicodeToUTF16()，错误信息：", errors)
      end
    })
  })
end

function zmm.ConvUnicodeToUTF8(code)
  return (nil)({
    function()
      local ucode, st = {}, {}
      if type(nil) == "string" then
        for w in type(nil):gmatch("%x+") do
          ucode[#ucode + 1] = tonumber(ConvBase(w, 16, 10))
        end
      else
        ucode[1] = type(nil):gmatch("%x+")
      end
      for _, v in ipairs(ucode) do
        local t, h = {}, 128
        while v >= h do
          t[#t + 1] = 128 + v % 64
          v = math.floor(v / 64)
          h = 32 < h and 32 or h / 2
        end
        t[#t + 1] = 256 - 2 * h + v
        st[#st + 1] = string.char(table.unpack(t)):reverse()
      end
      return table.concat(st)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ConvUnicodeToUTF8()，错误信息：", errors)
      end
    })
  })
end

function zmm.ConvUTF8ToUnicode(utf8str, pos)
  return (nil)({
    function()
      pos = nil or 1
      local code, size = (nil or 1):byte(nil), 1
      if 192 <= code and code < 254 then
        local mask = 64
        code = code - 128
        repeat
          local next_byte = (nil):byte(nil + size) or 0
          if 128 <= next_byte and next_byte < 192 then
            code, size = (code - mask - 2) * 64 + next_byte, size + 1
          else
            code, size = (code - mask - 2) * 64 + next_byte:byte(nil), 1
          end
          mask = mask * 32
        until code < mask
      end
      return code, size
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ConvUTF8ToUnicode()，错误信息：", errors)
      end
    })
  })
end

local map_1252_to_unicode = {
  [128] = 8364,
  [129] = 129,
  [130] = 8218,
  [131] = 402,
  [132] = 8222,
  [133] = 8230,
  [134] = 8224,
  [135] = 8225,
  [136] = 710,
  [137] = 8240,
  [138] = 352,
  [139] = 8249,
  [140] = 338,
  [141] = 141,
  [142] = 381,
  [143] = 143,
  [144] = 144,
  [145] = 8216,
  [146] = 8217,
  [147] = 8220,
  [148] = 8221,
  [149] = 8226,
  [150] = 8211,
  [151] = 8212,
  [152] = 732,
  [153] = 8482,
  [154] = 353,
  [155] = 8250,
  [156] = 339,
  [157] = 157,
  [158] = 382,
  [159] = 376,
  [160] = 160,
  [161] = 161,
  [162] = 162,
  [163] = 163,
  [164] = 164,
  [165] = 165,
  [166] = 166,
  [167] = 167,
  [168] = 168,
  [169] = 169,
  [170] = 170,
  [171] = 171,
  [172] = 172,
  [173] = 173,
  [174] = 174,
  [175] = 175,
  [176] = 176,
  [177] = 177,
  [178] = 178,
  [179] = 179,
  [180] = 180,
  [181] = 181,
  [182] = 182,
  [183] = 183,
  [184] = 184,
  [185] = 185,
  [186] = 186,
  [187] = 187,
  [188] = 188,
  [189] = 189,
  [190] = 190,
  [191] = 191,
  [192] = 192,
  [193] = 193,
  [194] = 194,
  [195] = 195,
  [196] = 196,
  [197] = 197,
  [198] = 198,
  [199] = 199,
  [200] = 200,
  [201] = 201,
  [202] = 202,
  [203] = 203,
  [204] = 204,
  [205] = 205,
  [206] = 206,
  [207] = 207,
  [208] = 208,
  [209] = 209,
  [210] = 210,
  [211] = 211,
  [212] = 212,
  [213] = 213,
  [214] = 214,
  [215] = 215,
  [216] = 216,
  [217] = 217,
  [218] = 218,
  [219] = 219,
  [220] = 220,
  [221] = 221,
  [222] = 222,
  [223] = 223,
  [224] = 224,
  [225] = 225,
  [226] = 226,
  [227] = 227,
  [228] = 228,
  [229] = 229,
  [230] = 230,
  [231] = 231,
  [232] = 232,
  [233] = 233,
  [234] = 234,
  [235] = 235,
  [236] = 236,
  [237] = 237,
  [238] = 238,
  [239] = 239,
  [240] = 240,
  [241] = 241,
  [242] = 242,
  [243] = 243,
  [244] = 244,
  [245] = 245,
  [246] = 246,
  [247] = 247,
  [248] = 248,
  [249] = 249,
  [250] = 250,
  [251] = 251,
  [252] = 252,
  [253] = 253,
  [254] = 254,
  [255] = 255
}

function zmm.ConvUTF8ToCP1252(utf8str)
  return (nil)({
    function()
      local map_unicode_to_1252 = {}
      for code1252, code in pairs(nil) do
        map_unicode_to_1252[code] = code1252
      end
      local pos, result_1252 = 1, {}
      while pos <= #pairs(nil) do
        local code, size = ConvUTF8ToUnicode(nil, pos)
        pos = pos + size
        code = code < 128 and code or map_unicode_to_1252[code] or string.byte("?")
        table.insert(result_1252, string.char(code))
      end
      return table.concat(result_1252)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ConvUTF8ToCP1252()，错误信息：", errors)
      end
    })
  })
end

function zmm.ConvCP1252ToUTF8(str1252)
  return (nil)({
    function()
      local result_utf8 = {}
      for pos = 1, #nil do
        local code = (nil):byte(pos)
        str1252.table.insert(result_utf8, str1252.ConvUnicodeToUTF8(str1252[code] or code))
      end
      return str1252.table.concat(result_utf8)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ConvUTF8ToCP1252()，错误信息：", errors)
      end
    })
  })
end

function zmm.RndInitSeed(seed)
  local isok, errors = pcall(function()
    local rst = seed
    if nil then
    else
      local socket = seed.require("socket")
      local t = seed.string.format("%f", socket.gettime())
      local st = seed.string.sub(t, seed.string.find(t, "%.") + 1, -1)
      rst = seed.tonumber(seed.string.reverse(st))
    end
    seed.math.randomseed(rst)
    return rst
  end)
  if isok then
    return errors
  else
    local rst = tostring(os.time()):reverse():sub(1, 7)
    math.randomseed(rst)
    return rst
  end
end

function zmm.RndNum(m, n)
  return (nil)({
    function()
      m = m.tonumber(nil) or 0
      n = m.tonumber(nil) or 0
      local max = m.tonumber(nil) or 0
      if not (nil < (m.tonumber(nil) or 0)) or not (m.tonumber(nil) or 0) then
      end
      local min
      if not (nil < nil) or not nil then
      end
      return m.math.random(min, max)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RndNum()，错误信息：", errors)
      end
    })
  })
end

function zmm.RndPos(...)
  local args = {
    ...
  }
  return ...({
    function()
      local n = zmm.RndNum(1, #nil)
      if zmm.type(zmm[1]) == "table" then
        return {
          n - 1,
          zmm[n][1],
          zmm[n][2],
          id = n - 1,
          x = zmm[n][1],
          y = zmm[n][2]
        }
      elseif zmm.type(zmm[1]) == "number" then
        local id = zmm.math.modf(n / 2)
        if n % 2 == 0 then
          return {
            id - 1,
            zmm[n - 1],
            zmm[n],
            id = id - 1,
            x = zmm[n - 1],
            y = zmm[n]
          }
        else
          return {
            id,
            zmm[n],
            zmm[n + 1],
            id = id,
            x = zmm[n],
            y = zmm[n + 1]
          }
        end
      end
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RndPos()，错误信息：", errors)
      end
    })
  })
end

function zmm.RndArrElement(t, m, n)
  return (nil)({
    function()
      if type(nil) ~= "table" then
      end
      assert(nil, "参数1必须是数组")
      if assert == _ENV["nil"] and assert == _ENV["nil"] then
        m, n = 1, #_ENV["nil"]
      else
        m = tonumber(#_ENV["nil"])
        if tonumber(#_ENV["nil"]) == _ENV["nil"] then
          n = tonumber(#_ENV["nil"]) < #_ENV["nil"] and tonumber(#_ENV["nil"]) + 1 or #(tonumber(#_ENV["nil"]) + 1)
          m = 1
        else
          n = tonumber(#_ENV["nil"])
          m, n = math.min(#_ENV["nil"], "参数1必须是数组") + 1, math.max("参数1必须是数组", nil) + 1
          if not (1 > math.min(#_ENV["nil"], "参数1必须是数组") + 1 or math.min(#_ENV["nil"], "参数1必须是数组") + 1 > #(math.max("参数1必须是数组", nil) + 1)) or not 1 then
          end
          m = 1
          if not (1 < 1 or 1 > ##(math.max("参数1必须是数组", nil) + 1)) or not #1 then
          end
          n = #1
        end
      end
      return _ENV[RndNum(##(math.max("参数1必须是数组", nil) + 1), "参数1必须是数组")]
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RndArrElement()，错误信息：", errors)
      end
    })
  })
end

function zmm.RndUniqueArr(t, m, n)
  return (nil)({
    function()
      if type(nil) ~= "table" then
        local min = type(nil)
        if not (nil > type(nil)) or not type(nil) then
        end
        local max
        if not (nil < nil) or not nil then
        end
        t = {}
        for i = min, max do
          table.insert(nil, i)
        end
      else
        n = type(nil)
      end
      local s, tt = {}, Clone(min)
      local i = _ENV
      if not ((max or #tt) >= #tt) or not #tt then
      end
      n = #tt
      while #tt > #s do
        i = math.random(#tt)
        table.insert(s, tt[i])
        table.remove(tt, i)
      end
      return s
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RndUniqueArr()，错误信息：", errors)
      end
    })
  })
end

function zmm.RndStr(n, mode, isNoRepeat)
  return (nil)({
    function()
      local t, tt = {}, {}
      n = nil or 1
      mode = nil or 1 or 7
      local m = n.string.sub("0000" .. n.ConvBase(nil, 10, 2), -4, -1)
      if n.string.sub(m, 1, 1) == "1" then
        local s = "!#$%&()*+,-./:;<=>?@[\\]\"^_`{|}~'"
        for i = 1, #s do
          n.table.insert(t, n.string.sub(s, i, i))
        end
      end
      if n.string.sub(m, 2, 2) == "1" then
        for i = 65, 90 do
          n.table.insert(t, n.string.char(i))
        end
      end
      if n.string.sub(m, 3, 3) == "1" then
        for i = 97, 122 do
          n.table.insert(t, n.string.char(i))
        end
      end
      if n.string.sub(m, 4, 4) == "1" then
        for i = 0, 9 do
          n.table.insert(t, n.tostring(i))
        end
      end
      if 0 then
        tt = n.RndUniqueArr(t, 1)
      else
        for _ = 1, t do
          n.table.insert(tt, n.RndArrElement(t))
        end
      end
      return n.table.concat(tt)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RndStr()，错误信息：", errors)
      end
    })
  })
end

function zmm.RndName(gender)
  return (nil)({
    function()
      local FirstNameArr = {
        "赵",
        "钱",
        "孙",
        "李",
        "周",
        "吴",
        "郑",
        "王",
        "冯",
        "陈",
        "楮",
        "卫",
        "蒋",
        "沈",
        "韩",
        "杨",
        "朱",
        "秦",
        "尤",
        "许",
        "何",
        "吕",
        "施",
        "张",
        "孔",
        "曹",
        "严",
        "华",
        "金",
        "魏",
        "陶",
        "姜",
        "戚",
        "谢",
        "邹",
        "喻",
        "柏",
        "水",
        "窦",
        "章",
        "云",
        "苏",
        "潘",
        "葛",
        "奚",
        "范",
        "彭",
        "郎",
        "鲁",
        "韦",
        "昌",
        "马",
        "苗",
        "凤",
        "花",
        "方",
        "俞",
        "任",
        "袁",
        "柳",
        "酆",
        "鲍",
        "史",
        "唐",
        "费",
        "廉",
        "岑",
        "薛",
        "雷",
        "贺",
        "倪",
        "汤",
        "滕",
        "殷",
        "罗",
        "毕",
        "郝",
        "邬",
        "安",
        "常",
        "乐",
        "于",
        "时",
        "傅",
        "皮",
        "卞",
        "齐",
        "康",
        "伍",
        "余",
        "元",
        "卜",
        "顾",
        "孟",
        "平",
        "黄",
        "和",
        "穆",
        "萧",
        "尹",
        "姚",
        "邵",
        "湛",
        "汪",
        "祁",
        "毛",
        "禹",
        "狄",
        "米",
        "贝",
        "明",
        "臧",
        "计",
        "伏",
        "成",
        "戴",
        "谈",
        "宋",
        "茅",
        "庞",
        "熊",
        "纪",
        "舒",
        "屈",
        "项",
        "祝",
        "董",
        "梁",
        "杜",
        "阮",
        "蓝",
        "闽",
        "席",
        "季",
        "麻",
        "强",
        "贾",
        "路",
        "娄",
        "危",
        "江",
        "童",
        "颜",
        "郭",
        "梅",
        "盛",
        "林",
        "刁",
        "锺",
        "徐",
        "丘",
        "骆",
        "高",
        "夏",
        "蔡",
        "田",
        "樊",
        "胡",
        "凌",
        "霍",
        "虞",
        "万",
        "支",
        "柯",
        "昝",
        "管",
        "卢",
        "莫",
        "经",
        "房",
        "裘",
        "缪",
        "干",
        "解",
        "应",
        "宗",
        "丁",
        "宣",
        "贲",
        "邓",
        "郁",
        "单",
        "杭",
        "洪",
        "包",
        "诸",
        "左",
        "石",
        "崔",
        "吉",
        "钮",
        "龚",
        "程",
        "嵇",
        "邢",
        "滑",
        "裴",
        "陆",
        "荣",
        "翁",
        "荀",
        "羊",
        "於",
        "惠",
        "甄",
        "麹",
        "家",
        "封",
        "芮",
        "羿",
        "储",
        "靳",
        "汲",
        "邴",
        "糜",
        "松",
        "井",
        "段",
        "富",
        "巫",
        "乌",
        "焦",
        "巴",
        "弓",
        "牧",
        "隗",
        "山",
        "谷",
        "车",
        "侯",
        "宓",
        "蓬",
        "全",
        "郗",
        "班",
        "仰",
        "秋",
        "仲",
        "伊",
        "宫",
        "宁",
        "仇",
        "栾",
        "暴",
        "甘",
        "斜",
        "厉",
        "戎",
        "祖",
        "武",
        "符",
        "刘",
        "景",
        "詹",
        "束",
        "龙",
        "叶",
        "幸",
        "司",
        "韶",
        "郜",
        "黎",
        "蓟",
        "薄",
        "印",
        "宿",
        "白",
        "怀",
        "蒲",
        "邰",
        "从",
        "鄂",
        "索",
        "咸",
        "籍",
        "赖",
        "卓",
        "蔺",
        "屠",
        "蒙",
        "池",
        "乔",
        "阴",
        "郁",
        "胥",
        "能",
        "苍",
        "双",
        "闻",
        "莘",
        "党",
        "翟",
        "谭",
        "贡",
        "劳",
        "逄",
        "姬",
        "申",
        "扶",
        "堵",
        "冉",
        "宰",
        "郦",
        "雍",
        "郤",
        "璩",
        "桑",
        "桂",
        "濮",
        "牛",
        "寿",
        "通",
        "边",
        "扈",
        "燕",
        "冀",
        "郏",
        "浦",
        "尚",
        "农",
        "温",
        "别",
        "庄",
        "晏",
        "柴",
        "瞿",
        "阎",
        "充",
        "慕",
        "连",
        "茹",
        "习",
        "宦",
        "艾",
        "鱼",
        "容",
        "向",
        "古",
        "易",
        "慎",
        "戈",
        "廖",
        "庾",
        "终",
        "暨",
        "居",
        "衡",
        "步",
        "都",
        "耿",
        "满",
        "弘",
        "匡",
        "国",
        "文",
        "寇",
        "广",
        "禄",
        "阙",
        "东",
        "欧",
        "殳",
        "沃",
        "利",
        "蔚",
        "越",
        "夔",
        "隆",
        "师",
        "巩",
        "厍",
        "聂",
        "晁",
        "勾",
        "敖",
        "融",
        "冷",
        "訾",
        "辛",
        "阚",
        "那",
        "简",
        "饶",
        "空",
        "曾",
        "毋",
        "沙",
        "乜",
        "养",
        "鞠",
        "须",
        "丰",
        "巢",
        "关",
        "蒯",
        "相",
        "查",
        "后",
        "荆",
        "红",
        "游",
        "竺",
        "权",
        "逑",
        "盖",
        "益",
        "桓",
        "公",
        "万俟",
        "司马",
        "上官",
        "欧阳",
        "夏侯",
        "诸葛",
        "闻人",
        "东方",
        "赫连",
        "皇甫",
        "尉迟",
        "公羊",
        "澹台",
        "公冶",
        "宗政",
        "濮阳",
        "淳于",
        "单于",
        "太叔",
        "申屠",
        "公孙",
        "仲孙",
        "轩辕",
        "令狐",
        "锺离",
        "宇文",
        "长孙",
        "慕容",
        "鲜于",
        "闾丘",
        "司徒",
        "司空",
        "丌官",
        "司寇",
        "仉",
        "督",
        "子车",
        "颛孙",
        "端木",
        "巫马",
        "公西",
        "漆雕",
        "乐正",
        "壤驷",
        "公良",
        "拓拔",
        "夹谷",
        "宰父",
        "谷梁",
        "晋",
        "楚",
        "阎",
        "法",
        "汝",
        "鄢",
        "涂",
        "钦",
        "段干",
        "百里",
        "东郭",
        "南门",
        "呼延",
        "归",
        "海",
        "羊舌",
        "微生",
        "岳",
        "帅",
        "缑",
        "亢",
        "况",
        "后",
        "有",
        "琴",
        "梁丘",
        "左丘",
        "东门",
        "西门",
        "商",
        "牟",
        "佘",
        "佴",
        "伯",
        "赏",
        "南宫",
        "墨",
        "哈",
        "谯",
        "笪",
        "年",
        "爱",
        "阳",
        "佟",
        "第五",
        "言",
        "福"
      }
      local MaleArr = {
        "君豪",
        "哲宇",
        "承钰",
        "承熙",
        "翰辰",
        "少杰",
        "天泽",
        "毅康",
        "俊杰",
        "凌豪",
        "岱熹",
        "希伦",
        "亭旭",
        "明曜",
        "禹杰",
        "梓轩",
        "昊宇",
        "辰熙",
        "梓泽",
        "昀锦",
        "奕嘉",
        "烁宇",
        "嘉铭",
        "广翰",
        "渝皓",
        "梓超",
        "翊翰",
        "徍烨",
        "杭骏",
        "智豪",
        "梓豪",
        "嘉豪",
        "熙钦",
        "泽毅",
        "硕杰",
        "翌熙",
        "炜堃",
        "诗崧",
        "昀昕",
        "元翰",
        "哲晗",
        "锦浩",
        "宇涵",
        "嘉昱",
        "子颢",
        "宇轩",
        "豪哲",
        "昊晗",
        "翰宇",
        "哲豪",
        "锦博",
        "锦灏",
        "宇杰",
        "文韬",
        "哲帆",
        "睿颖",
        "云恺",
        "灏轩",
        "思哲",
        "乐诚",
        "梓丞",
        "奕骁",
        "宇宸",
        "熙祥",
        "郅仑",
        "梓轩",
        "维翰",
        "嘉伟",
        "宇博",
        "大维",
        "梓明",
        "熙哲",
        "锦诚",
        "昊轩",
        "梓昕",
        "冠声",
        "梓林",
        "宝琛",
        "煜恒",
        "浩翔",
        "子晋",
        "毅诚",
        "奕恺",
        "天毅",
        "梓扬",
        "展豪",
        "昕哲",
        "博晗",
        "镇熙",
        "昊銘",
        "景豪",
        "仲轩",
        "梓谦",
        "宇翔",
        "浩行",
        "辰屹",
        "睿康",
        "昕哲",
        "子昂",
        "恺宇",
        "腾宇",
        "浩洋",
        "恺源",
        "天睿",
        "翌宸",
        "逸歆",
        "文琛",
        "智翔",
        "辰屹",
        "书宇",
        "逸天",
        "思睿",
        "奕哲",
        "辰恺",
        "闻涛",
        "子羽",
        "皓昇",
        "闻启",
        "宇瀚",
        "鼎恒",
        "嘉平",
        "彦川",
        "峥琪",
        "智行",
        "宇宸",
        "博涵",
        "杰恺",
        "闻韬",
        "圣祺",
        "梓恒",
        "智涵",
        "云帆",
        "灏宁",
        "奕辉",
        "凯扬",
        "文轩",
        "佳航",
        "天宇",
        "智权",
        "涵宇",
        "鑫哲",
        "涵韬",
        "嘉辉",
        "晨韬",
        "沁宇",
        "浩聪",
        "哲峰",
        "承俊",
        "鸿阳",
        "锦硕",
        "昱尧",
        "一鸣",
        "奕辰",
        "思宇",
        "嘉聪",
        "严涵",
        "文杰",
        "易鑫",
        "明琪",
        "逸航",
        "翌晨",
        "剑豪",
        "彦昕",
        "佳奕",
        "翔宇",
        "浩天",
        "承昊",
        "逸枫",
        "宇航",
        "宁悦",
        "玮杰",
        "骏杰",
        "哲涵",
        "恩硕",
        "亦瑄",
        "昊明",
        "佳毅",
        "缪瑄",
        "屹恒",
        "睿恒",
        "熠恒",
        "文烨",
        "添奕",
        "浩伦",
        "昊天",
        "曦宇",
        "子恒",
        "浩轩",
        "承辉",
        "明煜",
        "屹昕",
        "灏哲",
        "瑞聪",
        "嘉成",
        "睿哲",
        "铭鸿",
        "博怀",
        "博恺",
        "锦添",
        "鑫程",
        "昊泽",
        "晗瑜",
        "佳树",
        "浩然",
        "嘉临",
        "佳铭",
        "鼎宸",
        "博琛",
        "宇翱",
        "铭熙",
        "奕陶",
        "青云",
        "熙雨",
        "岳轩",
        "英赫",
        "盈叡",
        "卓瑄",
        "奕轩",
        "昕辰",
        "轩宇",
        "宇欣",
        "天奕",
        "宇赫",
        "皓涵",
        "成骢",
        "冰卓",
        "宇哲",
        "欣宇",
        "楚晗",
        "天琦",
        "瀚雄",
        "佳楠",
        "卓瀚",
        "誉乾",
        "羿凡",
        "泽昊",
        "昕宇",
        "潇洋",
        "嘉纯",
        "煜华",
        "琦硕",
        "俊乔",
        "俊言",
        "皓天",
        "麒暄",
        "乔哲",
        "嘉旭",
        "钰坤",
        "凡琪",
        "少祺",
        "宇昂",
        "珈睿",
        "泽晗",
        "彦鑫",
        "欣哲",
        "皓麒",
        "易灿",
        "昊南",
        "佳逸",
        "潇汉",
        "天翔",
        "佳翌",
        "佳玮",
        "潇阳",
        "承毓",
        "言恺",
        "嘉舟",
        "佑琪",
        "亦扬",
        "健坤",
        "哲睿",
        "伊铭",
        "皓楠",
        "煜哲",
        "嘉琛",
        "毅恒",
        "之麟",
        "晨昱",
        "嘉润",
        "宾鑫",
        "梓涵",
        "鑫烨",
        "铭恩",
        "睿麟",
        "彦伟",
        "景宸",
        "天麒",
        "沐阳",
        "奕可",
        "昱铭",
        "初微",
        "智钧",
        "祺敏",
        "佳轩",
        "宸铭",
        "卓玮",
        "佳皓",
        "羿臻",
        "梓晔",
        "歆昱",
        "祎博",
        "天瑜",
        "睿晗",
        "怡葳",
        "屹伦",
        "瀚文",
        "嘉鑫",
        "煜奇",
        "浩敏",
        "君涵",
        "宏宇",
        "若昕",
        "博雅",
        "行易",
        "佳栋",
        "舒阳",
        "欣奇",
        "天佑",
        "子程",
        "云宇",
        "梓暄",
        "珂贤",
        "煜烜",
        "易凡",
        "丰伟",
        "朝辉",
        "子俊",
        "正屹",
        "青阳",
        "宇诚",
        "宇豪",
        "昱哲",
        "臻宇",
        "夏宇",
        "紫霖",
        "天翊",
        "子岩",
        "天辰",
        "祎敏",
        "志成",
        "铭翔",
        "煜豪",
        "晨豪",
        "晨阳",
        "天浩",
        "怡辰",
        "雨昕",
        "曈欣",
        "衍杰",
        "思晨",
        "宏杰",
        "祎欣",
        "宇阳",
        "俊哲",
        "哲怡",
        "瑾祎",
        "宇帆",
        "正扬",
        "慕飞",
        "梓成",
        "仁浩",
        "家璐",
        "梓言",
        "诚熠",
        "铭皓",
        "舟宁",
        "伟杰",
        "泽阳",
        "晨祥",
        "羿青",
        "天易",
        "浩泽",
        "乐晨",
        "金豪",
        "天意",
        "杨奕",
        "子炜",
        "艺渊",
        "天一",
        "思昊",
        "昕远",
        "梓俊",
        "宸溪",
        "炜豪",
        "诗鸣",
        "钰航",
        "耀楠",
        "熠昊",
        "昱欣",
        "宸逸",
        "奕晨",
        "佳豪",
        "宇韬",
        "启铭",
        "宇辰",
        "世琪",
        "旻辉",
        "骏哲",
        "烨恒",
        "晨希",
        "奕凡",
        "嘉毅",
        "仕炜",
        "仕泓",
        "彦轩",
        "天宸",
        "益帆",
        "毅伟",
        "加易",
        "弘烨",
        "梓阳",
        "语彦",
        "星楠",
        "天博",
        "宸俞",
        "嘉伊",
        "诗喻",
        "浩枫",
        "宏昇",
        "旖烨",
        "嘉文",
        "颢铭",
        "紫杰",
        "怡聪",
        "浩峰",
        "佳俊",
        "辰煜",
        "奕旻",
        "峥玮",
        "炜霆",
        "子晗",
        "晨佳",
        "佩琪",
        "唯诣",
        "奕葳",
        "诗奕",
        "煜聪",
        "皓晖",
        "屹晨",
        "明远",
        "睿扬",
        "思杰",
        "奕聪",
        "佳骏",
        "铭欣",
        "晨星",
        "怡青",
        "俊寒",
        "舒翔",
        "闻哲",
        "俊袆",
        "睿熙",
        "世祺",
        "逸杰",
        "煜琪",
        "弘洋",
        "珺熠",
        "钰杰",
        "子寒",
        "书弈",
        "铭扬",
        "家奕",
        "睿健",
        "俊祎",
        "奕诚",
        "嘉煜",
        "晨翊",
        "行健",
        "奕佳",
        "燕楠",
        "澄浩",
        "宇乐",
        "仕翔",
        "昱诚",
        "奕琛",
        "海韬",
        "晔豪",
        "智淳",
        "昊铭",
        "熠晨",
        "成卓",
        "晟勋",
        "暄毅",
        "梓珏",
        "明烨",
        "驭涵",
        "诚炜",
        "凯杰",
        "昱文",
        "智健",
        "腾辉",
        "鑫海",
        "卓钰",
        "钰佳",
        "炜成",
        "鑫伟",
        "玮程",
        "毅峰",
        "宸毅",
        "鸣洋",
        "敏诚",
        "羿涵",
        "晨熠",
        "璟航",
        "奕隆",
        "诗玮",
        "烨铭",
        "嘉议",
        "志玮",
        "佳诚",
        "鸿诚",
        "懿帆",
        "奕玮",
        "智楷",
        "梓炜",
        "鑫璐",
        "奕腾",
        "羿飞",
        "文翰",
        "晨羿",
        "书瑾",
        "旻宇",
        "俊翊",
        "奕凯",
        "欣睿",
        "志宏",
        "嘉葳",
        "佩文",
        "昀轩",
        "硕成",
        "崇德",
        "佑哲",
        "孟哲",
        "诗淳",
        "焯涵",
        "志鸿",
        "楷峰",
        "彦成",
        "郁宏",
        "郁昇",
        "哲玮",
        "凯钧",
        "佑隆",
        "嘉容",
        "旻桦",
        "思咏",
        "峻纬",
        "昱彰",
        "峻贤",
        "嘉翔",
        "英翔",
        "俊曜",
        "嘉伦",
        "旻轩",
        "昱颖",
        "梓忆",
        "益昇",
        "彦锋",
        "钰翔",
        "奕翔",
        "卓谦",
        "玮伦",
        "卓峰",
        "泓伟",
        "子渊",
        "铭烨",
        "子巍",
        "鑫侃",
        "文凯",
        "哲晨",
        "嘉雨",
        "鑫彤",
        "昱阳",
        "晨皓",
        "诗灏",
        "青筠",
        "安邦",
        "安福",
        "安歌",
        "安国",
        "安和",
        "安康",
        "安澜",
        "安民",
        "安宁",
        "安平",
        "安然",
        "安顺",
        "安翔",
        "安晏",
        "安宜",
        "安怡",
        "安易",
        "安志",
        "昂然",
        "昂雄",
        "宾白",
        "宾鸿",
        "宾实",
        "彬彬",
        "彬炳",
        "彬郁",
        "斌斌",
        "斌蔚",
        "滨海",
        "波光",
        "波鸿",
        "波峻",
        "波涛",
        "博瀚",
        "博超",
        "博达",
        "博厚",
        "博简",
        "博明",
        "博容",
        "博赡",
        "博涉",
        "博实",
        "博涛",
        "博文",
        "博学",
        "博雅",
        "博延",
        "博艺",
        "博易",
        "博远",
        "才捷",
        "才良",
        "才艺",
        "才英",
        "才哲",
        "才俊",
        "成和",
        "成弘",
        "成化",
        "成济",
        "成礼",
        "成龙",
        "成仁",
        "成双",
        "成天",
        "成文",
        "成业",
        "成益",
        "成荫",
        "成周",
        "承安",
        "承弼",
        "承德",
        "承恩",
        "承福",
        "承基",
        "承教",
        "承平",
        "承嗣",
        "承天",
        "承望",
        "承宣",
        "承颜",
        "承业",
        "承悦",
        "承允",
        "承运",
        "承载",
        "承泽",
        "承志",
        "德本",
        "德海",
        "德厚",
        "德华",
        "德辉",
        "德惠",
        "德容",
        "德润",
        "德寿",
        "德水",
        "德馨",
        "德曜",
        "德业",
        "德义",
        "德庸",
        "德佑",
        "德宇",
        "德元",
        "德运",
        "德泽",
        "德明",
        "飞昂",
        "飞白",
        "飞飙",
        "飞掣",
        "飞尘",
        "飞沉",
        "飞驰",
        "飞光",
        "飞翰",
        "飞航",
        "飞翮",
        "飞鸿",
        "飞虎",
        "飞捷",
        "飞龙",
        "飞鸾",
        "飞鸣",
        "飞鹏",
        "飞扬",
        "飞文",
        "飞翔",
        "飞星",
        "飞翼",
        "飞英",
        "飞宇",
        "飞羽",
        "飞雨",
        "飞语",
        "飞跃",
        "飞章",
        "飞舟",
        "风华",
        "丰茂",
        "丰羽",
        "刚豪",
        "刚洁",
        "刚捷",
        "刚毅",
        "高昂",
        "高岑",
        "高畅",
        "高超",
        "高驰",
        "高达",
        "高澹",
        "高飞",
        "高芬",
        "高峯",
        "高峰",
        "高歌",
        "高格",
        "高寒",
        "高翰",
        "高杰",
        "高洁",
        "高峻",
        "高朗",
        "高丽",
        "高邈",
        "高旻",
        "高明",
        "高爽",
        "高兴",
        "高轩",
        "高雅",
        "高扬",
        "高阳",
        "高义",
        "高谊",
        "高逸",
        "高懿",
        "高原",
        "高远",
        "高韵",
        "高卓",
        "光赫",
        "光华",
        "光辉",
        "光济",
        "光霁",
        "光亮",
        "光临",
        "光明",
        "光启",
        "光熙",
        "光耀",
        "光誉",
        "光远",
        "国安",
        "国兴",
        "国源",
        "冠宇",
        "冠玉",
        "晗昱",
        "晗日",
        "涵畅",
        "涵涤",
        "涵亮",
        "涵忍",
        "涵容",
        "涵润",
        "涵涵",
        "涵煦",
        "涵蓄",
        "涵衍",
        "涵意",
        "涵映",
        "涵育",
        "翰采",
        "翰池",
        "翰飞",
        "翰海",
        "翰翮",
        "翰林",
        "翰学",
        "翰音",
        "瀚玥",
        "翰藻",
        "瀚海",
        "瀚漠",
        "昊苍",
        "昊昊",
        "昊空",
        "昊乾",
        "昊穹",
        "昊然",
        "昊天",
        "昊焱",
        "昊英",
        "浩波",
        "浩初",
        "浩大",
        "浩宕",
        "浩荡",
        "浩歌",
        "浩广",
        "浩涆",
        "浩瀚",
        "浩浩",
        "浩慨",
        "浩旷",
        "浩阔",
        "浩漫",
        "浩淼",
        "浩渺",
        "浩邈",
        "浩气",
        "浩然",
        "浩穰",
        "浩壤",
        "浩思",
        "浩言",
        "和蔼",
        "和安",
        "和璧",
        "和昶",
        "和风",
        "和歌",
        "和光",
        "和平",
        "和洽",
        "和惬",
        "和顺",
        "和硕",
        "和颂",
        "和泰",
        "和悌",
        "和通",
        "和同",
        "和煦",
        "和雅",
        "和宜",
        "和怡",
        "和玉",
        "和裕",
        "和豫",
        "和悦",
        "和韵",
        "和泽",
        "和正",
        "和志",
        "鹤轩",
        "弘博",
        "弘大",
        "弘方",
        "弘光",
        "弘和",
        "弘厚",
        "弘化",
        "弘济",
        "弘阔",
        "弘亮",
        "弘量",
        "弘深",
        "弘盛",
        "弘图",
        "弘伟",
        "弘文",
        "弘新",
        "弘雅",
        "弘扬",
        "弘业",
        "弘义",
        "弘益",
        "弘毅",
        "弘懿",
        "弘致",
        "弘壮",
        "宏伯",
        "宏博",
        "宏才",
        "宏畅",
        "宏达",
        "宏大",
        "宏放",
        "宏富",
        "宏峻",
        "宏浚",
        "宏恺",
        "宏旷",
        "宏阔",
        "宏朗",
        "宏茂",
        "宏邈",
        "宏儒",
        "宏深",
        "宏胜",
        "宏盛",
        "宏爽",
        "宏硕",
        "宏伟",
        "宏扬",
        "宏义",
        "宏逸",
        "宏毅",
        "宏远",
        "宏壮",
        "鸿宝",
        "鸿波",
        "鸿博",
        "鸿才",
        "鸿彩",
        "鸿畅",
        "鸿畴",
        "鸿达",
        "鸿德",
        "鸿飞",
        "鸿风",
        "鸿福",
        "鸿光",
        "鸿晖",
        "鸿朗",
        "鸿文",
        "鸿熙",
        "鸿羲",
        "鸿禧",
        "鸿信",
        "鸿轩",
        "鸿煊",
        "鸿煊",
        "鸿雪",
        "鸿羽",
        "鸿远",
        "鸿云",
        "鸿运",
        "鸿哲",
        "鸿祯",
        "鸿振",
        "鸿志",
        "鸿卓",
        "华奥",
        "华采",
        "华彩",
        "华灿",
        "华藏",
        "华池",
        "华翰",
        "华皓",
        "华晖",
        "华辉",
        "华茂",
        "华美",
        "华清",
        "华荣",
        "华容",
        "嘉赐",
        "嘉德",
        "嘉福",
        "嘉良",
        "嘉茂",
        "嘉木",
        "嘉慕",
        "嘉纳",
        "嘉年",
        "嘉平",
        "嘉庆",
        "嘉荣",
        "嘉容",
        "嘉瑞",
        "嘉胜",
        "嘉石",
        "嘉实",
        "嘉树",
        "嘉澍",
        "嘉熙",
        "嘉禧",
        "嘉祥",
        "嘉歆",
        "嘉许",
        "嘉勋",
        "嘉言",
        "嘉谊",
        "嘉懿",
        "嘉颖",
        "嘉佑",
        "嘉玉",
        "嘉誉",
        "嘉悦",
        "嘉运",
        "嘉泽",
        "嘉珍",
        "嘉祯",
        "嘉志",
        "嘉致",
        "坚白",
        "坚壁",
        "坚秉",
        "坚成",
        "坚诚",
        "建安",
        "建白",
        "建柏",
        "建本",
        "建弼",
        "建德",
        "建华",
        "建明",
        "建茗",
        "建木",
        "建树",
        "建同",
        "建修",
        "建业",
        "建义",
        "建元",
        "建章",
        "建中",
        "健柏",
        "金鑫",
        "锦程",
        "瑾瑜",
        "晋鹏",
        "经赋",
        "经亘",
        "经国",
        "经略",
        "经纶",
        "经天",
        "经武",
        "经业",
        "经义",
        "经艺",
        "景澄",
        "景福",
        "景焕",
        "景辉",
        "景辉",
        "景龙",
        "景明",
        "景山",
        "景胜",
        "景铄",
        "景天",
        "景同",
        "景曜",
        "靖琪",
        "君昊",
        "君浩",
        "俊艾",
        "俊拔",
        "俊弼",
        "俊才",
        "俊驰",
        "俊楚",
        "俊达",
        "俊德",
        "俊发",
        "俊风",
        "俊豪",
        "俊健",
        "俊杰",
        "俊捷",
        "俊郎",
        "俊力",
        "俊良",
        "俊迈",
        "俊茂",
        "俊美",
        "俊民",
        "俊名",
        "俊明",
        "俊楠",
        "俊能",
        "俊人",
        "俊爽",
        "俊悟",
        "俊晤",
        "俊侠",
        "俊雄",
        "俊逸",
        "俊英",
        "俊友",
        "俊语",
        "俊誉",
        "俊远",
        "俊哲",
        "俊喆",
        "俊智",
        "峻熙",
        "季萌",
        "季同",
        "开畅",
        "开诚",
        "开宇",
        "开济",
        "开霁",
        "开朗",
        "凯安",
        "凯唱",
        "凯定",
        "凯风",
        "凯复",
        "凯歌",
        "凯捷",
        "凯凯",
        "凯康",
        "凯乐",
        "凯旋",
        "凯泽",
        "恺歌",
        "恺乐",
        "康安",
        "康伯",
        "康成",
        "康德",
        "康复",
        "康健",
        "康乐",
        "康宁",
        "康平",
        "康胜",
        "康盛",
        "康时",
        "康适",
        "康顺",
        "康泰",
        "康裕",
        "乐安",
        "乐邦",
        "乐成",
        "乐池",
        "乐和",
        "乐家",
        "乐康",
        "乐人",
        "乐容",
        "乐山",
        "乐圣",
        "乐水",
        "乐天",
        "乐童",
        "乐贤",
        "乐心",
        "乐欣",
        "乐逸",
        "乐意",
        "乐音",
        "乐咏",
        "乐游",
        "乐语",
        "乐悦",
        "乐湛",
        "乐章",
        "黎昕",
        "黎明",
        "力夫",
        "力强",
        "力勤",
        "力行",
        "力学",
        "力言",
        "立诚",
        "立果",
        "立人",
        "立辉",
        "立轩",
        "立群",
        "良奥",
        "良弼",
        "良才",
        "良材",
        "良策",
        "良畴",
        "良工",
        "良翰",
        "良吉",
        "良骥",
        "良俊",
        "良骏",
        "良朋",
        "良平",
        "良哲",
        "理群",
        "理全",
        "茂才",
        "茂材",
        "茂德",
        "茂典",
        "茂实",
        "茂学",
        "茂勋",
        "茂彦",
        "敏博",
        "敏才",
        "敏达",
        "敏叡",
        "敏学",
        "敏智",
        "明诚",
        "明达",
        "明德",
        "明辉",
        "明杰",
        "明俊",
        "明朗",
        "明亮",
        "明旭",
        "明煦",
        "明轩",
        "明远",
        "明哲",
        "明喆",
        "明知",
        "明志",
        "明智",
        "明珠",
        "朋兴",
        "朋义",
        "彭勃",
        "彭薄",
        "彭湃",
        "彭彭",
        "彭魄",
        "彭越",
        "彭泽",
        "彭祖",
        "鹏池",
        "鹏飞",
        "鹏赋",
        "鹏海",
        "鹏鲸",
        "鹏举",
        "鹏鹍",
        "鹏鲲",
        "鹏涛",
        "鹏天",
        "鹏翼",
        "鹏云",
        "鹏运",
        "濮存",
        "溥心",
        "璞玉",
        "璞瑜",
        "浦和",
        "浦泽",
        "奇略",
        "奇迈",
        "奇胜",
        "奇水",
        "奇思",
        "奇邃",
        "奇伟",
        "奇玮",
        "奇文",
        "奇希",
        "奇逸",
        "奇正",
        "奇志",
        "奇致",
        "祺福",
        "祺然",
        "祺祥",
        "祺瑞",
        "琪睿",
        "庆生",
        "荣轩",
        "锐达",
        "锐锋",
        "锐翰",
        "锐进",
        "锐精",
        "锐立",
        "锐利",
        "锐思",
        "锐逸",
        "锐意",
        "锐藻",
        "锐泽",
        "锐阵",
        "锐志",
        "锐智",
        "睿才",
        "睿诚",
        "睿慈",
        "睿聪",
        "睿达",
        "睿德",
        "睿范",
        "睿广",
        "睿好",
        "睿明",
        "睿识",
        "睿思",
        "绍辉",
        "绍钧",
        "绍祺",
        "绍元",
        "升荣",
        "圣杰",
        "晟睿",
        "思聪",
        "思淼",
        "思源",
        "思远",
        "思博",
        "斯年",
        "斯伯",
        "泰初",
        "泰和",
        "泰河",
        "泰鸿",
        "泰华",
        "泰宁",
        "泰平",
        "泰清",
        "泰然",
        "天材",
        "天成",
        "天赋",
        "天干",
        "天罡",
        "天工",
        "天翰",
        "天和",
        "天华",
        "天骄",
        "天空",
        "天禄",
        "天路",
        "天瑞",
        "天睿",
        "天逸",
        "天佑",
        "天宇",
        "天元",
        "天韵",
        "天泽",
        "天纵",
        "同方",
        "同甫",
        "同光",
        "同和",
        "同化",
        "同济",
        "巍昂",
        "巍然",
        "巍奕",
        "伟博",
        "伟毅",
        "伟才",
        "伟诚",
        "伟茂",
        "伟懋",
        "伟祺",
        "伟彦",
        "伟晔",
        "伟泽",
        "伟兆",
        "伟志",
        "温纶",
        "温茂",
        "温书",
        "温韦",
        "温文",
        "温瑜",
        "文柏",
        "文昌",
        "文成",
        "文德",
        "文栋",
        "文赋",
        "文光",
        "文翰",
        "文虹",
        "文华",
        "文康",
        "文乐",
        "文林",
        "文敏",
        "文瑞",
        "文山",
        "文石",
        "文星",
        "文轩",
        "文宣",
        "文彦",
        "文曜",
        "文耀",
        "文斌",
        "文彬",
        "文滨",
        "向晨",
        "向笛",
        "向文",
        "向明",
        "向荣",
        "向阳",
        "翔宇",
        "翔飞",
        "项禹",
        "项明",
        "晓博",
        "心水",
        "心思",
        "心远",
        "欣德",
        "欣嘉",
        "欣可",
        "欣然",
        "欣荣",
        "欣怡",
        "欣怿",
        "欣悦",
        "新翰",
        "新霁",
        "新觉",
        "新立",
        "新荣",
        "新知",
        "信鸿",
        "信厚",
        "信鸥",
        "信然",
        "信瑞",
        "兴安",
        "兴邦",
        "兴昌",
        "兴朝",
        "兴德",
        "兴发",
        "兴国",
        "兴怀",
        "兴平",
        "兴庆",
        "兴生",
        "兴思",
        "兴腾",
        "兴旺",
        "兴为",
        "兴文",
        "兴贤",
        "兴修",
        "兴学",
        "兴言",
        "兴业",
        "兴运",
        "星波",
        "星辰",
        "星驰",
        "星光",
        "星海",
        "星汉",
        "星河",
        "星华",
        "星晖",
        "星火",
        "星剑",
        "星津",
        "星阑",
        "星纬",
        "星文",
        "星宇",
        "星雨",
        "星渊",
        "星洲",
        "修诚",
        "修德",
        "修杰",
        "修洁",
        "修谨",
        "修筠",
        "修明",
        "修能",
        "修平",
        "修然",
        "修为",
        "修伟",
        "修文",
        "修雅",
        "修永",
        "修远",
        "修真",
        "修竹",
        "旭尧",
        "炫明",
        "学博",
        "学海",
        "学林",
        "学民",
        "学名",
        "学文",
        "学义",
        "学真",
        "雪松",
        "雪峰",
        "雪风",
        "雅昶",
        "雅畅",
        "雅达",
        "雅惠",
        "雅健",
        "雅珺",
        "雅逸",
        "雅懿",
        "雅志",
        "炎彬",
        "阳飙",
        "阳飇",
        "阳冰",
        "阳波",
        "阳伯",
        "阳成",
        "阳德",
        "阳华",
        "阳晖",
        "阳辉",
        "阳嘉",
        "阳平",
        "阳秋",
        "阳荣",
        "阳舒",
        "阳朔",
        "阳文",
        "阳曦",
        "阳夏",
        "阳旭",
        "阳煦",
        "阳炎",
        "阳焱",
        "阳曜",
        "阳羽",
        "阳云",
        "阳泽",
        "阳州",
        "烨赫",
        "烨华",
        "烨磊",
        "烨霖",
        "烨然",
        "烨烁",
        "烨伟",
        "烨烨",
        "烨熠",
        "烨煜",
        "毅然",
        "逸仙",
        "逸明",
        "逸春",
        "宜春",
        "宜民",
        "宜年",
        "宜然",
        "宜人",
        "宜修",
        "意远",
        "意蕴",
        "意致",
        "意智",
        "熠彤",
        "英飙",
        "英博",
        "英才",
        "英达",
        "英发",
        "英范",
        "英光",
        "英豪",
        "英华",
        "英杰",
        "英朗",
        "英锐",
        "英睿",
        "英叡",
        "英韶",
        "英卫",
        "英武",
        "英悟",
        "英勋",
        "英彦",
        "英耀",
        "英奕",
        "英逸",
        "英毅",
        "英哲",
        "英喆",
        "英卓",
        "英资",
        "英纵",
        "永怡",
        "永春",
        "永安",
        "永昌",
        "永长",
        "永丰",
        "永福",
        "永嘉",
        "永康",
        "永年",
        "永宁",
        "永寿",
        "永思",
        "永望",
        "永新",
        "永言",
        "永逸",
        "永元",
        "永贞",
        "咏德",
        "咏歌",
        "咏思",
        "咏志",
        "勇男",
        "勇军",
        "勇捷",
        "勇锐",
        "勇毅",
        "宇达",
        "宇航",
        "宇寰",
        "宇文",
        "宇荫",
        "雨伯",
        "雨华",
        "雨石",
        "雨信",
        "雨星",
        "雨泽",
        "玉宸",
        "玉成",
        "玉龙",
        "玉泉",
        "玉山",
        "玉石",
        "玉书",
        "玉树",
        "玉堂",
        "玉轩",
        "玉宇",
        "玉韵",
        "玉泽",
        "煜祺",
        "元白",
        "元德",
        "元化",
        "元基",
        "元嘉",
        "元甲",
        "元驹",
        "元凯",
        "元恺",
        "元魁",
        "元良",
        "元亮",
        "元龙",
        "元明",
        "元青",
        "元思",
        "元纬",
        "元武",
        "元勋",
        "元正",
        "元忠",
        "元洲",
        "远航",
        "苑博",
        "苑杰",
        "越彬",
        "蕴涵",
        "蕴和",
        "蕴藉",
        "展鹏",
        "哲瀚",
        "哲茂",
        "哲圣",
        "哲彦",
        "振海",
        "振国",
        "正诚",
        "正初",
        "正德",
        "正浩",
        "正豪",
        "正平",
        "正奇",
        "正青",
        "正卿",
        "正文",
        "正祥",
        "正信",
        "正雅",
        "正阳",
        "正业",
        "正谊",
        "正真",
        "正志",
        "志诚",
        "志新",
        "志勇",
        "志明",
        "志国",
        "志强",
        "志尚",
        "志专",
        "志文",
        "志行",
        "志学",
        "志业",
        "志义",
        "志用",
        "志泽",
        "致远",
        "智明",
        "智鑫",
        "智勇",
        "智敏",
        "智志",
        "智渊",
        "子安",
        "子晋",
        "子民",
        "子明",
        "子默",
        "子墨",
        "子平",
        "子琪",
        "子石",
        "子实",
        "子真",
        "子濯",
        "子昂",
        "子轩",
        "子瑜",
        "自明",
        "自强",
        "作人",
        "自怡",
        "自珍",
        "曾琪",
        "泽宇",
        "泽语",
        "嘉博",
        "伟宇",
        "维博",
        "子明",
        "熙诚",
        "锦诚",
        "奕轩",
        "昊昕",
        "梓声",
        "冠林",
        "宝琛",
        "煜恒",
        "浩翔",
        "大晋",
        "梓毅",
        "天恺",
        "展毅",
        "梓扬",
        "銘豪",
        "昕哲",
        "梓晗",
        "镇熙",
        "昊哲"
      }
      local FeMaleArr = {
        "懿婕",
        "馨媛",
        "雨熙",
        "若涵",
        "馨瑜",
        "瑾涵",
        "羽欣",
        "琪悦",
        "逸菲",
        "馨瑜",
        "雨婷",
        "昕妤",
        "婉婷",
        "梦琪",
        "馨月",
        "佳瑜",
        "晓琦",
        "婷瑛",
        "诗琪",
        "瑾瑜",
        "艺琳",
        "雨婷",
        "欣怡",
        "诗雨",
        "佳琪",
        "悦涵",
        "昕瑶",
        "蓓佳",
        "诗萌",
        "曼如",
        "梦瑜",
        "若兮",
        "宛玉",
        "嘉淇",
        "莼菁",
        "雨涵",
        "诗懿",
        "雨彤",
        "璎琪",
        "婧怡",
        "姿蒨",
        "怡璐",
        "雨霏",
        "熙婷",
        "梓妍",
        "诗逸",
        "雯琪",
        "佳馨",
        "佳琪",
        "薇婷",
        "欣雨",
        "静茹",
        "欣怡",
        "蕙妍",
        "梓洁",
        "欣妍",
        "祺玥",
        "晨璐",
        "思懿",
        "佳蕊",
        "淑涵",
        "佳琦",
        "悦颖",
        "可馨",
        "思盈",
        "芷静",
        "欣卓",
        "璐怡",
        "嘉怡",
        "怡倩",
        "慧婷",
        "慧琳",
        "依婷",
        "雪菲",
        "雨妍",
        "语彤",
        "雨琪",
        "柏妍",
        "夏媛",
        "晓蝶",
        "若溪",
        "静雯",
        "涵诗",
        "心怡",
        "艾萌",
        "昕妍",
        "沈慧",
        "思颖",
        "靖雯",
        "梓慧",
        "欣桐",
        "伊嘉",
        "恬瑶",
        "靖怡",
        "鑫怡",
        "嘉雨",
        "歆玥",
        "诗雨",
        "诗怡",
        "语霏",
        "语悠",
        "雯慧",
        "欣予",
        "思琦",
        "蓓洁",
        "梓萌",
        "千媛",
        "玥涵",
        "彦瑶",
        "铭娴",
        "隽语",
        "依霏",
        "敏欣",
        "欣媛",
        "欣纯",
        "静霏",
        "雅楠",
        "昱涵",
        "婉毓",
        "熙婕",
        "莘瑶",
        "雅琪",
        "奕颖",
        "晗璐",
        "静楠",
        "佳瑶",
        "可心",
        "乐颜",
        "婉宜",
        "怡彤",
        "馨悦",
        "佳涵",
        "奕舒",
        "诗芮",
        "佳彦",
        "琚瑶",
        "晗瑜",
        "忆萱",
        "晨雁",
        "蕊嘉",
        "思妤",
        "子馨",
        "锦雯",
        "佳钰",
        "奕陶",
        "馨莹",
        "梓馨",
        "琬懿",
        "芷仪",
        "淑娴",
        "熙雨",
        "昕媛",
        "钰涵",
        "紫欣",
        "舒扬",
        "靖宜",
        "伊琳",
        "昱霏",
        "舒瑶",
        "梓蘅",
        "梓琪",
        "思予",
        "芷欣",
        "诗颖",
        "雨嫣",
        "懿真",
        "懿珊",
        "伊柔",
        "宇欣",
        "天奕",
        "奕菲",
        "予馨",
        "雨馨",
        "熙潆",
        "雅雯",
        "欣荣",
        "雨菲",
        "慧娴",
        "依睿",
        "雯欣",
        "艺璇",
        "蕊欣",
        "颖初",
        "欣宇",
        "歆乐",
        "文萱",
        "雅菲",
        "明婧",
        "雨杉",
        "萌露",
        "婷萱",
        "佳祺",
        "馨文",
        "雪婷",
        "怡嘉",
        "佳楠",
        "添艾",
        "欣羽",
        "芷晗",
        "馨尹",
        "语琦",
        "欣瑜",
        "馨妍",
        "雨乔",
        "诗涵",
        "煜华",
        "净萱",
        "哲娴",
        "奕心",
        "欣奕",
        "南颖",
        "思怡",
        "雨歆",
        "欣雯",
        "家琦",
        "嫣怡",
        "可新",
        "佳惠",
        "佳逸",
        "梓玥",
        "雨荷",
        "静怡",
        "思婷",
        "歆媛",
        "诗佳",
        "梓旋",
        "佑琪",
        "晨欣",
        "慧涵",
        "睿茜",
        "静仪",
        "雅然",
        "雨情",
        "冰倩",
        "语馨",
        "涵钰",
        "晓云",
        "枫滢",
        "熙妍",
        "雨茜",
        "曦涵",
        "宾鑫",
        "怡萱",
        "梓涵",
        "雅馨",
        "翊萱",
        "依涵",
        "昱欣",
        "珏铭",
        "乐彤",
        "芷馨",
        "冰滢",
        "静涵",
        "芷涵",
        "子茜",
        "唯伊",
        "馨月",
        "奕可",
        "佳缘",
        "雯昕",
        "祺敏",
        "奕璇",
        "梓熙",
        "歆昱",
        "韵涵",
        "雨宸",
        "欣平",
        "哓璐",
        "天瑜",
        "思雯",
        "伊颖",
        "佳璐",
        "睿晗",
        "昕颖",
        "嘉慧",
        "星玥",
        "艺涵",
        "煜琪",
        "馨蕾",
        "君涵",
        "若昕",
        "艺娴",
        "梓婷",
        "如昱",
        "熠婷",
        "欣奇",
        "紫沐",
        "馨竹",
        "圆婷",
        "语玥",
        "哲雯",
        "千慧",
        "佳诺",
        "恬易",
        "心奕",
        "懿饶",
        "怡辰",
        "雨昕",
        "曈欣",
        "懿倩",
        "宇馨",
        "凡琪",
        "鑫蕾",
        "钰沣",
        "乐怡",
        "叶馨",
        "梓言",
        "书晴",
        "舒文",
        "韵竹",
        "乐晨",
        "诗言",
        "佳言",
        "舒瑞",
        "诗蕊",
        "家彦",
        "佳瑶",
        "晗雁",
        "忆晨",
        "瑜萱",
        "嘉蕊",
        "瑜婷",
        "怡婷",
        "瑜洁",
        "晴语",
        "逸婷",
        "敏佳",
        "晓雪",
        "钰航",
        "佳玥",
        "雪晴",
        "怡雯",
        "奕瑶",
        "怡昕",
        "思媛",
        "依慧",
        "思蕊",
        "圣涵",
        "语尚",
        "心羽",
        "宇雯",
        "晴雨",
        "晨希",
        "煜婷",
        "辰萌",
        "昳涵",
        "语彦",
        "星楠",
        "嘉伊",
        "乐妍",
        "秀懿",
        "静蕾",
        "旖烨",
        "雯舒",
        "筱鹂",
        "宇萱",
        "佳敏",
        "诗怡",
        "奕婷",
        "逸萱",
        "奕洁",
        "采奕",
        "懿萱",
        "佳凝",
        "佳懿",
        "晨佳",
        "惠婷",
        "翌萌",
        "欣瑶",
        "煜祺",
        "诗奕",
        "梓怡",
        "珏妍",
        "奕柔",
        "怡晨",
        "乐薇",
        "雪怡",
        "铭欣",
        "佳韵",
        "卓语",
        "素妍",
        "怡青",
        "嘉旎",
        "昕瑜",
        "卓玲",
        "馨翊",
        "煜琪",
        "卓钰",
        "晓萱",
        "璐奕",
        "莞琪",
        "婉佳",
        "歆妍",
        "雨朦",
        "妙卓",
        "奕佳",
        "歆仪",
        "妤熙",
        "露瑶",
        "筱静",
        "智妤",
        "妤欣",
        "蕊怡",
        "筱晴",
        "燕楠",
        "钰婷",
        "裕湉",
        "涵玥",
        "奕琪",
        "瑾瑶",
        "思彤",
        "鑫雨",
        "若楠",
        "嘉懿",
        "淏妍",
        "宇晴",
        "雯怡",
        "彦琳",
        "诗琪",
        "誉菲",
        "郡瑶",
        "欣宜",
        "诗琦",
        "鑫月",
        "艾媛",
        "诗瑜",
        "思璇",
        "静宜",
        "懿文",
        "舒雯",
        "雯萱",
        "婉钰",
        "颖茜",
        "伊璇",
        "婧懿",
        "馨源",
        "佳奇",
        "昱琪",
        "梦馨",
        "宇菲",
        "梓忆",
        "卓妍",
        "嘉议",
        "逸璇",
        "佳莹",
        "书婕",
        "敏嘉",
        "懿帆",
        "慧雯",
        "佳湄",
        "慧怡",
        "欣婕",
        "馨宇",
        "鑫璐",
        "星语",
        "佳欣",
        "书瑾",
        "睿婕",
        "韵歆",
        "欣睿",
        "铭珠",
        "玫馨",
        "慕洁",
        "郁茹",
        "瑞珊",
        "姿婷",
        "欣容",
        "宜璇",
        "梓珏",
        "郁珊",
        "淑婷",
        "怡君",
        "旻珊",
        "珏如",
        "姿娴",
        "喻萱",
        "钰佳",
        "毓珊",
        "奕妤",
        "雯珊",
        "筱涵",
        "玮婷",
        "芳仪",
        "思咏",
        "馨瑶",
        "诗媛",
        "筱珺",
        "昱颖",
        "诗祺",
        "咏彤",
        "紫琪",
        "梓玲",
        "卓盈",
        "昱珊",
        "梦琪",
        "忆柳",
        "之桃",
        "慕青",
        "问兰",
        "尔岚",
        "元香",
        "初夏",
        "沛菡",
        "傲珊",
        "曼文",
        "乐菱",
        "痴珊",
        "恨玉",
        "惜文",
        "香寒",
        "新柔",
        "语蓉",
        "海安",
        "夜蓉",
        "涵柏",
        "水桃",
        "醉蓝",
        "春儿",
        "语琴",
        "从彤",
        "傲晴",
        "语兰",
        "又菱",
        "碧彤",
        "元霜",
        "怜梦",
        "紫寒",
        "妙彤",
        "曼易",
        "南莲",
        "紫翠",
        "雨寒",
        "易烟",
        "如萱",
        "若南",
        "寻真",
        "晓亦",
        "向珊",
        "慕灵",
        "以蕊",
        "寻雁",
        "映易",
        "雪柳",
        "孤岚",
        "笑霜",
        "海云",
        "凝天",
        "沛珊",
        "寒云",
        "冰旋",
        "宛儿",
        "绿真",
        "盼儿",
        "晓霜",
        "碧凡",
        "夏菡",
        "曼香",
        "若烟",
        "半梦",
        "雅绿",
        "冰蓝",
        "灵槐",
        "平安",
        "书翠",
        "翠风",
        "香巧",
        "代云",
        "梦曼",
        "幼翠",
        "友巧",
        "听寒",
        "梦柏",
        "醉易",
        "访旋",
        "亦玉",
        "凌萱",
        "访卉",
        "怀亦",
        "笑蓝",
        "春翠",
        "靖柏",
        "夜蕾",
        "冰夏",
        "梦松",
        "书雪",
        "乐枫",
        "念薇",
        "靖雁",
        "寻春",
        "恨山",
        "从寒",
        "忆香",
        "觅波",
        "静曼",
        "凡旋",
        "以亦",
        "念露",
        "芷蕾",
        "千兰",
        "新波",
        "代真",
        "新蕾",
        "雁玉",
        "冷卉",
        "紫山",
        "千琴",
        "恨天",
        "傲芙",
        "盼山",
        "怀蝶",
        "冰兰",
        "山柏",
        "翠萱",
        "恨松",
        "问旋",
        "从南",
        "白易",
        "问筠",
        "如霜",
        "半芹",
        "丹珍",
        "冰彤",
        "亦寒",
        "寒雁",
        "怜云",
        "寻文",
        "乐丹",
        "翠柔",
        "谷山",
        "之瑶",
        "冰露",
        "尔珍",
        "谷雪",
        "涵菡",
        "海莲",
        "傲蕾",
        "青槐",
        "冬儿",
        "易梦",
        "惜雪",
        "宛海",
        "之柔",
        "夏青",
        "亦瑶",
        "妙菡",
        "春竹",
        "痴梦",
        "紫蓝",
        "晓巧",
        "幻柏",
        "元风",
        "冰枫",
        "访蕊",
        "南春",
        "芷蕊",
        "凡蕾",
        "凡柔",
        "安蕾",
        "天荷",
        "含玉",
        "书兰",
        "雅琴",
        "书瑶",
        "春雁",
        "从安",
        "夏槐",
        "念芹",
        "怀萍",
        "代曼",
        "幻珊",
        "谷丝",
        "秋翠",
        "白晴",
        "海露",
        "代荷",
        "含玉",
        "书蕾",
        "听白",
        "访琴",
        "灵雁",
        "秋春",
        "雪青",
        "乐瑶",
        "含烟",
        "涵双",
        "平蝶",
        "雅蕊",
        "傲之",
        "灵薇",
        "绿春",
        "含蕾",
        "从梦",
        "从蓉",
        "初丹",
        "听兰",
        "听蓉",
        "语芙",
        "夏彤",
        "凌瑶",
        "忆翠",
        "幻灵",
        "怜菡",
        "紫南",
        "依珊",
        "妙竹",
        "访烟",
        "怜蕾",
        "映寒",
        "友绿",
        "冰萍",
        "惜霜",
        "凌香",
        "雁卉",
        "迎梦",
        "元柏",
        "代萱",
        "紫真",
        "千青",
        "凌寒",
        "紫安",
        "寒安",
        "怀蕊",
        "秋荷",
        "涵雁",
        "以山",
        "凡梅",
        "盼曼",
        "翠彤",
        "谷冬",
        "新巧",
        "冷安",
        "千萍",
        "冰烟",
        "雅阳",
        "友绿",
        "南松",
        "诗云",
        "飞风",
        "寄灵",
        "书芹",
        "幼蓉",
        "以蓝",
        "笑寒",
        "忆寒",
        "秋烟",
        "芷巧",
        "水香",
        "映之",
        "醉波",
        "幻莲",
        "夜山",
        "芷卉",
        "向彤",
        "小玉",
        "幼南",
        "凡梦",
        "尔曼",
        "念波",
        "迎松",
        "青寒",
        "笑天",
        "碧菡",
        "映秋",
        "盼烟",
        "忆山",
        "以寒",
        "寒香",
        "小凡",
        "代亦",
        "梦露",
        "映波",
        "友蕊",
        "寄凡",
        "怜蕾",
        "雁枫",
        "水绿",
        "曼荷",
        "笑珊",
        "寒珊",
        "谷南",
        "慕儿",
        "夏岚",
        "友儿",
        "小萱",
        "紫青",
        "妙菱",
        "冬寒",
        "曼柔",
        "语蝶",
        "青筠",
        "夜安",
        "觅海",
        "问安",
        "晓槐",
        "雅山",
        "访云",
        "翠容",
        "寒凡",
        "晓绿",
        "以菱",
        "冬云",
        "含玉",
        "访枫",
        "含卉",
        "夜白",
        "冷安",
        "灵竹",
        "醉薇",
        "元珊",
        "幻波",
        "盼夏",
        "元瑶",
        "迎曼",
        "水云",
        "访琴",
        "谷波",
        "乐之",
        "笑白",
        "之山",
        "妙海",
        "紫霜",
        "平夏",
        "凌旋",
        "孤丝",
        "怜寒",
        "向萍",
        "凡松",
        "青丝",
        "翠安",
        "如天",
        "凌雪",
        "绮菱",
        "代云",
        "南莲",
        "寻南",
        "春文",
        "香薇",
        "冬灵",
        "凌珍",
        "采绿",
        "天春",
        "沛文",
        "紫槐",
        "幻柏",
        "采文",
        "春梅",
        "雪旋",
        "盼海",
        "映梦",
        "映雪",
        "安雁",
        "映容",
        "凝阳",
        "访风",
        "天亦",
        "平绿",
        "盼香",
        "觅风",
        "小霜",
        "雪萍",
        "半雪",
        "山柳",
        "谷雪",
        "靖易",
        "白薇",
        "梦菡",
        "飞绿",
        "如波",
        "又晴",
        "友易",
        "香菱",
        "冬亦",
        "问雁",
        "妙春",
        "海冬",
        "半安",
        "平春",
        "幼柏",
        "秋灵",
        "凝芙",
        "念烟",
        "白山",
        "从灵",
        "尔芙",
        "迎蓉",
        "念寒",
        "翠绿",
        "翠芙",
        "靖儿",
        "妙柏",
        "千凝",
        "小珍",
        "天巧",
        "妙旋",
        "雪枫",
        "夏菡",
        "元绿",
        "痴灵",
        "绮琴",
        "雨双",
        "听枫",
        "觅荷",
        "凡之",
        "晓凡",
        "雅彤",
        "香薇",
        "孤风",
        "从安",
        "绮彤",
        "之玉",
        "雨珍",
        "幻丝",
        "代梅",
        "香波",
        "青亦",
        "元菱",
        "海瑶",
        "飞槐",
        "听露",
        "梦岚",
        "幻竹",
        "新冬",
        "盼翠",
        "谷云",
        "忆霜",
        "水瑶",
        "慕晴",
        "秋双",
        "雨真",
        "觅珍",
        "丹雪",
        "从阳",
        "元枫",
        "痴香",
        "思天",
        "如松",
        "妙晴",
        "谷秋",
        "妙松",
        "晓夏",
        "香柏",
        "巧绿",
        "宛筠",
        "碧琴",
        "盼兰",
        "小夏",
        "安容",
        "青曼",
        "千儿",
        "香春",
        "寻双",
        "涵瑶",
        "冷梅",
        "秋柔",
        "思菱",
        "醉波",
        "醉柳",
        "以寒",
        "迎夏",
        "向雪",
        "香莲",
        "以丹",
        "依凝",
        "如柏",
        "雁菱",
        "凝竹",
        "宛白",
        "初柔",
        "南蕾",
        "书萱",
        "梦槐",
        "香芹",
        "南琴",
        "绿海",
        "沛儿",
        "晓瑶",
        "听春",
        "凝蝶",
        "紫雪",
        "念双",
        "念真",
        "曼寒",
        "凡霜",
        "飞雪",
        "雪兰",
        "雅霜",
        "从蓉",
        "冷雪",
        "靖巧",
        "翠丝",
        "觅翠",
        "凡白",
        "迎波",
        "丹烟",
        "梦旋",
        "书双",
        "念桃",
        "夜天",
        "海桃",
        "青香",
        "恨风",
        "安筠",
        "觅柔",
        "初南",
        "秋蝶",
        "千易",
        "安露",
        "诗蕊",
        "山雁",
        "友菱",
        "香露",
        "晓兰",
        "白卉",
        "语山",
        "冷珍",
        "秋翠",
        "夏柳",
        "如之",
        "忆南",
        "书易",
        "翠桃",
        "寄瑶",
        "如曼",
        "问柳",
        "香梅",
        "幻桃",
        "又菡",
        "春绿",
        "醉蝶",
        "亦绿",
        "诗珊",
        "听芹",
        "新之",
        "易巧",
        "念云",
        "晓灵",
        "静枫",
        "夏蓉",
        "如南",
        "幼丝",
        "秋白",
        "冰安",
        "秋白",
        "南风",
        "醉山",
        "初彤",
        "凝海",
        "紫文",
        "凌晴",
        "香卉",
        "傲安",
        "傲之",
        "初蝶",
        "寻桃",
        "代芹",
        "诗霜",
        "春柏",
        "绿夏",
        "碧灵",
        "诗柳",
        "夏柳",
        "采白",
        "慕梅",
        "乐安",
        "冬菱",
        "紫安",
        "宛凝",
        "雨雪",
        "易真",
        "安荷",
        "静竹",
        "代柔",
        "丹秋",
        "绮梅",
        "依白",
        "凝荷",
        "幼珊",
        "忆彤",
        "凌青",
        "之桃",
        "芷荷",
        "听荷",
        "代玉",
        "念珍",
        "梦菲",
        "夜春",
        "千秋",
        "白秋",
        "谷菱",
        "飞松",
        "初瑶",
        "惜灵",
        "恨瑶",
        "梦易",
        "新瑶",
        "曼梅",
        "碧曼",
        "友瑶",
        "雨兰",
        "夜柳",
        "香蝶",
        "盼巧",
        "芷珍",
        "香卉",
        "含芙",
        "夜云",
        "依萱",
        "凝雁",
        "以莲",
        "易容",
        "元柳",
        "安南",
        "幼晴",
        "尔琴",
        "飞阳",
        "白凡",
        "沛萍",
        "向卉",
        "采文",
        "乐珍",
        "寒荷",
        "觅双",
        "白桃",
        "安卉",
        "迎曼",
        "盼雁",
        "乐松",
        "涵山",
        "恨寒",
        "问枫",
        "以柳",
        "含海",
        "秋春",
        "翠曼",
        "忆梅",
        "涵柳",
        "梦香",
        "海蓝",
        "晓曼",
        "代珊",
        "春冬",
        "恨荷",
        "忆丹",
        "静芙",
        "绮兰",
        "梦安",
        "紫丝",
        "千雁",
        "凝珍",
        "香萱",
        "梦容",
        "冷雁",
        "飞柏",
        "天真",
        "翠琴",
        "寄真",
        "秋荷",
        "代珊",
        "初雪",
        "雅柏",
        "怜容",
        "如风",
        "南露",
        "紫易",
        "冰凡",
        "海雪",
        "语蓉",
        "碧玉",
        "翠岚",
        "语风",
        "盼丹",
        "痴旋",
        "凝梦",
        "从雪",
        "白枫",
        "傲云",
        "白梅",
        "念露",
        "慕凝",
        "雅柔",
        "盼柳",
        "半青",
        "从霜",
        "怀柔",
        "怜晴",
        "夜蓉",
        "代双",
        "以南",
        "若菱",
        "芷文",
        "寄春",
        "南晴",
        "恨之",
        "梦寒",
        "初翠",
        "灵波",
        "巧春",
        "问夏",
        "凌春",
        "惜海",
        "亦旋",
        "沛芹",
        "幼萱",
        "白凝",
        "初露",
        "迎海",
        "绮玉",
        "凌香",
        "寻芹",
        "秋柳",
        "尔白",
        "映真",
        "含雁",
        "寒松",
        "友珊",
        "寻雪",
        "忆柏",
        "秋柏",
        "巧风",
        "恨蝶",
        "青烟",
        "问蕊",
        "灵阳",
        "春枫",
        "又儿",
        "雪巧",
        "丹萱",
        "凡双",
        "孤萍",
        "紫菱",
        "寻凝",
        "傲柏",
        "傲儿",
        "友容",
        "灵枫",
        "尔丝",
        "曼凝",
        "若蕊",
        "问丝",
        "思枫",
        "水卉",
        "问梅",
        "念寒",
        "诗双",
        "翠霜",
        "夜香",
        "寒蕾",
        "凡阳",
        "冷玉",
        "平彤",
        "语薇",
        "幻珊",
        "紫夏",
        "凌波",
        "芷蝶",
        "丹南",
        "之双",
        "凡波",
        "思雁",
        "白莲",
        "从菡",
        "如容",
        "采柳",
        "沛岚",
        "惜儿",
        "夜玉",
        "水儿",
        "半凡",
        "语海",
        "听莲",
        "幻枫",
        "念柏",
        "冰珍",
        "思山",
        "凝蕊",
        "天玉",
        "问香",
        "思萱",
        "向梦",
        "笑南",
        "夏旋",
        "之槐",
        "元灵",
        "以彤",
        "采萱",
        "巧曼",
        "绿兰",
        "平蓝",
        "问萍",
        "绿蓉",
        "靖柏",
        "迎蕾",
        "碧曼",
        "思卉",
        "白柏",
        "妙菡",
        "怜阳",
        "雨柏",
        "雁菡",
        "梦之",
        "又莲",
        "乐荷",
        "寒天",
        "凝琴",
        "书南",
        "映天",
        "白梦",
        "初瑶",
        "恨竹",
        "平露",
        "含巧",
        "慕蕊",
        "半莲",
        "醉卉",
        "天菱",
        "青雪",
        "雅旋",
        "巧荷",
        "飞丹",
        "恨云",
        "若灵"
      }
      if "又莲" == gender["nil"] then
        gender = gender.math.random(0, 1)
      end
      local Name = gender
      if 0 == 0 then
        Name = FirstNameArr[gender.math.random(1, #FirstNameArr)] .. FeMaleArr[gender.math.random(1, #FeMaleArr)]
      else
        Name = FirstNameArr[gender.math.random(1, #FirstNameArr)] .. MaleArr[gender.math.random(1, #MaleArr)]
      end
      return Name
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RndName()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeURL(str)
  return (nil)({
    function()
      if nil then
        str = str.string.gsub(nil, "\n", "\r\n")
        str = str.string.gsub(nil, "([^%w %-%_%.%~])", function(c)
          return string.format("%%%02X", string.byte(c))
        end)
        str = str.string.gsub(nil, " ", "+")
      end
      return (str.string.gsub(nil, " ", "+"))
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeURL()，错误信息：", errors)
      end
    })
  })
end

function zmm.DecodeURL(str)
  return (nil)({
    function()
      str = str.string.gsub(nil, "+", " ")
      str = str.string.gsub(nil, "%%(%x%x)", function(h)
        return string.char(tonumber(h, 16))
      end)
      str = str.string.gsub(nil, "\r\n", "\n")
      return (str.string.gsub(nil, "\r\n", "\n"))
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DecodeURL()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeMD5File(path)
  return (nil)({
    function()
      local ret = zmm.Execute("md5sum \"" .. nil .. "\"")
      return ret:match("[^ ]+")
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeMD5File()，错误信息：", errors)
      end
    })
  })
end

function _zmm.getBase64Code()
  local lua_text = "--[[**************************************************************************]]\n-- base64.lua\n-- Copyright 2014 Ernest R. Ewert\n--\n--  This Lua module contains the implementation of a Lua base64 encode\n--  and decode library.\n--\n--  The library exposes these methods.\n--\n--      Method      Args\n--      ----------- ----------------------------------------------\n--      encode      String in / out\n--      decode      String in / out\n--\n--      encode      String, function(value) predicate\n--      decode      String, function(value) predicate\n--\n--      encode      file, function(value) predicate\n--      deocde      file, function(value) predicate\n--\n--      encode      file, file\n--      deocde      file, file\n--\n--      alpha       alphabet, term char\n--\n\n--------------------------------------------------------------------------------\n-- known_base64_alphabets\n--\n--\nlocal known_base64_alphabets=\n{\n    base64= -- RFC 2045 (Ignores max line length restrictions)\n    {\n        _alpha=\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/\",\n        _strip=\"[^%a%d%+%/%=]\",\n        _term=\"=\"\n    },\n\n    base64noterm= -- RFC 2045 (Ignores max line length restrictions)\n    {\n        _alpha=\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/\",\n        _strip=\"[^%a%d%+%/]\",\n        _term=\"\"\n    },\n\n    base64url= -- RFC 4648 'base64url'\n    {\n        _alpha=\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_\",\n        _strip=\"[^%a%d%+%-%_=]\",\n        _term=\"\"\n    },\n}\nlocal c_alpha=known_base64_alphabets.base64\nlocal pattern_strip\n\n--[[**************************************************************************]]\n--[[****************************** Encoding **********************************]]\n--[[**************************************************************************]]\n\n\n-- Precomputed tables (compromise using more memory for speed)\nlocal b64e    -- 6 bit patterns to ANSI 'char' values\nlocal b64e_a  -- ready to use\nlocal b64e_a2 -- byte addend\nlocal b64e_b1 -- byte addend\nlocal b64e_b2 -- byte addend\nlocal b64e_c1 -- byte addend\nlocal b64e_c  -- ready to use\n\n\n-- Tail padding values\nlocal tail_padd64=\n{\n    \"==\",   -- two bytes modulo\n    \"=\"     -- one byte modulo\n}\n\n\n--------------------------------------------------------------------------------\n-- e64\n--\n--  Helper function to convert three eight bit values into four encoded\n--  6 (significant) bit values.\n--\n--                 7             0 7             0 7             0\n--             e64(a a a a a a a a,b b b b b b b b,c c c c c c c c)\n--                 |           |           |           |\n--  return    [    a a a a a a]|           |           |\n--                        [    a a b b b b]|           |\n--                                    [    b b b b c c]|\n--                                                [    c c c c c c]\n--\nlocal function e64( a, b, c )\n    -- Return pre-calculated values for encoded value 1 and 4\n    -- Get the pre-calculated extractions for value 2 and 3, look them\n    -- up and return the proper value.\n    --\n    return  b64e_a[a],\n            b64e[ b64e_a2[a]+b64e_b1[b] ],\n            b64e[ b64e_b2[b]+b64e_c1[c] ],\n            b64e_c[c]\nend\n\n\n--------------------------------------------------------------------------------\n-- encode_tail64\n--\n--  Send a tail pad value to the output predicate provided.\n--\nlocal function encode_tail64( out, x, y )\n    -- If we have a number of input bytes that isn't exactly divisible\n    -- by 3 then we need to pad the tail\n    if x ~= nil then\n        local a,b,r = x,0,1\n\n        if y ~= nil then\n            r = 2\n            b = y\n        end\n\n        -- Encode three bytes of info, with the tail byte as zeros and\n        -- ignore any fourth encoded ASCII value. (We should NOT have a\n        -- forth byte at this point.)\n        local b1, b2, b3 = e64( a, b, 0 )\n\n        -- always add the first 2 six bit values to the res table\n        -- 1 remainder input byte needs 8 output bits\n        local tail_value = string.char( b1, b2 )\n\n        -- two remainder input bytes will need 18 output bits (2 as pad)\n        if r == 2 then\n            tail_value=tail_value..string.char( b3 )\n        end\n\n        -- send the last 4 byte sequence with appropriate tail padding\n        out( tail_value .. tail_padd64[r] )\n    end\nend\n\n\n--------------------------------------------------------------------------------\n-- encode64_io_iterator\n--\n--  Create an io input iterator to read an input file and split values for\n--  proper encoding.\n--\nlocal function encode64_io_iterator(file)\n\n    assert( io.type(file)  == \"file\", \"argument must be readable file handle\" )\n    assert( file.read ~= nil,         \"argument must be readable file handle\" )\n\n    local ii = { } -- Table for the input iterator\n\n    setmetatable(ii,{ __tostring=function() return \"base64.io_iterator\" end})\n\n    -- Begin returns an input read iterator\n    --\n    function ii.begin()\n        local sb  = string.byte\n\n        -- The iterator returns three bytes from the file for encoding or nil\n        -- when the end of the file has been reached.\n        --\n        return function()\n            s = file:read(3)\n            if s ~= nil and #s == 3 then\n                return sb(s,1,3)\n            end\n            return nil\n        end\n    end\n\n    -- The tail method on the iterator allows the routines to run faster\n    -- because each sequence of bytes doesn't have to test for EOF.\n    --\n    function ii.tail()\n        -- If one or two \"overflow\" bytes exist, return those.\n        --\n        if s ~= nil then return s:byte(1,2) end\n    end\n\n    return ii\nend\n\n\n--------------------------------------------------------------------------------\n-- encode64_with_ii\n--\n--      Convert the value provided by an encode iterator that provides a begin\n--      method, a tail method, and an iterator that returns three bytes for\n--      each call until at the end. The tail method should return either 1 or 2\n--      tail bytes (for source values that are not evenly divisible by three).\n--\nlocal function encode64_with_ii( ii, out )\n    local sc=string.char\n\n    for a, b, c in ii.begin() do\n        out( sc( e64( a, b, c ) ) )\n    end\n\n    encode_tail64( out, ii.tail() )\n\nend\n\n\n--------------------------------------------------------------------------------\n-- encode64_with_predicate\n--\n--      Implements the basic raw data --> base64 conversion. Each three byte\n--      sequence in the input string is converted to the encoded string and\n--      given to the predicate provided in 4 output byte chunks. This method\n--      is slightly faster for traversing existing strings in memory.\n--\nlocal function encode64_with_predicate( raw, out )\n    local rem=#raw%3     -- remainder\n    local len=#raw-rem   -- 3 byte input adjusted\n    local sb=string.byte -- Mostly notational (slight performance)\n    local sc=string.char -- Mostly notational (slight performance)\n\n    -- Main encode loop converts three input bytes to 4 base64 encoded\n    -- ACSII values and calls the predicate with the value.\n    for i=1,len,3 do\n        -- This really isn't intended as obfuscation. It is more about\n        -- loop optimization and removing temporaries.\n        --\n        out( sc( e64( sb( raw ,i , i+3 ) ) ) )\n        --   |   |    |\n        --   |   |    byte i to i + 3\n        --   |   |\n        --   |   returns 4 encoded values\n        --   |\n        --   creates a string with the 4 returned values\n    end\n\n    -- If we have a number of input bytes that isn't exactly divisible\n    -- by 3 then we need to pad the tail\n    if rem > 0 then\n        local x, y = sb( raw, len+1 )\n\n        if rem > 1 then\n            y = sb( raw, len+2 )\n        end\n\n        encode_tail64( out, x, y )\n    end\nend\n\n\n--------------------------------------------------------------------------------\n-- encode64_tostring\n--\n--      Convenience method that accepts a string value and returns the\n--      encoded version of that string.\n--\nlocal function encode64_tostring(raw)\n\n    local sb={} -- table to build string\n\n    local function collection_predicate(v)\n        sb[#sb+1]=v\n    end\n\n    -- Test with an 818K string in memory. Result is 1.1M of data.\n    --\n    --      lua_base64      base64 (gnu 8.21)\n    --      202ms           54ms\n    --      203ms           48ms\n    --      204ms           50ms\n    --      203ms           42ms\n    --      205ms           46ms\n    --\n    encode64_with_predicate( raw, collection_predicate )\n\n    return table.concat(sb)\nend\n\n\n--[[**************************************************************************]]\n--[[****************************** Decoding **********************************]]\n--[[**************************************************************************]]\n\n\n-- Precomputed tables (compromise using more memory for speed)\nlocal b64d    -- ANSI 'char' to right shifted bit pattern\nlocal b64d_a1 -- byte addend\nlocal b64d_a2 -- byte addend\nlocal b64d_b1 -- byte addend\nlocal b64d_b2 -- byte addend\nlocal b64d_c1 -- byte addend\nlocal b64d_z  -- zero\n\n\n--------------------------------------------------------------------------------\n-- d64\n--\n--  Helper function to convert four six bit values into three full eight\n--  bit values. Input values are the integer expression of the six bit value\n--  encoded in the original base64 encoded string.\n--\n--     d64( _ _1 1 1 1 1 1,\n--             |       _ _ 2 2 2 2 2 2,\n--             |           |       _ _ 3 3 3 3 3 3,\n--             |           |           |       _ _ 4 4 4 4 4 4)\n--             |           |           |           |\n--  return ', [1 1 1 1 1 1 2 2]        |           |\n--         ',                 [2 2 2 2 3 3 3 3]    |\n--         '                                  [3 3 4 4 4 4 4 4]\n--\nlocal function d64( b1, b2, b3, b4 )\n    -- We can get away with addition instead of anding the values together\n    -- because there are no  overlapping bit patterns.\n    --\n    return\n        b64d_a1[b1] + b64d_a2[b2],\n        b64d_b1[b2] + b64d_b2[b3],\n        b64d_c1[b3] + b64d[b4]\nend\n\n\n--------------------------------------------------------------------------------\n-- decode_tail64\n--\n--  Send the end of stream bytes that didn't get decoded via the main loop.\n--\nlocal function decode_tail64( out, e1, e2 ,e3, e4 )\n\n    if tail_padd64[2] == \"\" or e4 == tail_padd64[2]:byte() then\n        local n3 = b64d_z\n\n        if e3 ~= nil and e3 ~= tail_padd64[2]:byte() then\n            n3 = e3\n        end\n\n        -- Unpack the six bit values into the 8 bit values\n        local b1, b2 = d64( e1, e2, n3, b64d_z )\n\n        -- And add them to the res table\n        if e3 ~= nil and e3 ~= tail_padd64[2]:byte() then\n            out( string.char( b1, b2 ) )\n        else\n            out( string.char( b1 ) )\n        end\n    end\nend\n\n\n--------------------------------------------------------------------------------\n-- decode64_io_iterator\n--\n--  Create an io input iterator to read an input file and split values for\n--  proper decoding.\n--\nlocal function decode64_io_iterator( file )\n\n    local ii = { }\n\n    -- An enumeration coroutine that handles the reading of an input file\n    -- to break data into proper pieces for building the original string.\n    --\n    local function enummerate( file )\n        local sc=string.char\n        local sb=string.byte\n        local ll=\"\" -- last line storage\n        local len\n        local yield = coroutine.yield\n\n        -- Read a \"reasonable amount\" of data into the line buffer. Line by\n        -- line is not used so that a file with no line breaks doesn't\n        -- cause an inordinate amount of memory usage.\n        --\n        for cl in file:lines(2048) do\n            -- Reset the current line to contain valid chars and any previous\n            -- \"leftover\" bytes from the previous read\n            --\n            cl = ll .. cl:gsub(pattern_strip,\"\")\n            --   |     |\n            --   |     Remove \"Invalid\" chars (white space etc)\n            --   |\n            --   Left over from last line\n            --\n            len = (#cl-4)-(#cl%4)\n\n            -- see the comments in decode64_with_predicate for a rundown of\n            -- the results of this loop (sans the coroutine)\n            for i=1,len,4 do\n                yield( sc( d64( sb( cl, i, i+4 ) ) ) )\n            end\n\n            ll = cl:sub( len +1, #cl )\n        end\n\n        local l = #ll\n\n        if l >= 4 and ll:sub(-1) ~= tail_padd64[2] then\n            yield( sc( d64( sb( ll, 1, 4 ) ) ) )\n            l=l-4\n        end\n\n        if l > 0 then\n\n            local e1,e2,e3,e4 = ll:byte( 0 - l, -1 )\n\n            if e1 ~= nil then\n                decode_tail64( function(s) yield( s ) end, e1, e2, e3, e4 )\n            end\n        end\n\n    end\n\n    -- Returns an input iterator that is implemented as a coroutine. Each\n    -- yield of the co-routine sends reconstructed bytes to the loop handling\n    -- the iteration.\n    --\n    function ii.begin()\n        local co = coroutine.create( function() enummerate(file) end )\n\n        return function()\n            local code,res = coroutine.resume(co)\n            assert(code == true)\n            return res\n        end\n    end\n\n    return ii\nend\n\n\n--------------------------------------------------------------------------------\n-- decode64_with_ii\n--\n--      Convert the value provided by a decode iterator that provides a begin\n--      method, a tail method, and an iterator that returns four (usable!) bytes\n--      for each call until at the end.\n--\nlocal function decode64_with_ii( ii, out )\n\n    -- Uses the iterator to pull values. Each reconstructed string\n    -- is sent to the output predicate.\n    --\n    for l in ii.begin() do out( l ) end\n\nend\n\n\n--------------------------------------------------------------------------------\n-- decode64_with_predicate\n--\n-- Decode an entire base64 encoded string in memory using the predicate for\n-- output.\n--\nlocal function decode64_with_predicate( raw, out )\n    -- Sanitize the input to strip characters that are not in the alphabet.\n    --\n    -- Note: This is a deviation from strict implementations where \"bad data\"\n    --       in the input stream is unsupported.\n    --\n    local san = raw:gsub(pattern_strip,\"\")\n    local len = #san-#san%4\n    local rem = #san-len\n    local sc  = string.char\n    local sb  = string.byte\n\n    if san:sub(-1,-1) == tail_padd64[2] then\n        rem = rem + 4\n        len = len - 4\n    end\n\n    for i=1,len,4 do\n        out( sc( d64( sb( san, i, i+4 ) ) ) )\n    end\n\n    if rem > 0 then\n        decode_tail64( out, sb( san, 0-rem, -1 ) )\n    end\nend\n\n\n--------------------------------------------------------------------------------\n-- decode64_tostring\n--\n--  Takes a string that is encoded in base64 and returns the decoded value in\n--  a new string.\n--\nlocal function decode64_tostring( raw )\n\n    local sb={} -- table to build string\n\n    local function collection_predicate(v)\n        sb[#sb+1]=v\n    end\n\n    decode64_with_predicate( raw, collection_predicate )\n\n    return table.concat(sb)\nend\n\n\n--------------------------------------------------------------------------------\n-- set_and_get_alphabet\n--\n--  Sets and returns the encode / decode alphabet.\n--\n--\nlocal function set_and_get_alphabet(alpha,term)\n\n    if alpha ~= nil then\n        local magic=\n        {\n    --        [\"%\"]=\"%%\",\n            [\" \"]=\"% \",\n            [\"^\"]=\"%^\",\n            [\"$\"]=\"%$\",\n            [\"(\"]=\"%(\",\n            [\")\"]=\"%)\",\n            [\".\"]=\"%.\",\n            [\"[\"]=\"%[\",\n            [\"]\"]=\"%]\",\n            [\"*\"]=\"%*\",\n            [\"+\"]=\"%+\",\n            [\"-\"]=\"%-\",\n            [\"?\"]=\"%?\",\n        }\n\n        c_alpha=known_base64_alphabets[alpha]\n        if c_alpha == nil then\n            c_alpha={ _alpha=alpha, _term=term }\n        end\n\n        assert( #c_alpha._alpha == 64,    \"The alphabet ~must~ be 64 unique values.\"  )\n        assert( #c_alpha._term  <=  1,    \"Specify zero or one termination character.\")\n\n        b64d={}  -- Decode table alpha          -> right shifted int values\n        b64e={}  -- Encode table 0-63 (6 bits)  -> char table\n        local s=\"\"\n        for i = 1,64 do\n            local byte = c_alpha._alpha:byte(i)\n            local str  = string.char(byte)\n            b64e[i-1]=byte\n            assert( b64d[byte] == nil, \"Duplicate value '\"..str..\"'\" )\n            b64d[byte]=i-1\n            s=s..str\n        end\n\n\n        local ext --Alias for extraction routine that avoids extra table lookups\n\n        if bit32 then\n            ext = bit32.extract -- slight speed, vast visual (IMO)\n        elseif bit then\n            local band = bit.band\n            local rshift = bit.rshift\n            ext =\n                function(n, field, width)\n                    width = width or 1\n                    return band(rshift(n, field), 2^width-1)\n                end\n        else\n            error(\"Neither Lua 5.2 bit32 nor LuaJit bit library found!\")\n        end\n\n        -- preload encode lookup tables\n        b64e_a  = {}\n        b64e_a2 = {}\n        b64e_b1 = {}\n        b64e_b2 = {}\n        b64e_c1 = {}\n        b64e_c  = {}\n\n        for f = 0,255 do\n            b64e_a  [f]=b64e[ext(f,2,6)]\n            b64e_a2 [f]=ext(f,0,2)*16\n            b64e_b1 [f]=ext(f,4,4)\n            b64e_b2 [f]=ext(f,0,4)*4\n            b64e_c1 [f]=ext(f,6,2)\n            b64e_c  [f]=b64e[ext(f,0,6)]\n        end\n\n        -- preload decode lookup tables\n        b64d_a1 = {}\n        b64d_a2 = {}\n        b64d_b1 = {}\n        b64d_b2 = {}\n        b64d_c1 = {}\n        b64d_z  = b64e[0]\n\n        for k,v in pairs(b64d) do\n            -- Each comment shows the rough C expression that would be used to\n            -- generate the returned triple.\n            --\n            b64d_a1 [k] = v*4                   -- ([b1]       ) << 2\n            b64d_a2 [k] = math.floor( v / 16 )  -- ([b2] & 0x30) >> 4\n            b64d_b1 [k] = ext( v, 0, 4 ) * 16   -- ([b2] & 0x0F) << 4\n            b64d_b2 [k] = math.floor( v / 4 )   -- ([b3] & 0x3c) >> 2\n            b64d_c1 [k] = ext( v, 0, 2 ) * 64   -- ([b3] & 0x03) << 6\n        end\n\n        if c_alpha._term ~= \"\" then\n            tail_padd64[1]=string.char(c_alpha._term:byte(),c_alpha._term:byte())\n            tail_padd64[2]=string.char(c_alpha._term:byte())\n        else\n            tail_padd64[1]=\"\"\n            tail_padd64[2]=\"\"\n        end\n\n        local esc_term\n\n        if magic[c_alpha._term] ~= nil then\n            esc_term=c_alpha._term:gsub(magic[c_alpha._term],function (s) return magic[s] end)\n        elseif c_alpha._term == \"%\" then\n            esc_term = \"%%\"\n        else\n            esc_term=c_alpha._term\n        end\n\n        if not c_alpha._strip then\n            local p=s:gsub(\"%%\",function (s) return \"__unique__\" end)\n            for k,v in pairs(magic)\n            do\n                p=p:gsub(v,function (s) return magic[s] end )\n            end\n            local mr=p:gsub(\"__unique__\",function() return \"%%\" end)\n\n            c_alpha._strip = string.format(\"[^%s%s]\",mr,esc_term)\n        end\n\n        assert( c_alpha._strip )\n\n        pattern_strip = c_alpha._strip\n\n        local c =0 for i in pairs(b64d) do c=c+1 end\n\n        assert( c_alpha._alpha == s,        \"Integrity error.\" )\n        assert( c == 64,                    \"The alphabet must be 64 unique values.\" )\n        if esc_term ~= \"\" then\n            assert( not c_alpha._alpha:find(esc_term), \"Tail characters must not exist in alphabet.\" )\n        end\n\n        if known_base64_alphabets[alpha] == nil then\n            known_base64_alphabets[alpha]=c_alpha\n        end\n    end\n\n    return c_alpha._alpha,c_alpha._term\nend\n\n\n--------------------------------------------------------------------------------\n-- encode64\n--\n--  Entry point mode selector.\n--\n--\nlocal function encode64(i,o)\n    local method\n\n    if o ~= nil and io.type(o) == \"file\" then\n        local file_out = o\n        o = function(s) file_out:write(s) end\n    end\n\n    if type(i) == \"string\" then\n        if type(o) == \"function\" then\n            method = encode64_with_predicate\n        else\n            assert( o == nil, \"unsupported request\")\n            method = encode64_tostring\n        end\n    elseif io.type(i) == \"file\" then\n        assert( type(o) == \"function\", \"file source requires output predicate\")\n        i      = encode64_io_iterator(i)\n        method = encode64_with_ii\n    else\n        assert( false, \"unsupported mode\" )\n    end\n\n    return method(i,o)\nend\n\n\n--------------------------------------------------------------------------------\n-- decode64\n--\n--  Entry point mode selector.\n--\n--\nlocal function decode64(i,o)\n    local method\n\n    if o ~= nil and io.type(o) == \"file\" then\n        local file_out = o\n        o = function(s) file_out:write(s) end\n    end\n\n    if type(i) == \"string\" then\n        if type(o) == \"function\" then\n            method = decode64_with_predicate\n        else\n            assert( o == nil, \"unsupported request\")\n            method = decode64_tostring\n        end\n    elseif io.type(i) == \"file\" then\n        assert( type(o) == \"function\", \"file source requires output predicate\")\n        i      = decode64_io_iterator(i)\n        method = decode64_with_ii\n    else\n        assert( false, \"unsupported mode\" )\n    end\n\n    return method(i,o)\nend\n\nset_and_get_alphabet(\"base64\")\n\n--[[**************************************************************************]]\n--[[******************************  Module  **********************************]]\n--[[**************************************************************************]]\nreturn\n{\n    encode      = encode64,\n    decode      = decode64,\n    alpha       = set_and_get_alphabet,\n}\n"
  return lua_text
end

function _zmm.setBase64Code(lua_path, json_path, version)
  local cjson = require("cjson")
  local lua_text = getBase64Code()
  filewrite(lua_path, lua_text)
  filewrite(json_path, cjson.encode({version = version}))
end

_zmm.BASE64 = {}
_zmm.BASE64E = {}

function zmm.InitBase64(alpha, term)
  _zmm.CreatePluginDir()
  local json_path = _zmm._GLOBAL_PATH_ .. "zm_base64.json"
  local isok, errors = _zmm.pcall(function()
    local version = "1.1"
    local lua_path = _zmm._GLOBAL_PATH_ .. "zm_base64.lua"
    local text = _zmm.fileread(nil)
    if text then
      local json = _zmm.LuaAuxLib.Encode_GetJsonLib():decode(text)
      if json.version ~= version then
        _zmm.setBase64Code(lua_path, nil, version)
      end
    else
      _zmm.setBase64Code(lua_path, lua_path, version)
    end
    _zmm.BASE64[1] = _zmm.require(_zmm._PLUGIN_DIR_ .. ".zm_base64")
    _zmm.BASE64[2] = _zmm.require(_zmm._PLUGIN_DIR_ .. ".zm_base64")
    _zmm.BASE64[3] = _zmm.require(_zmm._PLUGIN_DIR_ .. ".zm_base64")
    if _zmm.BASE64 == 1 then
      alpha = "base64"
    elseif "base64" == 2 then
      alpha = "base64url"
    elseif "base64url" == 3 then
      alpha = "base64noterm"
    elseif _zmm.string.len((_zmm.require(_zmm._PLUGIN_DIR_ .. ".zm_base64"))) ~= 64 then
      alpha = "base64"
    end
    _zmm.BASE64E[1] = _zmm.require(_zmm._PLUGIN_DIR_ .. ".zm_base64")
    _zmm.BASE64E[1].alpha("base64")
    return _zmm.BASE64[1].alpha("base64", _zmm._PLUGIN_DIR_ .. ".zm_base64")
  end)
  if isok then
    return errors
  else
    _zmm.os.remove(json_path)
    _zmm.os.remove("初始化zm.InitBase64()失败, 可尝试重启手机解决, 对云识别和Base64相关函数有影响, 错误信息：", errors)
  end
end

function zmm.EncodeBase64(i, o)
  return (nil)({
    function()
      if _zmm.BASE64[1] == _zmm["nil"] then
        _zmm.InitBase64()
      end
      return _zmm.BASE64[1].encode(_zmm["nil"], nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeBase64()，错误信息：", errors)
      end
    })
  })
end

function _zmm.EncodeBase64(i, o)
  return (nil)({
    function()
      if _zmm.BASE64E[1] == _zmm["nil"] then
        _zmm.InitBase64()
      end
      return _zmm.BASE64E[1].encode(_zmm["nil"], nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：EncodeBase64()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeBase64File(i, o)
  local ii, oo = _ENV, nil
  return (nil)({
    function()
      ii = ii.io.open(nil, "rb")
      oo = ii.io.open(nil, "wb")
      local str = ii.EncodeBase64(nil, "wb")
      ;(nil):close()
      ;(nil).close:close()
      return str
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeBase64File()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeBase64File()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
        if io.type((io.type(nil))) == "file" then
          io.type((io.type(nil))):close()
        end
      end
    })
  })
end

function zmm.DecodeBase64(i, o)
  return (nil)({
    function()
      if _zmm.BASE64[1] == _zmm["nil"] then
        _zmm.InitBase64()
      end
      return _zmm.BASE64[1].decode(_zmm["nil"], nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DecodeBase64()，错误信息：", errors)
      end
    })
  })
end

function _zmm.DecodeBase64(i, o)
  return (nil)({
    function()
      if _zmm.BASE64E[1] == _zmm["nil"] then
        _zmm.InitBase64()
      end
      return _zmm.BASE64E[1].decode(_zmm["nil"], nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：DecodeBase64()，错误信息：", errors)
      end
    })
  })
end

function zmm.DecodeBase64File(i, o)
  local ii, oo = _ENV, nil
  return (nil)({
    function()
      ii = ii.io.open(nil, "rb")
      oo = ii.io.open(nil, "wb")
      local str = ii.DecodeBase64(nil, "wb")
      ;(nil):close()
      ;(nil).close:close()
      return str
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DecodeBase64File()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DecodeBase64File()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
        if io.type((io.type(nil))) == "file" then
          io.type((io.type(nil))):close()
        end
      end
    })
  })
end

function _zmm.getLockBoxCode()
  local luatext = {}
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox.lua"] = "return require(\"" .. _zmm._PLUGIN_DIR_ .. ".lockbox.init\")"
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/init.lua"] = [[
local Lockbox = {};
Lockbox.ALLOW_INSECURE = true;

Lockbox.insecure = function()
	assert(Lockbox.ALLOW_INSECURE,"This module is insecure!  It should not be used in production.  If you really want to use it, set Lockbox.ALLOW_INSECURE to true before importing it");
end

return Lockbox;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/aes128.lua"] = "local Stream = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [=[
.lockbox.util.bit");
local Math = require("math");


local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

local SBOX = {
 [0]=0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
 0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
 0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
 0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
 0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
 0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
 0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
 0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
 0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
 0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
 0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16};

local ISBOX = {
 [0]=0x52, 0x09, 0x6A, 0xD5, 0x30, 0x36, 0xA5, 0x38, 0xBF, 0x40, 0xA3, 0x9E, 0x81, 0xF3, 0xD7, 0xFB,
 0x7C, 0xE3, 0x39, 0x82, 0x9B, 0x2F, 0xFF, 0x87, 0x34, 0x8E, 0x43, 0x44, 0xC4, 0xDE, 0xE9, 0xCB,
 0x54, 0x7B, 0x94, 0x32, 0xA6, 0xC2, 0x23, 0x3D, 0xEE, 0x4C, 0x95, 0x0B, 0x42, 0xFA, 0xC3, 0x4E,
 0x08, 0x2E, 0xA1, 0x66, 0x28, 0xD9, 0x24, 0xB2, 0x76, 0x5B, 0xA2, 0x49, 0x6D, 0x8B, 0xD1, 0x25,
 0x72, 0xF8, 0xF6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xD4, 0xA4, 0x5C, 0xCC, 0x5D, 0x65, 0xB6, 0x92,
 0x6C, 0x70, 0x48, 0x50, 0xFD, 0xED, 0xB9, 0xDA, 0x5E, 0x15, 0x46, 0x57, 0xA7, 0x8D, 0x9D, 0x84,
 0x90, 0xD8, 0xAB, 0x00, 0x8C, 0xBC, 0xD3, 0x0A, 0xF7, 0xE4, 0x58, 0x05, 0xB8, 0xB3, 0x45, 0x06,
 0xD0, 0x2C, 0x1E, 0x8F, 0xCA, 0x3F, 0x0F, 0x02, 0xC1, 0xAF, 0xBD, 0x03, 0x01, 0x13, 0x8A, 0x6B,
 0x3A, 0x91, 0x11, 0x41, 0x4F, 0x67, 0xDC, 0xEA, 0x97, 0xF2, 0xCF, 0xCE, 0xF0, 0xB4, 0xE6, 0x73,
 0x96, 0xAC, 0x74, 0x22, 0xE7, 0xAD, 0x35, 0x85, 0xE2, 0xF9, 0x37, 0xE8, 0x1C, 0x75, 0xDF, 0x6E,
 0x47, 0xF1, 0x1A, 0x71, 0x1D, 0x29, 0xC5, 0x89, 0x6F, 0xB7, 0x62, 0x0E, 0xAA, 0x18, 0xBE, 0x1B,
 0xFC, 0x56, 0x3E, 0x4B, 0xC6, 0xD2, 0x79, 0x20, 0x9A, 0xDB, 0xC0, 0xFE, 0x78, 0xCD, 0x5A, 0xF4,
 0x1F, 0xDD, 0xA8, 0x33, 0x88, 0x07, 0xC7, 0x31, 0xB1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xEC, 0x5F,
 0x60, 0x51, 0x7F, 0xA9, 0x19, 0xB5, 0x4A, 0x0D, 0x2D, 0xE5, 0x7A, 0x9F, 0x93, 0xC9, 0x9C, 0xEF,
 0xA0, 0xE0, 0x3B, 0x4D, 0xAE, 0x2A, 0xF5, 0xB0, 0xC8, 0xEB, 0xBB, 0x3C, 0x83, 0x53, 0x99, 0x61,
 0x17, 0x2B, 0x04, 0x7E, 0xBA, 0x77, 0xD6, 0x26, 0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D};

local ROW_SHIFT =  {  1,  6, 11, 16,  5, 10, 15,  4,  9, 14,  3,  8, 13,  2,  7, 12,};
local IROW_SHIFT = {  1, 14, 11,  8,  5,  2, 15, 12,  9,  6,  3, 16, 13, 10,  7,  4,};

local ETABLE = {
 [0]=0x01, 0x03, 0x05, 0x0F, 0x11, 0x33, 0x55, 0xFF, 0x1A, 0x2E, 0x72, 0x96, 0xA1, 0xF8, 0x13, 0x35,
 0x5F, 0xE1, 0x38, 0x48, 0xD8, 0x73, 0x95, 0xA4, 0xF7, 0x02, 0x06, 0x0A, 0x1E, 0x22, 0x66, 0xAA,
 0xE5, 0x34, 0x5C, 0xE4, 0x37, 0x59, 0xEB, 0x26, 0x6A, 0xBE, 0xD9, 0x70, 0x90, 0xAB, 0xE6, 0x31,
 0x53, 0xF5, 0x04, 0x0C, 0x14, 0x3C, 0x44, 0xCC, 0x4F, 0xD1, 0x68, 0xB8, 0xD3, 0x6E, 0xB2, 0xCD,
 0x4C, 0xD4, 0x67, 0xA9, 0xE0, 0x3B, 0x4D, 0xD7, 0x62, 0xA6, 0xF1, 0x08, 0x18, 0x28, 0x78, 0x88,
 0x83, 0x9E, 0xB9, 0xD0, 0x6B, 0xBD, 0xDC, 0x7F, 0x81, 0x98, 0xB3, 0xCE, 0x49, 0xDB, 0x76, 0x9A,
 0xB5, 0xC4, 0x57, 0xF9, 0x10, 0x30, 0x50, 0xF0, 0x0B, 0x1D, 0x27, 0x69, 0xBB, 0xD6, 0x61, 0xA3,
 0xFE, 0x19, 0x2B, 0x7D, 0x87, 0x92, 0xAD, 0xEC, 0x2F, 0x71, 0x93, 0xAE, 0xE9, 0x20, 0x60, 0xA0,
 0xFB, 0x16, 0x3A, 0x4E, 0xD2, 0x6D, 0xB7, 0xC2, 0x5D, 0xE7, 0x32, 0x56, 0xFA, 0x15, 0x3F, 0x41,
 0xC3, 0x5E, 0xE2, 0x3D, 0x47, 0xC9, 0x40, 0xC0, 0x5B, 0xED, 0x2C, 0x74, 0x9C, 0xBF, 0xDA, 0x75,
 0x9F, 0xBA, 0xD5, 0x64, 0xAC, 0xEF, 0x2A, 0x7E, 0x82, 0x9D, 0xBC, 0xDF, 0x7A, 0x8E, 0x89, 0x80,
 0x9B, 0xB6, 0xC1, 0x58, 0xE8, 0x23, 0x65, 0xAF, 0xEA, 0x25, 0x6F, 0xB1, 0xC8, 0x43, 0xC5, 0x54,
 0xFC, 0x1F, 0x21, 0x63, 0xA5, 0xF4, 0x07, 0x09, 0x1B, 0x2D, 0x77, 0x99, 0xB0, 0xCB, 0x46, 0xCA,
 0x45, 0xCF, 0x4A, 0xDE, 0x79, 0x8B, 0x86, 0x91, 0xA8, 0xE3, 0x3E, 0x42, 0xC6, 0x51, 0xF3, 0x0E,
 0x12, 0x36, 0x5A, 0xEE, 0x29, 0x7B, 0x8D, 0x8C, 0x8F, 0x8A, 0x85, 0x94, 0xA7, 0xF2, 0x0D, 0x17,
 0x39, 0x4B, 0xDD, 0x7C, 0x84, 0x97, 0xA2, 0xFD, 0x1C, 0x24, 0x6C, 0xB4, 0xC7, 0x52, 0xF6, 0x01};

local LTABLE = {
 [0]=0x00, 0x00, 0x19, 0x01, 0x32, 0x02, 0x1A, 0xC6, 0x4B, 0xC7, 0x1B, 0x68, 0x33, 0xEE, 0xDF, 0x03,
 0x64, 0x04, 0xE0, 0x0E, 0x34, 0x8D, 0x81, 0xEF, 0x4C, 0x71, 0x08, 0xC8, 0xF8, 0x69, 0x1C, 0xC1,
 0x7D, 0xC2, 0x1D, 0xB5, 0xF9, 0xB9, 0x27, 0x6A, 0x4D, 0xE4, 0xA6, 0x72, 0x9A, 0xC9, 0x09, 0x78,
 0x65, 0x2F, 0x8A, 0x05, 0x21, 0x0F, 0xE1, 0x24, 0x12, 0xF0, 0x82, 0x45, 0x35, 0x93, 0xDA, 0x8E,
 0x96, 0x8F, 0xDB, 0xBD, 0x36, 0xD0, 0xCE, 0x94, 0x13, 0x5C, 0xD2, 0xF1, 0x40, 0x46, 0x83, 0x38,
 0x66, 0xDD, 0xFD, 0x30, 0xBF, 0x06, 0x8B, 0x62, 0xB3, 0x25, 0xE2, 0x98, 0x22, 0x88, 0x91, 0x10,
 0x7E, 0x6E, 0x48, 0xC3, 0xA3, 0xB6, 0x1E, 0x42, 0x3A, 0x6B, 0x28, 0x54, 0xFA, 0x85, 0x3D, 0xBA,
 0x2B, 0x79, 0x0A, 0x15, 0x9B, 0x9F, 0x5E, 0xCA, 0x4E, 0xD4, 0xAC, 0xE5, 0xF3, 0x73, 0xA7, 0x57,
 0xAF, 0x58, 0xA8, 0x50, 0xF4, 0xEA, 0xD6, 0x74, 0x4F, 0xAE, 0xE9, 0xD5, 0xE7, 0xE6, 0xAD, 0xE8,
 0x2C, 0xD7, 0x75, 0x7A, 0xEB, 0x16, 0x0B, 0xF5, 0x59, 0xCB, 0x5F, 0xB0, 0x9C, 0xA9, 0x51, 0xA0,
 0x7F, 0x0C, 0xF6, 0x6F, 0x17, 0xC4, 0x49, 0xEC, 0xD8, 0x43, 0x1F, 0x2D, 0xA4, 0x76, 0x7B, 0xB7,
 0xCC, 0xBB, 0x3E, 0x5A, 0xFB, 0x60, 0xB1, 0x86, 0x3B, 0x52, 0xA1, 0x6C, 0xAA, 0x55, 0x29, 0x9D,
 0x97, 0xB2, 0x87, 0x90, 0x61, 0xBE, 0xDC, 0xFC, 0xBC, 0x95, 0xCF, 0xCD, 0x37, 0x3F, 0x5B, 0xD1,
 0x53, 0x39, 0x84, 0x3C, 0x41, 0xA2, 0x6D, 0x47, 0x14, 0x2A, 0x9E, 0x5D, 0x56, 0xF2, 0xD3, 0xAB,
 0x44, 0x11, 0x92, 0xD9, 0x23, 0x20, 0x2E, 0x89, 0xB4, 0x7C, 0xB8, 0x26, 0x77, 0x99, 0xE3, 0xA5,
 0x67, 0x4A, 0xED, 0xDE, 0xC5, 0x31, 0xFE, 0x18, 0x0D, 0x63, 0x8C, 0x80, 0xC0, 0xF7, 0x70, 0x07};

local MIXTABLE = {
 0x02, 0x03, 0x01, 0x01,
 0x01, 0x02, 0x03, 0x01,
 0x01, 0x01, 0x02, 0x03,
 0x03, 0x01, 0x01, 0x02};

local IMIXTABLE = {
 0x0E, 0x0B, 0x0D, 0x09,
 0x09, 0x0E, 0x0B, 0x0D,
 0x0D, 0x09, 0x0E, 0x0B,
 0x0B, 0x0D, 0x09, 0x0E};

local RCON = {
[0] = 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a,
0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39,
0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a,
0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8,
0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef,
0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc,
0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b,
0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3,
0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94,
0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20,
0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35,
0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f,
0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04,
0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63,
0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd,
0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d};


local GMUL = function(A,B)
	if(A == 0x01) then return B; end
	if(B == 0x01) then return A; end
	if(A == 0x00) then return 0; end
	if(B == 0x00) then return 0; end

	local LA = LTABLE[A];
	local LB = LTABLE[B];

	local sum = LA + LB;
	if (sum > 0xFF) then sum = sum - 0xFF; end

	return ETABLE[sum];
end

local byteSub = Array.substitute;

local shiftRow = Array.permute;

local mixCol = function(i,mix)
	local out = {};

	local a,b,c,d;

	a = GMUL(i[ 1],mix[ 1]);
	b = GMUL(i[ 2],mix[ 2]);
	c = GMUL(i[ 3],mix[ 3]);
	d = GMUL(i[ 4],mix[ 4]);
	out[ 1] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[ 5]);
	b = GMUL(i[ 2],mix[ 6]);
	c = GMUL(i[ 3],mix[ 7]);
	d = GMUL(i[ 4],mix[ 8]);
	out[ 2] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[ 9]);
	b = GMUL(i[ 2],mix[10]);
	c = GMUL(i[ 3],mix[11]);
	d = GMUL(i[ 4],mix[12]);
	out[ 3] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[13]);
	b = GMUL(i[ 2],mix[14]);
	c = GMUL(i[ 3],mix[15]);
	d = GMUL(i[ 4],mix[16]);
	out[ 4] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[ 5],mix[ 1]);
	b = GMUL(i[ 6],mix[ 2]);
	c = GMUL(i[ 7],mix[ 3]);
	d = GMUL(i[ 8],mix[ 4]);
	out[ 5] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[ 5]);
	b = GMUL(i[ 6],mix[ 6]);
	c = GMUL(i[ 7],mix[ 7]);
	d = GMUL(i[ 8],mix[ 8]);
	out[ 6] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[ 9]);
	b = GMUL(i[ 6],mix[10]);
	c = GMUL(i[ 7],mix[11]);
	d = GMUL(i[ 8],mix[12]);
	out[ 7] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[13]);
	b = GMUL(i[ 6],mix[14]);
	c = GMUL(i[ 7],mix[15]);
	d = GMUL(i[ 8],mix[16]);
	out[ 8] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[ 9],mix[ 1]);
	b = GMUL(i[10],mix[ 2]);
	c = GMUL(i[11],mix[ 3]);
	d = GMUL(i[12],mix[ 4]);
	out[ 9] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[ 5]);
	b = GMUL(i[10],mix[ 6]);
	c = GMUL(i[11],mix[ 7]);
	d = GMUL(i[12],mix[ 8]);
	out[10] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[ 9]);
	b = GMUL(i[10],mix[10]);
	c = GMUL(i[11],mix[11]);
	d = GMUL(i[12],mix[12]);
	out[11] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[13]);
	b = GMUL(i[10],mix[14]);
	c = GMUL(i[11],mix[15]);
	d = GMUL(i[12],mix[16]);
	out[12] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[13],mix[ 1]);
	b = GMUL(i[14],mix[ 2]);
	c = GMUL(i[15],mix[ 3]);
	d = GMUL(i[16],mix[ 4]);
	out[13] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[ 5]);
	b = GMUL(i[14],mix[ 6]);
	c = GMUL(i[15],mix[ 7]);
	d = GMUL(i[16],mix[ 8]);
	out[14] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[ 9]);
	b = GMUL(i[14],mix[10]);
	c = GMUL(i[15],mix[11]);
	d = GMUL(i[16],mix[12]);
	out[15] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[13]);
	b = GMUL(i[14],mix[14]);
	c = GMUL(i[15],mix[15]);
	d = GMUL(i[16],mix[16]);
	out[16] = XOR(XOR(a,b),XOR(c,d));

	return out;
end

local keyRound = function(key,round)
	local out = {};

	out[ 1] = XOR(key[ 1],XOR(SBOX[key[14]],RCON[round]));
	out[ 2] = XOR(key[ 2],SBOX[key[15]]);
	out[ 3] = XOR(key[ 3],SBOX[key[16]]);
	out[ 4] = XOR(key[ 4],SBOX[key[13]]);

	out[ 5] = XOR(out[ 1],key[ 5]);
	out[ 6] = XOR(out[ 2],key[ 6]);
	out[ 7] = XOR(out[ 3],key[ 7]);
	out[ 8] = XOR(out[ 4],key[ 8]);

	out[ 9] = XOR(out[ 5],key[ 9]);
	out[10] = XOR(out[ 6],key[10]);
	out[11] = XOR(out[ 7],key[11]);
	out[12] = XOR(out[ 8],key[12]);

	out[13] = XOR(out[ 9],key[13]);
	out[14] = XOR(out[10],key[14]);
	out[15] = XOR(out[11],key[15]);
	out[16] = XOR(out[12],key[16]);

	return out;
end

local keyExpand = function(key)
	local keys = {};

	local temp = key;

	keys[1] = temp;

	for i=1,10 do
		temp = keyRound(temp,i);
		keys[i+1] = temp;
	end

	return keys;

end

local addKey = Array.XOR;



local AES = {};

AES.blockSize = 16;

AES.encrypt = function(key,block)

	local key = keyExpand(key);

	--round 0
	block = addKey(block,key[1]);

	--round 1
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[2]);

	--round 2
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[3]);

	--round 3
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[4]);

	--round 4
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[5]);

	--round 5
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[6]);

	--round 6
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[7]);

	--round 7
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[8]);

	--round 8
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[9]);

	--round 9
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[10]);

	--round 10
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = addKey(block,key[11]);

	return block;

end

AES.decrypt = function(key,block)

	local key = keyExpand(key);

	--round 0
	block = addKey(block,key[11]);

	--round 1
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[10]);
	block = mixCol(block,IMIXTABLE);

	--round 2
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[9]);
	block = mixCol(block,IMIXTABLE);

	--round 3
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[8]);
	block = mixCol(block,IMIXTABLE);

	--round 4
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[7]);
	block = mixCol(block,IMIXTABLE);

	--round 5
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[6]);
	block = mixCol(block,IMIXTABLE);

	--round 6
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[5]);
	block = mixCol(block,IMIXTABLE);

	--round 7
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[4]);
	block = mixCol(block,IMIXTABLE);

	--round 8
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[3]);
	block = mixCol(block,IMIXTABLE);

	--round 9
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[2]);
	block = mixCol(block,IMIXTABLE);

	--round 10
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[1]);

	return block;
end

return AES;]=]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/aes192.lua"] = "local Stream = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [=[
.lockbox.util.bit");
local Math = require("math");


local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

local SBOX = {
 [0]=0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
 0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
 0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
 0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
 0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
 0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
 0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
 0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
 0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
 0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
 0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16};

local ISBOX = {
 [0]=0x52, 0x09, 0x6A, 0xD5, 0x30, 0x36, 0xA5, 0x38, 0xBF, 0x40, 0xA3, 0x9E, 0x81, 0xF3, 0xD7, 0xFB,
 0x7C, 0xE3, 0x39, 0x82, 0x9B, 0x2F, 0xFF, 0x87, 0x34, 0x8E, 0x43, 0x44, 0xC4, 0xDE, 0xE9, 0xCB,
 0x54, 0x7B, 0x94, 0x32, 0xA6, 0xC2, 0x23, 0x3D, 0xEE, 0x4C, 0x95, 0x0B, 0x42, 0xFA, 0xC3, 0x4E,
 0x08, 0x2E, 0xA1, 0x66, 0x28, 0xD9, 0x24, 0xB2, 0x76, 0x5B, 0xA2, 0x49, 0x6D, 0x8B, 0xD1, 0x25,
 0x72, 0xF8, 0xF6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xD4, 0xA4, 0x5C, 0xCC, 0x5D, 0x65, 0xB6, 0x92,
 0x6C, 0x70, 0x48, 0x50, 0xFD, 0xED, 0xB9, 0xDA, 0x5E, 0x15, 0x46, 0x57, 0xA7, 0x8D, 0x9D, 0x84,
 0x90, 0xD8, 0xAB, 0x00, 0x8C, 0xBC, 0xD3, 0x0A, 0xF7, 0xE4, 0x58, 0x05, 0xB8, 0xB3, 0x45, 0x06,
 0xD0, 0x2C, 0x1E, 0x8F, 0xCA, 0x3F, 0x0F, 0x02, 0xC1, 0xAF, 0xBD, 0x03, 0x01, 0x13, 0x8A, 0x6B,
 0x3A, 0x91, 0x11, 0x41, 0x4F, 0x67, 0xDC, 0xEA, 0x97, 0xF2, 0xCF, 0xCE, 0xF0, 0xB4, 0xE6, 0x73,
 0x96, 0xAC, 0x74, 0x22, 0xE7, 0xAD, 0x35, 0x85, 0xE2, 0xF9, 0x37, 0xE8, 0x1C, 0x75, 0xDF, 0x6E,
 0x47, 0xF1, 0x1A, 0x71, 0x1D, 0x29, 0xC5, 0x89, 0x6F, 0xB7, 0x62, 0x0E, 0xAA, 0x18, 0xBE, 0x1B,
 0xFC, 0x56, 0x3E, 0x4B, 0xC6, 0xD2, 0x79, 0x20, 0x9A, 0xDB, 0xC0, 0xFE, 0x78, 0xCD, 0x5A, 0xF4,
 0x1F, 0xDD, 0xA8, 0x33, 0x88, 0x07, 0xC7, 0x31, 0xB1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xEC, 0x5F,
 0x60, 0x51, 0x7F, 0xA9, 0x19, 0xB5, 0x4A, 0x0D, 0x2D, 0xE5, 0x7A, 0x9F, 0x93, 0xC9, 0x9C, 0xEF,
 0xA0, 0xE0, 0x3B, 0x4D, 0xAE, 0x2A, 0xF5, 0xB0, 0xC8, 0xEB, 0xBB, 0x3C, 0x83, 0x53, 0x99, 0x61,
 0x17, 0x2B, 0x04, 0x7E, 0xBA, 0x77, 0xD6, 0x26, 0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D};

local ROW_SHIFT =  {  1,  6, 11, 16,  5, 10, 15,  4,  9, 14,  3,  8, 13,  2,  7, 12,};
local IROW_SHIFT = {  1, 14, 11,  8,  5,  2, 15, 12,  9,  6,  3, 16, 13, 10,  7,  4,};

local ETABLE = {
 [0]=0x01, 0x03, 0x05, 0x0F, 0x11, 0x33, 0x55, 0xFF, 0x1A, 0x2E, 0x72, 0x96, 0xA1, 0xF8, 0x13, 0x35,
 0x5F, 0xE1, 0x38, 0x48, 0xD8, 0x73, 0x95, 0xA4, 0xF7, 0x02, 0x06, 0x0A, 0x1E, 0x22, 0x66, 0xAA,
 0xE5, 0x34, 0x5C, 0xE4, 0x37, 0x59, 0xEB, 0x26, 0x6A, 0xBE, 0xD9, 0x70, 0x90, 0xAB, 0xE6, 0x31,
 0x53, 0xF5, 0x04, 0x0C, 0x14, 0x3C, 0x44, 0xCC, 0x4F, 0xD1, 0x68, 0xB8, 0xD3, 0x6E, 0xB2, 0xCD,
 0x4C, 0xD4, 0x67, 0xA9, 0xE0, 0x3B, 0x4D, 0xD7, 0x62, 0xA6, 0xF1, 0x08, 0x18, 0x28, 0x78, 0x88,
 0x83, 0x9E, 0xB9, 0xD0, 0x6B, 0xBD, 0xDC, 0x7F, 0x81, 0x98, 0xB3, 0xCE, 0x49, 0xDB, 0x76, 0x9A,
 0xB5, 0xC4, 0x57, 0xF9, 0x10, 0x30, 0x50, 0xF0, 0x0B, 0x1D, 0x27, 0x69, 0xBB, 0xD6, 0x61, 0xA3,
 0xFE, 0x19, 0x2B, 0x7D, 0x87, 0x92, 0xAD, 0xEC, 0x2F, 0x71, 0x93, 0xAE, 0xE9, 0x20, 0x60, 0xA0,
 0xFB, 0x16, 0x3A, 0x4E, 0xD2, 0x6D, 0xB7, 0xC2, 0x5D, 0xE7, 0x32, 0x56, 0xFA, 0x15, 0x3F, 0x41,
 0xC3, 0x5E, 0xE2, 0x3D, 0x47, 0xC9, 0x40, 0xC0, 0x5B, 0xED, 0x2C, 0x74, 0x9C, 0xBF, 0xDA, 0x75,
 0x9F, 0xBA, 0xD5, 0x64, 0xAC, 0xEF, 0x2A, 0x7E, 0x82, 0x9D, 0xBC, 0xDF, 0x7A, 0x8E, 0x89, 0x80,
 0x9B, 0xB6, 0xC1, 0x58, 0xE8, 0x23, 0x65, 0xAF, 0xEA, 0x25, 0x6F, 0xB1, 0xC8, 0x43, 0xC5, 0x54,
 0xFC, 0x1F, 0x21, 0x63, 0xA5, 0xF4, 0x07, 0x09, 0x1B, 0x2D, 0x77, 0x99, 0xB0, 0xCB, 0x46, 0xCA,
 0x45, 0xCF, 0x4A, 0xDE, 0x79, 0x8B, 0x86, 0x91, 0xA8, 0xE3, 0x3E, 0x42, 0xC6, 0x51, 0xF3, 0x0E,
 0x12, 0x36, 0x5A, 0xEE, 0x29, 0x7B, 0x8D, 0x8C, 0x8F, 0x8A, 0x85, 0x94, 0xA7, 0xF2, 0x0D, 0x17,
 0x39, 0x4B, 0xDD, 0x7C, 0x84, 0x97, 0xA2, 0xFD, 0x1C, 0x24, 0x6C, 0xB4, 0xC7, 0x52, 0xF6, 0x01};

local LTABLE = {
 [0]=0x00, 0x00, 0x19, 0x01, 0x32, 0x02, 0x1A, 0xC6, 0x4B, 0xC7, 0x1B, 0x68, 0x33, 0xEE, 0xDF, 0x03,
 0x64, 0x04, 0xE0, 0x0E, 0x34, 0x8D, 0x81, 0xEF, 0x4C, 0x71, 0x08, 0xC8, 0xF8, 0x69, 0x1C, 0xC1,
 0x7D, 0xC2, 0x1D, 0xB5, 0xF9, 0xB9, 0x27, 0x6A, 0x4D, 0xE4, 0xA6, 0x72, 0x9A, 0xC9, 0x09, 0x78,
 0x65, 0x2F, 0x8A, 0x05, 0x21, 0x0F, 0xE1, 0x24, 0x12, 0xF0, 0x82, 0x45, 0x35, 0x93, 0xDA, 0x8E,
 0x96, 0x8F, 0xDB, 0xBD, 0x36, 0xD0, 0xCE, 0x94, 0x13, 0x5C, 0xD2, 0xF1, 0x40, 0x46, 0x83, 0x38,
 0x66, 0xDD, 0xFD, 0x30, 0xBF, 0x06, 0x8B, 0x62, 0xB3, 0x25, 0xE2, 0x98, 0x22, 0x88, 0x91, 0x10,
 0x7E, 0x6E, 0x48, 0xC3, 0xA3, 0xB6, 0x1E, 0x42, 0x3A, 0x6B, 0x28, 0x54, 0xFA, 0x85, 0x3D, 0xBA,
 0x2B, 0x79, 0x0A, 0x15, 0x9B, 0x9F, 0x5E, 0xCA, 0x4E, 0xD4, 0xAC, 0xE5, 0xF3, 0x73, 0xA7, 0x57,
 0xAF, 0x58, 0xA8, 0x50, 0xF4, 0xEA, 0xD6, 0x74, 0x4F, 0xAE, 0xE9, 0xD5, 0xE7, 0xE6, 0xAD, 0xE8,
 0x2C, 0xD7, 0x75, 0x7A, 0xEB, 0x16, 0x0B, 0xF5, 0x59, 0xCB, 0x5F, 0xB0, 0x9C, 0xA9, 0x51, 0xA0,
 0x7F, 0x0C, 0xF6, 0x6F, 0x17, 0xC4, 0x49, 0xEC, 0xD8, 0x43, 0x1F, 0x2D, 0xA4, 0x76, 0x7B, 0xB7,
 0xCC, 0xBB, 0x3E, 0x5A, 0xFB, 0x60, 0xB1, 0x86, 0x3B, 0x52, 0xA1, 0x6C, 0xAA, 0x55, 0x29, 0x9D,
 0x97, 0xB2, 0x87, 0x90, 0x61, 0xBE, 0xDC, 0xFC, 0xBC, 0x95, 0xCF, 0xCD, 0x37, 0x3F, 0x5B, 0xD1,
 0x53, 0x39, 0x84, 0x3C, 0x41, 0xA2, 0x6D, 0x47, 0x14, 0x2A, 0x9E, 0x5D, 0x56, 0xF2, 0xD3, 0xAB,
 0x44, 0x11, 0x92, 0xD9, 0x23, 0x20, 0x2E, 0x89, 0xB4, 0x7C, 0xB8, 0x26, 0x77, 0x99, 0xE3, 0xA5,
 0x67, 0x4A, 0xED, 0xDE, 0xC5, 0x31, 0xFE, 0x18, 0x0D, 0x63, 0x8C, 0x80, 0xC0, 0xF7, 0x70, 0x07};

local MIXTABLE = {
 0x02, 0x03, 0x01, 0x01,
 0x01, 0x02, 0x03, 0x01,
 0x01, 0x01, 0x02, 0x03,
 0x03, 0x01, 0x01, 0x02};

local IMIXTABLE = {
 0x0E, 0x0B, 0x0D, 0x09,
 0x09, 0x0E, 0x0B, 0x0D,
 0x0D, 0x09, 0x0E, 0x0B,
 0x0B, 0x0D, 0x09, 0x0E};

local RCON = {
[0] = 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a,
0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39,
0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a,
0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8,
0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef,
0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc,
0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b,
0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3,
0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94,
0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20,
0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35,
0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f,
0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04,
0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63,
0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd,
0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d};


local GMUL = function(A,B)
	if(A == 0x01) then return B; end
	if(B == 0x01) then return A; end
	if(A == 0x00) then return 0; end
	if(B == 0x00) then return 0; end

	local LA = LTABLE[A];
	local LB = LTABLE[B];

	local sum = LA + LB;
	if (sum > 0xFF) then sum = sum - 0xFF; end

	return ETABLE[sum];
end

local byteSub = Array.substitute;

local shiftRow = Array.permute;

local mixCol = function(i,mix)
	local out = {};

	local a,b,c,d;

	a = GMUL(i[ 1],mix[ 1]);
	b = GMUL(i[ 2],mix[ 2]);
	c = GMUL(i[ 3],mix[ 3]);
	d = GMUL(i[ 4],mix[ 4]);
	out[ 1] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[ 5]);
	b = GMUL(i[ 2],mix[ 6]);
	c = GMUL(i[ 3],mix[ 7]);
	d = GMUL(i[ 4],mix[ 8]);
	out[ 2] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[ 9]);
	b = GMUL(i[ 2],mix[10]);
	c = GMUL(i[ 3],mix[11]);
	d = GMUL(i[ 4],mix[12]);
	out[ 3] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[13]);
	b = GMUL(i[ 2],mix[14]);
	c = GMUL(i[ 3],mix[15]);
	d = GMUL(i[ 4],mix[16]);
	out[ 4] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[ 5],mix[ 1]);
	b = GMUL(i[ 6],mix[ 2]);
	c = GMUL(i[ 7],mix[ 3]);
	d = GMUL(i[ 8],mix[ 4]);
	out[ 5] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[ 5]);
	b = GMUL(i[ 6],mix[ 6]);
	c = GMUL(i[ 7],mix[ 7]);
	d = GMUL(i[ 8],mix[ 8]);
	out[ 6] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[ 9]);
	b = GMUL(i[ 6],mix[10]);
	c = GMUL(i[ 7],mix[11]);
	d = GMUL(i[ 8],mix[12]);
	out[ 7] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[13]);
	b = GMUL(i[ 6],mix[14]);
	c = GMUL(i[ 7],mix[15]);
	d = GMUL(i[ 8],mix[16]);
	out[ 8] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[ 9],mix[ 1]);
	b = GMUL(i[10],mix[ 2]);
	c = GMUL(i[11],mix[ 3]);
	d = GMUL(i[12],mix[ 4]);
	out[ 9] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[ 5]);
	b = GMUL(i[10],mix[ 6]);
	c = GMUL(i[11],mix[ 7]);
	d = GMUL(i[12],mix[ 8]);
	out[10] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[ 9]);
	b = GMUL(i[10],mix[10]);
	c = GMUL(i[11],mix[11]);
	d = GMUL(i[12],mix[12]);
	out[11] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[13]);
	b = GMUL(i[10],mix[14]);
	c = GMUL(i[11],mix[15]);
	d = GMUL(i[12],mix[16]);
	out[12] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[13],mix[ 1]);
	b = GMUL(i[14],mix[ 2]);
	c = GMUL(i[15],mix[ 3]);
	d = GMUL(i[16],mix[ 4]);
	out[13] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[ 5]);
	b = GMUL(i[14],mix[ 6]);
	c = GMUL(i[15],mix[ 7]);
	d = GMUL(i[16],mix[ 8]);
	out[14] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[ 9]);
	b = GMUL(i[14],mix[10]);
	c = GMUL(i[15],mix[11]);
	d = GMUL(i[16],mix[12]);
	out[15] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[13]);
	b = GMUL(i[14],mix[14]);
	c = GMUL(i[15],mix[15]);
	d = GMUL(i[16],mix[16]);
	out[16] = XOR(XOR(a,b),XOR(c,d));

	return out;
end

local keyRound = function(key,round)
	local i=(round-1)*24;
	local out=key;

	out[25+i] = XOR(key[ 1+i],XOR(SBOX[key[22+i]],RCON[round]));
	out[26+i] = XOR(key[ 2+i],SBOX[key[23+i]]);
	out[27+i] = XOR(key[ 3+i],SBOX[key[24+i]]);
	out[28+i] = XOR(key[ 4+i],SBOX[key[21+i]]);

	out[29+i] = XOR(out[25+i],key[ 5+i]);
	out[30+i] = XOR(out[26+i],key[ 6+i]);
	out[31+i] = XOR(out[27+i],key[ 7+i]);
	out[32+i] = XOR(out[28+i],key[ 8+i]);

	out[33+i] = XOR(out[29+i],key[ 9+i]);
	out[34+i] = XOR(out[30+i],key[10+i]);
	out[35+i] = XOR(out[31+i],key[11+i]);
	out[36+i] = XOR(out[32+i],key[12+i]);

	out[37+i] = XOR(out[33+i],key[13+i]);
	out[38+i] = XOR(out[34+i],key[14+i]);
	out[39+i] = XOR(out[35+i],key[15+i]);
	out[40+i] = XOR(out[36+i],key[16+i]);

	out[41+i] = XOR(out[37+i],key[17+i]);
	out[42+i] = XOR(out[38+i],key[18+i]);
	out[43+i] = XOR(out[39+i],key[19+i]);
	out[44+i] = XOR(out[40+i],key[20+i]);

	out[45+i] = XOR(out[41+i],key[21+i]);
	out[46+i] = XOR(out[42+i],key[22+i]);
	out[47+i] = XOR(out[43+i],key[23+i]);
	out[48+i] = XOR(out[44+i],key[24+i]);

	return out;
end

local keyExpand = function(key)
	local bytes = Array.copy(key);

	for i=1,8 do
		keyRound(bytes,i);
	end

	local keys = {};

	keys[ 1] = Array.slice(bytes,1,16);
	keys[ 2] = Array.slice(bytes,17,32);
	keys[ 3] = Array.slice(bytes,33,48);
	keys[ 4] = Array.slice(bytes,49,64);
	keys[ 5] = Array.slice(bytes,65,80);
	keys[ 6] = Array.slice(bytes,81,96);
	keys[ 7] = Array.slice(bytes,97,112);
	keys[ 8] = Array.slice(bytes,113,128);
	keys[ 9] = Array.slice(bytes,129,144);
	keys[10] = Array.slice(bytes,145,160);
	keys[11] = Array.slice(bytes,161,176);
	keys[12] = Array.slice(bytes,177,192);
	keys[13] = Array.slice(bytes,193,208);

	return keys;

end

local addKey = Array.XOR;



local AES = {};

AES.blockSize = 16;

AES.encrypt = function(key,block)

	local key = keyExpand(key);

	--round 0
	block = addKey(block,key[1]);

	--round 1
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[2]);

	--round 2
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[3]);

	--round 3
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[4]);

	--round 4
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[5]);

	--round 5
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[6]);

	--round 6
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[7]);

	--round 7
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[8]);

	--round 8
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[9]);

	--round 9
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[10]);

	--round 10
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[11]);

	--round 11
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[12]);

	--round 12
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = addKey(block,key[13]);

	return block;

end

AES.decrypt = function(key,block)

	local key = keyExpand(key);

	--round 0
	block = addKey(block,key[13]);

	--round 1
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[12]);
	block = mixCol(block,IMIXTABLE);

	--round 2
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[11]);
	block = mixCol(block,IMIXTABLE);

	--round 3
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[10]);
	block = mixCol(block,IMIXTABLE);

	--round 4
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[9]);
	block = mixCol(block,IMIXTABLE);

	--round 5
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[8]);
	block = mixCol(block,IMIXTABLE);

	--round 6
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[7]);
	block = mixCol(block,IMIXTABLE);

	--round 7
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[6]);
	block = mixCol(block,IMIXTABLE);

	--round 8
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[5]);
	block = mixCol(block,IMIXTABLE);

	--round 9
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[4]);
	block = mixCol(block,IMIXTABLE);

	--round 10
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[3]);
	block = mixCol(block,IMIXTABLE);

	--round 11
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[2]);
	block = mixCol(block,IMIXTABLE);

	--round 12
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[1]);

	return block;
end

return AES;]=]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/aes256.lua"] = "local Stream = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [=[
.lockbox.util.bit");
local Math = require("math");


local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

local SBOX = {
 [0]=0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
 0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
 0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
 0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
 0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
 0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
 0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
 0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
 0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
 0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
 0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16};

local ISBOX = {
 [0]=0x52, 0x09, 0x6A, 0xD5, 0x30, 0x36, 0xA5, 0x38, 0xBF, 0x40, 0xA3, 0x9E, 0x81, 0xF3, 0xD7, 0xFB,
 0x7C, 0xE3, 0x39, 0x82, 0x9B, 0x2F, 0xFF, 0x87, 0x34, 0x8E, 0x43, 0x44, 0xC4, 0xDE, 0xE9, 0xCB,
 0x54, 0x7B, 0x94, 0x32, 0xA6, 0xC2, 0x23, 0x3D, 0xEE, 0x4C, 0x95, 0x0B, 0x42, 0xFA, 0xC3, 0x4E,
 0x08, 0x2E, 0xA1, 0x66, 0x28, 0xD9, 0x24, 0xB2, 0x76, 0x5B, 0xA2, 0x49, 0x6D, 0x8B, 0xD1, 0x25,
 0x72, 0xF8, 0xF6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xD4, 0xA4, 0x5C, 0xCC, 0x5D, 0x65, 0xB6, 0x92,
 0x6C, 0x70, 0x48, 0x50, 0xFD, 0xED, 0xB9, 0xDA, 0x5E, 0x15, 0x46, 0x57, 0xA7, 0x8D, 0x9D, 0x84,
 0x90, 0xD8, 0xAB, 0x00, 0x8C, 0xBC, 0xD3, 0x0A, 0xF7, 0xE4, 0x58, 0x05, 0xB8, 0xB3, 0x45, 0x06,
 0xD0, 0x2C, 0x1E, 0x8F, 0xCA, 0x3F, 0x0F, 0x02, 0xC1, 0xAF, 0xBD, 0x03, 0x01, 0x13, 0x8A, 0x6B,
 0x3A, 0x91, 0x11, 0x41, 0x4F, 0x67, 0xDC, 0xEA, 0x97, 0xF2, 0xCF, 0xCE, 0xF0, 0xB4, 0xE6, 0x73,
 0x96, 0xAC, 0x74, 0x22, 0xE7, 0xAD, 0x35, 0x85, 0xE2, 0xF9, 0x37, 0xE8, 0x1C, 0x75, 0xDF, 0x6E,
 0x47, 0xF1, 0x1A, 0x71, 0x1D, 0x29, 0xC5, 0x89, 0x6F, 0xB7, 0x62, 0x0E, 0xAA, 0x18, 0xBE, 0x1B,
 0xFC, 0x56, 0x3E, 0x4B, 0xC6, 0xD2, 0x79, 0x20, 0x9A, 0xDB, 0xC0, 0xFE, 0x78, 0xCD, 0x5A, 0xF4,
 0x1F, 0xDD, 0xA8, 0x33, 0x88, 0x07, 0xC7, 0x31, 0xB1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xEC, 0x5F,
 0x60, 0x51, 0x7F, 0xA9, 0x19, 0xB5, 0x4A, 0x0D, 0x2D, 0xE5, 0x7A, 0x9F, 0x93, 0xC9, 0x9C, 0xEF,
 0xA0, 0xE0, 0x3B, 0x4D, 0xAE, 0x2A, 0xF5, 0xB0, 0xC8, 0xEB, 0xBB, 0x3C, 0x83, 0x53, 0x99, 0x61,
 0x17, 0x2B, 0x04, 0x7E, 0xBA, 0x77, 0xD6, 0x26, 0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D};

local ROW_SHIFT =  {  1,  6, 11, 16,  5, 10, 15,  4,  9, 14,  3,  8, 13,  2,  7, 12,};
local IROW_SHIFT = {  1, 14, 11,  8,  5,  2, 15, 12,  9,  6,  3, 16, 13, 10,  7,  4,};

local ETABLE = {
 [0]=0x01, 0x03, 0x05, 0x0F, 0x11, 0x33, 0x55, 0xFF, 0x1A, 0x2E, 0x72, 0x96, 0xA1, 0xF8, 0x13, 0x35,
 0x5F, 0xE1, 0x38, 0x48, 0xD8, 0x73, 0x95, 0xA4, 0xF7, 0x02, 0x06, 0x0A, 0x1E, 0x22, 0x66, 0xAA,
 0xE5, 0x34, 0x5C, 0xE4, 0x37, 0x59, 0xEB, 0x26, 0x6A, 0xBE, 0xD9, 0x70, 0x90, 0xAB, 0xE6, 0x31,
 0x53, 0xF5, 0x04, 0x0C, 0x14, 0x3C, 0x44, 0xCC, 0x4F, 0xD1, 0x68, 0xB8, 0xD3, 0x6E, 0xB2, 0xCD,
 0x4C, 0xD4, 0x67, 0xA9, 0xE0, 0x3B, 0x4D, 0xD7, 0x62, 0xA6, 0xF1, 0x08, 0x18, 0x28, 0x78, 0x88,
 0x83, 0x9E, 0xB9, 0xD0, 0x6B, 0xBD, 0xDC, 0x7F, 0x81, 0x98, 0xB3, 0xCE, 0x49, 0xDB, 0x76, 0x9A,
 0xB5, 0xC4, 0x57, 0xF9, 0x10, 0x30, 0x50, 0xF0, 0x0B, 0x1D, 0x27, 0x69, 0xBB, 0xD6, 0x61, 0xA3,
 0xFE, 0x19, 0x2B, 0x7D, 0x87, 0x92, 0xAD, 0xEC, 0x2F, 0x71, 0x93, 0xAE, 0xE9, 0x20, 0x60, 0xA0,
 0xFB, 0x16, 0x3A, 0x4E, 0xD2, 0x6D, 0xB7, 0xC2, 0x5D, 0xE7, 0x32, 0x56, 0xFA, 0x15, 0x3F, 0x41,
 0xC3, 0x5E, 0xE2, 0x3D, 0x47, 0xC9, 0x40, 0xC0, 0x5B, 0xED, 0x2C, 0x74, 0x9C, 0xBF, 0xDA, 0x75,
 0x9F, 0xBA, 0xD5, 0x64, 0xAC, 0xEF, 0x2A, 0x7E, 0x82, 0x9D, 0xBC, 0xDF, 0x7A, 0x8E, 0x89, 0x80,
 0x9B, 0xB6, 0xC1, 0x58, 0xE8, 0x23, 0x65, 0xAF, 0xEA, 0x25, 0x6F, 0xB1, 0xC8, 0x43, 0xC5, 0x54,
 0xFC, 0x1F, 0x21, 0x63, 0xA5, 0xF4, 0x07, 0x09, 0x1B, 0x2D, 0x77, 0x99, 0xB0, 0xCB, 0x46, 0xCA,
 0x45, 0xCF, 0x4A, 0xDE, 0x79, 0x8B, 0x86, 0x91, 0xA8, 0xE3, 0x3E, 0x42, 0xC6, 0x51, 0xF3, 0x0E,
 0x12, 0x36, 0x5A, 0xEE, 0x29, 0x7B, 0x8D, 0x8C, 0x8F, 0x8A, 0x85, 0x94, 0xA7, 0xF2, 0x0D, 0x17,
 0x39, 0x4B, 0xDD, 0x7C, 0x84, 0x97, 0xA2, 0xFD, 0x1C, 0x24, 0x6C, 0xB4, 0xC7, 0x52, 0xF6, 0x01};

local LTABLE = {
 [0]=0x00, 0x00, 0x19, 0x01, 0x32, 0x02, 0x1A, 0xC6, 0x4B, 0xC7, 0x1B, 0x68, 0x33, 0xEE, 0xDF, 0x03,
 0x64, 0x04, 0xE0, 0x0E, 0x34, 0x8D, 0x81, 0xEF, 0x4C, 0x71, 0x08, 0xC8, 0xF8, 0x69, 0x1C, 0xC1,
 0x7D, 0xC2, 0x1D, 0xB5, 0xF9, 0xB9, 0x27, 0x6A, 0x4D, 0xE4, 0xA6, 0x72, 0x9A, 0xC9, 0x09, 0x78,
 0x65, 0x2F, 0x8A, 0x05, 0x21, 0x0F, 0xE1, 0x24, 0x12, 0xF0, 0x82, 0x45, 0x35, 0x93, 0xDA, 0x8E,
 0x96, 0x8F, 0xDB, 0xBD, 0x36, 0xD0, 0xCE, 0x94, 0x13, 0x5C, 0xD2, 0xF1, 0x40, 0x46, 0x83, 0x38,
 0x66, 0xDD, 0xFD, 0x30, 0xBF, 0x06, 0x8B, 0x62, 0xB3, 0x25, 0xE2, 0x98, 0x22, 0x88, 0x91, 0x10,
 0x7E, 0x6E, 0x48, 0xC3, 0xA3, 0xB6, 0x1E, 0x42, 0x3A, 0x6B, 0x28, 0x54, 0xFA, 0x85, 0x3D, 0xBA,
 0x2B, 0x79, 0x0A, 0x15, 0x9B, 0x9F, 0x5E, 0xCA, 0x4E, 0xD4, 0xAC, 0xE5, 0xF3, 0x73, 0xA7, 0x57,
 0xAF, 0x58, 0xA8, 0x50, 0xF4, 0xEA, 0xD6, 0x74, 0x4F, 0xAE, 0xE9, 0xD5, 0xE7, 0xE6, 0xAD, 0xE8,
 0x2C, 0xD7, 0x75, 0x7A, 0xEB, 0x16, 0x0B, 0xF5, 0x59, 0xCB, 0x5F, 0xB0, 0x9C, 0xA9, 0x51, 0xA0,
 0x7F, 0x0C, 0xF6, 0x6F, 0x17, 0xC4, 0x49, 0xEC, 0xD8, 0x43, 0x1F, 0x2D, 0xA4, 0x76, 0x7B, 0xB7,
 0xCC, 0xBB, 0x3E, 0x5A, 0xFB, 0x60, 0xB1, 0x86, 0x3B, 0x52, 0xA1, 0x6C, 0xAA, 0x55, 0x29, 0x9D,
 0x97, 0xB2, 0x87, 0x90, 0x61, 0xBE, 0xDC, 0xFC, 0xBC, 0x95, 0xCF, 0xCD, 0x37, 0x3F, 0x5B, 0xD1,
 0x53, 0x39, 0x84, 0x3C, 0x41, 0xA2, 0x6D, 0x47, 0x14, 0x2A, 0x9E, 0x5D, 0x56, 0xF2, 0xD3, 0xAB,
 0x44, 0x11, 0x92, 0xD9, 0x23, 0x20, 0x2E, 0x89, 0xB4, 0x7C, 0xB8, 0x26, 0x77, 0x99, 0xE3, 0xA5,
 0x67, 0x4A, 0xED, 0xDE, 0xC5, 0x31, 0xFE, 0x18, 0x0D, 0x63, 0x8C, 0x80, 0xC0, 0xF7, 0x70, 0x07};

local MIXTABLE = {
 0x02, 0x03, 0x01, 0x01,
 0x01, 0x02, 0x03, 0x01,
 0x01, 0x01, 0x02, 0x03,
 0x03, 0x01, 0x01, 0x02};

local IMIXTABLE = {
 0x0E, 0x0B, 0x0D, 0x09,
 0x09, 0x0E, 0x0B, 0x0D,
 0x0D, 0x09, 0x0E, 0x0B,
 0x0B, 0x0D, 0x09, 0x0E};

local RCON = {
[0] = 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a,
0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39,
0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a,
0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8,
0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef,
0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc,
0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b,
0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3,
0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94,
0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20,
0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35,
0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f,
0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04,
0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63,
0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd,
0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d};


local GMUL = function(A,B)
	if(A == 0x01) then return B; end
	if(B == 0x01) then return A; end
	if(A == 0x00) then return 0; end
	if(B == 0x00) then return 0; end

	local LA = LTABLE[A];
	local LB = LTABLE[B];

	local sum = LA + LB;
	if (sum > 0xFF) then sum = sum - 0xFF; end

	return ETABLE[sum];
end

local byteSub = Array.substitute;

local shiftRow = Array.permute;

local mixCol = function(i,mix)
	local out = {};

	local a,b,c,d;

	a = GMUL(i[ 1],mix[ 1]);
	b = GMUL(i[ 2],mix[ 2]);
	c = GMUL(i[ 3],mix[ 3]);
	d = GMUL(i[ 4],mix[ 4]);
	out[ 1] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[ 5]);
	b = GMUL(i[ 2],mix[ 6]);
	c = GMUL(i[ 3],mix[ 7]);
	d = GMUL(i[ 4],mix[ 8]);
	out[ 2] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[ 9]);
	b = GMUL(i[ 2],mix[10]);
	c = GMUL(i[ 3],mix[11]);
	d = GMUL(i[ 4],mix[12]);
	out[ 3] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 1],mix[13]);
	b = GMUL(i[ 2],mix[14]);
	c = GMUL(i[ 3],mix[15]);
	d = GMUL(i[ 4],mix[16]);
	out[ 4] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[ 5],mix[ 1]);
	b = GMUL(i[ 6],mix[ 2]);
	c = GMUL(i[ 7],mix[ 3]);
	d = GMUL(i[ 8],mix[ 4]);
	out[ 5] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[ 5]);
	b = GMUL(i[ 6],mix[ 6]);
	c = GMUL(i[ 7],mix[ 7]);
	d = GMUL(i[ 8],mix[ 8]);
	out[ 6] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[ 9]);
	b = GMUL(i[ 6],mix[10]);
	c = GMUL(i[ 7],mix[11]);
	d = GMUL(i[ 8],mix[12]);
	out[ 7] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 5],mix[13]);
	b = GMUL(i[ 6],mix[14]);
	c = GMUL(i[ 7],mix[15]);
	d = GMUL(i[ 8],mix[16]);
	out[ 8] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[ 9],mix[ 1]);
	b = GMUL(i[10],mix[ 2]);
	c = GMUL(i[11],mix[ 3]);
	d = GMUL(i[12],mix[ 4]);
	out[ 9] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[ 5]);
	b = GMUL(i[10],mix[ 6]);
	c = GMUL(i[11],mix[ 7]);
	d = GMUL(i[12],mix[ 8]);
	out[10] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[ 9]);
	b = GMUL(i[10],mix[10]);
	c = GMUL(i[11],mix[11]);
	d = GMUL(i[12],mix[12]);
	out[11] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[ 9],mix[13]);
	b = GMUL(i[10],mix[14]);
	c = GMUL(i[11],mix[15]);
	d = GMUL(i[12],mix[16]);
	out[12] = XOR(XOR(a,b),XOR(c,d));


	a = GMUL(i[13],mix[ 1]);
	b = GMUL(i[14],mix[ 2]);
	c = GMUL(i[15],mix[ 3]);
	d = GMUL(i[16],mix[ 4]);
	out[13] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[ 5]);
	b = GMUL(i[14],mix[ 6]);
	c = GMUL(i[15],mix[ 7]);
	d = GMUL(i[16],mix[ 8]);
	out[14] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[ 9]);
	b = GMUL(i[14],mix[10]);
	c = GMUL(i[15],mix[11]);
	d = GMUL(i[16],mix[12]);
	out[15] = XOR(XOR(a,b),XOR(c,d));
	a = GMUL(i[13],mix[13]);
	b = GMUL(i[14],mix[14]);
	c = GMUL(i[15],mix[15]);
	d = GMUL(i[16],mix[16]);
	out[16] = XOR(XOR(a,b),XOR(c,d));

	return out;
end

local keyRound = function(key,round)
	local i=(round-1)*32;
	local out=key;

	out[33+i] = XOR(key[ 1+i],XOR(SBOX[key[30+i]],RCON[round]));
	out[34+i] = XOR(key[ 2+i],SBOX[key[31+i]]);
	out[35+i] = XOR(key[ 3+i],SBOX[key[32+i]]);
	out[36+i] = XOR(key[ 4+i],SBOX[key[29+i]]);

	out[37+i] = XOR(out[33+i],key[ 5+i]);
	out[38+i] = XOR(out[34+i],key[ 6+i]);
	out[39+i] = XOR(out[35+i],key[ 7+i]);
	out[40+i] = XOR(out[36+i],key[ 8+i]);

	out[41+i] = XOR(out[37+i],key[ 9+i]);
	out[42+i] = XOR(out[38+i],key[10+i]);
	out[43+i] = XOR(out[39+i],key[11+i]);
	out[44+i] = XOR(out[40+i],key[12+i]);

	out[45+i] = XOR(out[41+i],key[13+i]);
	out[46+i] = XOR(out[42+i],key[14+i]);
	out[47+i] = XOR(out[43+i],key[15+i]);
	out[48+i] = XOR(out[44+i],key[16+i]);


	out[49+i] = XOR(SBOX[out[45+i]],key[17+i]);
	out[50+i] = XOR(SBOX[out[46+i]],key[18+i]);
	out[51+i] = XOR(SBOX[out[47+i]],key[19+i]);
	out[52+i] = XOR(SBOX[out[48+i]],key[20+i]);

	out[53+i] = XOR(out[49+i],key[21+i]);
	out[54+i] = XOR(out[50+i],key[22+i]);
	out[55+i] = XOR(out[51+i],key[23+i]);
	out[56+i] = XOR(out[52+i],key[24+i]);

	out[57+i] = XOR(out[53+i],key[25+i]);
	out[58+i] = XOR(out[54+i],key[26+i]);
	out[59+i] = XOR(out[55+i],key[27+i]);
	out[60+i] = XOR(out[56+i],key[28+i]);

	out[61+i] = XOR(out[57+i],key[29+i]);
	out[62+i] = XOR(out[58+i],key[30+i]);
	out[63+i] = XOR(out[59+i],key[31+i]);
	out[64+i] = XOR(out[60+i],key[32+i]);

	return out;
end

local keyExpand = function(key)
	local bytes = Array.copy(key);

	for i=1,7 do
		keyRound(bytes,i);
	end

	local keys = {};

	keys[ 1] = Array.slice(bytes,1,16);
	keys[ 2] = Array.slice(bytes,17,32);
	keys[ 3] = Array.slice(bytes,33,48);
	keys[ 4] = Array.slice(bytes,49,64);
	keys[ 5] = Array.slice(bytes,65,80);
	keys[ 6] = Array.slice(bytes,81,96);
	keys[ 7] = Array.slice(bytes,97,112);
	keys[ 8] = Array.slice(bytes,113,128);
	keys[ 9] = Array.slice(bytes,129,144);
	keys[10] = Array.slice(bytes,145,160);
	keys[11] = Array.slice(bytes,161,176);
	keys[12] = Array.slice(bytes,177,192);
	keys[13] = Array.slice(bytes,193,208);
	keys[14] = Array.slice(bytes,209,224);
	keys[15] = Array.slice(bytes,225,240);

	return keys;

end

local addKey = Array.XOR;



local AES = {};

AES.blockSize = 16;

AES.encrypt = function(key,block)

	local key = keyExpand(key);

	--round 0
	block = addKey(block,key[1]);

	--round 1
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[2]);

	--round 2
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[3]);

	--round 3
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[4]);

	--round 4
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[5]);

	--round 5
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[6]);

	--round 6
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[7]);

	--round 7
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[8]);

	--round 8
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[9]);

	--round 9
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[10]);

	--round 10
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[11]);

	--round 11
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[12]);

	--round 12
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[13]);

	--round 13
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = mixCol(block,MIXTABLE);
	block = addKey(block,key[14]);

	--round 14
	block = byteSub(block,SBOX);
	block = shiftRow(block,ROW_SHIFT);
	block = addKey(block,key[15]);

	return block;

end

AES.decrypt = function(key,block)

	local key = keyExpand(key);

	--round 0
	block = addKey(block,key[15]);

	--round 1
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[14]);
	block = mixCol(block,IMIXTABLE);

	--round 2
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[13]);
	block = mixCol(block,IMIXTABLE);

	--round 3
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[12]);
	block = mixCol(block,IMIXTABLE);

	--round 4
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[11]);
	block = mixCol(block,IMIXTABLE);

	--round 5
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[10]);
	block = mixCol(block,IMIXTABLE);

	--round 6
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[9]);
	block = mixCol(block,IMIXTABLE);

	--round 7
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[8]);
	block = mixCol(block,IMIXTABLE);

	--round 8
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[7]);
	block = mixCol(block,IMIXTABLE);

	--round 9
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[6]);
	block = mixCol(block,IMIXTABLE);

	--round 10
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[5]);
	block = mixCol(block,IMIXTABLE);

	--round 11
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[4]);
	block = mixCol(block,IMIXTABLE);

	--round 12
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[3]);
	block = mixCol(block,IMIXTABLE);

	--round 13
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[2]);
	block = mixCol(block,IMIXTABLE);

	--round 14
	block = shiftRow(block,IROW_SHIFT);
	block = byteSub(block,ISBOX);
	block = addKey(block,key[1]);

	return block;
end

return AES;]=]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/des.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local Math = require("math");


local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

local IN_P = {	58, 50, 42, 34, 26, 18, 10,  2,
				60, 52, 44, 36, 28, 20, 12,  4,
				62, 54, 46, 38, 30, 22, 14,  6,
				64, 56, 48, 40, 32, 24, 16,  8,
				57, 49, 41, 33, 25, 17,  9,  1,
				59, 51, 43, 35, 27, 19, 11,  3,
				61, 53, 45, 37, 29, 21, 13,  5,
				63, 55, 47, 39, 31, 23, 15,  7};

local OUT_P = {	40,  8, 48, 16, 56, 24, 64, 32,
				39,  7, 47, 15, 55, 23, 63, 31,
				38,  6, 46, 14, 54, 22, 62, 30,
				37,  5, 45, 13, 53, 21, 61, 29,
				36,  4, 44, 12, 52, 20, 60, 28,
				35,  3, 43, 11, 51, 19, 59, 27,
				34,  2, 42, 10, 50, 18, 58, 26,
				33,  1, 41,  9, 49, 17, 57, 25};

-- add 32 to each because we do the expansion on the full LR table, not just R
local EBIT = {	32+32,  1+32,  2+32,  3+32,  4+32,  5+32,  4+32,  5+32,  6+32,  7+32,  8+32,  9+32,
				 8+32,  9+32, 10+32, 11+32, 12+32, 13+32, 12+32, 13+32, 14+32, 15+32, 16+32, 17+32,
				16+32, 17+32, 18+32, 19+32, 20+32, 21+32, 20+32, 21+32, 22+32, 23+32, 24+32, 25+32,
				24+32, 25+32, 26+32, 27+32, 28+32, 29+32, 28+32, 29+32, 30+32, 31+32, 32+32,  1+32, };

local LR_SWAP = {	33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,
					49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,
					 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,
					17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32};

local PC1 = {	57,49,41,33,25,17, 9, 1,58,50,42,34,26,18,
				10, 2,59,51,43,35,27,19,11, 3,60,52,44,36,
				63,55,47,39,31,23,15, 7,62,54,46,38,30,22,
				14, 6,61,53,45,37,29,21,13, 5,28,20,12, 4};

local PC2 = {	14,17,11,24, 1, 5, 3,28,15, 6,21,10,
                23,19,12, 4,26, 8,16, 7,27,20,13, 2,
                41,52,31,37,47,55,30,40,51,45,33,48,
                44,49,39,56,34,53,46,42,50,36,29,32};

local KS1 = {	 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28, 1,
				30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,29};
local KS2 = KS1;

local KS3 = {	 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28, 1, 2,
				31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,29,30};

local KS4  = KS3;
local KS5  = KS3;
local KS6  = KS3;
local KS7  = KS3;
local KS8  = KS3;
local KS9  = KS1;
local KS10 = KS3;
local KS11 = KS3;
local KS12 = KS3;
local KS13 = KS3;
local KS14 = KS3;
local KS15 = KS3;
local KS16 = KS1;


local SIND1 = {    2,   3,   4,   5,   1,   6 };
local SIND2 = {  2+6, 3+6, 4+6, 5+6, 1+6, 6+6 };
local SIND3 = { 2+12,3+12,4+12,5+12,1+12,6+12 };
local SIND4 = { 2+18,3+18,4+18,5+18,1+18,6+18 };
local SIND5 = { 2+24,3+24,4+24,5+24,1+24,6+24 };
local SIND6 = { 2+30,3+30,4+30,5+30,1+30,6+30 };
local SIND7 = { 2+36,3+36,4+36,5+36,1+36,6+36 };
local SIND8 = { 2+42,3+42,4+42,5+42,1+42,6+42 };

local SBOX1 = {	14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
		 		0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
		 		4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
		 		15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13};

local SBOX2 = {	15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
		 		3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
		 		0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
		 		13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9};

local SBOX3 = {	10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
				13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
				13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
				1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12};

local SBOX4 = {	7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
				13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
				10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
				3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14};

local SBOX5 = {	2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
				14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
				4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
				11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3};

local SBOX6 = {	12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
				10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
				9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
				4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13};

local SBOX7 = {	4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
				13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
				1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
				6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12};

local SBOX8 = {	13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
				1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
				7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
				2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11};

local ROUND_P = {	16, 7,20,21,29,12,28,17, 1,15,23,26, 5,18,31,10,
					 2, 8,24,14,32,27, 3, 9,19,13,30, 6,22,11, 4,25};

local permute = Array.permute;

local unpackBytes = function(bytes)
	local bits = {};

	for k,b in pairs(bytes) do
		table.insert(bits,RSHIFT(AND(b,0x80),7));
		table.insert(bits,RSHIFT(AND(b,0x40),6));
		table.insert(bits,RSHIFT(AND(b,0x20),5));
		table.insert(bits,RSHIFT(AND(b,0x10),4));
		table.insert(bits,RSHIFT(AND(b,0x08),3));
		table.insert(bits,RSHIFT(AND(b,0x04),2));
		table.insert(bits,RSHIFT(AND(b,0x02),1));
		table.insert(bits,      AND(b,0x01)   );
	end

	return bits;
end

local packBytes = function(bits)
	local bytes = {}

	for k,v in pairs(bits) do
		local index = Math.floor((k-1)/8) + 1;
		local shift = 7-Math.fmod((k-1),8);

		local bit = bits[k];
		local byte = bytes[index];

		if not byte then byte = 0x00; end
		byte = OR(byte,LSHIFT(bit,shift));
		bytes[index] = byte;
	end

	return bytes;
end

local mix = function(LR,key)

	local ER = permute(LR,EBIT);

	for k,v in pairs(ER) do
		ER[k] = XOR(ER[k],key[k]);
	end

	local FRK = {};

	local S = 0x00;
	S = OR(S,ER[1]); S = LSHIFT(S,1);
	S = OR(S,ER[6]); S = LSHIFT(S,1);
	S = OR(S,ER[2]); S = LSHIFT(S,1);
	S = OR(S,ER[3]); S = LSHIFT(S,1);
	S = OR(S,ER[4]); S = LSHIFT(S,1);
	S = OR(S,ER[5]); S = S+1;
	S = SBOX1[S];

	FRK[1] = RSHIFT(AND(S,0x08),3);
	FRK[2] = RSHIFT(AND(S,0x04),2);
	FRK[3] = RSHIFT(AND(S,0x02),1);
	FRK[4] = AND(S,0x01);


	S = 0x00;
	S = OR(S,ER[1+6]); S = LSHIFT(S,1);
	S = OR(S,ER[6+6]); S = LSHIFT(S,1);
	S = OR(S,ER[2+6]); S = LSHIFT(S,1);
	S = OR(S,ER[3+6]); S = LSHIFT(S,1);
	S = OR(S,ER[4+6]); S = LSHIFT(S,1);
	S = OR(S,ER[5+6]); S = S+1;
	S = SBOX2[S];

	FRK[5] = RSHIFT(AND(S,0x08),3);
	FRK[6] = RSHIFT(AND(S,0x04),2);
	FRK[7] = RSHIFT(AND(S,0x02),1);
	FRK[8] = AND(S,0x01);


	S = 0x00;
	S = OR(S,ER[1+12]); S = LSHIFT(S,1);
	S = OR(S,ER[6+12]); S = LSHIFT(S,1);
	S = OR(S,ER[2+12]); S = LSHIFT(S,1);
	S = OR(S,ER[3+12]); S = LSHIFT(S,1);
	S = OR(S,ER[4+12]); S = LSHIFT(S,1);
	S = OR(S,ER[5+12]); S = S+1;
	S = SBOX3[S];

	FRK[9] = RSHIFT(AND(S,0x08),3);
	FRK[10] = RSHIFT(AND(S,0x04),2);
	FRK[11] = RSHIFT(AND(S,0x02),1);
	FRK[12] = AND(S,0x01);


	S = 0x00;
	S = OR(S,ER[1+18]); S = LSHIFT(S,1);
	S = OR(S,ER[6+18]); S = LSHIFT(S,1);
	S = OR(S,ER[2+18]); S = LSHIFT(S,1);
	S = OR(S,ER[3+18]); S = LSHIFT(S,1);
	S = OR(S,ER[4+18]); S = LSHIFT(S,1);
	S = OR(S,ER[5+18]); S = S+1;
	S = SBOX4[S];

	FRK[13] = RSHIFT(AND(S,0x08),3);
	FRK[14] = RSHIFT(AND(S,0x04),2);
	FRK[15] = RSHIFT(AND(S,0x02),1);
	FRK[16] = AND(S,0x01);


	S = 0x00;
	S = OR(S,ER[1+24]); S = LSHIFT(S,1);
	S = OR(S,ER[6+24]); S = LSHIFT(S,1);
	S = OR(S,ER[2+24]); S = LSHIFT(S,1);
	S = OR(S,ER[3+24]); S = LSHIFT(S,1);
	S = OR(S,ER[4+24]); S = LSHIFT(S,1);
	S = OR(S,ER[5+24]); S = S+1;
	S = SBOX5[S];

	FRK[17] = RSHIFT(AND(S,0x08),3);
	FRK[18] = RSHIFT(AND(S,0x04),2);
	FRK[19] = RSHIFT(AND(S,0x02),1);
	FRK[20] = AND(S,0x01);


	S = 0x00;
	S = OR(S,ER[1+30]); S = LSHIFT(S,1);
	S = OR(S,ER[6+30]); S = LSHIFT(S,1);
	S = OR(S,ER[2+30]); S = LSHIFT(S,1);
	S = OR(S,ER[3+30]); S = LSHIFT(S,1);
	S = OR(S,ER[4+30]); S = LSHIFT(S,1);
	S = OR(S,ER[5+30]); S = S+1;
	S = SBOX6[S];

	FRK[21] = RSHIFT(AND(S,0x08),3);
	FRK[22] = RSHIFT(AND(S,0x04),2);
	FRK[23] = RSHIFT(AND(S,0x02),1);
	FRK[24] = AND(S,0x01);


	S = 0x00;
	S = OR(S,ER[1+36]); S = LSHIFT(S,1);
	S = OR(S,ER[6+36]); S = LSHIFT(S,1);
	S = OR(S,ER[2+36]); S = LSHIFT(S,1);
	S = OR(S,ER[3+36]); S = LSHIFT(S,1);
	S = OR(S,ER[4+36]); S = LSHIFT(S,1);
	S = OR(S,ER[5+36]); S = S+1;
	S = SBOX7[S];

	FRK[25] = RSHIFT(AND(S,0x08),3);
	FRK[26] = RSHIFT(AND(S,0x04),2);
	FRK[27] = RSHIFT(AND(S,0x02),1);
	FRK[28] = AND(S,0x01);


	S = 0x00;
	S = OR(S,ER[1+42]); S = LSHIFT(S,1);
	S = OR(S,ER[6+42]); S = LSHIFT(S,1);
	S = OR(S,ER[2+42]); S = LSHIFT(S,1);
	S = OR(S,ER[3+42]); S = LSHIFT(S,1);
	S = OR(S,ER[4+42]); S = LSHIFT(S,1);
	S = OR(S,ER[5+42]); S = S+1;
	S = SBOX8[S];

	FRK[29] = RSHIFT(AND(S,0x08),3);
	FRK[30] = RSHIFT(AND(S,0x04),2);
	FRK[31] = RSHIFT(AND(S,0x02),1);
	FRK[32] = AND(S,0x01);

	FRK = permute(FRK,ROUND_P);

	return FRK;
end

local DES = {};

DES.blockSize = 8;

DES.encrypt = function(keyBlock,inputBlock)

	local LR = unpackBytes(inputBlock);
	local keyBits = unpackBytes(keyBlock);


	local CD = permute(keyBits,PC1);

	--key schedule
	CD = permute(CD,KS1); local KEY1 = permute(CD,PC2);
	CD = permute(CD,KS2); local KEY2 = permute(CD,PC2);
	CD = permute(CD,KS3); local KEY3 = permute(CD,PC2);
	CD = permute(CD,KS4); local KEY4 = permute(CD,PC2);
	CD = permute(CD,KS5); local KEY5 = permute(CD,PC2);
	CD = permute(CD,KS6); local KEY6 = permute(CD,PC2);
	CD = permute(CD,KS7); local KEY7 = permute(CD,PC2);
	CD = permute(CD,KS8); local KEY8 = permute(CD,PC2);
	CD = permute(CD,KS9); local KEY9 = permute(CD,PC2);
	CD = permute(CD,KS10); local KEY10 = permute(CD,PC2);
	CD = permute(CD,KS11); local KEY11 = permute(CD,PC2);
	CD = permute(CD,KS12); local KEY12 = permute(CD,PC2);
	CD = permute(CD,KS13); local KEY13 = permute(CD,PC2);
	CD = permute(CD,KS14); local KEY14 = permute(CD,PC2);
	CD = permute(CD,KS15); local KEY15 = permute(CD,PC2);
	CD = permute(CD,KS16); local KEY16 = permute(CD,PC2);

	--input permutation
	LR = permute(LR,IN_P);

	--rounds
	local frk = mix(LR,KEY1);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY2);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY3);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY4);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY5);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY6);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY7);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY8);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY9);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY10);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY11);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY12);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY13);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY14);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY15);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY16);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	--LR = permute(LR,LR_SWAP);

	--output permutation
	LR = permute(LR,OUT_P);

	local outputBlock = packBytes(LR);
	return outputBlock;
end

DES.decrypt = function(keyBlock,inputBlock)


	local LR = unpackBytes(inputBlock);
	local keyBits = unpackBytes(keyBlock);


	local CD = permute(keyBits,PC1);

	--key schedule
	CD = permute(CD,KS1); local KEY1 = permute(CD,PC2);
	CD = permute(CD,KS2); local KEY2 = permute(CD,PC2);
	CD = permute(CD,KS3); local KEY3 = permute(CD,PC2);
	CD = permute(CD,KS4); local KEY4 = permute(CD,PC2);
	CD = permute(CD,KS5); local KEY5 = permute(CD,PC2);
	CD = permute(CD,KS6); local KEY6 = permute(CD,PC2);
	CD = permute(CD,KS7); local KEY7 = permute(CD,PC2);
	CD = permute(CD,KS8); local KEY8 = permute(CD,PC2);
	CD = permute(CD,KS9); local KEY9 = permute(CD,PC2);
	CD = permute(CD,KS10); local KEY10 = permute(CD,PC2);
	CD = permute(CD,KS11); local KEY11 = permute(CD,PC2);
	CD = permute(CD,KS12); local KEY12 = permute(CD,PC2);
	CD = permute(CD,KS13); local KEY13 = permute(CD,PC2);
	CD = permute(CD,KS14); local KEY14 = permute(CD,PC2);
	CD = permute(CD,KS15); local KEY15 = permute(CD,PC2);
	CD = permute(CD,KS16); local KEY16 = permute(CD,PC2);

	--input permutation
	LR = permute(LR,IN_P);

	--rounds
	local frk = mix(LR,KEY16);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY15);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY14);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY13);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY12);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY11);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY10);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY9);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY8);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY7);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY6);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY5);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY4);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY3);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY2);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	LR = permute(LR,LR_SWAP);

	frk = mix(LR,KEY1);
	for k,v in pairs(frk) do LR[k] = XOR(LR[k],frk[k]); end
	--LR = permute(LR,LR_SWAP);

	--output permutation
	LR = permute(LR,OUT_P);

	local outputBlock = packBytes(LR);
	return outputBlock;
end

return DES;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/des3.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local DES = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.cipher.des");

local DES3 = {};

local getKeys = function(keyBlock)
	local size = Array.size(keyBlock)

	local key1;
	local key2;
	local key3;

	if (size == 8) then
		key1 = keyBlock;
		key2 = keyBlock;
		key3 = keyBlock;
	elseif (size == 16) then
		key1 = Array.slice(keyBlock,1,8);
		key2 = Array.slice(keyBlock,9,16);
		key3 = key1;
	elseif (size == 24) then
		key1 = Array.slice(keyBlock,1,8);
		key2 = Array.slice(keyBlock,9,16);
		key3 = Array.slice(keyBlock,17,24);
	else
		assert(false,"Invalid key size for 3DES");
	end

	return key1,key2,key3;
end

DES3.blockSize = DES.blockSize;

DES3.encrypt = function(keyBlock,inputBlock)
	local key1;
	local key2;
	local key3;

	key1, key2, key3 = getKeys(keyBlock);

	local block = inputBlock;
	block = DES.encrypt(key1,block);
	block = DES.decrypt(key2,block);
	block = DES.encrypt(key3,block);

	return block;
end

DES3.decrypt = function(keyBlock,inputBlock)
	local key1;
	local key2;
	local key3;

	key1, key2, key3 = getKeys(keyBlock);

	local block = inputBlock;
	block = DES.decrypt(key3,block);
	block = DES.encrypt(key2,block);
	block = DES.decrypt(key1,block);

	return block;
end

return DES3;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/tea.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local Math = require("math");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;


--NOTE: TEA is endian-dependent!
--The spec does not seem to specify which to use.
--It looks like most implementations use big-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b0; i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b3);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b3 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b0 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local TEA = {};

TEA.blockSize = 8;

TEA.encrypt = function(key,data)
	local y = bytes2word(data[1],data[2],data[3],data[4]);
	local z = bytes2word(data[5],data[6],data[7],data[8]);
	local delta = 0x9e3779b9;
	local sum = 0;

	local k0 = bytes2word(key[ 1],key[ 2],key[ 3],key[ 4]);
	local k1 = bytes2word(key[ 5],key[ 6],key[ 7],key[ 8]);
	local k2 = bytes2word(key[ 9],key[10],key[11],key[12]);
	local k3 = bytes2word(key[13],key[14],key[15],key[16]);

	for i = 1,32 do
		local temp;

		sum = AND(sum + delta, 0xFFFFFFFF);

		temp = z+sum;
		temp = XOR(temp,LSHIFT(z,4)+k0);
		temp = XOR(temp,RSHIFT(z,5)+k1);
		y = AND(y + temp, 0xFFFFFFFF);

		temp = y+sum;
		temp = XOR(temp,LSHIFT(y,4)+k2);
		temp = XOR(temp,RSHIFT(y,5)+k3);
		z = AND( z + temp, 0xFFFFFFFF);
	end

	local out = {};

	out[1],out[2],out[3],out[4] = word2bytes(y);
	out[5],out[6],out[7],out[8] = word2bytes(z);

	return out;
end

TEA.decrypt = function(key,data)
	local y = bytes2word(data[1],data[2],data[3],data[4]);
	local z = bytes2word(data[5],data[6],data[7],data[8]);

	local delta = 0x9e3779b9;
	local sum = 0xc6ef3720; --AND(delta*32,0xFFFFFFFF);

	local k0 = bytes2word(key[ 1],key[ 2],key[ 3],key[ 4]);
	local k1 = bytes2word(key[ 5],key[ 6],key[ 7],key[ 8]);
	local k2 = bytes2word(key[ 9],key[10],key[11],key[12]);
	local k3 = bytes2word(key[13],key[14],key[15],key[16]);

	for i = 1,32 do
		local temp;

		temp = y+sum;
		temp = XOR(temp,LSHIFT(y,4)+k2);
		temp = XOR(temp,RSHIFT(y,5)+k3);
		z = AND(z + 0x100000000 - temp,0xFFFFFFFF);

		temp = z+sum;
		temp = XOR(temp,LSHIFT(z,4)+k0);
		temp = XOR(temp,RSHIFT(z,5)+k1);
		y = AND(y + 0x100000000 - temp,0xFFFFFFFF);

		sum = AND(sum + 0x100000000 - delta,0xFFFFFFFF);
	end

	local out = {};

	out[1],out[2],out[3],out[4] = word2bytes(y);
	out[5],out[6],out[7],out[8] = word2bytes(z);

	return out;
end

return TEA;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/xtea.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local Math = require("math");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;


--NOTE: XTEA is endian-dependent!
--The spec does not seem to specify which to use.
--It looks like most implementations use big-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b0; i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b3);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b3 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b0 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local XTEA = {};

XTEA.blockSize = 8;

XTEA.encrypt = function(key,data)
	local y = bytes2word(data[1],data[2],data[3],data[4]);
	local z = bytes2word(data[5],data[6],data[7],data[8]);
	local delta = 0x9e3779b9;
	local sum = 0;

	local k0 = bytes2word(key[ 1],key[ 2],key[ 3],key[ 4]);
	local k1 = bytes2word(key[ 5],key[ 6],key[ 7],key[ 8]);
	local k2 = bytes2word(key[ 9],key[10],key[11],key[12]);
	local k3 = bytes2word(key[13],key[14],key[15],key[16]);
	local k = {[0] = k0, k1, k2, k3};

	for i = 1,32 do
		local temp;

		temp = XOR(LSHIFT(z,4),RSHIFT(z,5)) + z
		temp = XOR(temp,sum + k[ AND(sum,0x3) ])
		y = AND(y + temp, 0xFFFFFFFF);

		sum = AND(sum + delta, 0xFFFFFFFF);

		temp = XOR(LSHIFT(y,4),RSHIFT(y,5)) + y
		temp = XOR(temp,sum + k[ AND(RSHIFT(sum,11),0x3) ])
		z = AND( z + temp, 0xFFFFFFFF);
	end

	local out = {};

	out[1],out[2],out[3],out[4] = word2bytes(y);
	out[5],out[6],out[7],out[8] = word2bytes(z);

	return out;
end

XTEA.decrypt = function(key,data)
	local y = bytes2word(data[1],data[2],data[3],data[4]);
	local z = bytes2word(data[5],data[6],data[7],data[8]);

	local delta = 0x9e3779b9;
	local sum = 0xc6ef3720; --AND(delta*32,0xFFFFFFFF);

	local k0 = bytes2word(key[ 1],key[ 2],key[ 3],key[ 4]);
	local k1 = bytes2word(key[ 5],key[ 6],key[ 7],key[ 8]);
	local k2 = bytes2word(key[ 9],key[10],key[11],key[12]);
	local k3 = bytes2word(key[13],key[14],key[15],key[16]);
	local k = {[0] = k0, k1, k2, k3};

	for i = 1,32 do
		local temp;

		temp = XOR(LSHIFT(y,4),RSHIFT(y,5)) + y
		temp = XOR(temp,sum + k[ AND(RSHIFT(sum,11),0x3) ])
		z = AND(z + 0x100000000 - temp,0xFFFFFFFF);

		sum = AND(sum + 0x100000000 - delta,0xFFFFFFFF);

		temp = XOR(LSHIFT(z,4),RSHIFT(z,5)) + z
		temp = XOR(temp,sum + k[ AND(sum,0x3) ])
		y = AND(y + 0x100000000 - temp,0xFFFFFFFF);

	end

	local out = {};

	out[1],out[2],out[3],out[4] = word2bytes(y);
	out[5],out[6],out[7],out[8] = word2bytes(z);

	return out;
end

return XTEA;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/mode/cbc.lua"] = "local Array = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. ".lockbox.util.bit\");\n\nlocal CBC = {};\n\nCBC.Cipher = function()\n\n\tlocal public = {};\n\n\tlocal key;\n\tlocal blockCipher;\n\tlocal padding;\n\tlocal inputQueue;\n\tlocal outputQueue;\n\tlocal iv;\n\n\tpublic.setKey = function(keyBytes)\n\t\tkey = keyBytes;\n\t\treturn public;\n\tend\n\n\tpublic.setBlockCipher = function(cipher)\n\t\tblockCipher = cipher;\n\t\treturn public;\n\tend\n\n\tpublic.setPadding = function(paddingMode)\n\t\tpadding = paddingMode;\n\t\treturn public;\n\tend\n\n\tpublic.init = function()\n\t\tinputQueue = Queue();\n\t\toutputQueue = Queue();\n\t\tiv = nil;\n\t\treturn public;\n\tend\n\n\tpublic.update = function(messageStream)\n\t\tlocal byte = messageStream();\n\t\twhile (byte ~= nil) do\n\t\t\tinputQueue.push(byte);\n\t\t\tif(inputQueue.size() >= blockCipher.blockSize) then\n\t\t\t\tlocal block = Array.readFromQueue(inputQueue,blockCipher.blockSize);\n\n\t\t\t\tif(iv == nil) then\n\t\t\t\t\tiv = block;\n\t\t\t\telse\n\t\t\t\t\tlocal out = Array.XOR(iv,block);\n\t\t\t\t\tout = blockCipher.encrypt(key,out);\n\t\t\t\t\tArray.writeToQueue(outputQueue,out);\n\t\t\t\t\tiv = out;\n\t\t\t\tend\n\t\t\tend\n\t\t\tbyte = messageStream();\n\t\tend\n\t\treturn public;\n\tend\n\n\tpublic.finish = function()\n\t\tpaddingStream = padding(blockCipher.blockSize,inputQueue.getHead());\n\t\tpublic.update(paddingStream);\n\n\t\treturn public;\n\tend\n\n\tpublic.getOutputQueue = function()\n\t\treturn outputQueue;\n\tend\n\n\tpublic.asHex = function()\n\t\treturn Stream.toHex(outputQueue.pop);\n\tend\n\n\tpublic.asBytes = function()\n\t\treturn Stream.toArray(outputQueue.pop);\n\tend\n\n\treturn public;\n\nend\n\n\nCBC.Decipher = function()\n\n\tlocal public = {};\n\n\tlocal key;\n\tlocal blockCipher;\n\tlocal padding;\n\tlocal inputQueue;\n\tlocal outputQueue;\n\tlocal iv;\n\n\tpublic.setKey = function(keyBytes)\n\t\tkey = keyBytes;\n\t\treturn public;\n\tend\n\n\tpublic.setBlockCipher = function(cipher)\n\t\tblockCipher = cipher;\n\t\treturn public;\n\tend\n\n\tpublic.setPadding = function(paddingMode)\n\t\tpadding = paddingMode;\n\t\treturn public;\n\tend\n\n\tpublic.init = function()\n\t\tinputQueue = Queue();\n\t\toutputQueue = Queue();\n\t\tiv = nil;\n\t\treturn public;\n\tend\n\n\tpublic.update = function(messageStream)\n\t\tlocal byte = messageStream();\n\t\twhile (byte ~= nil) do\n\t\t\tinputQueue.push(byte);\n\t\t\tif(inputQueue.size() >= blockCipher.blockSize) then\n\t\t\t\tlocal block = Array.readFromQueue(inputQueue,blockCipher.blockSize);\n\n\t\t\t\tif(iv == nil) then\n\t\t\t\t\tiv = block;\n\t\t\t\telse\n\t\t\t\t\tlocal out = block;\n\t\t\t\t\tout = blockCipher.decrypt(key,out);\n\t\t\t\t\tout = Array.XOR(iv,out);\n\t\t\t\t\tArray.writeToQueue(outputQueue,out);\n\t\t\t\t\tiv = block;\n\t\t\t\tend\n\t\t\tend\n\t\t\tbyte = messageStream();\n\t\tend\n\t\treturn public;\n\tend\n\n\tpublic.finish = function()\n--\t\tlocal data=Stream.toArray(outputQueue.pop)\n--        local paddingByte=data[#data]\n\n--        local realLength=#data-paddingByte--如果有padding,计算去除padding后的长度\n--        local padded=true\n--        for i=#data,realLength+1,-1 do\n--            if(data[i]~=paddingByte) then\n--                padded=false\n--            end\n--        end\n--        print(\"realLength is \"..realLength)\n--        local paddedBytes=Array.slice(data,1,realLength)\n        \n--        if padded then\n--            Array.writeToQueue(outputQueue,paddedBytes)\n--        end\n        \n\t\tpaddingStream = padding(blockCipher.blockSize,inputQueue.getHead());\n\t\tpublic.update(paddingStream);\n\n\t\treturn public;\n\tend\n\n\tpublic.getOutputQueue = function()\n\t\treturn outputQueue;\n\tend\n\n\tpublic.asHex = function()\n\t\treturn Stream.toHex(outputQueue.pop);\n\tend\n\n\tpublic.asBytes = function()\n\t\treturn Stream.toArray(outputQueue.pop);\n\tend\n\n\treturn public;\n\nend\n\nreturn CBC;"
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/mode/cfb.lua"] = "local Array = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");

local CFB = {};

CFB.Cipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = iv;
					out = blockCipher.encrypt(key,out);
					out = Array.XOR(out,block);
					Array.writeToQueue(outputQueue,out);
					iv = out;
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end

CFB.Decipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = iv;
					out = blockCipher.encrypt(key,out);
					out = Array.XOR(out,block);
					Array.writeToQueue(outputQueue,out);
					iv = block;
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end

return CFB;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/mode/ctr.lua"] = "local Array = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--CTR counter is big-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b0; i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b3);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b3 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b0 = AND(word,0xFF);
	return b0,b1,b2,b3;
end


local CTR = {};

CTR.Cipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	local updateIV = function()
		iv[16] = iv[16] + 1;
		if iv[16] <= 0xFF then return; end
		iv[16] = AND(iv[16],0xFF);

		iv[15] = iv[15] + 1;
		if iv[15] <= 0xFF then return; end
		iv[15] = AND(iv[15],0xFF);

		iv[14] = iv[14] + 1;
		if iv[14] <= 0xFF then return; end
		iv[14] = AND(iv[14],0xFF);

		iv[13] = iv[13] + 1;
		if iv[13] <= 0xFF then return; end
		iv[13] = AND(iv[13],0xFF);

		iv[12] = iv[12] + 1;
		if iv[12] <= 0xFF then return; end
		iv[12] = AND(iv[12],0xFF);

		iv[11] = iv[11] + 1;
		if iv[11] <= 0xFF then return; end
		iv[11] = AND(iv[11],0xFF);

		iv[10] = iv[10] + 1;
		if iv[10] <= 0xFF then return; end
		iv[10] = AND(iv[10],0xFF);

		iv[9] = iv[9] + 1;
		if iv[9] <= 0xFF then return; end
		iv[9] = AND(iv[9],0xFF);

		return;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);

			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = iv;
					out = blockCipher.encrypt(key,out);

					out = Array.XOR(out,block);
					Array.writeToQueue(outputQueue,out);
					updateIV();
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end


CTR.Decipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	local updateIV = function()
		iv[16] = iv[16] + 1;
		if iv[16] <= 0xFF then return; end
		iv[16] = AND(iv[16],0xFF);

		iv[15] = iv[15] + 1;
		if iv[15] <= 0xFF then return; end
		iv[15] = AND(iv[15],0xFF);

		iv[14] = iv[14] + 1;
		if iv[14] <= 0xFF then return; end
		iv[14] = AND(iv[14],0xFF);

		iv[13] = iv[13] + 1;
		if iv[13] <= 0xFF then return; end
		iv[13] = AND(iv[13],0xFF);

		iv[12] = iv[12] + 1;
		if iv[12] <= 0xFF then return; end
		iv[12] = AND(iv[12],0xFF);

		iv[11] = iv[11] + 1;
		if iv[11] <= 0xFF then return; end
		iv[11] = AND(iv[11],0xFF);

		iv[10] = iv[10] + 1;
		if iv[10] <= 0xFF then return; end
		iv[10] = AND(iv[10],0xFF);

		iv[9] = iv[9] + 1;
		if iv[9] <= 0xFF then return; end
		iv[9] = AND(iv[9],0xFF);

		return;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);

			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = iv;
					out = blockCipher.encrypt(key,out);

					out = Array.XOR(out,block);
					Array.writeToQueue(outputQueue,out);
					updateIV();
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end




return CTR;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/mode/ecb.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. ".lockbox.util.bit\");\n\nlocal ECB = {};\n\nECB.Cipher = function()\n\n\tlocal public = {};\n\n\tlocal key;\n\tlocal blockCipher;\n\tlocal padding;\n\tlocal inputQueue;\n\tlocal outputQueue;\n\n\tpublic.setKey = function(keyBytes)\n\t\tkey = keyBytes;\n\t\treturn public;\n\tend\n\n\tpublic.setBlockCipher = function(cipher)\n\t\tblockCipher = cipher;\n\t\treturn public;\n\tend\n\n\tpublic.setPadding = function(paddingMode)\n\t\tpadding = paddingMode;\n\t\treturn public;\n\tend\n\n\tpublic.init = function()\n\t\tinputQueue = Queue();\n\t\toutputQueue = Queue();\n\t\treturn public;\n\tend\n\n\tpublic.update = function(messageStream)\n\t\tlocal byte = messageStream();\n\t\twhile (byte ~= nil) do\n\t\t\tinputQueue.push(byte);\n\t\t\tif(inputQueue.size() >= blockCipher.blockSize) then\n\t\t\t\tlocal block = Array.readFromQueue(inputQueue,blockCipher.blockSize);\n\n\t\t\t\tblock = blockCipher.encrypt(key,block);\n\n\t\t\t\tArray.writeToQueue(outputQueue,block);\n\t\t\tend\n\t\t\tbyte = messageStream();\n\t\tend\n\t\treturn public;\n\tend\n\n\tpublic.finish = function()\n\t\tpaddingStream = padding(blockCipher.blockSize,inputQueue.getHead());\n\t\tpublic.update(paddingStream);\n\n\t\treturn public;\n\tend\n\n\tpublic.getOutputQueue = function()\n\t\treturn outputQueue;\n\tend\n\n\tpublic.asHex = function()\n\t\treturn Stream.toHex(outputQueue.pop);\n\tend\n\n\tpublic.asBytes = function()\n\t\treturn Stream.toArray(outputQueue.pop);\n\tend\n\n\treturn public;\n\nend\n\nECB.Decipher = function()\n\n\tlocal public = {};\n\n\tlocal key;\n\tlocal blockCipher;\n\tlocal padding;\n\tlocal inputQueue;\n\tlocal outputQueue;\n\n\tpublic.setKey = function(keyBytes)\n\t\tkey = keyBytes;\n\t\treturn public;\n\tend\n\n\tpublic.setBlockCipher = function(cipher)\n\t\tblockCipher = cipher;\n\t\treturn public;\n\tend\n\n\tpublic.setPadding = function(paddingMode)\n\t\tpadding = paddingMode;\n\t\treturn public;\n\tend\n\n\tpublic.init = function()\n\t\tinputQueue = Queue();\n\t\toutputQueue = Queue();\n\t\treturn public;\n\tend\n\n\tpublic.update = function(messageStream)\n\t\tlocal byte = messageStream();\n\t\twhile (byte ~= nil) do\n\t\t\tinputQueue.push(byte);\n\t\t\tif(inputQueue.size() >= blockCipher.blockSize) then\n\t\t\t\tlocal block = Array.readFromQueue(inputQueue,blockCipher.blockSize);\n\n\t\t\t\tblock = blockCipher.decrypt(key,block);\n\n\t\t\t\tArray.writeToQueue(outputQueue,block);\n\t\t\tend\n\t\t\tbyte = messageStream();\n\t\tend\n\t\treturn public;\n\tend\n\n\tpublic.finish = function()\n--\t\tlocal data=Stream.toArray(outputQueue.pop)\n--        local paddingByte=data[#data]\n\n--        local realLength=#data-paddingByte--如果有padding,计算去除padding后的长度\n--        local padded=true\n--        for i=#data,realLength+1,-1 do\n--            if(data[i]~=paddingByte) then\n--                padded=false\n--            end\n--        end\n--        print(\"realLength is \"..realLength)\n--        local paddedBytes=Array.slice(data,1,realLength)\n        \n--        if padded then\n--            Array.writeToQueue(outputQueue,paddedBytes)\n--        end\n\n        paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());\n\t\tpublic.update(paddingStream);\n\n\t\treturn public;\n\tend\n\n\tpublic.getOutputQueue = function()\n\t\treturn outputQueue;\n\tend\n\n\tpublic.asHex = function()\n\t\treturn Stream.toHex(outputQueue.pop);\n\tend\n\n\tpublic.asBytes = function()\n\t\treturn Stream.toArray(outputQueue.pop);\n\tend\n\n\treturn public;\n\nend\n\n\nreturn ECB;"
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/mode/ige.lua"] = "local Array = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");

local IGE = {};

IGE.Cipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local xPrev,yPrev;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		xPrev = nil;
		yPrev = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(yPrev == nil) then
					yPrev = block;
				elseif(xPrev == nil) then
					xPrev = block
				else
					local out = Array.XOR(yPrev,block);
					out = blockCipher.encrypt(key,out);
					out = Array.XOR(out,xPrev);
					Array.writeToQueue(outputQueue,out);
					xPrev = block;
					yPrev = out;
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end

IGE.Decipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local xPrev,yPrev;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		xPrev = nil;
		yPrev = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(xPrev == nil) then
					xPrev = block;
				elseif(yPrev == nil) then
					yPrev = block
				else
					local out = Array.XOR(yPrev,block);
					out = blockCipher.decrypt(key,out);
					out = Array.XOR(out,xPrev);
					Array.writeToQueue(outputQueue,out);
					xPrev = block;
					yPrev = out;
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end

return IGE;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/mode/ofb.lua"] = "local Array = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");

local OFB = {};

OFB.Cipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = iv;
					out = blockCipher.encrypt(key,out);
					iv = out;
					out = Array.XOR(out,block);
					Array.writeToQueue(outputQueue,out);
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end

OFB.Decipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = iv;
					out = blockCipher.encrypt(key,out);
					iv = out;
					out = Array.XOR(out,block);
					Array.writeToQueue(outputQueue,out);
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end


return OFB;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/cipher/mode/pcbc.lua"] = "local Array = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");

local PCBC = {};

PCBC.Cipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = block;
					out = Array.XOR(iv,out);
					out = blockCipher.encrypt(key,out);
					iv = Array.XOR(out,block);
					Array.writeToQueue(outputQueue,out);
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end

PCBC.Decipher = function()

	local public = {};

	local key;
	local blockCipher;
	local padding;
	local inputQueue;
	local outputQueue;
	local iv;

	public.setKey = function(keyBytes)
		key = keyBytes;
		return public;
	end

	public.setBlockCipher = function(cipher)
		blockCipher = cipher;
		return public;
	end

	public.setPadding = function(paddingMode)
		padding = paddingMode;
		return public;
	end

	public.init = function()
		inputQueue = Queue();
		outputQueue = Queue();
		iv = nil;
		return public;
	end

	public.update = function(messageStream)
		local byte = messageStream();
		while (byte ~= nil) do
			inputQueue.push(byte);
			if(inputQueue.size() >= blockCipher.blockSize) then
				local block = Array.readFromQueue(inputQueue,blockCipher.blockSize);

				if(iv == nil) then
					iv = block;
				else
					local out = block;
					out = blockCipher.decrypt(key,out);
					out = Array.XOR(iv,out);
					Array.writeToQueue(outputQueue,out);
					iv = Array.XOR(out,block);
				end
			end
			byte = messageStream();
		end
		return public;
	end

	public.finish = function()
		paddingStream = padding(blockCipher.blockSize,inputQueue.getHead());
		public.update(paddingStream);

		return public;
	end

	public.getOutputQueue = function()
		return outputQueue;
	end

	public.asHex = function()
		return Stream.toHex(outputQueue.pop);
	end

	public.asBytes = function()
		return Stream.toArray(outputQueue.pop);
	end

	return public;

end


return PCBC;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/md2.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local SUBST = {
  0x29, 0x2E, 0x43, 0xC9, 0xA2, 0xD8, 0x7C, 0x01, 0x3D, 0x36, 0x54, 0xA1, 0xEC, 0xF0, 0x06, 0x13,
  0x62, 0xA7, 0x05, 0xF3, 0xC0, 0xC7, 0x73, 0x8C, 0x98, 0x93, 0x2B, 0xD9, 0xBC, 0x4C, 0x82, 0xCA,
  0x1E, 0x9B, 0x57, 0x3C, 0xFD, 0xD4, 0xE0, 0x16, 0x67, 0x42, 0x6F, 0x18, 0x8A, 0x17, 0xE5, 0x12,
  0xBE, 0x4E, 0xC4, 0xD6, 0xDA, 0x9E, 0xDE, 0x49, 0xA0, 0xFB, 0xF5, 0x8E, 0xBB, 0x2F, 0xEE, 0x7A,
  0xA9, 0x68, 0x79, 0x91, 0x15, 0xB2, 0x07, 0x3F, 0x94, 0xC2, 0x10, 0x89, 0x0B, 0x22, 0x5F, 0x21,
  0x80, 0x7F, 0x5D, 0x9A, 0x5A, 0x90, 0x32, 0x27, 0x35, 0x3E, 0xCC, 0xE7, 0xBF, 0xF7, 0x97, 0x03,
  0xFF, 0x19, 0x30, 0xB3, 0x48, 0xA5, 0xB5, 0xD1, 0xD7, 0x5E, 0x92, 0x2A, 0xAC, 0x56, 0xAA, 0xC6,
  0x4F, 0xB8, 0x38, 0xD2, 0x96, 0xA4, 0x7D, 0xB6, 0x76, 0xFC, 0x6B, 0xE2, 0x9C, 0x74, 0x04, 0xF1,
  0x45, 0x9D, 0x70, 0x59, 0x64, 0x71, 0x87, 0x20, 0x86, 0x5B, 0xCF, 0x65, 0xE6, 0x2D, 0xA8, 0x02,
  0x1B, 0x60, 0x25, 0xAD, 0xAE, 0xB0, 0xB9, 0xF6, 0x1C, 0x46, 0x61, 0x69, 0x34, 0x40, 0x7E, 0x0F,
  0x55, 0x47, 0xA3, 0x23, 0xDD, 0x51, 0xAF, 0x3A, 0xC3, 0x5C, 0xF9, 0xCE, 0xBA, 0xC5, 0xEA, 0x26,
  0x2C, 0x53, 0x0D, 0x6E, 0x85, 0x28, 0x84, 0x09, 0xD3, 0xDF, 0xCD, 0xF4, 0x41, 0x81, 0x4D, 0x52,
  0x6A, 0xDC, 0x37, 0xC8, 0x6C, 0xC1, 0xAB, 0xFA, 0x24, 0xE1, 0x7B, 0x08, 0x0C, 0xBD, 0xB1, 0x4A,
  0x78, 0x88, 0x95, 0x8B, 0xE3, 0x63, 0xE8, 0x6D, 0xE9, 0xCB, 0xD5, 0xFE, 0x3B, 0x00, 0x1D, 0x39,
  0xF2, 0xEF, 0xB7, 0x0E, 0x66, 0x58, 0xD0, 0xE4, 0xA6, 0x77, 0x72, 0xF8, 0xEB, 0x75, 0x4B, 0x0A,
  0x31, 0x44, 0x50, 0xB4, 0x8F, 0xED, 0x1F, 0x1A, 0xDB, 0x99, 0x8D, 0x33, 0x9F, 0x11, 0x83, 0x14 };

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

local MD2 = function()

	local queue = Queue();

	local X = {};
	for i=0,47 do
		X[i] = 0x00;
	end

	local L = 0;
	local C = {};
	for i=0,15 do
		C[i] = 0x00;
	end

	local public = {};

	local processBlock = function()
		local block = {};

		for i=0,15 do
			block[i] = queue.pop();
		end

		for i=0,15 do
			X[i+16] = block[i];
			X[i+32] = XOR(X[i],block[i]); --mix
		end

		local t;

		--update block
		t=0;
		for i=0,17 do
			for j=0,47 do
				X[j] = XOR(X[j],SUBST[t+1]);
				t = X[j];
			end
			t = (t+i) % 256;
		end

		--update checksum
		t = C[15];
		for i=0,15 do
			C[i] = XOR(C[i],SUBST[XOR(block[i],t)+1]);
			t = C[i];
		end

	end

	public.init = function()
		queue.reset();

		X = {};
		for i=0,47 do
			X[i] = 0x00;
		end

		L = 0;
		C = {};
		for i=0,15 do
			C[i] = 0x00;
		end

		return public;
	end

	public.update = function(stream)
		for b in stream do
			queue.push(b);
			if(queue.size() >= 16) then processBlock(); end
		end

		return public;
	end

	public.finish = function()
		local i = 16-queue.size();

		while queue.size() < 16 do
			queue.push(i);
		end

		processBlock();

		queue.push(C[ 0]); queue.push(C[ 1]); queue.push(C[ 2]); queue.push(C[ 3]);
		queue.push(C[ 4]); queue.push(C[ 5]); queue.push(C[ 6]); queue.push(C[ 7]);
		queue.push(C[ 8]); queue.push(C[ 9]); queue.push(C[10]); queue.push(C[11]);
		queue.push(C[12]); queue.push(C[13]); queue.push(C[14]); queue.push(C[15]);

		processBlock();

		return public;
	end

	public.asBytes = function()
		return {X[ 0],X[ 1],X[ 2],X[ 3],X[ 4],X[ 5],X[ 6],X[ 7],
				X[ 8],X[ 9],X[10],X[11],X[12],X[13],X[14],X[15]};
	end

	public.asHex = function()
		return String.format("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				X[ 0],X[ 1],X[ 2],X[ 3],X[ 4],X[ 5],X[ 6],X[ 7],
				X[ 8],X[ 9],X[10],X[11],X[12],X[13],X[14],X[15]);
	end

	return public;

end

return MD2;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/md4.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Math = require("math");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local SHIFT = {	3,  7, 11, 19,  3,  7, 11, 19,  3,  7, 11, 19,  3,  7, 11, 19,
				3,  5,  9, 13,  3,  5,  9, 13,  3,  5,  9, 13,  3,  5,  9, 13,
				3,  9, 11, 15,  3,  9, 11, 15,  3,  9, 11, 15,  3,  9, 11, 15 };

local WORD = {	0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
				0,  4,  8, 12,  1,  5,  9, 13,  2,  6, 10, 14,  3,  7, 11, 13,
				3,  8,  4, 12,  2, 10,  6, 14,  1,  9,  5, 13,  3,  1,  7, 15 };

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--MD4 is little-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b3; i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b0);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b0 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b3 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local bytes2dword = function(b0,b1,b2,b3,b4,b5,b6,b7)
	local i = bytes2word(b0,b1,b2,b3);
	local j = bytes2word(b4,b5,b6,b7);
	return (j*0x100000000)+i;
end

local dword2bytes = function(i)
	local b4,b5,b6,b7 = word2bytes(Math.floor(i/0x100000000));
	local b0,b1,b2,b3 = word2bytes(i);
	return b0,b1,b2,b3,b4,b5,b6,b7;
end

local F = function(x,y,z) return OR(AND(x,y),AND(NOT(x),z)); end
local G = function(x,y,z) return OR(AND(x,y), OR(AND(x,z), AND(y,z))); end
local H = function(x,y,z) return XOR(x,XOR(y,z)); end


local MD4 = function()

	local queue = Queue();

	local A = 0x67452301;
	local B = 0xefcdab89;
	local C = 0x98badcfe;
	local D = 0x10325476;
	local public = {};

	local processBlock = function()
		local a = A;
		local b = B;
		local c = C;
		local d = D;

		local X = {};

		for i=0,15 do
			X[i] = bytes2word(queue.pop(),queue.pop(),queue.pop(),queue.pop());
		end

		a = LROT(a + F(b,c,d) + X[ 0], 3);
		d = LROT(d + F(a,b,c) + X[ 1], 7);
		c = LROT(c + F(d,a,b) + X[ 2],11);
		b = LROT(b + F(c,d,a) + X[ 3],19);

		a = LROT(a + F(b,c,d) + X[ 4], 3);
		d = LROT(d + F(a,b,c) + X[ 5], 7);
		c = LROT(c + F(d,a,b) + X[ 6],11);
		b = LROT(b + F(c,d,a) + X[ 7],19);

		a = LROT(a + F(b,c,d) + X[ 8], 3);
		d = LROT(d + F(a,b,c) + X[ 9], 7);
		c = LROT(c + F(d,a,b) + X[10],11);
		b = LROT(b + F(c,d,a) + X[11],19);

		a = LROT(a + F(b,c,d) + X[12], 3);
		d = LROT(d + F(a,b,c) + X[13], 7);
		c = LROT(c + F(d,a,b) + X[14],11);
		b = LROT(b + F(c,d,a) + X[15],19);


		a = LROT(a + G(b,c,d) + X[ 0] + 0x5A827999, 3);
		d = LROT(d + G(a,b,c) + X[ 4] + 0x5A827999, 5);
		c = LROT(c + G(d,a,b) + X[ 8] + 0x5A827999, 9);
		b = LROT(b + G(c,d,a) + X[12] + 0x5A827999,13);

		a = LROT(a + G(b,c,d) + X[ 1] + 0x5A827999, 3);
		d = LROT(d + G(a,b,c) + X[ 5] + 0x5A827999, 5);
		c = LROT(c + G(d,a,b) + X[ 9] + 0x5A827999, 9);
		b = LROT(b + G(c,d,a) + X[13] + 0x5A827999,13);

		a = LROT(a + G(b,c,d) + X[ 2] + 0x5A827999, 3);
		d = LROT(d + G(a,b,c) + X[ 6] + 0x5A827999, 5);
		c = LROT(c + G(d,a,b) + X[10] + 0x5A827999, 9);
		b = LROT(b + G(c,d,a) + X[14] + 0x5A827999,13);

		a = LROT(a + G(b,c,d) + X[ 3] + 0x5A827999, 3);
		d = LROT(d + G(a,b,c) + X[ 7] + 0x5A827999, 5);
		c = LROT(c + G(d,a,b) + X[11] + 0x5A827999, 9);
		b = LROT(b + G(c,d,a) + X[15] + 0x5A827999,13);


		a = LROT(a + H(b,c,d) + X[ 0] + 0x6ED9EBA1, 3);
		d = LROT(d + H(a,b,c) + X[ 8] + 0x6ED9EBA1, 9);
		c = LROT(c + H(d,a,b) + X[ 4] + 0x6ED9EBA1,11);
		b = LROT(b + H(c,d,a) + X[12] + 0x6ED9EBA1,15);

		a = LROT(a + H(b,c,d) + X[ 2] + 0x6ED9EBA1, 3);
		d = LROT(d + H(a,b,c) + X[10] + 0x6ED9EBA1, 9);
		c = LROT(c + H(d,a,b) + X[ 6] + 0x6ED9EBA1,11);
		b = LROT(b + H(c,d,a) + X[14] + 0x6ED9EBA1,15);

		a = LROT(a + H(b,c,d) + X[ 1] + 0x6ED9EBA1, 3);
		d = LROT(d + H(a,b,c) + X[ 9] + 0x6ED9EBA1, 9);
		c = LROT(c + H(d,a,b) + X[ 5] + 0x6ED9EBA1,11);
		b = LROT(b + H(c,d,a) + X[13] + 0x6ED9EBA1,15);

		a = LROT(a + H(b,c,d) + X[ 3] + 0x6ED9EBA1, 3);
		d = LROT(d + H(a,b,c) + X[11] + 0x6ED9EBA1, 9);
		c = LROT(c + H(d,a,b) + X[ 7] + 0x6ED9EBA1,11);
		b = LROT(b + H(c,d,a) + X[15] + 0x6ED9EBA1,15);


		A = AND(A + a, 0xFFFFFFFF);
		B = AND(B + b, 0xFFFFFFFF);
		C = AND(C + c, 0xFFFFFFFF);
		D = AND(D + d, 0xFFFFFFFF);
	end

	public.init = function()
		queue.reset();

		A = 0x67452301;
		B = 0xefcdab89;
		C = 0x98badcfe;
		D = 0x10325476;

		return public;
	end

	public.update = function(bytes)
		for b in bytes do
			queue.push(b);
			if(queue.size() >= 64) then processBlock(); end
		end

		return public;
	end

	public.finish = function()
		local bits = queue.getHead() * 8;

		queue.push(0x80);
		while ((queue.size()+7) % 64) < 63 do
			queue.push(0x00);
		end

		local b0,b1,b2,b3,b4,b5,b6,b7 = dword2bytes(bits);

		queue.push(b0);
		queue.push(b1);
		queue.push(b2);
		queue.push(b3);
		queue.push(b4);
		queue.push(b5);
		queue.push(b6);
		queue.push(b7);

		while queue.size() > 0 do
			processBlock();
		end

		return public;
	end

	public.asBytes = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);

		return {b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15};
	end

	public.asHex = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);

		return String.format("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15);
	end

	return public;

end

return MD4;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/md5.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Math = require("math");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local SHIFT = {	7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
				5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
				4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
				6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21 };

local CONSTANTS = {	0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
					0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
					0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
					0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
					0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
					0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
					0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
					0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
					0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
					0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
					0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
					0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
					0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
					0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
					0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
					0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391};

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--MD5 is little-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b3; i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b0);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b0 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b3 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local bytes2dword = function(b0,b1,b2,b3,b4,b5,b6,b7)
	local i = bytes2word(b0,b1,b2,b3);
	local j = bytes2word(b4,b5,b6,b7);
	return (j*0x100000000)+i;
end

local dword2bytes = function(i)
	local b4,b5,b6,b7 = word2bytes(Math.floor(i/0x100000000));
	local b0,b1,b2,b3 = word2bytes(i);
	return b0,b1,b2,b3,b4,b5,b6,b7;
end

local F = function(x,y,z) return OR(AND(x,y),AND(NOT(x),z)); end
local G = function(x,y,z) return OR(AND(x,z),AND(y,NOT(z))); end
local H = function(x,y,z) return XOR(x,XOR(y,z)); end
local I = function(x,y,z) return XOR(y,OR(x,NOT(z))); end

local MD5 = function()

	local queue = Queue();

	local A = 0x67452301;
	local B = 0xefcdab89;
	local C = 0x98badcfe;
	local D = 0x10325476;
	local public = {};

	local processBlock = function()
		local a = A;
		local b = B;
		local c = C;
		local d = D;

		local X = {};

		for i=1,16 do
			X[i] = bytes2word(queue.pop(),queue.pop(),queue.pop(),queue.pop());
		end

		for i=0,63 do
			local f,g,temp;

			if (0 <= i) and (i <= 15) then
				f = F(b,c,d);
				g = i;
			elseif (16 <= i) and (i <= 31) then
				f = G(b,c,d);
				g = (5*i + 1) % 16;
			elseif (32 <= i) and (i <= 47) then
				f = H(b,c,d);
				g = (3*i + 5) % 16;
			elseif (48 <= i) and (i <= 63) then
				f = I(b,c,d);
				g = (7*i) % 16;
			end
			temp = d;
			d = c;
			c = b;
			b = b + LROT((a + f + CONSTANTS[i+1] + X[g+1]), SHIFT[i+1]);
			a = temp;
		end

		A = AND(A + a, 0xFFFFFFFF);
		B = AND(B + b, 0xFFFFFFFF);
		C = AND(C + c, 0xFFFFFFFF);
		D = AND(D + d, 0xFFFFFFFF);
	end

	public.init = function()
		queue.reset();

		A = 0x67452301;
		B = 0xefcdab89;
		C = 0x98badcfe;
		D = 0x10325476;

		return public;
	end

	public.update = function(bytes)
		for b in bytes do
			queue.push(b);
			if(queue.size() >= 64) then processBlock(); end
		end

		return public;
	end

	public.finish = function()
		local bits = queue.getHead() * 8;

		queue.push(0x80);
		while ((queue.size()+7) % 64) < 63 do
			queue.push(0x00);
		end

		local b0,b1,b2,b3,b4,b5,b6,b7 = dword2bytes(bits);

		queue.push(b0);
		queue.push(b1);
		queue.push(b2);
		queue.push(b3);
		queue.push(b4);
		queue.push(b5);
		queue.push(b6);
		queue.push(b7);

		while queue.size() > 0 do
			processBlock();
		end

		return public;
	end

	public.asBytes = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);

		return {b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15};
	end

	public.asHex = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);

		return String.format("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15);
	end

	return public;

end

return MD5;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/ripemd128.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Math = require("math");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--RIPEMD128 is little-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b3; i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b0);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b0 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b3 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local bytes2dword = function(b0,b1,b2,b3,b4,b5,b6,b7)
	local i = bytes2word(b0,b1,b2,b3);
	local j = bytes2word(b4,b5,b6,b7);
	return (j*0x100000000)+i;
end

local dword2bytes = function(i)
	local b4,b5,b6,b7 = word2bytes(Math.floor(i/0x100000000));
	local b0,b1,b2,b3 = word2bytes(i);
	return b0,b1,b2,b3,b4,b5,b6,b7;
end

local F = function(x,y,z) return XOR(x, XOR(y,z)); end
local G = function(x,y,z) return OR(AND(x,y), AND(NOT(x),z)); end
local H = function(x,y,z) return XOR(OR(x,NOT(y)),z); end
local I = function(x,y,z) return OR(AND(x,z),AND(y,NOT(z))); end

local FF = function(a,b,c,d,x,s)
	a = a + F(b,c,d) + x;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local GG = function(a,b,c,d,x,s)
	a = a + G(b,c,d) + x + 0x5a827999;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local HH = function(a,b,c,d,x,s)
	a = a + H(b,c,d) + x + 0x6ed9eba1;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local II = function(a,b,c,d,x,s)
	a = a + I(b,c,d) + x + 0x8f1bbcdc;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end


local FFF = function(a,b,c,d,x,s)
	a = a + F(b,c,d) + x;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local GGG = function(a,b,c,d,x,s)
	a = a + G(b,c,d) + x + 0x6d703ef3;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local HHH = function(a,b,c,d,x,s)
	a = a + H(b,c,d) + x + 0x5c4dd124;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local III = function(a,b,c,d,x,s)
	a = a + I(b,c,d) + x + 0x50a28be6;
	a = LROT(a,s);
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local RIPEMD128 = function()

	local queue = Queue();

	local A = 0x67452301;
	local B = 0xefcdab89;
	local C = 0x98badcfe;
	local D = 0x10325476;

	local public = {};

	local processBlock = function()
		local aa,bb,cc,dd = A,B,C,D;
		local aaa,bbb,ccc,ddd = A,B,C,D;

		local X = {};

		for i=0,15 do
			X[i] = bytes2word(queue.pop(),queue.pop(),queue.pop(),queue.pop());
		end

		aa = FF(aa, bb, cc, dd, X[ 0], 11);
		dd = FF(dd, aa, bb, cc, X[ 1], 14);
		cc = FF(cc, dd, aa, bb, X[ 2], 15);
		bb = FF(bb, cc, dd, aa, X[ 3], 12);
		aa = FF(aa, bb, cc, dd, X[ 4],  5);
		dd = FF(dd, aa, bb, cc, X[ 5],  8);
		cc = FF(cc, dd, aa, bb, X[ 6],  7);
		bb = FF(bb, cc, dd, aa, X[ 7],  9);
		aa = FF(aa, bb, cc, dd, X[ 8], 11);
		dd = FF(dd, aa, bb, cc, X[ 9], 13);
		cc = FF(cc, dd, aa, bb, X[10], 14);
		bb = FF(bb, cc, dd, aa, X[11], 15);
		aa = FF(aa, bb, cc, dd, X[12],  6);
		dd = FF(dd, aa, bb, cc, X[13],  7);
		cc = FF(cc, dd, aa, bb, X[14],  9);
		bb = FF(bb, cc, dd, aa, X[15],  8);

		aa = GG(aa, bb, cc, dd, X[ 7],  7);
		dd = GG(dd, aa, bb, cc, X[ 4],  6);
		cc = GG(cc, dd, aa, bb, X[13],  8);
		bb = GG(bb, cc, dd, aa, X[ 1], 13);
		aa = GG(aa, bb, cc, dd, X[10], 11);
		dd = GG(dd, aa, bb, cc, X[ 6],  9);
		cc = GG(cc, dd, aa, bb, X[15],  7);
		bb = GG(bb, cc, dd, aa, X[ 3], 15);
		aa = GG(aa, bb, cc, dd, X[12],  7);
		dd = GG(dd, aa, bb, cc, X[ 0], 12);
		cc = GG(cc, dd, aa, bb, X[ 9], 15);
		bb = GG(bb, cc, dd, aa, X[ 5],  9);
		aa = GG(aa, bb, cc, dd, X[ 2], 11);
		dd = GG(dd, aa, bb, cc, X[14],  7);
		cc = GG(cc, dd, aa, bb, X[11], 13);
		bb = GG(bb, cc, dd, aa, X[ 8], 12);

		aa = HH(aa, bb, cc, dd, X[ 3], 11);
		dd = HH(dd, aa, bb, cc, X[10], 13);
		cc = HH(cc, dd, aa, bb, X[14],  6);
		bb = HH(bb, cc, dd, aa, X[ 4],  7);
		aa = HH(aa, bb, cc, dd, X[ 9], 14);
		dd = HH(dd, aa, bb, cc, X[15],  9);
		cc = HH(cc, dd, aa, bb, X[ 8], 13);
		bb = HH(bb, cc, dd, aa, X[ 1], 15);
		aa = HH(aa, bb, cc, dd, X[ 2], 14);
		dd = HH(dd, aa, bb, cc, X[ 7],  8);
		cc = HH(cc, dd, aa, bb, X[ 0], 13);
		bb = HH(bb, cc, dd, aa, X[ 6],  6);
		aa = HH(aa, bb, cc, dd, X[13],  5);
		dd = HH(dd, aa, bb, cc, X[11], 12);
		cc = HH(cc, dd, aa, bb, X[ 5],  7);
		bb = HH(bb, cc, dd, aa, X[12],  5);

		aa = II(aa, bb, cc, dd, X[ 1], 11);
		dd = II(dd, aa, bb, cc, X[ 9], 12);
		cc = II(cc, dd, aa, bb, X[11], 14);
		bb = II(bb, cc, dd, aa, X[10], 15);
		aa = II(aa, bb, cc, dd, X[ 0], 14);
		dd = II(dd, aa, bb, cc, X[ 8], 15);
		cc = II(cc, dd, aa, bb, X[12],  9);
		bb = II(bb, cc, dd, aa, X[ 4],  8);
		aa = II(aa, bb, cc, dd, X[13],  9);
		dd = II(dd, aa, bb, cc, X[ 3], 14);
		cc = II(cc, dd, aa, bb, X[ 7],  5);
		bb = II(bb, cc, dd, aa, X[15],  6);
		aa = II(aa, bb, cc, dd, X[14],  8);
		dd = II(dd, aa, bb, cc, X[ 5],  6);
		cc = II(cc, dd, aa, bb, X[ 6],  5);
		bb = II(bb, cc, dd, aa, X[ 2], 12);

		aaa = III(aaa, bbb, ccc, ddd, X[ 5],  8);
		ddd = III(ddd, aaa, bbb, ccc, X[14],  9);
		ccc = III(ccc, ddd, aaa, bbb, X[ 7],  9);
		bbb = III(bbb, ccc, ddd, aaa, X[ 0], 11);
		aaa = III(aaa, bbb, ccc, ddd, X[ 9], 13);
		ddd = III(ddd, aaa, bbb, ccc, X[ 2], 15);
		ccc = III(ccc, ddd, aaa, bbb, X[11], 15);
		bbb = III(bbb, ccc, ddd, aaa, X[ 4],  5);
		aaa = III(aaa, bbb, ccc, ddd, X[13],  7);
		ddd = III(ddd, aaa, bbb, ccc, X[ 6],  7);
		ccc = III(ccc, ddd, aaa, bbb, X[15],  8);
		bbb = III(bbb, ccc, ddd, aaa, X[ 8], 11);
		aaa = III(aaa, bbb, ccc, ddd, X[ 1], 14);
		ddd = III(ddd, aaa, bbb, ccc, X[10], 14);
		ccc = III(ccc, ddd, aaa, bbb, X[ 3], 12);
		bbb = III(bbb, ccc, ddd, aaa, X[12],  6);

		aaa = HHH(aaa, bbb, ccc, ddd, X[ 6],  9);
		ddd = HHH(ddd, aaa, bbb, ccc, X[11], 13);
		ccc = HHH(ccc, ddd, aaa, bbb, X[ 3], 15);
		bbb = HHH(bbb, ccc, ddd, aaa, X[ 7],  7);
		aaa = HHH(aaa, bbb, ccc, ddd, X[ 0], 12);
		ddd = HHH(ddd, aaa, bbb, ccc, X[13],  8);
		ccc = HHH(ccc, ddd, aaa, bbb, X[ 5],  9);
		bbb = HHH(bbb, ccc, ddd, aaa, X[10], 11);
		aaa = HHH(aaa, bbb, ccc, ddd, X[14],  7);
		ddd = HHH(ddd, aaa, bbb, ccc, X[15],  7);
		ccc = HHH(ccc, ddd, aaa, bbb, X[ 8], 12);
		bbb = HHH(bbb, ccc, ddd, aaa, X[12],  7);
		aaa = HHH(aaa, bbb, ccc, ddd, X[ 4],  6);
		ddd = HHH(ddd, aaa, bbb, ccc, X[ 9], 15);
		ccc = HHH(ccc, ddd, aaa, bbb, X[ 1], 13);
		bbb = HHH(bbb, ccc, ddd, aaa, X[ 2], 11);

		aaa = GGG(aaa, bbb, ccc, ddd, X[15],  9);
		ddd = GGG(ddd, aaa, bbb, ccc, X[ 5],  7);
		ccc = GGG(ccc, ddd, aaa, bbb, X[ 1], 15);
		bbb = GGG(bbb, ccc, ddd, aaa, X[ 3], 11);
		aaa = GGG(aaa, bbb, ccc, ddd, X[ 7],  8);
		ddd = GGG(ddd, aaa, bbb, ccc, X[14],  6);
		ccc = GGG(ccc, ddd, aaa, bbb, X[ 6],  6);
		bbb = GGG(bbb, ccc, ddd, aaa, X[ 9], 14);
		aaa = GGG(aaa, bbb, ccc, ddd, X[11], 12);
		ddd = GGG(ddd, aaa, bbb, ccc, X[ 8], 13);
		ccc = GGG(ccc, ddd, aaa, bbb, X[12],  5);
		bbb = GGG(bbb, ccc, ddd, aaa, X[ 2], 14);
		aaa = GGG(aaa, bbb, ccc, ddd, X[10], 13);
		ddd = GGG(ddd, aaa, bbb, ccc, X[ 0], 13);
		ccc = GGG(ccc, ddd, aaa, bbb, X[ 4],  7);
		bbb = GGG(bbb, ccc, ddd, aaa, X[13],  5);

		aaa = FFF(aaa, bbb, ccc, ddd, X[ 8], 15);
		ddd = FFF(ddd, aaa, bbb, ccc, X[ 6],  5);
		ccc = FFF(ccc, ddd, aaa, bbb, X[ 4],  8);
		bbb = FFF(bbb, ccc, ddd, aaa, X[ 1], 11);
		aaa = FFF(aaa, bbb, ccc, ddd, X[ 3], 14);
		ddd = FFF(ddd, aaa, bbb, ccc, X[11], 14);
		ccc = FFF(ccc, ddd, aaa, bbb, X[15],  6);
		bbb = FFF(bbb, ccc, ddd, aaa, X[ 0], 14);
		aaa = FFF(aaa, bbb, ccc, ddd, X[ 5],  6);
		ddd = FFF(ddd, aaa, bbb, ccc, X[12],  9);
		ccc = FFF(ccc, ddd, aaa, bbb, X[ 2], 12);
		bbb = FFF(bbb, ccc, ddd, aaa, X[13],  9);
		aaa = FFF(aaa, bbb, ccc, ddd, X[ 9], 12);
		ddd = FFF(ddd, aaa, bbb, ccc, X[ 7],  5);
		ccc = FFF(ccc, ddd, aaa, bbb, X[10], 15);
		bbb = FFF(bbb, ccc, ddd, aaa, X[14],  8);


		A, B, C, D = AND(B + cc + ddd, 0xFFFFFFFF),
					 AND(C + dd + aaa, 0xFFFFFFFF),
					 AND(D + aa + bbb, 0xFFFFFFFF),
					 AND(A + bb + ccc, 0xFFFFFFFF);

	end

	public.init = function()
		queue.reset();

		A = 0x67452301;
		B = 0xefcdab89;
		C = 0x98badcfe;
		D = 0x10325476;

		return public;
	end


	public.update = function(bytes)
		for b in bytes do
			queue.push(b);
			if(queue.size() >= 64) then processBlock(); end
		end

		return public;
	end

	public.finish = function()
		local bits = queue.getHead() * 8;

		queue.push(0x80);

		while ((queue.size()+7) % 64) < 63 do
			queue.push(0x00);
		end

		local b0,b1,b2,b3,b4,b5,b6,b7 = dword2bytes(bits);

		queue.push(b0);
		queue.push(b1);
		queue.push(b2);
		queue.push(b3);
		queue.push(b4);
		queue.push(b5);
		queue.push(b6);
		queue.push(b7);

		while queue.size() > 0 do
			processBlock();
		end

		return public;
	end

	public.asBytes = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);

		return { b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,
				b10,b11,b12,b13,b14,b15};
	end

	public.asHex = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);

		local fmt = "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x";

		return String.format(fmt,
				 b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,
				b10,b11,b12,b13,b14,b15);
	end

	return public;

end

return RIPEMD128;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/ripemd160.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Math = require("math");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--RIPEMD160 is little-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b3; i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b0);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b0 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b3 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local bytes2dword = function(b0,b1,b2,b3,b4,b5,b6,b7)
	local i = bytes2word(b0,b1,b2,b3);
	local j = bytes2word(b4,b5,b6,b7);
	return (j*0x100000000)+i;
end

local dword2bytes = function(i)
	local b4,b5,b6,b7 = word2bytes(Math.floor(i/0x100000000));
	local b0,b1,b2,b3 = word2bytes(i);
	return b0,b1,b2,b3,b4,b5,b6,b7;
end

local F = function(x,y,z) return XOR(x, XOR(y,z)); end
local G = function(x,y,z) return OR(AND(x,y), AND(NOT(x),z)); end
local H = function(x,y,z) return XOR(OR(x,NOT(y)),z); end
local I = function(x,y,z) return OR(AND(x,z),AND(y,NOT(z))); end
local J = function(x,y,z) return XOR(x,OR(y,NOT(z))); end

local FF = function(a,b,c,d,e,x,s)
	a = a + F(b,c,d) + x;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local GG = function(a,b,c,d,e,x,s)
	a = a + G(b,c,d) + x + 0x5a827999;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local HH = function(a,b,c,d,e,x,s)
	a = a + H(b,c,d) + x + 0x6ed9eba1;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local II = function(a,b,c,d,e,x,s)
	a = a + I(b,c,d) + x + 0x8f1bbcdc;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local JJ = function(a,b,c,d,e,x,s)
	a = a + J(b,c,d) + x + 0xa953fd4e;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local FFF = function(a,b,c,d,e,x,s)
	a = a + F(b,c,d) + x;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local GGG = function(a,b,c,d,e,x,s)
	a = a + G(b,c,d) + x + 0x7a6d76e9;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local HHH = function(a,b,c,d,e,x,s)
	a = a + H(b,c,d) + x + 0x6d703ef3;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local III = function(a,b,c,d,e,x,s)
	a = a + I(b,c,d) + x + 0x5c4dd124;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local JJJ = function(a,b,c,d,e,x,s)
	a = a + J(b,c,d) + x + 0x50a28be6;
	a = LROT(a,s) + e;
	a = AND(a, 0xFFFFFFFF);
	return a;
end

local RIPEMD160 = function()

	local queue = Queue();

	local A = 0x67452301;
	local B = 0xefcdab89;
	local C = 0x98badcfe;
	local D = 0x10325476;
	local E = 0xc3d2e1f0;

	local public = {};

	local processBlock = function()
		local aa,bb,cc,dd,ee = A,B,C,D,E;
		local aaa,bbb,ccc,ddd,eee = A,B,C,D,E;

		local X = {};

		for i=0,15 do
			X[i] = bytes2word(queue.pop(),queue.pop(),queue.pop(),queue.pop());
		end

		aa, cc = FF(aa, bb, cc, dd, ee, X[ 0], 11), LROT(cc,10);
		ee, bb = FF(ee, aa, bb, cc, dd, X[ 1], 14), LROT(bb,10);
		dd, aa = FF(dd, ee, aa, bb, cc, X[ 2], 15), LROT(aa,10);
		cc, ee = FF(cc, dd, ee, aa, bb, X[ 3], 12), LROT(ee,10);
		bb, dd = FF(bb, cc, dd, ee, aa, X[ 4],  5), LROT(dd,10);
		aa, cc = FF(aa, bb, cc, dd, ee, X[ 5],  8), LROT(cc,10);
		ee, bb = FF(ee, aa, bb, cc, dd, X[ 6],  7), LROT(bb,10);
		dd, aa = FF(dd, ee, aa, bb, cc, X[ 7],  9), LROT(aa,10);
		cc, ee = FF(cc, dd, ee, aa, bb, X[ 8], 11), LROT(ee,10);
		bb, dd = FF(bb, cc, dd, ee, aa, X[ 9], 13), LROT(dd,10);
		aa, cc = FF(aa, bb, cc, dd, ee, X[10], 14), LROT(cc,10);
		ee, bb = FF(ee, aa, bb, cc, dd, X[11], 15), LROT(bb,10);
		dd, aa = FF(dd, ee, aa, bb, cc, X[12],  6), LROT(aa,10);
		cc, ee = FF(cc, dd, ee, aa, bb, X[13],  7), LROT(ee,10);
		bb, dd = FF(bb, cc, dd, ee, aa, X[14],  9), LROT(dd,10);
		aa, cc = FF(aa, bb, cc, dd, ee, X[15],  8), LROT(cc,10);

		ee, bb = GG(ee, aa, bb, cc, dd, X[ 7],  7), LROT(bb,10);
		dd, aa = GG(dd, ee, aa, bb, cc, X[ 4],  6), LROT(aa,10);
		cc, ee = GG(cc, dd, ee, aa, bb, X[13],  8), LROT(ee,10);
		bb, dd = GG(bb, cc, dd, ee, aa, X[ 1], 13), LROT(dd,10);
		aa, cc = GG(aa, bb, cc, dd, ee, X[10], 11), LROT(cc,10);
		ee, bb = GG(ee, aa, bb, cc, dd, X[ 6],  9), LROT(bb,10);
		dd, aa = GG(dd, ee, aa, bb, cc, X[15],  7), LROT(aa,10);
		cc, ee = GG(cc, dd, ee, aa, bb, X[ 3], 15), LROT(ee,10);
		bb, dd = GG(bb, cc, dd, ee, aa, X[12],  7), LROT(dd,10);
		aa, cc = GG(aa, bb, cc, dd, ee, X[ 0], 12), LROT(cc,10);
		ee, bb = GG(ee, aa, bb, cc, dd, X[ 9], 15), LROT(bb,10);
		dd, aa = GG(dd, ee, aa, bb, cc, X[ 5],  9), LROT(aa,10);
		cc, ee = GG(cc, dd, ee, aa, bb, X[ 2], 11), LROT(ee,10);
		bb, dd = GG(bb, cc, dd, ee, aa, X[14],  7), LROT(dd,10);
		aa, cc = GG(aa, bb, cc, dd, ee, X[11], 13), LROT(cc,10);
		ee, bb = GG(ee, aa, bb, cc, dd, X[ 8], 12), LROT(bb,10);

		dd, aa = HH(dd, ee, aa, bb, cc, X[ 3], 11), LROT(aa,10);
		cc, ee = HH(cc, dd, ee, aa, bb, X[10], 13), LROT(ee,10);
		bb, dd = HH(bb, cc, dd, ee, aa, X[14],  6), LROT(dd,10);
		aa, cc = HH(aa, bb, cc, dd, ee, X[ 4],  7), LROT(cc,10);
		ee, bb = HH(ee, aa, bb, cc, dd, X[ 9], 14), LROT(bb,10);
		dd, aa = HH(dd, ee, aa, bb, cc, X[15],  9), LROT(aa,10);
		cc, ee = HH(cc, dd, ee, aa, bb, X[ 8], 13), LROT(ee,10);
		bb, dd = HH(bb, cc, dd, ee, aa, X[ 1], 15), LROT(dd,10);
		aa, cc = HH(aa, bb, cc, dd, ee, X[ 2], 14), LROT(cc,10);
		ee, bb = HH(ee, aa, bb, cc, dd, X[ 7],  8), LROT(bb,10);
		dd, aa = HH(dd, ee, aa, bb, cc, X[ 0], 13), LROT(aa,10);
		cc, ee = HH(cc, dd, ee, aa, bb, X[ 6],  6), LROT(ee,10);
		bb, dd = HH(bb, cc, dd, ee, aa, X[13],  5), LROT(dd,10);
		aa, cc = HH(aa, bb, cc, dd, ee, X[11], 12), LROT(cc,10);
		ee, bb = HH(ee, aa, bb, cc, dd, X[ 5],  7), LROT(bb,10);
		dd, aa = HH(dd, ee, aa, bb, cc, X[12],  5), LROT(aa,10);

		cc, ee = II(cc, dd, ee, aa, bb, X[ 1], 11), LROT(ee,10);
		bb, dd = II(bb, cc, dd, ee, aa, X[ 9], 12), LROT(dd,10);
		aa, cc = II(aa, bb, cc, dd, ee, X[11], 14), LROT(cc,10);
		ee, bb = II(ee, aa, bb, cc, dd, X[10], 15), LROT(bb,10);
		dd, aa = II(dd, ee, aa, bb, cc, X[ 0], 14), LROT(aa,10);
		cc, ee = II(cc, dd, ee, aa, bb, X[ 8], 15), LROT(ee,10);
		bb, dd = II(bb, cc, dd, ee, aa, X[12],  9), LROT(dd,10);
		aa, cc = II(aa, bb, cc, dd, ee, X[ 4],  8), LROT(cc,10);
		ee, bb = II(ee, aa, bb, cc, dd, X[13],  9), LROT(bb,10);
		dd, aa = II(dd, ee, aa, bb, cc, X[ 3], 14), LROT(aa,10);
		cc, ee = II(cc, dd, ee, aa, bb, X[ 7],  5), LROT(ee,10);
		bb, dd = II(bb, cc, dd, ee, aa, X[15],  6), LROT(dd,10);
		aa, cc = II(aa, bb, cc, dd, ee, X[14],  8), LROT(cc,10);
		ee, bb = II(ee, aa, bb, cc, dd, X[ 5],  6), LROT(bb,10);
		dd, aa = II(dd, ee, aa, bb, cc, X[ 6],  5), LROT(aa,10);
		cc, ee = II(cc, dd, ee, aa, bb, X[ 2], 12), LROT(ee,10);

		bb, dd = JJ(bb, cc, dd, ee, aa, X[ 4],  9), LROT(dd,10);
		aa, cc = JJ(aa, bb, cc, dd, ee, X[ 0], 15), LROT(cc,10);
		ee, bb = JJ(ee, aa, bb, cc, dd, X[ 5],  5), LROT(bb,10);
		dd, aa = JJ(dd, ee, aa, bb, cc, X[ 9], 11), LROT(aa,10);
		cc, ee = JJ(cc, dd, ee, aa, bb, X[ 7],  6), LROT(ee,10);
		bb, dd = JJ(bb, cc, dd, ee, aa, X[12],  8), LROT(dd,10);
		aa, cc = JJ(aa, bb, cc, dd, ee, X[ 2], 13), LROT(cc,10);
		ee, bb = JJ(ee, aa, bb, cc, dd, X[10], 12), LROT(bb,10);
		dd, aa = JJ(dd, ee, aa, bb, cc, X[14],  5), LROT(aa,10);
		cc, ee = JJ(cc, dd, ee, aa, bb, X[ 1], 12), LROT(ee,10);
		bb, dd = JJ(bb, cc, dd, ee, aa, X[ 3], 13), LROT(dd,10);
		aa, cc = JJ(aa, bb, cc, dd, ee, X[ 8], 14), LROT(cc,10);
		ee, bb = JJ(ee, aa, bb, cc, dd, X[11], 11), LROT(bb,10);
		dd, aa = JJ(dd, ee, aa, bb, cc, X[ 6],  8), LROT(aa,10);
		cc, ee = JJ(cc, dd, ee, aa, bb, X[15],  5), LROT(ee,10);
		bb, dd = JJ(bb, cc, dd, ee, aa, X[13],  6), LROT(dd,10);

		aaa, ccc = JJJ(aaa, bbb, ccc, ddd, eee, X[ 5],  8), LROT(ccc,10);
		eee, bbb = JJJ(eee, aaa, bbb, ccc, ddd, X[14],  9), LROT(bbb,10);
		ddd, aaa = JJJ(ddd, eee, aaa, bbb, ccc, X[ 7],  9), LROT(aaa,10);
		ccc, eee = JJJ(ccc, ddd, eee, aaa, bbb, X[ 0], 11), LROT(eee,10);
		bbb, ddd = JJJ(bbb, ccc, ddd, eee, aaa, X[ 9], 13), LROT(ddd,10);
		aaa, ccc = JJJ(aaa, bbb, ccc, ddd, eee, X[ 2], 15), LROT(ccc,10);
		eee, bbb = JJJ(eee, aaa, bbb, ccc, ddd, X[11], 15), LROT(bbb,10);
		ddd, aaa = JJJ(ddd, eee, aaa, bbb, ccc, X[ 4],  5), LROT(aaa,10);
		ccc, eee = JJJ(ccc, ddd, eee, aaa, bbb, X[13],  7), LROT(eee,10);
		bbb, ddd = JJJ(bbb, ccc, ddd, eee, aaa, X[ 6],  7), LROT(ddd,10);
		aaa, ccc = JJJ(aaa, bbb, ccc, ddd, eee, X[15],  8), LROT(ccc,10);
		eee, bbb = JJJ(eee, aaa, bbb, ccc, ddd, X[ 8], 11), LROT(bbb,10);
		ddd, aaa = JJJ(ddd, eee, aaa, bbb, ccc, X[ 1], 14), LROT(aaa,10);
		ccc, eee = JJJ(ccc, ddd, eee, aaa, bbb, X[10], 14), LROT(eee,10);
		bbb, ddd = JJJ(bbb, ccc, ddd, eee, aaa, X[ 3], 12), LROT(ddd,10);
		aaa, ccc = JJJ(aaa, bbb, ccc, ddd, eee, X[12],  6), LROT(ccc,10);

		eee, bbb = III(eee, aaa, bbb, ccc, ddd, X[ 6],  9), LROT(bbb,10);
		ddd, aaa = III(ddd, eee, aaa, bbb, ccc, X[11], 13), LROT(aaa,10);
		ccc, eee = III(ccc, ddd, eee, aaa, bbb, X[ 3], 15), LROT(eee,10);
		bbb, ddd = III(bbb, ccc, ddd, eee, aaa, X[ 7],  7), LROT(ddd,10);
		aaa, ccc = III(aaa, bbb, ccc, ddd, eee, X[ 0], 12), LROT(ccc,10);
		eee, bbb = III(eee, aaa, bbb, ccc, ddd, X[13],  8), LROT(bbb,10);
		ddd, aaa = III(ddd, eee, aaa, bbb, ccc, X[ 5],  9), LROT(aaa,10);
		ccc, eee = III(ccc, ddd, eee, aaa, bbb, X[10], 11), LROT(eee,10);
		bbb, ddd = III(bbb, ccc, ddd, eee, aaa, X[14],  7), LROT(ddd,10);
		aaa, ccc = III(aaa, bbb, ccc, ddd, eee, X[15],  7), LROT(ccc,10);
		eee, bbb = III(eee, aaa, bbb, ccc, ddd, X[ 8], 12), LROT(bbb,10);
		ddd, aaa = III(ddd, eee, aaa, bbb, ccc, X[12],  7), LROT(aaa,10);
		ccc, eee = III(ccc, ddd, eee, aaa, bbb, X[ 4],  6), LROT(eee,10);
		bbb, ddd = III(bbb, ccc, ddd, eee, aaa, X[ 9], 15), LROT(ddd,10);
		aaa, ccc = III(aaa, bbb, ccc, ddd, eee, X[ 1], 13), LROT(ccc,10);
		eee, bbb = III(eee, aaa, bbb, ccc, ddd, X[ 2], 11), LROT(bbb,10);

		ddd, aaa = HHH(ddd, eee, aaa, bbb, ccc, X[15],  9), LROT(aaa,10);
		ccc, eee = HHH(ccc, ddd, eee, aaa, bbb, X[ 5],  7), LROT(eee,10);
		bbb, ddd = HHH(bbb, ccc, ddd, eee, aaa, X[ 1], 15), LROT(ddd,10);
		aaa, ccc = HHH(aaa, bbb, ccc, ddd, eee, X[ 3], 11), LROT(ccc,10);
		eee, bbb = HHH(eee, aaa, bbb, ccc, ddd, X[ 7],  8), LROT(bbb,10);
		ddd, aaa = HHH(ddd, eee, aaa, bbb, ccc, X[14],  6), LROT(aaa,10);
		ccc, eee = HHH(ccc, ddd, eee, aaa, bbb, X[ 6],  6), LROT(eee,10);
		bbb, ddd = HHH(bbb, ccc, ddd, eee, aaa, X[ 9], 14), LROT(ddd,10);
		aaa, ccc = HHH(aaa, bbb, ccc, ddd, eee, X[11], 12), LROT(ccc,10);
		eee, bbb = HHH(eee, aaa, bbb, ccc, ddd, X[ 8], 13), LROT(bbb,10);
		ddd, aaa = HHH(ddd, eee, aaa, bbb, ccc, X[12],  5), LROT(aaa,10);
		ccc, eee = HHH(ccc, ddd, eee, aaa, bbb, X[ 2], 14), LROT(eee,10);
		bbb, ddd = HHH(bbb, ccc, ddd, eee, aaa, X[10], 13), LROT(ddd,10);
		aaa, ccc = HHH(aaa, bbb, ccc, ddd, eee, X[ 0], 13), LROT(ccc,10);
		eee, bbb = HHH(eee, aaa, bbb, ccc, ddd, X[ 4],  7), LROT(bbb,10);
		ddd, aaa = HHH(ddd, eee, aaa, bbb, ccc, X[13],  5), LROT(aaa,10);

		ccc, eee = GGG(ccc, ddd, eee, aaa, bbb, X[ 8], 15), LROT(eee,10);
		bbb, ddd = GGG(bbb, ccc, ddd, eee, aaa, X[ 6],  5), LROT(ddd,10);
		aaa, ccc = GGG(aaa, bbb, ccc, ddd, eee, X[ 4],  8), LROT(ccc,10);
		eee, bbb = GGG(eee, aaa, bbb, ccc, ddd, X[ 1], 11), LROT(bbb,10);
		ddd, aaa = GGG(ddd, eee, aaa, bbb, ccc, X[ 3], 14), LROT(aaa,10);
		ccc, eee = GGG(ccc, ddd, eee, aaa, bbb, X[11], 14), LROT(eee,10);
		bbb, ddd = GGG(bbb, ccc, ddd, eee, aaa, X[15],  6), LROT(ddd,10);
		aaa, ccc = GGG(aaa, bbb, ccc, ddd, eee, X[ 0], 14), LROT(ccc,10);
		eee, bbb = GGG(eee, aaa, bbb, ccc, ddd, X[ 5],  6), LROT(bbb,10);
		ddd, aaa = GGG(ddd, eee, aaa, bbb, ccc, X[12],  9), LROT(aaa,10);
		ccc, eee = GGG(ccc, ddd, eee, aaa, bbb, X[ 2], 12), LROT(eee,10);
		bbb, ddd = GGG(bbb, ccc, ddd, eee, aaa, X[13],  9), LROT(ddd,10);
		aaa, ccc = GGG(aaa, bbb, ccc, ddd, eee, X[ 9], 12), LROT(ccc,10);
		eee, bbb = GGG(eee, aaa, bbb, ccc, ddd, X[ 7],  5), LROT(bbb,10);
		ddd, aaa = GGG(ddd, eee, aaa, bbb, ccc, X[10], 15), LROT(aaa,10);
		ccc, eee = GGG(ccc, ddd, eee, aaa, bbb, X[14],  8), LROT(eee,10);

		bbb, ddd = FFF(bbb, ccc, ddd, eee, aaa, X[12] ,  8), LROT(ddd,10);
		aaa, ccc = FFF(aaa, bbb, ccc, ddd, eee, X[15] ,  5), LROT(ccc,10);
		eee, bbb = FFF(eee, aaa, bbb, ccc, ddd, X[10] , 12), LROT(bbb,10);
		ddd, aaa = FFF(ddd, eee, aaa, bbb, ccc, X[ 4] ,  9), LROT(aaa,10);
		ccc, eee = FFF(ccc, ddd, eee, aaa, bbb, X[ 1] , 12), LROT(eee,10);
		bbb, ddd = FFF(bbb, ccc, ddd, eee, aaa, X[ 5] ,  5), LROT(ddd,10);
		aaa, ccc = FFF(aaa, bbb, ccc, ddd, eee, X[ 8] , 14), LROT(ccc,10);
		eee, bbb = FFF(eee, aaa, bbb, ccc, ddd, X[ 7] ,  6), LROT(bbb,10);
		ddd, aaa = FFF(ddd, eee, aaa, bbb, ccc, X[ 6] ,  8), LROT(aaa,10);
		ccc, eee = FFF(ccc, ddd, eee, aaa, bbb, X[ 2] , 13), LROT(eee,10);
		bbb, ddd = FFF(bbb, ccc, ddd, eee, aaa, X[13] ,  6), LROT(ddd,10);
		aaa, ccc = FFF(aaa, bbb, ccc, ddd, eee, X[14] ,  5), LROT(ccc,10);
		eee, bbb = FFF(eee, aaa, bbb, ccc, ddd, X[ 0] , 15), LROT(bbb,10);
		ddd, aaa = FFF(ddd, eee, aaa, bbb, ccc, X[ 3] , 13), LROT(aaa,10);
		ccc, eee = FFF(ccc, ddd, eee, aaa, bbb, X[ 9] , 11), LROT(eee,10);
		bbb, ddd = FFF(bbb, ccc, ddd, eee, aaa, X[11] , 11), LROT(ddd,10);

		A, B, C, D, E = AND(B + cc + ddd, 0xFFFFFFFF),
						AND(C + dd + eee, 0xFFFFFFFF),
						AND(D + ee + aaa, 0xFFFFFFFF),
						AND(E + aa + bbb, 0xFFFFFFFF),
						AND(A + bb + ccc, 0xFFFFFFFF);

	end

	public.init = function()
		queue.reset();

		A = 0x67452301;
		B = 0xefcdab89;
		C = 0x98badcfe;
		D = 0x10325476;
		E = 0xc3d2e1f0;

		return public;
	end

	public.update = function(bytes)
		for b in bytes do
			queue.push(b);
			if(queue.size() >= 64) then processBlock(); end
		end

		return public;
	end

	public.finish = function()
		local bits = queue.getHead() * 8;

		queue.push(0x80);

		while ((queue.size()+7) % 64) < 63 do
			queue.push(0x00);
		end

		local b0,b1,b2,b3,b4,b5,b6,b7 = dword2bytes(bits);

		queue.push(b0);
		queue.push(b1);
		queue.push(b2);
		queue.push(b3);
		queue.push(b4);
		queue.push(b5);
		queue.push(b6);
		queue.push(b7);

		while queue.size() > 0 do
			processBlock();
		end

		return public;
	end

	public.asBytes = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);
		local b16,b17,b18,b19 = word2bytes(E);

		return { b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,
				b10,b11,b12,b13,b14,b15,b16,b17,b18,b19};
	end

	public.asHex = function()
		local  b0, b1, b2, b3 = word2bytes(A);
		local  b4, b5, b6, b7 = word2bytes(B);
		local  b8, b9,b10,b11 = word2bytes(C);
		local b12,b13,b14,b15 = word2bytes(D);
		local b16,b17,b18,b19 = word2bytes(E);

		local fmt = "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x";

		return String.format(fmt,
				 b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,
				b10,b11,b12,b13,b14,b15,b16,b17,b18,b19);
	end

	return public;

end

return RIPEMD160;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/sha1.lua"] = "require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox").insecure();

local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Math = require("math");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--SHA1 is big-endian
local bytes2word = function(b0, b1, b2, b3)
    local i = b0; i = LSHIFT(i, 8);
    i = OR(i, b1); i = LSHIFT(i, 8);
    i = OR(i, b2); i = LSHIFT(i, 8);
    i = OR(i, b3);
    return i;
end

local word2bytes = function(word)
    local b0, b1, b2, b3;
    b3 = AND(word, 0xFF); word = RSHIFT(word, 8);
    b2 = AND(word, 0xFF); word = RSHIFT(word, 8);
    b1 = AND(word, 0xFF); word = RSHIFT(word, 8);
    b0 = AND(word, 0xFF);
    return b0, b1, b2, b3;
end

local bytes2dword = function(b0, b1, b2, b3, b4, b5, b6, b7)
    local i = bytes2word(b0, b1, b2, b3);
    local j = bytes2word(b4, b5, b6, b7);
    return (i * 0x100000000) + j;
end

local dword2bytes = function(i)
    local b4, b5, b6, b7 = word2bytes(i);
    local b0, b1, b2, b3 = word2bytes(Math.floor(i / 0x100000000));
    return b0, b1, b2, b3, b4, b5, b6, b7;
end

local F = function(x, y, z) return XOR(z, AND(x, XOR(y, z))); end
local G = function(x, y, z) return XOR(x, XOR(y, z)); end
local H = function(x, y, z) return OR(AND(x, OR(y, z)), AND(y, z)); end
local I = function(x, y, z) return XOR(x, XOR(y, z)); end

local SHA1 = function()

    local queue = Queue();

    local h0 = 0x67452301;
    local h1 = 0xEFCDAB89;
    local h2 = 0x98BADCFE;
    local h3 = 0x10325476;
    local h4 = 0xC3D2E1F0;

    local public = {};

    local processBlock = function()
        local a = h0;
        local b = h1;
        local c = h2;
        local d = h3;
        local e = h4;
        local temp;
        local k;

        local w = {};
        for i = 0, 15 do
            w[i] = bytes2word(queue.pop(), queue.pop(), queue.pop(), queue.pop());
        end

        for i = 16, 79 do
            w[i] = LROT((XOR(XOR(w[i - 3], w[i - 8]), XOR(w[i - 14], w[i - 16]))), 1);
        end

        for i = 0, 79 do
            if (i <= 19) then
                temp = F(b, c, d);
                k = 0x5A827999;
            elseif (i <= 39) then
                temp = G(b, c, d);
                k = 0x6ED9EBA1;
            elseif (i <= 59) then
                temp = H(b, c, d);
                k = 0x8F1BBCDC;
            else
                temp = I(b, c, d);
                k = 0xCA62C1D6;
            end
            temp = LROT(a, 5) + temp + e + k + w[i];
            e = d;
            d = c;
            c = LROT(b, 30);
            b = a;
            a = temp;
        end

        h0 = AND(h0 + a, 0xFFFFFFFF);
        h1 = AND(h1 + b, 0xFFFFFFFF);
        h2 = AND(h2 + c, 0xFFFFFFFF);
        h3 = AND(h3 + d, 0xFFFFFFFF);
        h4 = AND(h4 + e, 0xFFFFFFFF);
    end

    public.init = function()
        queue.reset();
        h0 = 0x67452301;
        h1 = 0xEFCDAB89;
        h2 = 0x98BADCFE;
        h3 = 0x10325476;
        h4 = 0xC3D2E1F0;
        return public;
    end


    public.update = function(bytes)
        for b in bytes do
            queue.push(b);
            if queue.size() >= 64 then processBlock(); end
        end

        return public;
    end

    public.finish = function()
        local bits = queue.getHead() * 8;

        queue.push(0x80);
        while ((queue.size() + 7) % 64) < 63 do
            queue.push(0x00);
        end

        local b0, b1, b2, b3, b4, b5, b6, b7 = dword2bytes(bits);

        queue.push(b0);
        queue.push(b1);
        queue.push(b2);
        queue.push(b3);
        queue.push(b4);
        queue.push(b5);
        queue.push(b6);
        queue.push(b7);

        while queue.size() > 0 do
            processBlock();
        end

        return public;
    end

    public.asBytes = function()
        local  b0, b1, b2, b3 = word2bytes(h0);
        local  b4, b5, b6, b7 = word2bytes(h1);
        local  b8, b9, b10, b11 = word2bytes(h2);
        local b12, b13, b14, b15 = word2bytes(h3);
        local b16, b17, b18, b19 = word2bytes(h4);

        return {b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19};
    end

    public.asHex = function()
        local  b0, b1, b2, b3 = word2bytes(h0);
        local  b4, b5, b6, b7 = word2bytes(h1);
        local  b8, b9, b10, b11 = word2bytes(h2);
        local b12, b13, b14, b15 = word2bytes(h3);
        local b16, b17, b18, b19 = word2bytes(h4);

        return String.format("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19);
    end

    return public;
end

return SHA1;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/sha2_224.lua"] = "local Bit = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Math = require("math");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local CONSTANTS = {
   0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
   0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
   0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
   0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
   0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
   0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
   0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
   0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2  };

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--SHA2 is big-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b0; i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b3);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b3 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b0 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local bytes2dword = function(b0,b1,b2,b3,b4,b5,b6,b7)
	local i = bytes2word(b0,b1,b2,b3);
	local j = bytes2word(b4,b5,b6,b7);
	return (i*0x100000000)+j;
end

local dword2bytes = function(i)
	local b4,b5,b6,b7 = word2bytes(i);
	local b0,b1,b2,b3 = word2bytes(Math.floor(i/0x100000000));
	return b0,b1,b2,b3,b4,b5,b6,b7;
end




local SHA2_224 = function()

	local queue = Queue();

	local h0 = 0xc1059ed8;
	local h1 = 0x367cd507;
	local h2 = 0x3070dd17;
	local h3 = 0xf70e5939;
	local h4 = 0xffc00b31;
	local h5 = 0x68581511;
	local h6 = 0x64f98fa7;
	local h7 = 0xbefa4fa4;

	local public = {};

	local processBlock = function()
		local a = h0;
		local b = h1;
		local c = h2;
		local d = h3;
		local e = h4;
		local f = h5;
		local g = h6;
		local h = h7;

		local w = {};

		for i=0,15 do
			w[i] = bytes2word(queue.pop(),queue.pop(),queue.pop(),queue.pop());
		end

		for i=16,63 do
			local s0 = XOR(RROT(w[i-15],7), XOR(RROT(w[i-15],18), RSHIFT(w[i-15],3)));
			local s1 = XOR(RROT(w[i-2],17), XOR(RROT(w[i-2], 19), RSHIFT(w[i-2],10)));
			w[i] = AND(w[i-16] + s0 + w[i-7] + s1, 0xFFFFFFFF);
		end

		for i=0,63 do
			local s1 = XOR(RROT(e,6), XOR(RROT(e,11),RROT(e,25)));
			local ch = XOR(AND(e,f), AND(NOT(e),g));
			local temp1 = h + s1 + ch + CONSTANTS[i+1] + w[i];
			local s0 = XOR(RROT(a,2), XOR(RROT(a,13), RROT(a,22)));
			local maj = XOR(AND(a,b), XOR(AND(a,c), AND(b,c)));
			local temp2 = s0 + maj;

			h = g;
			g = f;
			f = e;
			e = d + temp1;
			d = c;
			c = b;
			b = a;
			a = temp1 + temp2;
		end

		h0 = AND(h0 + a, 0xFFFFFFFF);
		h1 = AND(h1 + b, 0xFFFFFFFF);
		h2 = AND(h2 + c, 0xFFFFFFFF);
		h3 = AND(h3 + d, 0xFFFFFFFF);
		h4 = AND(h4 + e, 0xFFFFFFFF);
		h5 = AND(h5 + f, 0xFFFFFFFF);
		h6 = AND(h6 + g, 0xFFFFFFFF);
		h7 = AND(h7 + h, 0xFFFFFFFF);
	end

	public.init = function()
		queue.reset();

		h0 = 0xc1059ed8;
		h1 = 0x367cd507;
		h2 = 0x3070dd17;
		h3 = 0xf70e5939;
		h4 = 0xffc00b31;
		h5 = 0x68581511;
		h6 = 0x64f98fa7;
		h7 = 0xbefa4fa4;

		return public;
	end

	public.update = function(bytes)
		for b in bytes do
			queue.push(b);
			if queue.size() >= 64 then processBlock(); end
		end

		return public;
	end

	public.finish = function()
		local bits = queue.getHead() * 8;

		queue.push(0x80);
		while ((queue.size()+7) % 64) < 63 do
			queue.push(0x00);
		end

		local b0,b1,b2,b3,b4,b5,b6,b7 = dword2bytes(bits);

		queue.push(b0);
		queue.push(b1);
		queue.push(b2);
		queue.push(b3);
		queue.push(b4);
		queue.push(b5);
		queue.push(b6);
		queue.push(b7);

		while queue.size() > 0 do
			processBlock();
		end

		return public;
	end

	public.asBytes = function()
		local  b0, b1, b2, b3 = word2bytes(h0);
		local  b4, b5, b6, b7 = word2bytes(h1);
		local  b8, b9,b10,b11 = word2bytes(h2);
		local b12,b13,b14,b15 = word2bytes(h3);
		local b16,b17,b18,b19 = word2bytes(h4);
		local b20,b21,b22,b23 = word2bytes(h5);
		local b24,b25,b26,b27 = word2bytes(h6);

		return {  b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,b10,b11,b12,b13,b14,b15
				,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27};
	end

	public.asHex = function()
		local  b0, b1, b2, b3 = word2bytes(h0);
		local  b4, b5, b6, b7 = word2bytes(h1);
		local  b8, b9,b10,b11 = word2bytes(h2);
		local b12,b13,b14,b15 = word2bytes(h3);
		local b16,b17,b18,b19 = word2bytes(h4);
		local b20,b21,b22,b23 = word2bytes(h5);
		local b24,b25,b26,b27 = word2bytes(h6);

		local fmt = "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"

		return String.format(fmt, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,b10,b11,b12,b13,b14,b15
				,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27);
	end

	return public;

end

return SHA2_224;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/digest/sha2_256.lua"] = "local Bit = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Math = require("math");
local Queue = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");

local CONSTANTS = {
   0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
   0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
   0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
   0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
   0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
   0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
   0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
   0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2  };

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--SHA2 is big-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b0; i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b3);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b3 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b0 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local bytes2dword = function(b0,b1,b2,b3,b4,b5,b6,b7)
	local i = bytes2word(b0,b1,b2,b3);
	local j = bytes2word(b4,b5,b6,b7);
	return (i*0x100000000)+j;
end

local dword2bytes = function(i)
	local b4,b5,b6,b7 = word2bytes(i);
	local b0,b1,b2,b3 = word2bytes(Math.floor(i/0x100000000));
	return b0,b1,b2,b3,b4,b5,b6,b7;
end




local SHA2_256 = function()

	local queue = Queue();

	local h0 = 0x6a09e667;
	local h1 = 0xbb67ae85;
	local h2 = 0x3c6ef372;
	local h3 = 0xa54ff53a;
	local h4 = 0x510e527f;
	local h5 = 0x9b05688c;
	local h6 = 0x1f83d9ab;
	local h7 = 0x5be0cd19;

	local public = {};

	local processBlock = function()
		local a = h0;
		local b = h1;
		local c = h2;
		local d = h3;
		local e = h4;
		local f = h5;
		local g = h6;
		local h = h7;

		local w = {};

		for i=0,15 do
			w[i] = bytes2word(queue.pop(),queue.pop(),queue.pop(),queue.pop());
		end

		for i=16,63 do
			local s0 = XOR(RROT(w[i-15],7), XOR(RROT(w[i-15],18), RSHIFT(w[i-15],3)));
			local s1 = XOR(RROT(w[i-2],17), XOR(RROT(w[i-2], 19), RSHIFT(w[i-2],10)));
			w[i] = AND(w[i-16] + s0 + w[i-7] + s1, 0xFFFFFFFF);
		end

		for i=0,63 do
			local s1 = XOR(RROT(e,6), XOR(RROT(e,11),RROT(e,25)));
			local ch = XOR(AND(e,f), AND(NOT(e),g));
			local temp1 = h + s1 + ch + CONSTANTS[i+1] + w[i];
			local s0 = XOR(RROT(a,2), XOR(RROT(a,13), RROT(a,22)));
			local maj = XOR(AND(a,b), XOR(AND(a,c), AND(b,c)));
			local temp2 = s0 + maj;

			h = g;
			g = f;
			f = e;
			e = d + temp1;
			d = c;
			c = b;
			b = a;
			a = temp1 + temp2;
		end

		h0 = AND(h0 + a, 0xFFFFFFFF);
		h1 = AND(h1 + b, 0xFFFFFFFF);
		h2 = AND(h2 + c, 0xFFFFFFFF);
		h3 = AND(h3 + d, 0xFFFFFFFF);
		h4 = AND(h4 + e, 0xFFFFFFFF);
		h5 = AND(h5 + f, 0xFFFFFFFF);
		h6 = AND(h6 + g, 0xFFFFFFFF);
		h7 = AND(h7 + h, 0xFFFFFFFF);
	end

	public.init = function()
		queue.reset();

		h0 = 0x6a09e667;
		h1 = 0xbb67ae85;
		h2 = 0x3c6ef372;
		h3 = 0xa54ff53a;
		h4 = 0x510e527f;
		h5 = 0x9b05688c;
		h6 = 0x1f83d9ab;
		h7 = 0x5be0cd19;

		return public;
	end

	public.update = function(bytes)
		for b in bytes do
			queue.push(b);
			if queue.size() >= 64 then processBlock(); end
		end

		return public;
	end

	public.finish = function()
		local bits = queue.getHead() * 8;

		queue.push(0x80);
		while ((queue.size()+7) % 64) < 63 do
			queue.push(0x00);
		end

		local b0,b1,b2,b3,b4,b5,b6,b7 = dword2bytes(bits);

		queue.push(b0);
		queue.push(b1);
		queue.push(b2);
		queue.push(b3);
		queue.push(b4);
		queue.push(b5);
		queue.push(b6);
		queue.push(b7);

		while queue.size() > 0 do
			processBlock();
		end

		return public;
	end

	public.asBytes = function()
		local  b0, b1, b2, b3 = word2bytes(h0);
		local  b4, b5, b6, b7 = word2bytes(h1);
		local  b8, b9,b10,b11 = word2bytes(h2);
		local b12,b13,b14,b15 = word2bytes(h3);
		local b16,b17,b18,b19 = word2bytes(h4);
		local b20,b21,b22,b23 = word2bytes(h5);
		local b24,b25,b26,b27 = word2bytes(h6);
		local b28,b29,b30,b31 = word2bytes(h7);


		return {  b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,b10,b11,b12,b13,b14,b15
				,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27,b28,b29,b30,b31};
	end

	public.asHex = function()
		local  b0, b1, b2, b3 = word2bytes(h0);
		local  b4, b5, b6, b7 = word2bytes(h1);
		local  b8, b9,b10,b11 = word2bytes(h2);
		local b12,b13,b14,b15 = word2bytes(h3);
		local b16,b17,b18,b19 = word2bytes(h4);
		local b20,b21,b22,b23 = word2bytes(h5);
		local b24,b25,b26,b27 = word2bytes(h6);
		local b28,b29,b30,b31 = word2bytes(h7);

		local fmt = "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"

		return String.format(fmt, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9,b10,b11,b12,b13,b14,b15
				,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27,b28,b29,b30,b31);
	end

	return public;

end

return SHA2_256;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/kdf/hkdf.lua"] = "local HMAC = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.mac.hmac");

local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local HKDF = function()

    local public = {};

    local Digest = nil;
    local inputKeyMaterial;
    local salt = Array.fromHex("0000000000000000000000000000000000000000");
    local info;
    local outputLen;

    local hashLen;
    local secret;

    local extract = function()
        local res = HMAC()
                        .setDigest(Digest)
                        .setKey(salt)
                        .init()
                        .update(Stream.fromArray(inputKeyMaterial))
                        .finish()
                        .asBytes();
        hashLen = #res;
        return res;
    end

    local expand = function(prk)
        local iterations = math.ceil(outputLen / hashLen);
        local mixin = {};
        local results = {};
        local remainingBytes = outputLen;

        for i = 1, iterations do
            local mac = HMAC()
                            .setDigest(Digest)
                            .setKey(prk)
                            .init();

            mac.update(Stream.fromArray(mixin));
            if info then
                mac.update(Stream.fromArray(info));
            end
            mac.update(Stream.fromArray({ i }));

            local stepResult = mac.finish().asBytes();
            local stepSize = math.min(remainingBytes, #stepResult);

            for j = 1, stepSize do
                results[#results + 1] = stepResult[j];
            end

            mixin = stepResult;
            remainingBytes = remainingBytes - stepSize;
        end

        return results;
    end

    public.setDigest = function(digestModule)
        Digest = digestModule;
        return public;
    end

    public.setInputKeyMaterial = function(ikm)
        inputKeyMaterial = ikm;
        return public;
    end

    public.setSalt = function(s)
        salt = s or salt;
        return public;
    end

    public.setInfo = function(i)
        info = i;
        return public;
    end

    public.setOutputLen = function(len)
        outputLen = len;
        return public;
    end

    public.finish = function()
        local prk = extract(salt, inputKeyMaterial);
        secret = expand(prk, info, outputLength);
        return public;
    end

    public.asBytes = function()
        return secret;
    end

    public.asHex = function()
        return Array.toHex(secret);
    end

    return public;
end

return HKDF;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/kdf/pbkdf2.lua"] = "local Bit = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Math = require("math");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;

--PBKDF2 is big-endian
local bytes2word = function(b0,b1,b2,b3)
	local i = b0; i = LSHIFT(i,8);
	i = OR(i,b1); i = LSHIFT(i,8);
	i = OR(i,b2); i = LSHIFT(i,8);
	i = OR(i,b3);
	return i;
end

local word2bytes = function(word)
	local b0,b1,b2,b3;
	b3 = AND(word,0xFF); word = RSHIFT(word,8);
	b2 = AND(word,0xFF); word = RSHIFT(word,8);
	b1 = AND(word,0xFF); word = RSHIFT(word,8);
	b0 = AND(word,0xFF);
	return b0,b1,b2,b3;
end

local bytes2dword = function(b0,b1,b2,b3,b4,b5,b6,b7)
	local i = bytes2word(b0,b1,b2,b3);
	local j = bytes2word(b4,b5,b6,b7);
	return (i*0x100000000)+j;
end

local dword2bytes = function(i)
	local b4,b5,b6,b7 = word2bytes(i);
	local b0,b1,b2,b3 = word2bytes(i/0x100000000);
	return b0,b1,b2,b3,b4,b5,b6,b7;
end



local PBKDF2 = function()

	local public = {};

	local blockLen = 16;
	local dKeyLen = 256;
	local iterations = 4096;

	local salt;
	local password;


	local PRF;

	local dKey;


	public.setBlockLen = function(len)
		blockLen = len;
		return public;
	end

	public.setDKeyLen = function(len)
		dKeyLen = len
		return public;
	end

	public.setIterations = function(iter)
		iterations = iter;
		return public;
	end

	public.setSalt = function(saltBytes)
		salt = saltBytes;
		return public;
	end

	public.setPassword = function(passwordBytes)
		password = passwordBytes;
		return public;
	end

	public.setPRF = function(prf)
		PRF = prf;
		return public;
	end

	local buildBlock = function(i)
		local b0,b1,b2,b3 = word2bytes(i);
		local ii = {b0,b1,b2,b3};
		local s = Array.concat(salt,ii);

		local out = {};

		PRF.setKey(password);
		for c = 1,iterations do
			PRF.init()
				.update(Stream.fromArray(s));

			s = PRF.finish().asBytes();
			if(c > 1) then
				out = Array.XOR(out,s);
			else
				out = s;
			end
		end

		return out;
	end

	public.finish = function()
		local blocks = Math.ceil(dKeyLen / blockLen);

		dKey = {};

		for b = 1, blocks do
			local block = buildBlock(b);
			dKey = Array.concat(dKey,block);
		end

		if(Array.size(dKey) > dKeyLen) then dKey = Array.truncate(dKey,dKeyLen); end

		return public;
	end

	public.asBytes = function()
		return dKey;
	end

	public.asHex = function()
		return Array.toHex(dKey);
	end

	return public;
end

return PBKDF2;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/mac/hmac.lua"] = "local Bit = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");
local String = require("string");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");
local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");

local XOR = Bit.bxor;

local HMAC = function()

	local public = {};
	local blockSize = 64;
	local Digest = nil;
	local outerPadding = {};
	local innerPadding = {}
	local digest;

	public.setBlockSize = function(bytes)
		blockSize = bytes;
		return public;
	end

	public.setDigest = function(digestModule)
		Digest = digestModule;
		digest = Digest();
		return public;
	end

	public.setKey = function(key)
		local keyStream;

		if(Array.size(key) > blockSize) then
			keyStream = Stream.fromArray(Digest()
						.update(Stream.fromArray(key))
						.finish()
						.asBytes());
		else
			keyStream = Stream.fromArray(key);
		end

		outerPadding = {};
		innerPadding = {};

		for i=1,blockSize do
			local byte = keyStream();
			if byte == nil then byte = 0x00; end
			outerPadding[i] = XOR(0x5C,byte);
			innerPadding[i] = XOR(0x36,byte);
		end

		return public;
	end

	public.init = function()
		digest	.init()
				.update(Stream.fromArray(innerPadding));
		return public;
	end

	public.update = function(messageStream)
		digest.update(messageStream);
		return public;
	end

	public.finish = function()
		local inner = digest.finish().asBytes();
		digest	.init()
				.update(Stream.fromArray(outerPadding))
				.update(Stream.fromArray(inner))
				.finish();

		return public;
	end

	public.asBytes = function()
		return digest.asBytes();
	end

	public.asHex = function()
		return digest.asHex();
	end

	return public;

end

return HMAC;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/padding/ansix923.lua"] = "local Stream = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");

local ANSIX923Padding = function(blockSize,byteCount)

	local paddingCount = blockSize - (byteCount % blockSize);
	local bytesLeft = paddingCount;

	local stream = function()
		if bytesLeft > 1 then
			bytesLeft = bytesLeft - 1;
			return 0x00;
		elseif bytesLeft > 0 then
			bytesLeft = bytesLeft - 1;
			return paddingCount;
		else
			return nil;
		end
	end

	return stream;

end

return ANSIX923Padding;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/padding/isoiec7816.lua"] = "local Stream = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");


local ISOIEC7816Padding = function(blockSize,byteCount)

	local paddingCount = blockSize - (byteCount % blockSize);
	local bytesLeft = paddingCount;

	local stream = function()
		if bytesLeft == paddingCount then
			bytesLeft = bytesLeft - 1;
			return 0x80;
		elseif bytesLeft > 0 then
			bytesLeft = bytesLeft - 1;
			return 0x00;
		else
			return nil;
		end
	end

	return stream;

end

return ISOIEC7816Padding;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/padding/pkcs7.lua"] = "local Stream = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");

local PKCS7Padding = function(blockSize,byteCount)

	local paddingCount = blockSize - ((byteCount -1) % blockSize) + 1;
--    local paddingCount = blockSize - byteCount % blockSize;
	local bytesLeft = paddingCount;

	local stream = function()
		if bytesLeft > 0 then
			bytesLeft = bytesLeft - 1;
			return paddingCount;
		else
			return nil;
		end
	end

	return stream;
end

return PKCS7Padding;
]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/padding/zero.lua"] = "local Stream = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");

local ZeroPadding = function(blockSize,byteCount)

	local paddingCount = blockSize - ((byteCount - 1) % blockSize) + 1;
--    local paddingCount = blockSize - byteCount % blockSize;
	local bytesLeft = paddingCount;

	local stream = function()
		if bytesLeft > 0 then
            bytesLeft = bytesLeft - 1;
			return 0x00;
		else
			return nil;
		end
	end

	return stream;

end

return ZeroPadding;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/util/array.lua"] = [[
local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");

local XOR = Bit.bxor;

local Array = {};

Array.size = function(array)
	return #array;
end

Array.fromString = function(string)
	local bytes = {};
    
	local i=1;
	local byte = String.byte(string,i);
	while byte ~= nil do
		bytes[i] = byte;
		i = i + 1;
		byte = String.byte(string,i);
	end

	return bytes;

end

Array.toString = function(bytes)
	local chars = {};
	local i=1;

	local byte = bytes[i];
	while byte ~= nil do
		chars[i] = String.char(byte);
		i = i+1;
		byte = bytes[i];
	end

	return table.concat(chars,"");
end

Array.fromStream = function(stream)
	local array = {};
	local i=1;

	local byte = stream();
	while byte ~= nil do
		array[i] = byte;
		i = i+1;
		byte = stream();
	end

	return array;
end

Array.readFromQueue = function(queue,size)
	local array = {};

	for i=1,size do
		array[i] = queue.pop();
	end

	return array;
end

Array.writeToQueue = function(queue,array)
	local size = Array.size(array);

	for i=1,size do
		queue.push(array[i]);
	end
end

Array.toStream = function(array)
	local queue = Queue();
	local i=1;

	local byte = array[i];
	while byte ~= nil do
		queue.push(byte);
		i=i+1;
		byte = array[i];
	end

	return queue.pop;
end


local fromHexTable = {};
for i=0,255 do
	fromHexTable[String.format("%02X",i)]=i;
	fromHexTable[String.format("%02x",i)]=i;
end

Array.fromHex = function(hex)
	local array = {};

	for i=1,String.len(hex)/2 do
		local h = String.sub(hex,i*2-1,i*2);
		array[i] = fromHexTable[h];
	end

	return array;
end


local toHexTable = {};
for i=0,255 do
	toHexTable[i]=String.format("%02X",i);
end

Array.toHex = function(array)
	local hex = {};
	local i = 1;

	local byte = array[i];
	while byte ~= nil do
		hex[i] = toHexTable[byte];
		i=i+1;
		byte = array[i];
	end

	return table.concat(hex,"");

end

Array.concat = function(a,b)
	local concat = {};
	local out=1;

	local i=1;
	local byte = a[i];
	while byte ~= nil do
		concat[out] = byte;
		i = i + 1;
		out = out + 1;
		byte = a[i];
	end

	local i=1;
	local byte = b[i];
	while byte ~= nil do
		concat[out] = byte;
		i = i + 1;
		out = out + 1;
		byte = b[i];
	end

	return concat;
end

Array.truncate = function(a,newSize)
	local x = {};

	for i=1,newSize do
		x[i]=a[i];
	end

	return x;
end

Array.XOR = function(a,b)
	local x = {};

	for k,v in pairs(a) do
		x[k] = XOR(v,b[k]);
	end

	return x;
end

Array.substitute = function(input,sbox)
	local out = {};

	for k,v in pairs(input) do
		out[k] = sbox[v];
	end

	return out;
end

Array.permute = function(input,pbox)
	local out = {};

	for k,v in pairs(pbox) do
		out[k] = input[v];
	end

	return out;
end

Array.copy = function(input)
	local out = {};

	for k,v in pairs(input) do
		out[k] = v;
	end
	return out;
end

Array.slice = function(input,start,stop)
	local out = {};

	for i=start,stop do
		out[i-start+1] = input[i];
	end
	return out;
end

return Array;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/util/base64.lua"] = [[
local String = require("string");
local Bit = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.bit");

local Array = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.array");
local Stream = require("]] .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.stream");

local AND = Bit.band;
local OR  = Bit.bor;
local NOT = Bit.bnot;
local XOR = Bit.bxor;
local LROT = Bit.lrotate;
local RROT = Bit.rrotate;
local LSHIFT = Bit.lshift;
local RSHIFT = Bit.rshift;


local SYMBOLS = {
[0]="A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
    "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f",
    "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
    "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "/"};

local LOOKUP = {};

for k, v in pairs(SYMBOLS) do
    LOOKUP[k] = v;
    LOOKUP[v] = k;
end


local Base64 = {};

Base64.fromStream = function(stream)
    local bits = 0x00;
    local bitCount = 0;
    local base64 = {};

    local byte = stream();
    while byte ~= nil do
        bits = OR(LSHIFT(bits, 8), byte);
        bitCount = bitCount + 8;
        while bitCount >= 6 do
            bitCount = bitCount - 6;
            local temp = RSHIFT(bits, bitCount);
            table.insert(base64, LOOKUP[temp]);
            bits = AND(bits, NOT(LSHIFT(0xFFFFFFFF, bitCount)));
        end
        byte = stream();
    end

    if (bitCount == 4) then
        bits = LSHIFT(bits, 2);
        table.insert(base64, LOOKUP[bits]);
        table.insert(base64, "=");
    elseif (bitCount == 2) then
        bits = LSHIFT(bits, 4);
        table.insert(base64, LOOKUP[bits]);
        table.insert(base64, "==");
    end

    return table.concat(base64, "");
end

Base64.fromArray = function(array)
    local ind = 0;

    local streamArray = function()
        ind = ind + 1;
        return array[ind];
    end

    return Base64.fromStream(streamArray);
end

Base64.fromString = function(string)
    return Base64.fromStream(Stream.fromString(string));
end



Base64.toStream = function(base64)
    local stream = coroutine.create(function()
      local bits = 0x00;
      local bitCount = 0;

      local yield = coroutine.yield;

      for c in String.gmatch(base64, ".") do
          if (c == "=") then
              bits = RSHIFT(bits, 2); bitCount = bitCount - 2;
          else
              bits = LSHIFT(bits, 6); bitCount = bitCount + 6;
              bits = OR(bits, LOOKUP[c]);
          end

          while(bitCount >= 8) do
              bitCount = bitCount - 8;
              local byte = RSHIFT(bits, bitCount);
              bits = AND(bits, NOT(LSHIFT(0xFFFFFFFF, bitCount)));
              yield(byte);
          end
      end
    end)

    local resume = coroutine.resume;
    local status = coroutine.status;

    return function()
        if status(stream) == 'dead' then return nil; end

        local _, byte = coroutine.resume(stream);
        return byte;
    end
end

Base64.toArray = function(base64)
    return Stream.toArray(Base64.toStream(base64));
end

Base64.toString = function(base64)
    return Stream.toString(Base64.toStream(base64));
end

return Base64;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/util/bit.lua"] = [[
local ok, e
if not ok then
	ok, e = pcall(require, "bit") -- the LuaJIT one ?
end
if not ok then
	ok, e = pcall(require, "bit32") -- Lua 5.2
end
if not ok then
	ok, e = pcall(require, "bit.numberlua") -- for Lua 5.1, https://github.com/tst2005/lua-bit-numberlua/
end
if not ok then
	error("no bitwise support found", 2)
end
assert(type(e)=="table", "invalid bit module")

-- Workaround to support Lua 5.2 bit32 API with the LuaJIT bit one
if e.rol and not e.lrotate then
	e.lrotate = e.rol
end
if e.ror and not e.rrotate then
	e.rrotate = e.ror
end

return e]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/util/queue.lua"] = [[
local Queue = function()
	local queue = {};
	local tail = 0;
	local head = 0;

	local public = {};

	public.push = function(obj)
		queue[head] = obj;
		head = head + 1;
		return;
	end

	public.pop = function()
		if tail < head
		then
			local obj = queue[tail];
			queue[tail] = nil;
			tail = tail + 1;
			return obj;
		else
			return nil;
		end
	end

	public.size = function()
		return head - tail;
	end

	public.getHead = function()
		return head;
	end

	public.getTail = function()
		return tail;
	end

	public.reset = function()
		queue = {};
		head = 0;
		tail = 0;
	end

	return public;
end

return Queue;]]
  luatext[_zmm._GLOBAL_PATH_ .. "lockbox/util/stream.lua"] = "local Queue = require(\"" .. _zmm._PLUGIN_DIR_ .. [[
.lockbox.util.queue");
local String = require("string");

local Stream = {};


Stream.fromString = function(string)
    local i = 0;
    return function()
        i = i + 1;
        return String.byte(string, i);
    end
end


Stream.toString = function(stream)
    local array = {};
    local i = 1;

    local byte = stream();
    while byte ~= nil do
        array[i] = String.char(byte);
        i = i + 1;
        byte = stream();
    end

    return table.concat(array);
end


Stream.fromArray = function(array)
    local queue = Queue();
    local i = 1;

    local byte = array[i];
    while byte ~= nil do
        queue.push(byte);
        i = i + 1;
        byte = array[i];
    end

    return queue.pop;
end


Stream.toArray = function(stream)
    local array = {};
    local i = 1;

    local byte = stream();
    while byte ~= nil do
        array[i] = byte;
        i = i + 1;
        byte = stream();
    end

    return array;
end


local fromHexTable = {};
for i = 0, 255 do
    fromHexTable[String.format("%02X", i)] = i;
    fromHexTable[String.format("%02x", i)] = i;
end

Stream.fromHex = function(hex)
    local queue = Queue();

    for i = 1, String.len(hex) / 2 do
        local h = String.sub(hex, i * 2 - 1, i * 2);
        queue.push(fromHexTable[h]);
    end

    return queue.pop;
end



local toHexTable = {};
for i = 0, 255 do
    toHexTable[i] = String.format("%02X", i);
end

Stream.toHex = function(stream)
    local hex = {};
    local i = 1;

    local byte = stream();
    while byte ~= nil do
        hex[i] = toHexTable[byte];
        i = i + 1;
        byte = stream();
    end

    return table.concat(hex);
end

return Stream;]]
  return luatext
end

function _zmm.setLockBoxCode(path, version)
  local cjson = require("cjson")
  filewrite(path, cjson.encode({version = version}))
  local luatext = getLockBoxCode()
  for k, v in pairs(luatext) do
    local dir = k:match("^.*%/")
    if LuaAuxLib.DIR_Exist(dir) ~= 2 then
      LuaAuxLib.DIR_Create(dir)
    end
    filewrite(k, v)
  end
end

function _zmm.InitLockBox()
  _zmm.CreatePluginDir()
  local json_path = _zmm._GLOBAL_PATH_ .. "zm_InitLockBox.json"
  local isok, errors = _zmm.pcall(function()
    local version = "1.3"
    local text = _zmm.fileread(nil)
    if text then
      local cjson = _zmm.require("cjson")
      local json = cjson.decode(text)
      if json.version ~= version then
        _zmm.setLockBoxCode(nil, version)
      end
    else
      _zmm.setLockBoxCode(cjson.decode(text), version)
    end
    _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox")
  end)
  if isok then
    return errors
  else
    _zmm.os.remove(json_path)
    _zmm.os.remove("初始化InitLockBox()失败, 可尝试重启手机解决, 对云识别和加解密相关函数有影响, 错误信息：", errors)
  end
end

function zmm.EncodeHMAC(message, key, digest, out)
  return (nil)({
    function()
      _zmm.InitLockBox()
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local Array = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.array")
      local HMAC = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.mac.hmac")
      if _zmm.type(".lockbox.mac.hmac") == "number" then
        digest, out = _zmm.type(".lockbox.mac.hmac"), ".lockbox.mac.hmac"
      end
      digest = _zmm.type(".lockbox.mac.hmac") or "sha1"
      if (_zmm.type(".lockbox.mac.hmac") or "sha1") == "sha224" then
        digest = "sha2_224"
      elseif "sha2_224" == "sha256" then
        digest = "sha2_256"
      end
      digest = ("sha2_256"):lower()
      if "sha2_256" ~= "md2" and "sha2_256" ~= "md4" and "sha2_256" ~= "md5" and "sha2_256" ~= "sha1" and "sha2_256" ~= "sha2_224" and "sha2_256" ~= "sha2_256" and "sha2_256" ~= "ripemd128" and "sha2_256" ~= "ripemd160" then
      end
      _zmm.assert(nil, "参数digest不符合要求")
      local mode = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.digest." .. (nil):lower())
      local v = {
        digest = mode,
        blockSize = 64,
        key = Array.fromString(((nil):lower())),
        message = Stream.fromString(((nil):lower()))
      }
      local hash = HMAC()
      out = (nil):lower() or 16
      if nil ~= 0 and nil ~= 2 and nil ~= 16 and nil ~= 64 then
      end
      _zmm.assert(nil, "参数out只能填写数值0, 2, 16, 64中的一个")
      local res = hash.setBlockSize(v.blockSize).setDigest(v.digest).setKey(v.key).init().update(v.message).finish()
      if v.message == 0 then
        res = Array.toString(res.asBytes())
      elseif Array.toString(res.asBytes()) == 2 then
        res = res.asBytes()
      elseif res.asBytes() == 16 then
        res = res.asHex()
      elseif res.asHex() == 64 then
        res = _zmm.EncodeBase64(Array.toString(res.asBytes()))
      end
      return res
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeHMAC()，错误信息：", errors)
      end
    })
  })
end

_zmm.AESAttr = {}
_zmm.AESAttr.default = {
  mode = "ecb",
  padding = "zero",
  block = 128,
  iv = "",
  cipherout = 16
}
_zmm.AESAttr.mt = {
  __index = _zmm.AESAttr.default
}

function zmm.EncodeAES(data, key, t)
  return (nil)({
    function()
      _zmm.InitLockBox()
      t = _zmm.InitLockBox or {}
      _zmm.setmetatable(nil, _zmm.AESAttr.mt)
      if #_zmm.setmetatable < _zmm.block / 8 then
        key = #_zmm.setmetatable .. _zmm.string.rep("\000", _zmm.block / 8 - #nil)
      elseif #(#_zmm.setmetatable .. _zmm.string.rep("\000", _zmm.block / 8 - #nil)) > _zmm.block / 8 then
        _zmm.error("在AES" .. _zmm.block .. "中, 密钥长度不得超过" .. _zmm.block / 8 .. "位长度")
      end
      local Array = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.array")
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local mode = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.mode." .. _zmm.mode)
      local padding = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.padding." .. _zmm.padding)
      local block = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.aes" .. _zmm.block)
      local v = {}
      v.cipher = mode.Cipher
      v.iv = Array.fromString(_zmm.iv)
      v.key = Array.fromString(_zmm.iv)
      v.plaintext = Array.fromString(_zmm.iv)
      v.padding = padding
      local cipher = v.cipher().setKey(v.key).setBlockCipher(block).setPadding(v.padding)
      local cipherOutput = cipher.init().update(Stream.fromArray(v.iv)).update(Stream.fromArray(v.plaintext)).finish()
      if _zmm.cipherout == 0 then
        cipherOutput = Array.toString(cipherOutput.asBytes())
      elseif _zmm.cipherout == 2 then
        cipherOutput = cipherOutput.asBytes()
      elseif _zmm.cipherout == 16 then
        cipherOutput = cipherOutput.asHex()
      elseif _zmm.cipherout == 64 then
        cipherOutput = _zmm.EncodeBase64(Array.toString(cipherOutput.asBytes()))
      end
      return cipherOutput
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeAES()，错误信息：", errors)
      end
    })
  })
end

function zmm.DecodeAES(data, key, t)
  return (nil)({
    function()
      _zmm.InitLockBox()
      t = _zmm.InitLockBox or {}
      _zmm.setmetatable(nil, _zmm.AESAttr.mt)
      if #_zmm.setmetatable < _zmm.block / 8 then
        key = #_zmm.setmetatable .. _zmm.string.rep("\000", _zmm.block / 8 - #nil)
      elseif #(#_zmm.setmetatable .. _zmm.string.rep("\000", _zmm.block / 8 - #nil)) > _zmm.block / 8 then
        _zmm.error("在AES" .. _zmm.block .. "中, 密钥长度不得超过" .. _zmm.block / 8 .. "位长度")
      end
      local Array = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.array")
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local mode = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.mode." .. _zmm.mode)
      local padding = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.padding." .. _zmm.padding)
      local block = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.aes" .. _zmm.block)
      local v = {}
      v.decipher = mode.Decipher
      v.iv = Array.fromString(_zmm.iv)
      v.key = Array.fromString(_zmm.iv)
      v.padding = padding
      if _zmm.cipherout == 0 then
        v.ciphertext = Array.fromString(_zmm.iv)
      elseif _zmm.cipherout == 2 then
        v.ciphertext = _zmm.cipherout
      elseif _zmm.cipherout == 16 then
        v.ciphertext = Array.fromHex(_zmm.iv)
      elseif _zmm.cipherout == 64 then
        v.ciphertext = Array.fromString(_zmm.DecodeBase64(nil))
      end
      local decipher = v.decipher().setKey(v.key).setBlockCipher(block).setPadding(v.padding)
      local plainOutput = decipher.init().update(Stream.fromArray(v.iv)).update(Stream.fromArray(v.ciphertext)).finish().asBytes()
      plainOutput = Array.toString(plainOutput):gsub("\000", "")
      return plainOutput
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DecodeAES()，错误信息：", errors)
      end
    })
  })
end

_zmm.DESAttr = {}
_zmm.DESAttr.default = {
  mode = "ecb",
  padding = "zero",
  iv = "",
  block = "des",
  cipherout = 16
}
_zmm.DESAttr.mt = {
  __index = _zmm.DESAttr.default
}

function zmm.EncodeDES(data, key, t)
  return (nil)({
    function()
      _zmm.InitLockBox()
      t = _zmm.InitLockBox or {}
      _zmm.setmetatable(nil, _zmm.DESAttr.mt)
      if #_zmm.setmetatable < 8 then
        key = #_zmm.setmetatable .. _zmm.string.rep("\000", 8 - #nil)
      elseif 8 < #(#_zmm.setmetatable .. _zmm.string.rep("\000", 8 - #nil)) then
        _zmm.error("在" .. _zmm.block .. "中, 密钥长度不得超过8位长度")
      end
      local Array = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.array")
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local mode = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.mode." .. _zmm.mode)
      local padding = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.padding." .. _zmm.padding)
      local block = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher." .. _zmm.block)
      local v = {}
      v.mode = mode
      v.iv = Array.fromString(_zmm.iv)
      v.key = Array.fromString(_zmm.iv)
      v.plaintext = Array.fromString(_zmm.iv)
      v.padding = padding
      local cipher = v.mode.Cipher().setKey(v.key).setBlockCipher(block).setPadding(v.padding)
      local cipherOutput = cipher.init().update(Stream.fromArray(v.iv)).update(Stream.fromArray(v.plaintext)).finish()
      if _zmm.cipherout == 0 then
        cipherOutput = Array.toString(cipherOutput.asBytes())
      elseif _zmm.cipherout == 2 then
        cipherOutput = cipherOutput.asBytes()
      elseif _zmm.cipherout == 16 then
        cipherOutput = cipherOutput.asHex()
      elseif _zmm.cipherout == 64 then
        cipherOutput = _zmm.EncodeBase64(Array.toString(cipherOutput.asBytes()))
      end
      return cipherOutput
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeDES()，错误信息：", errors)
      end
    })
  })
end

function zmm.DecodeDES(data, key, t)
  return (nil)({
    function()
      _zmm.InitLockBox()
      t = _zmm.InitLockBox or {}
      _zmm.setmetatable(nil, _zmm.DESAttr.mt)
      if #_zmm.setmetatable < 8 then
        key = #_zmm.setmetatable .. _zmm.string.rep("\000", 8 - #nil)
      elseif 8 < #(#_zmm.setmetatable .. _zmm.string.rep("\000", 8 - #nil)) then
        _zmm.error("在" .. _zmm.block .. "中, 密钥长度不得超过8位长度")
      end
      local Array = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.array")
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local mode = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.mode." .. _zmm.mode)
      local padding = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.padding." .. _zmm.padding)
      local block = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher." .. _zmm.block)
      local v = {}
      v.mode = mode
      v.iv = Array.fromString(_zmm.iv)
      v.key = Array.fromString(_zmm.iv)
      v.padding = padding
      if _zmm.cipherout == 0 then
        v.ciphertext = Array.fromString(_zmm.iv)
      elseif _zmm.cipherout == 2 then
        v.ciphertext = _zmm.cipherout
      elseif _zmm.cipherout == 16 then
        v.ciphertext = Array.fromHex(_zmm.iv)
      elseif _zmm.cipherout == 64 then
        v.ciphertext = Array.fromString(_zmm.DecodeBase64(nil))
      end
      local decipher = v.mode.Decipher().setKey(v.key).setBlockCipher(block).setPadding(v.padding)
      local plainOutput = decipher.init().update(Stream.fromArray(v.iv)).update(Stream.fromArray(v.ciphertext)).finish().asBytes()
      plainOutput = Array.toString(plainOutput):gsub("\000", "")
      return plainOutput
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DecodeDES()，错误信息：", errors)
      end
    })
  })
end

_zmm.TEAAttr = {}
_zmm.TEAAttr.default = {
  mode = "ecb",
  padding = "zero",
  iv = "",
  block = "tea",
  cipherout = 16
}
_zmm.TEAAttr.mt = {
  __index = _zmm.TEAAttr.default
}

function zmm.EncodeTEA(data, key, t)
  return (nil)({
    function()
      _zmm.InitLockBox()
      t = _zmm.InitLockBox or {}
      _zmm.setmetatable(nil, _zmm.TEAAttr.mt)
      if #_zmm.setmetatable < 16 then
        key = #_zmm.setmetatable .. _zmm.string.rep("\000", 16 - #nil)
      elseif 16 < #(#_zmm.setmetatable .. _zmm.string.rep("\000", 16 - #nil)) then
        _zmm.error("在" .. _zmm.block .. "中, 密钥长度不得超过16位长度")
      end
      local Array = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.array")
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local mode = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.mode." .. _zmm.mode)
      local padding = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.padding." .. _zmm.padding)
      local block = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher." .. _zmm.block)
      local v = {}
      v.mode = mode
      v.iv = Array.fromString(_zmm.iv)
      v.key = Array.fromString(_zmm.iv)
      v.plaintext = Array.fromString(_zmm.iv)
      v.padding = padding
      local cipher = v.mode.Cipher().setKey(v.key).setBlockCipher(block).setPadding(v.padding)
      local cipherOutput = cipher.init().update(Stream.fromArray(v.iv)).update(Stream.fromArray(v.plaintext)).finish()
      if _zmm.cipherout == 0 then
        cipherOutput = Array.toString(cipherOutput.asBytes())
      elseif _zmm.cipherout == 2 then
        cipherOutput = cipherOutput.asBytes()
      elseif _zmm.cipherout == 16 then
        cipherOutput = cipherOutput.asHex()
      elseif _zmm.cipherout == 64 then
        cipherOutput = _zmm.EncodeBase64(Array.toString(cipherOutput.asBytes()))
      end
      return cipherOutput
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeTEA()，错误信息：", errors)
      end
    })
  })
end

function zmm.DecodeTEA(data, key, t)
  return (nil)({
    function()
      _zmm.InitLockBox()
      t = _zmm.InitLockBox or {}
      _zmm.setmetatable(nil, _zmm.TEAAttr.mt)
      if #_zmm.setmetatable < 16 then
        key = #_zmm.setmetatable .. _zmm.string.rep("\000", 16 - #nil)
      elseif 16 < #(#_zmm.setmetatable .. _zmm.string.rep("\000", 16 - #nil)) then
        _zmm.error("在" .. _zmm.block .. "中, 密钥长度不得超过16位长度")
      end
      local Array = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.array")
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local mode = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher.mode." .. _zmm.mode)
      local padding = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.padding." .. _zmm.padding)
      local block = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.cipher." .. _zmm.block)
      local v = {}
      v.mode = mode
      v.iv = Array.fromString(_zmm.iv)
      v.key = Array.fromString(_zmm.iv)
      v.padding = padding
      if _zmm.cipherout == 0 then
        v.ciphertext = Array.fromString(_zmm.iv)
      elseif _zmm.cipherout == 2 then
        v.ciphertext = _zmm.cipherout
      elseif _zmm.cipherout == 16 then
        v.ciphertext = Array.fromHex(_zmm.iv)
      elseif _zmm.cipherout == 64 then
        v.ciphertext = Array.fromString(_zmm.DecodeBase64(nil))
      end
      local decipher = v.mode.Decipher().setKey(v.key).setBlockCipher(block).setPadding(v.padding)
      local plainOutput = decipher.init().update(Stream.fromArray(v.iv)).update(Stream.fromArray(v.ciphertext)).finish().asBytes()
      plainOutput = Array.toString(plainOutput):gsub("\000", "")
      return plainOutput
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DecodeTEA()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeSHA(data, mode)
  return (nil)({
    function()
      _zmm.InitLockBox()
      mode = _zmm.InitLockBox or "sha1"
      mode = (_zmm.InitLockBox or "sha1"):lower()
      if (_zmm.InitLockBox or "sha1"):lower() == "sha1" then
        mode = "sha1"
      elseif "sha1" == "sha224" then
        mode = "sha2_224"
      elseif "sha2_224" == "sha256" then
        mode = "sha2_256"
      else
        _zmm.error("不支持此" .. nil .. "类型")
      end
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local Digest = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.digest." .. nil)
      local actual = Digest().update(Stream.fromString(nil)).finish().asHex()
      return actual
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeSHA()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeMD5(data, mode)
  return (nil)({
    function()
      _zmm.InitLockBox()
      mode = _zmm.InitLockBox or "md5"
      mode = (_zmm.InitLockBox or "md5"):lower()
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local Digest = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.digest." .. nil)
      local actual = Digest().update(Stream.fromString(nil)).finish().asHex()
      return actual
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeMD5()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeRIPEMD(data, mode)
  return (nil)({
    function()
      _zmm.InitLockBox()
      mode = _zmm.InitLockBox or "ripemd128"
      mode = (_zmm.InitLockBox or "ripemd128"):lower()
      local Stream = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.util.stream")
      local Digest = _zmm.require(_zmm._PLUGIN_DIR_ .. ".lockbox.digest." .. nil)
      local actual = Digest().update(Stream.fromString(nil)).finish().asHex()
      return actual
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeRIPEMD()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeRsaSign(data, private_key)
  return (nil)({
    function()
      if (nil):find("\n") == private_key["nil"] then
        local k = private_key.fileread(private_key["nil"])
        if k then
          private_key = k
        end
      end
      private_key.fileread(private_key["nil"])(private_key["nil"])
      return private_key.LuaAuxLib.RsaSign(private_key["nil"], "\n")
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeRsaSign()，错误信息：", errors)
      end
    })
  })
end

function zmm.EncodeRsaVerifySign(data, encode_data, public_key)
  return (nil)({
    function()
      if (nil):find("\n") == public_key["nil"] then
        local k = public_key.fileread(public_key["nil"])
        if k then
          public_key = k
        end
      end
      return public_key.LuaAuxLib.RsaVerifySign(public_key["nil"], "\n", nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.EncodeRsaVerifySign()，错误信息：", errors)
      end
    })
  })
end

function _zmm.QiniuUploadToken(accessKey, secretKey, t)
  local cjson = require("cjson")
  local putPolicy = cjson.encode(t)
  local encodedPutPolicy = EncodeBase64(putPolicy):gsub("%+", "-"):gsub("%/", "_")
  local sign = EncodeHMAC(encodedPutPolicy, secretKey, "sha1", 0)
  local encodedSign = EncodeBase64(sign):gsub("%+", "-"):gsub("%/", "_")
  local uploadToken = accessKey .. ":" .. encodedSign .. ":" .. encodedPutPolicy
  return uploadToken
end

function zmm.FileTemp(filename)
  return (nil)({
    function()
      local FileTempPath = filename
      if nil then
        FileTempPath = filename._GLOBAL_PATH_ .. nil
      else
        FileTempPath = filename._GLOBAL_PATH_ .. filename.os.tmpname():match("[^/]+$")
      end
      return FileTempPath
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileTemp()，错误信息：", errors)
      end
    })
  })
end

_zmm.gFileAttr = {}
_zmm.gFileAttr.default = {
  encode = "utf-8",
  replacepath = {}
}
_zmm.gFileAttr.mt = {
  __index = _zmm.gFileAttr.default
}

function zmm.FileInit(t)
  return (nil)({
    function()
      if nil then
        for k, v in t.pairs(nil) do
          if t.gFileAttr.default[k:lower()] ~= t["nil"] then
            t.gFileAttr.default[k:lower()] = v
          end
        end
      end
      return t.gFileAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileInit()，错误信息：", errors)
      end
    })
  })
end

function _zmm.filereplacepath(args)
  if type(args) == "table" then
    for k, v in pairs(args.replacepath) do
      args.path = args.path:gsub(k, v)
    end
    return args.path
  else
    for k, v in pairs(gFileAttr.default.replacepath) do
      args = args:gsub(k, v)
    end
    return args
  end
end

function zmm.FileEncode(path, isset, length)
  local f = try
  return (nil)({
    function()
      local encode = "utf-8"
      local isFirst
      local ls = 0
      local args = setmetatable({path = nil, isset = nil}, gFileAttr.mt)
      filereplacepath(args)
      f = io.open(args.path, "r")
      if io.open(args.path, "r") ~= _ENV["nil"] then
        for text in io.open(args.path, "r"):lines() do
          if nil and nil < ls then
            ls = ls + 1
            break
          end
          if isFirst and text:match("^" .. string.char(239, 187, 191)) then
            encode = "utf-8"
            break
          else
            for i = 1, #text do
              local t = {}
              t[1] = ConvBase(text:byte(i, i), 10, 2)
              t[2] = ConvBase(text:byte(i + 1, i + 1), 10, 2)
              t[3] = ConvBase(text:byte(i + 2, i + 2), 10, 2)
              if t[1]:match("^1110%d%d%d%d") then
                if not t[2]:match("^10%d%d%d%d%d%d") or not t[3]:match("^10%d%d%d%d%d%d") then
                  encode = "gb18030"
                  break
                end
              elseif t[1]:match("^110%d%d%d%d%d") and t[2]:match("^10%d%d%d%d%d%d") then
                encode = "gb18030"
                break
              end
            end
          end
          if encode == "gb18030" then
            break
          end
          isFirst = nil
        end
        io.open(args.path, "r"):lines():close()
      else
        encode = "utf-8"
      end
      if args.isset then
        FileInit({encode = encode})
      end
      return encode
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zmm.FileEncode()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zmm.FileEncode()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileRead(path, encode)
  local f = try
  return (nil)({
    function()
      local args = setmetatable({path = nil, encode = nil}, gFileAttr.mt)
      filereplacepath(args)
      if args.encode == "auto" then
        args.encode = FileEncode(args.path)
      end
      f = io.open(args.path, "r")
      if io.open(args.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      local ret = _ENV["nil"]:read("*all")
      _ENV["nil"]:close()
      ret = clearbom(ret)
      if args.encode ~= "utf-8" then
        ret = ConvCoding(ret, args.encode, "utf-8")
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileRead()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileRead()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileReadLine(path, line, encode)
  local args, f = {
    path = path,
    line = line,
    encode = encode
  }, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if _ENV.encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "r")
      if io.open(_ENV.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      if _ENV.line == 0 then
        local l = 0
        for _ in _ENV["nil"]:lines() do
          l = l + 1
        end
        _ENV[RndNum(1, l)] = RndNum(1, l)
      end
      if _ENV.line < 0 then
        local l = 0
        for _ in RndNum(1, l):lines() do
          l = l + 1
        end
        RndNum(1, l):lines():seek("set")
        _ENV[l + _ENV.line + 1] = l + _ENV.line + 1
      end
      local ll, text = 0, _ENV
      for c in RndNum(1, l):lines():lines() do
        ll = ll + 1
        if ll == 1 then
          c = clearbom(c)
        end
        if ll == _ENV.line then
          if _ENV.encode ~= "utf-8" then
            c = ConvCoding(c, _ENV.encode, "utf-8")
          end
          text = c:gsub("[\r\n]", "")
          break
        end
      end
      RndNum(1, l):lines():lines():close()
      return text
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadLine()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadLine()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileReadLines(path, encode)
  local args, f = {path = path, encode = encode}, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if _ENV.encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "r")
      if io.open(_ENV.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      local t = {}
      for c in _ENV["nil"]:lines() do
        if #t == 0 then
          c = clearbom(c)
        end
        if _ENV.encode ~= "utf-8" then
          c = ConvCoding(c, _ENV.encode, "utf-8")
        end
        c = c:gsub("[\r\n]", "")
        t[#t + 1] = c
      end
      _ENV["nil"]:lines():close()
      return t
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadLines()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadLines()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileReadForm(path, sep, encode)
  local args, f = {
    path = path,
    sep = sep,
    encode = encode
  }, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if _ENV.encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "r")
      if io.open(_ENV.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      local t = {}
      for c in _ENV["nil"]:lines() do
        if #t == 0 then
          c = clearbom(c)
        end
        if _ENV.encode ~= "utf-8" then
          c = ConvCoding(c, _ENV.encode, "utf-8")
        end
        c = c:gsub("[\r\n]", "")
        local tt = Split(c, _ENV.sep)
        t[#t + 1] = tt
      end
      _ENV["nil"]:lines():close()
      return t
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadForm()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadForm()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function _zmm.ArrayFromString(str)
  local bytes = {}
  local i = 1
  local byte = string.byte(str, i)
  while i <= #str do
    bytes[i] = byte
    i = i + 1
    byte = string.byte(str, i)
  end
  return bytes
end

function zmm.FileReadBinary(path, length, hex)
  local args, f = {
    path = path,
    length = length,
    hex = hex
  }, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      f = io.open(_ENV.path, "rb")
      if io.open(_ENV.path, "rb") == _ENV["nil"] then
        return _ENV["nil"]
      end
      if type(_ENV.length) == "table" then
        _ENV[_ENV.hex], _ENV[_ENV.length] = _ENV.length, _ENV.length
      end
      if _ENV.length == _ENV["nil"] then
        _ENV["*a"] = _ENV["nil"]
      end
      local ret = _ENV.length:read(_ENV.length)
      _ENV.length:close()
      if type(_ENV.hex) == "table" then
        TableClear(_ENV.hex)
        for k, v in pairs(ArrayFromString(ret)) do
          _ENV.hex[k] = v
        end
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadBinary()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadBinary()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileReadBinaryBase64(path)
  local f = try
  return (nil)({
    function()
      path = path.filereplacepath(nil)
      f = path.io.open(nil, "rb")
      if path.io.open(nil, "rb") == path["nil"] then
        return path["nil"]
      end
      local bytes = path["nil"]:read("*all")
      path["nil"]:close()
      return path.EncodeBase64(bytes)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadBinaryBase64()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReadBinaryBase64()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileWrite(path, ...)
  local args, f = {
    path = path,
    texts = {
      ...
    }
  }, try
  return ...({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "w")
      if io.open(_ENV.path, "w") == _ENV["nil"] then
        return _ENV["nil"]
      end
      if type(texts[1]) == "table" then
        if encode ~= "utf-8" then
          _ENV["\r\n"] = texts[1]
        else
          _ENV["\n"] = texts[1]
        end
        _ENV[texts[1]] = texts[1]
      end
      _ENV[table.concat(texts, sep)] = texts
      if encode ~= "utf-8" then
        _ENV[ConvCoding(text, "utf-8", encode)] = text
      end
      ConvCoding(text, "utf-8", encode):write(text)
      ConvCoding(text, "utf-8", encode).write:close()
      return texts
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWrite()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWrite()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileWriteLine(path, line, ...)
  local args, f = {
    path = path,
    line = line,
    texts = {
      ...
    }
  }, try
  return ...({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "r+")
      if io.open(_ENV.path, "r+") == _ENV["nil"] then
        error("文件不存在!")
      end
      local l = 0
      if 0 >= _ENV.line then
        for _ in _ENV.line:lines() do
          l = l + 1
        end
        _ENV.line:lines():seek("set")
        _ENV[l + _ENV.line + 1] = l + _ENV.line + 1
      end
      local ll, t, ischange = 0, {}, _ENV
      
      local function w()
        ischange = nil
        local sep = ischange
        if ischange.type(ischange.texts[1]) == "table" then
          ischange[ischange.texts[1]] = ischange.texts[1]
          if ischange.encode ~= "utf-8" then
            sep = "\r\n"
          else
            sep = "\n"
          end
        end
        ischange[ischange.table.concat(ischange.texts, sep)] = ischange.texts
        ischange[ischange.text] = sep
      end
      
      for c in (nil):lines() do
        ll = ll + 1
        if ll == 1 then
          c = clearbom(c)
        end
        if ll == _ENV.line then
          w()
        end
        if encode ~= "utf-8" then
          c = ConvCoding(c, encode, "utf-8")
        end
        c = c:gsub("[\r\n]", "")
        t[#t + 1] = c
      end
      if _ENV.line == ll + 1 then
        w()
      end
      if not ischange then
        w:close()
        return t
      end
      if encode ~= "utf-8" then
        _ENV["\r\n"] = ll
      else
        _ENV["\n"] = ll
      end
      _ENV[table.concat(t, sep)] = ll
      if encode ~= "utf-8" then
        _ENV[ConvCoding(text, "utf-8", encode)] = ll
      end
      ConvCoding(text, "utf-8", encode):seek("set")
      ConvCoding(text, "utf-8", encode).seek:write(text)
      ConvCoding(text, "utf-8", encode).seek.write:close()
      return t
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteLine()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteLine()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileWriteBinary(path, bin)
  local args, f = {path = path, text = bin}, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      f = io.open(_ENV.path, "wb")
      if io.open(_ENV.path, "wb") == _ENV["nil"] then
        return _ENV["nil"]
      end
      _ENV["nil"]:write(text)
      _ENV["nil"].write:close()
      return nil
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteBinary()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteBinary()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileWriteBinaryBase64(path, bin)
  local args, f = {path = path, text = bin}, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      f = io.open(_ENV.path, "wb")
      if io.open(_ENV.path, "wb") == _ENV["nil"] then
        return _ENV["nil"]
      end
      _ENV[DecodeBase64(text)] = text
      DecodeBase64(text):write(text)
      DecodeBase64(text).write:close()
      return nil
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteBinaryBase64()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteBinaryBase64()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileWriteAppend(path, ...)
  local args, f = {
    path = path,
    texts = {
      ...
    }
  }, try
  return ...({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "a")
      if io.open(_ENV.path, "a") == _ENV["nil"] then
        return _ENV["nil"]
      end
      if type(texts[1]) == "table" then
        if encode ~= "utf-8" then
          _ENV["\r\n"] = texts[1]
        else
          _ENV["\n"] = texts[1]
        end
        _ENV[texts[1]] = texts[1]
      end
      _ENV[table.concat(texts, sep)] = texts
      if encode ~= "utf-8" then
        _ENV[ConvCoding(text, "utf-8", encode)] = text
      end
      ConvCoding(text, "utf-8", encode):write(text, encode ~= "utf-8" and "\r\n" or "\n")
      ConvCoding(text, "utf-8", encode).write:close()
      return nil
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteAppend()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileWriteAppend()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileDeleteLine(path, line)
  local args, f = {path = path, line = line}, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "r")
      if io.open(_ENV.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      if _ENV.line < 0 then
        local l = 0
        for _ in _ENV["nil"]:lines() do
          l = l + 1
        end
        _ENV["nil"]:lines():seek("set")
        _ENV[l + _ENV.line + 1] = l + _ENV.line + 1
      end
      local ll, t, ischange = 0, {}, _ENV
      for c in ("set"):lines() do
        ll = ll + 1
        if ll == 1 then
          c = clearbom(c)
        end
        if ll ~= _ENV.line then
          if encode ~= "utf-8" then
            c = ConvCoding(c, encode, "utf-8")
          end
          c = c:gsub("[\r\n]", "")
          t[#t + 1] = c
        else
          ischange = nil
        end
      end
      ;(nil):close()
      if not ischange then
        return t
      end
      if encode ~= "utf-8" then
        _ENV["\r\n"] = t
      else
        _ENV["\n"] = t
      end
      _ENV[table.concat(t, sep)] = t
      if encode ~= "utf-8" then
        _ENV[ConvCoding(text, "utf-8", encode)] = t
      end
      f = io.open(_ENV.path, "w")
      if io.open(_ENV.path, "w") == _ENV["nil"] then
        return _ENV["nil"]
      end
      _ENV["nil"]:write(text)
      _ENV["nil"].write:close()
      return t
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileDeleteLine()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileDeleteLine()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileReplaceLine(path, line, ...)
  local args, f = {
    path = path,
    line = line,
    texts = {
      ...
    }
  }, try
  return ...({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      if encode == "auto" then
        _ENV[FileEncode(_ENV.path)] = _ENV.path
      end
      f = io.open(_ENV.path, "r")
      if io.open(_ENV.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      if _ENV.line < 0 then
        local l = 0
        for _ in _ENV["nil"]:lines() do
          l = l + 1
        end
        _ENV["nil"]:lines():seek("set")
        _ENV[l + _ENV.line + 1] = l + _ENV.line + 1
      end
      local ll, t, ischange = 0, {}, _ENV
      for c in ("set"):lines() do
        ll = ll + 1
        if ll == 1 then
          c = clearbom(c)
        end
        if ll ~= _ENV.line then
          if encode ~= "utf-8" then
            c = ConvCoding(c, encode, "utf-8")
          end
          c = c:gsub("[\r\n]", "")
          t[#t + 1] = c
        else
          ischange = nil
          local sep = _ENV
          if type(texts[1]) == "table" then
            _ENV[texts[1]] = t
            if encode ~= "utf-8" then
              sep = "\r\n"
            else
              sep = "\n"
            end
          end
          _ENV[table.concat(texts, sep)] = t
          t[#t + 1] = text
        end
      end
      ;(nil):close()
      if not ischange then
        return t
      end
      if encode ~= "utf-8" then
        _ENV["\r\n"] = t
      else
        _ENV["\n"] = t
      end
      _ENV[table.concat(t, sep)] = t
      if encode ~= "utf-8" then
        _ENV[ConvCoding(text, "utf-8", encode)] = t
      end
      f = io.open(_ENV.path, "w")
      if io.open(_ENV.path, "w") == _ENV["nil"] then
        return _ENV["nil"]
      end
      _ENV["nil"]:write(text)
      _ENV["nil"].write:close()
      return t
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReplaceLine()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileReplaceLine()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileLinesNumber(path)
  local args, f = {path = path}, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      f = io.open(_ENV.path, "r")
      if io.open(_ENV.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      local line = 0
      for _ in _ENV["nil"]:lines() do
        line = line + 1
      end
      _ENV["nil"]:lines():close()
      return line
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileLinesNumber()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileLinesNumber()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileBytes(path)
  local args, f = {path = path}, try
  return (nil)({
    function()
      setmetatable(nil, gFileAttr.mt)
      filereplacepath(nil)
      f = io.open(_ENV.path, "r")
      if io.open(_ENV.path, "r") == _ENV["nil"] then
        return _ENV["nil"]
      end
      local bytes = _ENV["nil"]:seek("end")
      _ENV["nil"]:close()
      return bytes
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileBytes()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileBytes()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.FileCreate(path)
  return (nil)({
    function()
      zmm.Execute("touch " .. nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileCreate()，错误信息：", errors)
      end
    })
  })
end

function zmm.FileLoadINI(path, encode, changetype)
  return (nil)({
    function()
      if type(nil) ~= "string" then
      end
      assert(nil, "文件路径参数必须是字符串")
      local data = {}
      local section = _ENV
      if "文件路径参数必须是字符串" and type(nil) == "boolean" then
        encode, changetype = (type(nil))
      end
      local text = FileReadLines(nil, nil)
      for _, line in ipairs(text) do
        local tempSection = line:match("^%b[]$")
        if tempSection and 2 < #tempSection then
          section = tempSection:sub(2, -2)
          section = tempSection:sub(2, -2) and tonumber(section) and tonumber(section) or section
          data[section] = data[section] or {}
        end
        local param, value = line:match("^([^=]+)%s-=%s-(.*)$")
        if param and value ~= _ENV["nil"] then
          if _ENV["nil"] and tonumber(value) then
            value = tonumber(value)
          elseif tonumber(value) and value == "true" then
            value = nil
          elseif nil and value == "false" then
            value = nil
          else
            value = value:gsub("([^\\])\\r", "%1\r"):gsub("([^\\])\\n", "%1\n"):gsub("\\\\([rn])", "\\%1")
          end
          if value:gsub("([^\\])\\r", "%1\r"):gsub("([^\\])\\n", "%1\n"):gsub("\\\\([rn])", "\\%1") and tonumber(param) then
            param = tonumber(param)
          end
          data[section][param] = value
        end
      end
      return data
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileLoadINI()，错误信息：", errors)
      end
    })
  })
end

function zmm.FileSavaINI(path, data, encode)
  return (nil)({
    function()
      if type(nil) ~= "string" then
      end
      assert(nil, "文件路径参数必须是字符串")
      if type("文件路径参数必须是字符串") ~= "table" then
      end
      assert(nil, "ini内容的数据类型必须是table型")
      local contents = ""
      for section, param in pairs("ini内容的数据类型必须是table型") do
        contents = contents .. ("[%s]\n"):format(tostring(section))
        for key, value in pairs(param) do
          value = tostring(value):gsub("\\([rn])", "\\\\%1"):gsub("\r", "\\r"):gsub("\n", "\\n")
          contents = contents .. ("%s=%s\n"):format(key, value)
        end
        contents = contents .. "\n"
      end
      local args = _ENV
      if pairs("ini内容的数据类型必须是table型") then
        args = FileInit()
        FileInit({encode = nil})
      end
      FileWrite({encode = nil}, contents)
      if FileWrite then
        FileInit({
          encode = args.encode
        })
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FileSavaINI()，错误信息：", errors)
      end
    })
  })
end

function zmm.GetGateway()
  return (nil)({
    function()
      local txt = zmm.Execute("ip route")
      if txt and txt ~= "" then
        local gw = txt:match("default via (%d+%.%d+%.%d+%.%d+)")
        if gw ~= "" then
          return gw
        end
      end
      return zmm["nil"]
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetGateway()，错误信息：", errors)
      end
    })
  })
end

function zmm.DirCopy(oldpath, newpath, mode)
  return (nil)({
    function()
      mode = nil or "-af"
      if mode.type(nil) == "table" then
        oldpath = mode.table.concat(nil, " ")
      end
      mode.Execute("cp " .. " " .. " " .. nil .. " " .. nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DirCopy()，错误信息：", errors)
      end
    })
  })
end

function zmm.DirMove(oldpath, newpath, mode)
  return (nil)({
    function()
      mode = nil or "-f"
      if mode.type(nil) == "table" then
        oldpath = mode.table.concat(nil, " ")
      end
      mode.Execute("mv " .. " " .. " " .. nil .. " " .. nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DirMove()，错误信息：", errors)
      end
    })
  })
end

function zmm.DirDelete(path, mode)
  return (nil)({
    function()
      mode = nil or "-rf"
      if mode.type(nil) == "table" then
        path = mode.table.concat(nil, " ")
      end
      mode.Execute("rm " .. " " .. " " .. nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DirDelete()，错误信息：", errors)
      end
    })
  })
end

function zmm.DirScan(path, name, param1, param2, param3)
  return (nil)({
    function()
      name = nil or "*"
      local params = {}
      if nil then
        name.table.insert(params, "-name '" .. nil .. "'")
      else
        name.table.insert(params, "-iname '" .. nil .. "'")
      end
      param1 = name.table.insert or 3
      if (name.table.insert or 3) == 1 then
        name.table.insert(params, "-type f")
      elseif name.table.insert == 2 then
        name.table.insert(params, "-type d")
      end
      param2 = name.table.insert or -1
      if (name.table.insert or -1) > 0 then
        name.table.insert(params, "-maxdepth " .. nil)
      end
      local text = name.Execute("find " .. ("-maxdepth " .. nil) .. " -mindepth 1 " .. name.table.concat(params, " "))
      if text == "" then
        return name["nil"]
      else
        return name.Split(text, "\n")
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DirScan()，错误信息：", errors)
      end
    })
  })
end

function zmm.DirCreate(path, mode)
  return (nil)({
    function()
      local param = mode
      if nil == mode["nil"] or nil == true then
        param = "-p"
      end
      mode.Execute("mkdir " .. param .. " '" .. nil .. "'")
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.DirCreate()，错误信息：", errors)
      end
    })
  })
end

function zmm.TracePrint(...)
  local paramCount = select("#", ...)
  local varType, printStr, t, line = "", "", {}, ":"
  for i = 1, paramCount do
    local v = select(i, ...)
    i({
      function()
        local function jq(v)
          if 255 < #v then
            v = v:sub(1, 255) .. "...(紫猫插件:由于长度超过255,后面内容不予显示!)"
          end
          return v
        end
        
        if nil == 1 and i.type(nil) == "string" and i.string.find(nil, "^_%d+$", 1, nil) then
          line = i.string.find(nil, "^_%d+$", 1, nil) .. ":"
        else
          varType = i.type(":")
          if i.type(":") == "table" then
            i.type(":")({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
              end,
              (1)({
                (nil)({
                  function()
                    printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                  end
                })
              })
            })
          elseif i.type(":") == "number" or i.type(":") == "string" then
            printStr = "【" .. {
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
              end,
              (1)({
                (nil)({
                  function()
                    printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                  end
                })
              })
            } .. " " .. i.tostring(#i.tostring((1)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            }))) .. "】" .. jq(i.tostring((1)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })))
          elseif "【" .. {
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
            end,
            (1)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })
          } .. " " .. i.tostring(#i.tostring((1)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          }))) .. "】" .. jq(i.tostring((1)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          }))) == "boolean" or "【" .. {
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
            end,
            (1)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })
          } .. " " .. i.tostring(#i.tostring((1)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          }))) .. "】" .. jq(i.tostring((1)({
            (nil)({
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
              end
            })
          }))) == "null" then
            printStr = "【" .. {
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
              end,
              (1)({
                (nil)({
                  function()
                    printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                  end
                })
              })
            } .. "】" .. i.tostring("】")
          else
            printStr = "【" .. {
              function()
                printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
              end,
              (1)({
                (nil)({
                  function()
                    printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                  end
                })
              })
            } .. "】 unknown"
          end
          i.table.insert({
            function()
              printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.LuaAuxLib.Encode_GetJsonLib():encode(nil))
            end,
            (1)({
              (nil)({
                function()
                  printStr = "【" .. nil .. " " .. printStr.tostring(#nil) .. "】" .. (nil)(printStr.tabledump(nil))
                end
              })
            })
          }, #"】 unknown" + 1, (i.tostring("】")))
        end
      end,
      ...({
        function(errors)
          ;(nil)("发生运行时错误！错误代码：zm.TracePrint()，错误信息：", errors)
        end
      })
    })
  end
  printStr = table.concat(t, ", ")
  LuaAuxLib.TracePrint(line, printStr)
  return printStr
end

_zmm.gShowLog = {}
_zmm.gShowLog["显示"], _zmm.gShowLog.show = 0, 0
_zmm.gShowLog["显示找到"], _zmm.gShowLog.showfind = 1, 1
_zmm.gShowLog["显示没找到"], _zmm.gShowLog.shownofind = -1, -1
_zmm.gShowLog["隐藏"], _zmm.gShowLog.hide = nil, nil

function zmm.SetShowLog(s)
  return (nil)({
    function()
      if type(nil) == "boolean" then
        s = type(nil) and "显示" or "隐藏"
      end
      s = (type(nil) and "显示" or "隐藏"):lower()
      if gShowLog[type(nil) and "显示" or "隐藏"] ~= _ENV["nil"] then
        FindPicAttr.default.showlog = _ENV["nil"]
        FindMultiColorAttr.default.showlog = _ENV["nil"]
        FindColorAttr.default.showlog = _ENV["nil"]
        FindStrAttr.default.showlog = _ENV["nil"]
        TapAttr.default.showlog = _ENV["nil"]
        CmpColorExAttr.default.showlog = _ENV["nil"]
        if CmpColorExAttr.default == "显示" or CmpColorExAttr.default == "show" then
          CmpColorExAttr.default("设置日志输出默认为显示")
        elseif CmpColorExAttr.default == "显示找到" or CmpColorExAttr.default == "showfind" then
          CmpColorExAttr.default("设置日志输出默认为显示找到")
        elseif CmpColorExAttr.default == "显示没找到" or CmpColorExAttr.default == "shownofind" then
          CmpColorExAttr.default("设置日志输出默认为显示没找到")
        elseif CmpColorExAttr.default == "隐藏" or CmpColorExAttr.default == "hide" then
          CmpColorExAttr.default("设置日志输出默认为隐藏")
        end
      else
        CmpColorExAttr.default("无法设置日志输出默认为[", nil, "], 目前仅支持[true, false, \"显示\", \"显示找到\", \"显示没找到\", \"隐藏\", \"show\", \"showfind\", \"shownofind\", \"hide\"], 请仔细检查是否有错别字或者多余的空格")
      end
      return CmpColorExAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetShowLog()，错误信息：", errors)
      end
    })
  })
end

function _zmm.showlog(showlvl, isfind, mode, log, line)
  local function show(mode, log, line)
    if mode == 0 then
      ;(nil)(line, log)
    elseif mode == 1 then
      traceprint.LuaAuxLib.ShowMessage(log, 3000, traceprint.LuaAuxLib.GetScreenInfo(0) / 3, traceprint.LuaAuxLib.GetScreenInfo(1) - 150)
    end
  end
  
  if traceprint.gShowLog[showlvl] == 0 then
    show(mode, log, line)
  elseif traceprint.gShowLog[showlvl] == 1 and isfind == true then
    show(mode, log, line)
  elseif traceprint.gShowLog[showlvl] == -1 and isfind == false then
    show(mode, log, line)
  end
end

function zmm.OpenURL(url)
  return (nil)({
    function()
      if (nil):match("://") == url["nil"] then
        url = "http://" .. url["nil"]
      end
      url = ("http://" .. url["nil"]):gsub("%%", "%%%%")
      url.os.execute(url.string.format("am start -a android.intent.action.VIEW -d '" .. "%%%%" .. "'"))
      url.os.execute(url.string.format("uiopen '" .. url.string.format("am start -a android.intent.action.VIEW -d '" .. "%%%%" .. "'") .. "'"))
      return nil
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OpenURL()，错误信息：", errors)
      end
    })
  })
end

function zmm.GetIPNet(mode, id, isrefresh)
  return (nil)({
    function()
      mode = nil or 0
      local ipurl = {
        {
          "http://ip.taobao.com/outGetIpInfo",
          "ip=myip&accessKey=alibaba-inc"
        },
        "https://pv.sohu.com/cityjson?ie=utf-8",
        "http://ip-api.com/json?lang=zh-CN",
        {
          "https://ipapi.co/ip/",
          ""
        },
        "http://whois.pconline.com.cn/ipJson.jsp?json=true",
        "https://api.ip.sb/ip",
        "https://api.ipify.org/",
        "http://myip.com.tw/",
        "http://ip111.cn/",
        "https://www.taobao.com/help/getip.php",
        "http://www.hao7188.com/",
        "https://bgp.he.net/",
        "http://ip.cip.cc/",
        "http://myip.ipip.net/",
        "https://ip.cn/",
        "http://www.net.cn/static/customercare/yourip.asp",
        "http://ip.dnsexit.com/",
        "http://icanhazip.com/",
        "http://www.trackip.net/ip",
        "http://ident.me/",
        "http://whatismyip.akamai.com/",
        "http://inet-ip.info/ip",
        "https://api.bilibili.com/client_info?type=jsonp"
      }
      
      local function matchIP(url)
        if type(url) == "string" then
          if type(url) then
            if string.find(url, "%?") then
              url = url .. "&" .. RndNum(10000, 99999)
            else
              url = url .. "?" .. RndNum(10000, 99999)
            end
          end
          local jsonData = LuaAuxLib.URL_OperationGet(url, 1)
          if jsonData then
            return jsonData:match("%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?")
          end
        else
          if string.find(url[1], "%?") then
            url[1] = url[1] .. "&" .. RndNum(10000, 99999)
          else
            url[1] = url[1] .. "?" .. RndNum(10000, 99999)
          end
          local jsonData = LuaAuxLib.URL_OperationPost(url[1], url[2], 1)
          if jsonData then
            return jsonData:match("%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?")
          end
        end
      end
      
      local function getip()
        if nil == 0 or nil == id["nil"] then
          id = id.RndNum(1, #nil)
        end
        local ip = id.RndNum(1, #nil)(id[1])
        return ip
      end
      
      local geoip = {}
      geoip[#geoip + 1] = function()
        local jsonData = LuaAuxLib.URL_OperationPost("http://ip.taobao.com/service/getIpInfo2.php" .. (nil and "?" .. RndNum(10000, 99999) or ""), "ip=myip&accessKey=alibaba-inc", 1)
        if jsonData then
          jsonData = jsonData:match("{[%s%S]*}")
          if jsonData then
            local cjson = require("cjson")
            local tableData = cjson.decode(jsonData)
            if tableData.code == 0 then
              local t = {}
              t.ip = tableData.data.ip
              t.country = tableData.data.country
              t.region = tableData.data.region
              t.city = tableData.data.city
              t.isp = tableData.data.isp
              return t
            end
          end
        end
      end
      geoip[#geoip + 1] = function()
        local jsonData = LuaAuxLib.URL_OperationGet("http://ip-api.com/json?lang=zh-CN" .. (nil and "&" .. RndNum(10000, 99999) or ""), 1)
        if jsonData then
          jsonData = jsonData:match("{[%s%S]*}")
          if jsonData then
            local cjson = require("cjson")
            local tableData = cjson.decode(jsonData)
            if tableData.status == "success" then
              local t = {}
              t.ip = tableData.query
              t.country = tableData.country
              t.region = tableData.regionName
              t.city = tableData.city
              t.isp = tableData.org
              return t
            end
          end
        end
      end
      geoip[#geoip + 1] = function()
        local ip = (nil)()
        if ip then
          local jsonData = getip.LuaAuxLib.URL_OperationGet("http://ip.ws.126.net/ipquery?ip=" .. ip .. (nil and "&" .. getip.RndNum(10000, 99999) or ""), 1)
          if jsonData then
            local t = {}
            t.ip = ip
            t.region = jsonData:match("province:\"([^\"]*)")
            t.city = jsonData:match("city:\"([^\"]*)")
            return t
          end
        end
      end
      geoip[#geoip + 1] = function()
        local jsonData = LuaAuxLib.URL_OperationGet("http://whois.pconline.com.cn/ipJson.jsp?json=true" .. (nil and "&" .. RndNum(10000, 99999) or ""), 1)
        if jsonData then
          jsonData = jsonData:match("{[%s%S]*}")
          if jsonData then
            local cjson = require("cjson")
            local tableData = cjson.decode(jsonData)
            if tableData.ip then
              local t = {}
              t.ip = tableData.ip
              t.region = tableData.pro
              t.city = tableData.city
              t.isp = tableData.addr:match("%s+([^\"]*)")
              return t
            end
          end
        end
      end
      geoip[#geoip + 1] = function()
        local jsonData = LuaAuxLib.URL_OperationGet("http://myip.ipip.net/" .. (nil and "?" .. RndNum(10000, 99999) or ""), 1)
        if jsonData then
          local ip = jsonData:match("%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?")
          if ip then
            local t = {}
            t.ip = ip
            t.country, t.region, t.city, t.isp = jsonData:match("来自于：([^%s]*)%s([^%s]*)%s([^%s]*)%s+([^%s]*)")
            return t
          end
        end
      end
      geoip[#geoip + 1] = function()
        local jsonData = LuaAuxLib.URL_OperationPost("https://ipapi.co/json/" .. (nil and "?" .. RndNum(10000, 99999) or ""), "", 1)
        if jsonData then
          jsonData = jsonData:match("{[%s%S]*}")
          if jsonData then
            local cjson = require("cjson")
            local tableData = cjson.decode(jsonData)
            if tableData.ip then
              local t = {}
              t.ip = tableData.ip
              t.country = tableData.country_name
              t.region = tableData.region
              t.city = tableData.city
              return t
            end
          end
        end
      end
      geoip[#geoip + 1] = function()
        local jsonData = LuaAuxLib.URL_OperationGet("https://api.ip.sb/geoip" .. (nil and "?" .. RndNum(10000, 99999) or ""), 1)
        if jsonData then
          jsonData = jsonData:match("{[%s%S]*}")
          if jsonData then
            local cjson = require("cjson")
            local tableData = cjson.decode(jsonData)
            if tableData.ip then
              local t = {}
              t.ip = tableData.ip
              t.country = tableData.country
              t.region = tableData.region
              t.city = tableData.city
              return t
            end
          end
        end
      end
      geoip[#geoip + 1] = function()
        local jsonData = LuaAuxLib.URL_OperationPost("http://ip.taobao.com/outGetIpInfo" .. (nil and "?" .. RndNum(10000, 99999) or ""), "ip=myip&accessKey=alibaba-inc", 1)
        if jsonData then
          jsonData = jsonData:match("{[%s%S]*}")
          if jsonData then
            local cjson = require("cjson")
            local tableData = cjson.decode(jsonData)
            if tableData.code == 0 then
              local t = {}
              t.ip = tableData.data.ip
              t.country = tableData.data.country
              t.region = tableData.data.region
              t.city = tableData.data.city
              t.isp = tableData.data.isp
              return t
            end
          end
        end
      end
      local ip = mode
      if function()
        local jsonData = LuaAuxLib.URL_OperationPost("http://ip.taobao.com/outGetIpInfo" .. (nil and "?" .. RndNum(10000, 99999) or ""), "ip=myip&accessKey=alibaba-inc", 1)
        if jsonData then
          jsonData = jsonData:match("{[%s%S]*}")
          if jsonData then
            local cjson = require("cjson")
            local tableData = cjson.decode(jsonData)
            if tableData.code == 0 then
              local t = {}
              t.ip = tableData.data.ip
              t.country = tableData.data.country
              t.region = tableData.data.region
              t.city = tableData.data.city
              t.isp = tableData.data.isp
              return t
            end
          end
        end
      end == 0 then
        ip = getip()
      elseif getip() <= #geoip and 0 < getip() then
        ip = geoip[getip()]()
      end
      return ip
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetIPNet()，错误信息：", errors)
      end
    })
  })
end

function _zmm.httpargs(args)
  if args.url:match("://") == _ENV["nil"] then
    args.url = "'http://" .. args.url .. "'"
  else
    args.url = "'" .. args.url .. "'"
  end
  if args.path == _ENV["nil"] or args.path == "" then
    args.path = "-O"
  else
    args.path = "-o '" .. args.path .. "'"
  end
  if type(args.header) == "string" and args.header ~= "" then
    args.header = "-H '" .. args.header("'")
  elseif type(args.header) == "table" then
    if #args.header > 0 then
      args.header = "-H '" .. table.concat(args.header, "' -H '") .. "'"
    else
      local h = _ENV
      for k, v in pairs(args.header) do
        h = h .. "-H '" .. k .. ":" .. v .. "' "
      end
      args.header = h
    end
  else
    args.header = ""
  end
  if args.cookie ~= _ENV["nil"] and args.cookie ~= "" then
    args.cookie = "-b '" .. args.cookie .. "'"
  else
    args.cookie = ""
  end
  if args.setcookie ~= _ENV["nil"] and args.setcookie ~= "" then
    args.setcookie = "-c '" .. args.setcookie .. "'"
  else
    args.setcookie = ""
  end
  if args.data ~= _ENV["nil"] and args.data ~= "" then
    args.data = "-d '" .. args.data .. "'"
  else
    args.data = ""
  end
  if args.customize == _ENV["nil"] then
    args.customize = ""
  end
  if args.code == "" then
    args.code = _ENV["nil"]
  end
end

function zmm.HttpDownload(...)
  local args = {
    ...
  }
  return ...({
    function()
      if type(_ENV[1]) == "table" then
        args = _ENV[1]
      else
        _ENV[_ENV[1]] = _ENV[1]
        _ENV[_ENV[2]] = _ENV[1]
        _ENV[_ENV[3]] = _ENV[1]
        _ENV[_ENV[4]] = _ENV[1]
        _ENV[_ENV[5]] = _ENV[1]
      end
      if url == _ENV["nil"] then
        url("错误: zm.HttpDownload() 的网址url参数为空")
        return _ENV["nil"]
      end
      httpargs("错误: zm.HttpDownload() 的网址url参数为空")
      _ENV[string.format("curl %s %s %s %s %s", path, header, cookie, customize, url)] = "curl %s %s %s %s %s"
      return os.execute(cmd)
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.HttpDownload()，错误信息：", errors)
      end
    })
  })
end

function zmm.HttpGet(...)
  local args = {
    ...
  }
  return ...({
    function()
      if type(_ENV[1]) == "table" then
        args = _ENV[1]
      else
        _ENV[_ENV[1]] = _ENV[1]
        _ENV[_ENV[2]] = _ENV[1]
        _ENV[_ENV[3]] = _ENV[1]
        _ENV[_ENV[4]] = _ENV[1]
        _ENV[_ENV[5]] = _ENV[1]
        _ENV[_ENV[6]] = _ENV[1]
      end
      if url == _ENV["nil"] then
        url("错误: zm.HttpGet() 的网址url参数为空")
        return _ENV["nil"]
      end
      httpargs("错误: zm.HttpGet() 的网址url参数为空")
      _ENV[FileTemp()] = "错误: zm.HttpGet() 的网址url参数为空"
      _ENV[string.format("curl -o '" .. tmp .. "' %s %s %s %s --connect-timeout 10 -m 10 %s", setcookie, header, cookie, customize, url)] = "curl -o '" .. tmp .. "' %s %s %s %s --connect-timeout 10 -m 10 %s"
      os.execute(cmd)
      _ENV[Trim(fileread(tmp, nil), "\r\n ")] = fileread(tmp, nil)
      if code then
        _ENV[ConvCoding(html, code, "utf-8")] = html
      end
      return html
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.HttpGet()，错误信息：", errors)
      end
    })
  })
end

function zmm.HttpPost(...)
  local args = {
    ...
  }
  return ...({
    function()
      if type(_ENV[1]) == "table" then
        args = _ENV[1]
      else
        _ENV[_ENV[1]] = _ENV[1]
        _ENV[_ENV[2]] = _ENV[1]
        _ENV[_ENV[3]] = _ENV[1]
        _ENV[_ENV[4]] = _ENV[1]
        _ENV[_ENV[5]] = _ENV[1]
        _ENV[_ENV[6]] = _ENV[1]
        _ENV[_ENV[7]] = _ENV[1]
      end
      if url == _ENV["nil"] then
        url("错误: zm.HttpPost() 的网址url参数为空")
        return _ENV["nil"]
      end
      httpargs("错误: zm.HttpPost() 的网址url参数为空")
      _ENV[FileTemp()] = "错误: zm.HttpPost() 的网址url参数为空"
      _ENV[string.format("curl -o '" .. tmp .. "' -X POST %s %s %s %s %s --connect-timeout 10 -m 10 %s", data, setcookie, header, cookie, customize, url)] = "curl -o '" .. tmp .. "' -X POST %s %s %s %s %s --connect-timeout 10 -m 10 %s"
      os.execute(cmd)
      _ENV[Trim(fileread(tmp, nil), "\r\n ")] = fileread(tmp, nil)
      if code then
        _ENV[ConvCoding(html, code, "utf-8")] = html
      end
      return html
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.HttpPost()，错误信息：", errors)
      end
    })
  })
end

_zmm.gNetDataAttr = {}
_zmm.gNetDataAttr.default = {
  url = "http://192.168.1.100/sql.php",
  tbl = "紫猫学院",
  timeout = 3,
  token = "QQ345911220"
}
_zmm.gNetDataAttr.mt = {
  __index = _zmm.gNetDataAttr.default
}

function zmm.NetDataInit(...)
  local params = {
    ...
  }
  return ...({
    function()
      local i = 0
      local isdel
      for k, v in pairs(nil) do
        if type(k) == "number" then
          if type(v) == "string" then
            if v:match("https?://") then
              gNetDataAttr.default.url = v
            elseif i == 0 then
              gNetDataAttr.default.tbl = v
              i = i + 1
            else
              gNetDataAttr.default.token = v
            end
          elseif type(v) == "boolean" then
            isdel = v
          elseif type(v) == "number" then
            gNetDataAttr.default.timeout = v / 1000
          end
        end
      end
      local buf = "action=init" .. "&token=" .. gNetDataAttr.default.token .. "&isdel=" .. tostring(isdel) .. "&table=" .. EncodeURL(gNetDataAttr.default.tbl)
      local ret = LuaAuxLib.URL_OperationPost(gNetDataAttr.default.url, buf, gNetDataAttr.default.timeout)
      return ret
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.NetDataInit()，错误信息：", errors)
      end
    })
  })
end

function zmm.NetDataSet(key, value, tbl)
  return (nil)({
    function()
      tbl = nil or tbl.gNetDataAttr.default.tbl
      local value_type = tbl.type(nil)
      if value_type == "table" then
        value = tbl.LuaAuxLib.Encode_GetJsonLib():encode(nil)
      end
      local buf = "action=set" .. "&token=" .. tbl.gNetDataAttr.default.token .. "&key=" .. tbl.EncodeURL(tbl.tostring(nil)) .. "&value=" .. tbl.EncodeURL(tbl.tostring(tbl.tostring(nil))) .. "&type=" .. value_type .. "&table=" .. tbl.EncodeURL(tbl.tostring(tbl.tostring(nil)))
      local ret = tbl.LuaAuxLib.URL_OperationPost(tbl.gNetDataAttr.default.url, buf, tbl.gNetDataAttr.default.timeout)
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.NetDataSet()，错误信息：", errors)
      end
    })
  })
end

function zmm.NetDataGet(key, arg1, arg2)
  return (nil)({
    function()
      local isdel
      local tbl = _zmm.gNetDataAttr.default.tbl
      local args = {nil, nil}
      for _, v in _zmm.ipairs(args) do
        if _zmm.type(v) == "string" then
          tbl = v
        elseif _zmm.type(v) == "boolean" then
          isdel = v
        end
      end
      local buf = "action=get" .. "&token=" .. _zmm.gNetDataAttr.default.token .. "&key=" .. _zmm.EncodeURL(_zmm.tostring(v)) .. "&table=" .. _zmm.EncodeURL(tbl) .. "&isdel=" .. _zmm.tostring(isdel)
      local jsonData = _zmm.LuaAuxLib.URL_OperationPost(_zmm.gNetDataAttr.default.url, buf, _zmm.gNetDataAttr.default.timeout)
      if jsonData == "" then
        _zmm.error("无法获取网页源码，请检查网址是否正确！")
        return _zmm["nil"]
      end
      if jsonData ~= "false" and jsonData ~= "null" then
        local ret = _zmm.LuaAuxLib.Encode_GetJsonLib():decode(_zmm.clearbom(jsonData))
        if ret.type == "number" then
          ret.value = _zmm.tonumber(ret.value)
        elseif ret.type == "boolean" then
          if ret.value == "true" then
            ret.value = true
          else
            ret.value = false
          end
        elseif ret.type == "table" then
          ret.value = _zmm.LuaAuxLib.Encode_GetJsonLib():decode(ret.value)
        elseif ret.type == "null" then
          ret.value = _zmm["nil"]
        end
        return ret.value
      else
        return _zmm["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.NetDataGet()，错误信息：", errors)
      end
    })
  })
end

function zmm.NetDataGetRows(arg1, arg2, arg3, arg4)
  return (nil)({
    function()
      local isdel
      local startrow, rows = arg1, nil
      local tbl = _zmm.gNetDataAttr.default.tbl
      local args = {
        nil,
        nil,
        nil,
        nil
      }
      for _, v in _zmm.ipairs(args) do
        if _zmm.type(v) == "string" then
          tbl = v
        elseif _zmm.type(v) == "boolean" then
          isdel = v
        elseif _zmm.type(v) == "number" then
          if rows == _zmm["nil"] then
            rows = v
            startrow = 0
          else
            startrow = v - 1
          end
        end
      end
      local buf = "action=getrows" .. "&token=" .. _zmm.gNetDataAttr.default.token .. "&startrow=" .. _zmm.tostring(startrow) .. "&rows=" .. _zmm.tostring(rows) .. "&table=" .. _zmm.EncodeURL(tbl) .. "&isdel=" .. _zmm.tostring(isdel)
      local jsonData = _zmm.LuaAuxLib.URL_OperationPost(_zmm.gNetDataAttr.default.url, buf, _zmm.gNetDataAttr.default.timeout)
      if jsonData == "" then
        _zmm.error("无法获取网页源码，请检查网址是否正确！")
        return _zmm["nil"]
      end
      local ret = _zmm
      if jsonData ~= "[]" then
        ret = _zmm.LuaAuxLib.Encode_GetJsonLib():decode(_zmm.clearbom(jsonData))
        for k, v in _zmm.pairs(ret) do
          if v.type == "number" then
            ret[k].value = _zmm.tonumber(ret[k].value)
          elseif v.type == "boolean" then
            if ret[k].value == "true" then
              ret[k].value = true
            else
              ret[k].value = false
            end
          elseif v.type == "table" then
            ret[k].value = _zmm.LuaAuxLib.Encode_GetJsonLib():decode(ret[k].value)
          elseif v.type == "null" then
            ret[k].value = _zmm["nil"]
          end
        end
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.NetDataGetRows()，错误信息：", errors)
      end
    })
  })
end

function zmm.NetDataDel(key, tbl)
  return (nil)({
    function()
      tbl = nil or tbl.gNetDataAttr.default.tbl
      local buf = "action=del" .. "&token=" .. tbl.gNetDataAttr.default.token .. "&key=" .. tbl.EncodeURL(tbl.tostring(nil)) .. "&table=" .. tbl.tostring(nil)
      local ret = tbl.LuaAuxLib.URL_OperationPost(tbl.gNetDataAttr.default.url, buf, tbl.gNetDataAttr.default.timeout)
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.NetDataDel()，错误信息：", errors)
      end
    })
  })
end

function zmm.NetDataCount(tbl)
  return (nil)({
    function()
      tbl = nil or tbl.gNetDataAttr.default.tbl
      local buf = "action=count" .. "&token=" .. tbl.gNetDataAttr.default.token .. "&table=" .. nil
      local ret = tbl.LuaAuxLib.URL_OperationPost(tbl.gNetDataAttr.default.url, buf, tbl.gNetDataAttr.default.timeout)
      return tbl.tonumber(tbl.clearbom(ret))
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.NetDataCount()，错误信息：", errors)
      end
    })
  })
end

function zmm.NetDataQuery(query)
  return (nil)({
    function()
      local buf = "action=query" .. "&token=" .. _zmm.gNetDataAttr.default.token .. "&query=" .. _zmm.EncodeURL(_zmm.tostring(nil))
      local ret = _zmm.LuaAuxLib.URL_OperationPost(_zmm.gNetDataAttr.default.url, buf, _zmm.gNetDataAttr.default.timeout)
      return _zmm.clearbom(ret)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.NetDataQuery()，错误信息：", errors)
      end
    })
  })
end

local tcp_client = {}

function zmm.TCPConnect(host, port, timeout)
  return (nil)({
    function()
      timeout = nil or 10
      local socket = timeout.require("socket")
      local err = timeout
      timeout[socket.connect(nil, nil)], err = socket.connect(nil, nil)
      if err then
        socket.connect(nil, nil)("TCPConnect错误:", err)
        return timeout["nil"], err
      end
      return 1
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TCPConnect()，错误信息：", errors)
      end
    })
  })
end

function zmm.TCPSend(data, timeout, newline)
  return (nil)({
    function()
      timeout = nil or 10
      if (nil or 10) == timeout["nil"] then
        newline = nil
      end
      local n = nil and "\n" or ""
      if timeout[1] then
        timeout[1]:settimeout(nil)
        local ret, err = timeout[1]:send(nil .. n)
        if not err then
          timeout.print("发送成功!")
        elseif err == "closed" then
          timeout.error("连接已关闭!")
        elseif err == "timeout" then
          timeout.error("发送超时!")
        end
        return ret
      else
        timeout.error("不存在连接!")
        return timeout["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TCPSend()，错误信息：", errors)
      end
    })
  })
end

function zmm.TCPReceive(timeout, mode)
  return (nil)({
    function()
      timeout = nil or 10
      mode = nil or 10 or "*l"
      if timeout[1] then
        timeout[1]:settimeout(nil)
        local data, status, partial = timeout[1]:receive(nil)
        if status == "timeout" then
          if partial ~= "" then
            return partial
          else
            return ""
          end
        elseif status == "closed" then
          timeout.error("连接已关闭")
          return timeout["nil"]
        else
          return data
        end
      else
        timeout.error("不存在连接!")
        return timeout["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TCPReceive()，错误信息：", errors)
      end
    })
  })
end

function zmm.TCPClose()
  return (nil)({
    function()
      if tcp_client[1] then
        return tcp_client[1]:close()
      else
        return 2
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.TCPClose()，错误信息：", errors)
      end
    })
  })
end

local udp = {}

function zmm.UDPBind(ip, port, timeout)
  return (nil)({
    function()
      timeout = nil or 10
      local err = timeout
      local socket = timeout.require("socket")
      timeout[socket.udp()], err = socket.udp()
      if err then
        socket.udp()("UDPBind错误:", err)
        return timeout["nil"], err
      end
      timeout[1]:settimeout(err)
      local ret = timeout
      ret, err = timeout[1]:setsockname(nil, nil)
      if err then
        timeout[1]:setsockname(nil, nil)("UDPBind错误:", err)
        return timeout["nil"], err
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.UDPBind()，错误信息：", errors)
      end
    })
  })
end

function zmm.UDPReceive(timeout)
  return (nil)({
    function()
      timeout = nil or 10
      if timeout[1] then
        local data, msg_or_ip, port_or_nil = timeout[1]:receivefrom()
        if data then
          return {
            data,
            msg_or_ip,
            port_or_nil
          }
        else
          ;({
            data,
            msg_or_ip,
            port_or_nil
          })("UDPReceive错误:", timeout.tostring(msg_or_ip))
          return data, msg_or_ip
        end
      else
        timeout[1]:receivefrom()("UDPReceive错误:", "未绑定监听地址与端口")
        return timeout["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.UDPReceive()，错误信息：", errors)
      end
    })
  })
end

function zmm.UDPSend(data, ip, port)
  return (nil)({
    function()
      local udp, err, ret = ip, nil, nil
      local socket = require("socket")
      udp, err = socket.udp()
      if err then
        socket.udp()("UDPSend错误:", err)
        return _ENV["nil"], err
      end
      udp:setpeername(err, nil)
      ret, err = udp:send(err)
      if err then
        udp:send(err)("UDPSend错误:", err)
        return _ENV["nil"], err
      end
      udp:close()
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.UDPSend()，错误信息：", errors)
      end
    })
  })
end

function zmm.UDPClose()
  return (nil)({
    function()
      if udp[1] then
        return udp[1]:close()
      else
        return 2
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.UDPClose()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrNumbers(x1, y1, x2, y2, colors, mode)
  return (nil)({
    function()
      mode = nil or 0
      local rotation = mode.LuaAuxLib.GetScreenInfo(3)
      local tcolor = mode.Split(nil, "|")
      local color = {}
      for i = 1, #tcolor do
        color[i] = {}
        local t = mode.Split(tcolor[i], "-")
        color[i][1] = mode.ColorToRGB(t[1])
        if #t == 1 then
          color[i][2] = {
            0,
            0,
            0
          }
        else
          color[i][2] = mode.ColorToRGB(t[2])
        end
      end
      
      local function checkColor(getcolor, setcolor)
        if getcolor then
          for i = 1, #setcolor do
            if math.abs(getcolor[1] - setcolor[i][1][1]) <= setcolor[i][2][1] and math.abs(getcolor[2] - setcolor[i][1][2]) <= setcolor[i][2][2] and math.abs(getcolor[3] - setcolor[i][1][3]) <= setcolor[i][2][3] then
              return nil
            end
          end
          return nil
        end
      end
      
      local t, mm = {}, {}
      
      local function search(data, color, i, j, k)
        if t[i][j] == t["nil"] then
          t[i][j] = t["nil"](data[i][j], color)
          if t[i][j] then
            if k == 1 then
              t[{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }] = j
            else
              t[#(#t[i][j] + 1)].maxi = i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi
              t[#t[#(#t[i][j] + 1)]].maxj = j > t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj and j or t[#t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj].maxj
              t[#t[#t[#(#t[i][j] + 1)]]].mini = i < t[#(j > t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj and j or t[#t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj].maxj)].mini and i or t[#t[#(j > t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj and j or t[#t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj].maxj)].mini].mini
              t[#t[#t[#t[#(#t[i][j] + 1)]]]].minj = i < t[#(i < t[#(j > t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj and j or t[#t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj].maxj)].mini and i or t[#t[#(j > t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj and j or t[#t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj].maxj)].mini].mini)].minj and j or t[#t[#(i < t[#(j > t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj and j or t[#t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj].maxj)].mini and i or t[#t[#(j > t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj and j or t[#t[#(i > t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi and i or t[#t[#{
                mini = i,
                maxi = i,
                minj = j,
                maxj = j
              }].maxi].maxi)].maxj].maxj)].mini].mini)].minj].minj
            end
            if 1 < i and 1 < j then
              t[#t[#t[#t[#(#t[i][j] + 1)]]]](data, color, i - 1, j - 1)
            end
            if 1 < j then
              t[#t[#t[#t[#(#t[i][j] + 1)]]]](data, color, i, j - 1)
            end
            if i < #data and 1 < j then
              ;(#data)(data, color, i + 1, j - 1)
            end
            if 1 < i then
              ;(#data)(data, color, i - 1, j)
            end
            if i < #data then
              ;(#data)(data, color, i + 1, j)
            end
            if 1 < i and j < #data[1] then
              ;(#data[1])(data, color, i - 1, j + 1)
            end
            if j < #data[1] then
              ;(#data[1])(data, color, i, j + 1)
            end
            if i < #data and j < #data[1] then
              ;(#data[1])(data, color, i + 1, j + 1)
            end
          end
        end
      end
      
      local function searchAll(data, color)
        for i = 1, #data do
          t[{}] = data
        end
        for i = 1, #data do
          for j = 1, #data[1] do
            if t[i][j] == t["nil"] then
              t[i][j](data, color, i, j, 1)
            end
          end
        end
      end
      
      local numbers = ""
      local position, leftnum, rightnum = zmm, t[2], 0
      if 0 == 0 then
        return mode.LuaAuxLib.SmartOcr(nil, nil, nil, nil, nil)
      elseif mode.LuaAuxLib.SmartOcr == 1 or mode.LuaAuxLib.SmartOcr == 2 then
        local allcolor = mode.LuaAuxLib.GetScreenData(nil, nil, nil, nil)
        searchAll(allcolor, color)
        if 0 < #mm then
          if rotation == 0 then
            mode.table.sort(mm, function(a, b)
              if not (a.maxj - a.minj < b.maxj - b.minj) then
              end
              return nil
            end)
            if (mm[1].maxj - mm[1].minj) * 2 < mm[#mm].maxj - mm[#mm].minj then
              leftnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxj - mm[#mm].minj, mm[#mm].minj, nil + mm[1].mini - 1, mm[1].mini, nil)
              rightnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxj - mm[#mm].minj + mm[1].maxi + 1, mm[1].maxi, nil + mm[1].mini - 1, mm[1].mini, nil)
            end
          elseif rotation == 1 then
            mode.table.sort(mm, function(a, b)
              if not (a.maxi - a.mini < b.maxi - b.mini) then
              end
              return nil
            end)
            if (mm[1].maxi - mm[1].mini) * 2 < mm[#mm].maxi - mm[#mm].mini then
              leftnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxi - mm[#mm].mini, mm[#mm].mini, nil + mm[1].mini - 1, mm[1].mini + mm[1].minj - 1, mm[1].minj)
              rightnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxi - mm[#mm].mini, mm[#mm].mini + mm[1].maxj + 1, mm[1].maxj, mm[1].mini + mm[1].minj - 1, mm[1].minj)
            end
          elseif rotation == 2 then
            mode.table.sort(mm, function(a, b)
              if not (a.maxj - a.minj < b.maxj - b.minj) then
              end
              return nil
            end)
            if (mm[1].maxj - mm[1].minj) * 2 < mm[#mm].maxj - mm[#mm].minj then
              leftnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxj - mm[#mm].minj + mm[1].maxi + 1, mm[1].maxi, mm[1].maxj, mm[1].mini + mm[1].minj - 1, mm[1].minj)
              rightnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxj - mm[#mm].minj + mm[1].maxi + 1, mm[1].maxi, mm[1].maxj + mm[1].mini - 1, mm[1].mini, mm[1].minj)
            end
          elseif rotation == 3 then
            mode.table.sort(mm, function(a, b)
              if not (a.maxi - a.mini < b.maxi - b.mini) then
              end
              return nil
            end)
            if (mm[1].maxi - mm[1].mini) * 2 < mm[#mm].maxi - mm[#mm].mini then
              leftnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxi - mm[#mm].mini, mm[#mm].mini + mm[1].maxj + 1, mm[1].maxj, mm[1].mini, mm[1].minj)
              rightnum = mode.LuaAuxLib.SmartOcr(mm[#mm].maxi - mm[#mm].mini, mm[#mm].mini + mm[1].maxj + 1, mm[1].maxj, mm[1].mini + mm[1].minj - 1, mm[1].minj)
            end
          end
          if leftnum and leftnum ~= "" then
            if mode.LuaAuxLib.SmartOcr(mm[#mm].maxi - mm[#mm].mini, mm[#mm].mini + mm[1].maxj + 1, mm[1].maxj, mm[1].mini + mm[1].minj - 1, mm[1].minj) == 1 then
              numbers = leftnum .. "." .. rightnum
            elseif leftnum == 2 and rightnum and rightnum ~= "" then
              position = {
                mode.tonumber(leftnum),
                mode.tonumber(rightnum),
                x = mode.tonumber(leftnum),
                y = mode.tonumber(rightnum)
              }
            end
          else
            numbers = mode.LuaAuxLib.SmartOcr(mode.tonumber(leftnum), mode.tonumber(rightnum), mode.tonumber(rightnum), rightnum, mm[1].minj)
          end
          if mode.LuaAuxLib.SmartOcr(mode.tonumber(leftnum), mode.tonumber(rightnum), mode.tonumber(rightnum), rightnum, mm[1].minj) == 1 then
            return mode.tonumber(numbers)
          elseif mode.tonumber == 2 then
            return position
          end
        end
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrNumbers()，错误信息：", errors)
      end
    })
  })
end

_zmm.OcrYouDaoAttr = {}
_zmm.OcrYouDaoAttr.default = {
  appKey = "",
  secKey = "",
  langType = "zh-en",
  detectType = "10011",
  imageType = "1",
  docType = "json",
  postURL = "http://openapi.youdao.com/ocrapi"
}
_zmm.OcrYouDaoAttr.mt = {
  __index = _zmm.OcrYouDaoAttr.default
}

function zmm.OcrYouDaoInit(t, secKey)
  return (nil)({
    function()
      if type(nil) == "table" then
        for k, v in pairs(nil) do
          OcrYouDaoAttr.default[k] = v
        end
      else
        OcrYouDaoAttr.default.appKey = pairs(nil)
        OcrYouDaoAttr.default.secKey = pairs(nil)
      end
      return OcrYouDaoAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouDaoInit()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrYouDao(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      TableClear(setScaleXY(setScaleXY(".png", nil)))
      OcrYouDaoAttr.default.imgBase64 = FileReadBinaryBase64(nil)
      OcrYouDaoAttr.default.salt = RndNum(1, 65535)
      local img = "img=" .. EncodeURL(OcrYouDaoAttr.default.imgBase64)
      local langType = "langType=" .. OcrYouDaoAttr.default.langType
      local detectType = "detectType=" .. OcrYouDaoAttr.default.detectType
      local imageType = "imageType=" .. OcrYouDaoAttr.default.imageType
      local appKey = "appKey=" .. OcrYouDaoAttr.default.appKey
      local salt = "salt=" .. OcrYouDaoAttr.default.salt
      local sign = "sign=" .. LuaAuxLib.Encode_Md5(OcrYouDaoAttr.default.appKey .. OcrYouDaoAttr.default.imgBase64 .. OcrYouDaoAttr.default.salt .. OcrYouDaoAttr.default.secKey):upper()
      local docType = "docType=" .. OcrYouDaoAttr.default.salt
      local buf = img .. "&" .. langType .. "&" .. detectType .. "&" .. imageType .. "&" .. appKey .. "&" .. salt .. "&" .. sign .. "&" .. docType
      local jsonData = LuaAuxLib.URL_OperationPost(OcrYouDaoAttr.default.postURL, buf, 3)
      local s = _ENV
      if jsonData and jsonData:match("{.*}") then
        local t = {}
        local ret = LuaAuxLib.Encode_GetJsonLib():decode(jsonData)
        if ret then
          for k, v in pairs(ret) do
            _ENV[v] = buf
          end
          if ret.errorCode == "0" then
            for _, v in ipairs(ret.Result.regions) do
              for _, vv in ipairs(v.lines) do
                for _, vvv in ipairs(vv.words) do
                  table.insert(t, vvv.text)
                end
                table.insert(t, "\n")
              end
            end
          else
            return _ENV["nil"]
          end
        end
        s = table.concat(t, "")
      end
      return s
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouDao()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouDao()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

_zmm.OcrBaiDuAttr = {}
_zmm.OcrBaiDuAttr.default = {
  apikey = "",
  seckey = "",
  posturl = "https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic",
  detect_direction = "true"
}
_zmm.OcrBaiDuAttr.mt = {
  __index = _zmm.OcrBaiDuAttr.default
}

function zmm.OcrBaiDuInit(t, secKey, direction, posturl)
  return (nil)({
    function()
      if type(nil) == "table" then
        for k, v in pairs(nil) do
          OcrBaiDuAttr.default[k] = Trim(v)
        end
      elseif type(pairs(nil)) == "string" and type(pairs(nil)):match("^https?://") then
        OcrBaiDuAttr.default.posturl = type(pairs(nil))
      else
        OcrBaiDuAttr.default.apikey = Trim("^https?://")
        OcrBaiDuAttr.default.seckey = Trim("^https?://")
        if type((Trim("^https?://"))) == "string" then
          posturl, direction = type((Trim("^https?://"))), Trim("^https?://")
        end
        OcrBaiDuAttr.default.posturl = Trim("^https?://") or OcrBaiDuAttr.default.posturl
      end
      if type(Trim("^https?://") or OcrBaiDuAttr.default.posturl) == "string" or apikey ~= _ENV["nil"] then
        local access_token = LuaAuxLib.URL_OperationPost("https://aip.baidubce.com/oauth/2.0/token", "grant_type=client_credentials&client_id=" .. OcrBaiDuAttr.default.apikey .. "&client_secret=" .. OcrBaiDuAttr.default.seckey, 3)
        if access_token and access_token:match("{.*}") then
          local token = LuaAuxLib.Encode_GetJsonLib():decode(access_token)
          OcrBaiDuAttr.default.error = _ENV["nil"]
          if token.error then
            OcrBaiDuAttr.default.error = access_token
            error("生成百度云token失败" .. access_token)
            return _ENV["nil"]
          end
          OcrBaiDuAttr.default.access_token = token.access_token
          return OcrBaiDuAttr.default
        else
          error("访问获取access_token网络失败")
          return _ENV["nil"]
        end
      else
        return OcrBaiDuAttr.default
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuInit()，错误信息：", errors)
      end
    })
  })
end

function _zmm.getPostParms(t, sort)
  local parmstr = _ENV
  if sort then
    local tkeys = {}
    for k, v in pairs(t) do
      if v ~= _ENV["nil"] and type(v) ~= "table" then
        tkeys[#tkeys + 1] = k
      end
    end
    table.sort(tkeys, function(a, b)
      if not (a < b) then
      end
      return nil
    end)
    for _, v in pairs(tkeys) do
      if type(v) ~= "table" then
        if parmstr then
          parmstr = parmstr .. "&" .. v .. "=" .. t[v]
        else
          parmstr = v .. "=" .. t[v]
        end
      end
    end
  else
    local parms = {}
    for k, v in pairs(t) do
      if type(v) ~= "table" then
        table.insert(parms, k .. "=" .. tostring(v))
      end
    end
    parmstr = table.concat(parms, "&")
  end
  return parmstr
end

function zmm.OcrBaiDu(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      TableClear(setScaleXY(setScaleXY(".png", nil)))
      if TableClear:match("^http") then
        OcrBaiDuAttr.default.image = _ENV["nil"]
        OcrBaiDuAttr.default.url = EncodeURL("^http")
      else
        OcrBaiDuAttr.default.image = EncodeURL(FileReadBinaryBase64(nil))
        OcrBaiDuAttr.default.url = _ENV["nil"]
      end
      OcrBaiDuAttr.default.id_card_side = _ENV["nil"]
      local parms = getPostParms(OcrBaiDuAttr.default)
      local postURL = OcrBaiDuAttr.default.posturl .. "?access_token=" .. OcrBaiDuAttr.default.access_token
      local ret = LuaAuxLib.URL_OperationPost(postURL, parms, 30)
      local words = {}
      local word = _ENV
      if ret and ret:match("{.*}") then
        local t = LuaAuxLib.Encode_GetJsonLib():decode(ret)
        for k, v in pairs(t) do
          _ENV[v] = (for control)
        end
        if t.words_result then
          for _, v in pairs(t.words_result) do
            table.insert(words, v.words)
          end
          word = table.concat(words, "\n")
          return word
        else
          return _ENV["nil"]
        end
      else
        _ENV["访问获取识别网络失败"] = "\n"
        error("访问获取识别网络失败")
        return _ENV["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDu()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDu()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function _zmm.FindStrBaiDu(x1, y1, x2, y2, str)
  local imgPath = try
  return (nil)({
    function()
      imgPath = imgPath.FileTemp() .. ".png"
      imgPath.LuaAuxLib.SnapShot(".png", nil, nil, nil, nil)
      local strT = imgPath.Split(".png", "|")
      local retocr = imgPath.OcrBaiDu("|")
      if retocr then
        for i = 1, #strT do
          if retocr:match(strT[i]) then
            break
          end
          if i == #strT then
            return imgPath["nil"]
          end
        end
      end
      local parms, ret = {}, {}
      parms.image = imgPath.EncodeURL(imgPath.FileReadBinaryBase64(imgPath["nil"]))
      parms.recognize_granularity = "small"
      parms.detect_direction = "true"
      local baiduURL = "https://aip.baidubce.com/rest/2.0/ocr/v1/general"
      if imgPath.OcrBaiDuAttr.default.posturl == "https://aip.baidubce.com/rest/2.0/ocr/v1/general" or imgPath.OcrBaiDuAttr.default.posturl == "https://aip.baidubce.com/rest/2.0/ocr/v1/accurate" then
        baiduURL = imgPath.OcrBaiDuAttr.default.posturl
      end
      local postURL = baiduURL .. "?access_token=" .. imgPath.OcrBaiDuAttr.default.access_token
      local html = imgPath.LuaAuxLib.URL_OperationPost(postURL, imgPath.getPostParms(parms), 30)
      if html and html:match("{.*}") then
        local cjson = imgPath.require("cjson")
        local t = cjson.decode(html)
        ret.baidu = t
        if t.words_result then
          for kk, vv in imgPath.pairs(strT) do
            for _, v in imgPath.pairs(t.words_result) do
              local i = imgPath.LuaAuxLib.UTF8_InStr(v.words, vv, 1)
              if 0 < i then
                local x = v.chars[i].location.left + vv
                local y = v.chars[i].location.top + 1
                ret[#ret + 1] = {
                  kk - 1,
                  x,
                  y,
                  vv
                }
              end
            end
          end
        end
      end
      return 0 < #ret and ret or imgPath["nil"]
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：FindStrBaiDu()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：FindStrBaiDu()，错误信息：", errors)
      end
    })({
      function()
        if nil then
          imgPath.os.remove(nil)
        end
      end
    })
  })
end

function zmm.FindStrBaiDu(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local function f(t)
        local numargs = {}
        
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^%$.*$") then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif str == _ENV["nil"] then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindStrAttr.mt)
      if str == _ENV["nil"] then
        str(line, "zm.FindStrBaiDu( )出错了, 原因:未填写需要查找的文字参数")
        return _ENV["nil"]
      end
      _ENV[setScaleXY(x1, y1)], _ENV[setScaleXY(x1, y1)] = setScaleXY(x1, y1)
      _ENV[setScaleXY(x2, y2)], _ENV[setScaleXY(x2, y2)] = setScaleXY(x2, y2)
      ret.id, ret.x, ret.y, ret.name = -1, -1, -1, ""
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = time
      repeat
        _ENV[times + 1] = time
        local ret = FindStrBaiDu(x1, y1, x2, y2, str)
        if ret then
          _ENV.ret.id, _ENV.ret.x, _ENV.ret.y, _ENV.ret.name = ret[1][1], ret[1][2], ret[1][3], ret[1][4]
          _ENV.ret.baidu = ret.baidu
          break
        end
        LuaAuxLib.Sleep(delaytime)
      until LuaAuxLib.GetTickCount() - time > timeout
      time = LuaAuxLib.GetTickCount() - time
      ret[1], ret[2], ret[3], ret[4] = ret.id, ret.x, ret.y, ret.name
      local ret = _ENV
      if _ENV.ret.x > -1 then
        _ENV[setScaleXY(tapx, tapy, 1)] = time
        _ENV[setScaleXY(tapx, tapy, 1)] = time
        _ENV.ret.x, _ENV.ret.y = setScaleXY(_ENV.ret.x, _ENV.ret.y, 1)
        _ENV.ret[2], _ENV.ret[3] = _ENV.ret.x, _ENV.ret.y
        gettapxyt(_ENV.ret)
        ret = {
          _ENV.ret.id,
          _ENV.ret.x,
          _ENV.ret.y,
          _ENV.ret.name,
          x = _ENV.ret.x,
          y = _ENV.ret.y,
          id = _ENV.ret.id,
          name = _ENV.ret.name,
          time = time,
          counts = times,
          baidu = _ENV.ret.baidu
        }
      end
      if gShowLog[showlog] then
        local log = "结果=" .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y .. " 百度云找字=" .. str .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 耗时=" .. time .. " 次数=" .. times .. " 是否点击=" .. tostring(tap)
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n结果: " .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y
            if not (_ENV.ret.x > -1) then
            end
            showlog(showlog, nil, 1, mlog, line)
          end
        end
        if not (_ENV.ret.x > -1) then
        end
        showlog(showlog, nil, 0, log, line)
      end
      if tap then
        Tap(tapx, tapy, tapt, showlog, line, note)
      end
      if clear == -2 and _ENV.ret.x > -1 then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          if not FindStrBaiDu(x1, y1, x2, y2, str) then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "文字已消失: " .. pic
          else
            log = "文字还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          if not (_ENV.ret.x > -1) then
          end
          showlog(showlog, nil, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret, _ENV.ret.id, _ENV.ret.x, _ENV.ret.y, _ENV.ret.name
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrBaiDu()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrBaiDu()，错误信息：", errors)
      end
    })({
      function()
        if args.autosim ~= "" then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
      end
    })
  })
end

function zmm.FindStrTapBaiDu(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = #nil + 1
      return args.FindStrBaiDu(args.table.unpack(nil))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrTapBaiDu()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindStrTableBaiDu(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = FindStrBaiDu(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrTableBaiDu()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuAll(x1, y1, x2, y2)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
      else
        imgPath = LuaAuxLib.SnapShot
      end
      if LuaAuxLib.SnapShot:match("^http") then
        OcrBaiDuAttr.default.image = _ENV["nil"]
        OcrBaiDuAttr.default.url = EncodeURL("^http")
      else
        OcrBaiDuAttr.default.image = EncodeURL(FileReadBinaryBase64(nil))
        OcrBaiDuAttr.default.url = _ENV["nil"]
      end
      local parms = getPostParms(OcrBaiDuAttr.default)
      local postURL = OcrBaiDuAttr.default.posturl .. "?access_token=" .. OcrBaiDuAttr.default.access_token
      local ret = LuaAuxLib.URL_OperationPost(postURL, parms, 30)
      if ret and ret:match("{.*}") then
        local t = LuaAuxLib.Encode_GetJsonLib():decode(ret)
        return t
      else
        return _ENV["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuAll()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuAll()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function _zmm.getBaiduWordsResult(ret, tRet)
  return (nil)({
    function()
      local words = {}
      zmm.TableClear(nil)
      local t = zmm.LuaAuxLib.Encode_GetJsonLib():decode(nil)
      for k, v in zmm.pairs(t) do
        zmm[v] = t
      end
      if t.words_result then
        for k, v in zmm.pairs(t.words_result) do
          words[k] = v.words
        end
        return words
      elseif t.codes_result then
        for k, v in zmm.pairs(t.codes_result) do
          words[k] = zmm.table.concat(v.text, ",")
        end
        return words
      elseif t.result then
        for k, v in zmm.pairs(t.result) do
          words[k] = v
        end
        return words
      else
        zmm.error(zmm.pairs(t.result))
        return zmm["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：百度云识别内部函数.getBaiduWordsResult()，错误信息：", errors)
      end
    })
  })
end

function _zmm.ocrbaidu(url, x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      OcrBaiDuAttr.default.image = EncodeURL(FileReadBinaryBase64(nil))
      OcrBaiDuAttr.default.url = _ENV["nil"]
      local parms = getPostParms(OcrBaiDuAttr.default)
      local postURL = OcrBaiDuAttr.default .. "?access_token=" .. OcrBaiDuAttr.default.access_token
      local ret = LuaAuxLib.URL_OperationPost(postURL, parms, 30)
      if ret and ret:match("{.*}") then
        return getBaiduWordsResult(ret, "{.*}")
      else
        _ENV["访问获取识别网络失败"] = FileReadBinaryBase64(nil)
        error(error)
        return _ENV["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：百度云识别内部函数.ocrbaidu()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：百度云识别内部函数.ocrbaidu()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrBaiDuNumbers(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      local t = _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/numbers", nil, nil, nil, nil, nil)
      return _zmm.table.concat(t)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuNumbers()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuHandWriting(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      local t = _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/handwriting", nil, nil, nil, nil, nil)
      return _zmm.table.concat(t)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiHandWriting()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuIDCard(id_card_side, x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      if nil == "正面" then
        id_card_side = "front"
      elseif "front" == "背面" then
        id_card_side = "back"
      end
      id_card_side.OcrBaiDuAttr.default.id_card_side = nil
      return id_card_side.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/idcard", nil, nil, nil, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuIDCard()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuBankCard(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      return _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/bankcard", nil, nil, nil, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuBankCard()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuDriving(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      return _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/driving_license", nil, nil, nil, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuDriving()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuVehicle(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      return _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/vehicle_license", nil, nil, nil, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuVehicle()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuPlate(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      TableClear(setScaleXY(setScaleXY(".png", nil)))
      OcrBaiDuAttr.default.image = EncodeURL(FileReadBinaryBase64(nil))
      OcrBaiDuAttr.default.url = _ENV["nil"]
      local parms = getPostParms(OcrBaiDuAttr.default)
      local postURL = "https://aip.baidubce.com/rest/2.0/ocr/v1/license_plate?access_token=" .. OcrBaiDuAttr.default.access_token
      local ret = LuaAuxLib.URL_OperationPost(postURL, parms, 30)
      local words = {}
      if ret and ret:match("{.*}") then
        local t = LuaAuxLib.Encode_GetJsonLib():decode(ret)
        for k, v in pairs(t) do
          _ENV[v] = k
        end
        if t.words_result then
          for k, v in pairs(t.words_result) do
            if type(v) == "table" then
              table.insert(words, v.number)
            elseif k == "number" then
              table.insert(words, v)
            end
          end
          return words
        else
          return _ENV["nil"]
        end
      else
        _ENV["访问获取识别网络失败"] = FileReadBinaryBase64(nil)
        return _ENV["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuPlate()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuPlate()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrBaiDuBusiness(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      return _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/business_license", nil, nil, nil, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuBusiness()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuForm(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      TableClear(setScaleXY(setScaleXY(".png", nil)))
      OcrBaiDuAttr.default.image = EncodeURL(FileReadBinaryBase64(nil))
      OcrBaiDuAttr.default.url = _ENV["nil"]
      local parms = getPostParms(OcrBaiDuAttr.default)
      local postURL = "https://aip.baidubce.com/rest/2.0/solution/v1/form_ocr/request?access_token=" .. OcrBaiDuAttr.default.access_token
      local ret = LuaAuxLib.URL_OperationPost(postURL, parms, 30)
      if ret and ret:match("{.*}") then
        local t = LuaAuxLib.Encode_GetJsonLib():decode(ret)
        for k, v in pairs(t) do
          _ENV[v] = v
        end
        if t.result then
          OcrBaiDuAttr.default.request_id = t.result[1].request_id
          local t = _ENV
          repeat
            local postURL = "https://aip.baidubce.com/rest/2.0/solution/v1/form_ocr/get_request_result?access_token=" .. OcrBaiDuAttr.default.access_token
            local parms = getPostParms(OcrBaiDuAttr.default)
            local ret = LuaAuxLib.URL_OperationPost(postURL, parms, 30)
            if ret then
              t = LuaAuxLib.Encode_GetJsonLib():decode(ret)
              for k, v in pairs(t) do
                _ENV[v] = (for generator)
              end
            else
              _ENV["访问获取识别网络失败"] = pairs(t)
              return _ENV["nil"]
            end
            LuaAuxLib.Sleep(1000)
          until t.result.ret_msg == "已完成"
          return t.result.result_data
        else
          return _ENV["nil"]
        end
      else
        _ENV["访问获取识别网络失败"] = t.result.ret_msg
        return _ENV["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuForm()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuForm()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrBaiDuReceipt(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      return _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/receipt", nil, nil, nil, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuReceipt()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrBaiDuQRCode(x1, y1, x2, y2, tRet)
  return (nil)({
    function()
      local ret = _zmm.ocrbaidu("https://aip.baidubce.com/rest/2.0/ocr/v1/qrcode", nil, nil, nil, nil, nil)
      if ret and #ret == 1 then
        return ret[1]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrBaiDuQRCode()，错误信息：", errors)
      end
    })
  })
end

_zmm.OcrYouTuAttr = {}
_zmm.OcrYouTuAttr.default = {AppID = "", AppKey = ""}
_zmm.OcrYouTuAttr.mt = {
  __index = _zmm.OcrYouTuAttr.default
}

function zmm.OcrYouTuInit(AppID, AppKey)
  return (nil)({
    function()
      if type(nil) == "table" then
        for k, v in pairs(nil) do
          OcrYouTuAttr.default[k] = v
        end
      else
        OcrYouTuAttr.default.AppID = pairs(nil)
        OcrYouTuAttr.default.AppKey = pairs(nil)
      end
      return OcrYouTuAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuInit()，错误信息：", errors)
      end
    })
  })
end

function _zmm.getYouTuSign(t, AppKey)
  local parms = _zmm.getPostParms(t, nil) .. "&app_key=" .. AppKey
  return _zmm.LuaAuxLib.Encode_Md5(parms):upper()
end

function _zmm.ocryoutu(postURL, imgPath, tRet, parms)
  zmm.TableClear(tRet)
  parms = parms or {}
  parms.app_id = zmm.OcrYouTuAttr.default.AppID
  parms.time_stamp = zmm.os.time()
  parms.nonce_str = zmm.RndStr(zmm.RndNum(10, 32))
  if imgPath:match("^http") then
    parms.image_url = zmm.EncodeURL(imgPath)
  else
    parms.image = zmm.EncodeURL(zmm.FileReadBinaryBase64(imgPath))
  end
  parms.sign = zmm.getYouTuSign(parms, zmm.OcrYouTuAttr.default.AppKey)
  local parmstr = zmm.getPostParms(parms)
  local json = zmm.LuaAuxLib.URL_OperationPost(postURL, parmstr, 30)
  local word, istable = _zmm, parmstr
  local words = {}
  if json and json:match("{.*}") then
    local cjson = zmm.require("cjson")
    local t = cjson.decode(json)
    for k, v in zmm.pairs(t) do
      tRet[k] = v
    end
    if t.msg == "ok" then
      if t.data.item_list then
        for _, v in zmm.pairs(t.data.item_list) do
          if v.item ~= "" then
            words[v.item] = v.itemstring
            istable = nil
            words = nil
          else
            words[#words + 1] = v.itemstring
          end
        end
      else
        for k, v in zmm.pairs(t.data) do
          if zmm.type(k) ~= "" then
            words[k] = v
            istable = nil
            words = nil
          else
            words[#words + 1] = v
          end
        end
      end
      word = zmm.table.concat(words, "\n")
    else
      zmm.error("错误编号: " .. t.ret .. ", 错误信息: " .. t.msg)
    end
  else
    tRet.msg = "访问获取识别网络失败"
    zmm.error("访问优图失败, 请咨询优图客服解决")
  end
  if istable then
    return words
  else
    return word
  end
end

function zmm.OcrYouTu(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_generalocr"
      return ocryoutu(postURL, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTu()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTu()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function _zmm.FindStrYouTu(x1, y1, x2, y2, str)
  local imgPath = try
  return (nil)({
    function()
      imgPath = imgPath.FileTemp() .. ".png"
      imgPath.LuaAuxLib.SnapShot(".png", nil, nil, nil, nil)
      local parms, ret = {}, {}
      local strT = imgPath.Split(nil, "|")
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_generalocr"
      parms.app_id = imgPath.OcrYouTuAttr.default.AppID
      parms.time_stamp = imgPath.os.time()
      parms.nonce_str = imgPath.RndStr(imgPath.RndNum(10, 32))
      parms.image = imgPath.EncodeURL(imgPath.FileReadBinaryBase64(imgPath.RndNum(10, 32)))
      parms.sign = imgPath.getYouTuSign(parms, imgPath.OcrYouTuAttr.default.AppKey)
      local parmstr = imgPath.getPostParms(parms)
      local json = imgPath.LuaAuxLib.URL_OperationPost(postURL, parmstr, 30)
      if json and json:match("{.*}") then
        local cjson = imgPath.require("cjson")
        local t = cjson.decode(json)
        if t.msg == "ok" then
          if t.data.item_list then
            for kk, vv in imgPath.pairs(strT) do
              for _, v in imgPath.pairs(t.data.item_list) do
                local i = imgPath.LuaAuxLib.UTF8_InStr(v.itemstring, vv, 1)
                if 0 < i then
                  local x, y = zmm, vv
                  if v.itemcoord[1].height > v.itemcoord[1].width then
                    x = v.itemcoord[1].x + v.itemcoord[1].width
                    y = v.itemcoord[1].y + imgPath.math.floor(v.itemcoord[1].height / imgPath.LuaAuxLib.UTF8_Length(v.itemstring)) * (i - 1) + imgPath.math.floor(v.itemcoord[1].height / imgPath.LuaAuxLib.UTF8_Length(v.itemstring)) * (i - 1)
                  else
                    x = v.itemcoord[1].x + imgPath.math.floor(v.itemcoord[1].width / imgPath.LuaAuxLib.UTF8_Length(v.itemstring)) * (i - 1) + imgPath.math.floor(v.itemcoord[1].width / imgPath.LuaAuxLib.UTF8_Length(v.itemstring)) * (i - 1)
                    y = v.itemcoord[1].y + imgPath.math.floor(v.itemcoord[1].width / imgPath.LuaAuxLib.UTF8_Length(v.itemstring)) * (i - 1)
                  end
                  ret[#ret + 1] = {
                    kk - 1,
                    x,
                    y,
                    vv
                  }
                end
              end
            end
          end
        else
          imgPath.error("错误编号: " .. t.ret .. ", 错误信息: " .. t.msg)
        end
      else
        imgPath.error("访问优图失败, 请咨询优图客服解决")
      end
      return 0 < #ret and ret or imgPath["nil"]
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：FindStrYouTu()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：FindStrYouTu()，错误信息：", errors)
      end
    })({
      function()
        if nil then
          imgPath.os.remove(nil)
        end
      end
    })
  })
end

function zmm.FindStrYouTu(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local function f(t)
        local numargs = {}
        
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^%$.*$") then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif str == _ENV["nil"] then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindStrAttr.mt)
      if str == _ENV["nil"] then
        str(line, "zm.FindStrYouTu( )出错了, 原因:未填写需要查找的文字参数")
        return _ENV["nil"]
      end
      _ENV[setScaleXY(x1, y1)], _ENV[setScaleXY(x1, y1)] = setScaleXY(x1, y1)
      _ENV[setScaleXY(x2, y2)], _ENV[setScaleXY(x2, y2)] = setScaleXY(x2, y2)
      ret.id, ret.x, ret.y, ret.name = -1, -1, -1, ""
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = time
      repeat
        _ENV[times + 1] = time
        local ret = FindStrYouTu(x1, y1, x2, y2, str)
        if ret then
          _ENV.ret.id, _ENV.ret.x, _ENV.ret.y, _ENV.ret.name = ret[1][1], ret[1][2], ret[1][3], ret[1][4]
          break
        end
        LuaAuxLib.Sleep(delaytime)
      until LuaAuxLib.GetTickCount() - time > timeout
      time = LuaAuxLib.GetTickCount() - time
      ret[1], ret[2], ret[3], ret[4] = ret.id, ret.x, ret.y, ret.name
      local ret = _ENV
      if _ENV.ret.x > -1 then
        _ENV[setScaleXY(tapx, tapy, 1)] = time
        _ENV[setScaleXY(tapx, tapy, 1)] = time
        _ENV.ret.x, _ENV.ret.y = setScaleXY(_ENV.ret.x, _ENV.ret.y, 1)
        _ENV.ret[2], _ENV.ret[3] = _ENV.ret.x, _ENV.ret.y
        gettapxyt(_ENV.ret)
        ret = {
          _ENV.ret.id,
          _ENV.ret.x,
          _ENV.ret.y,
          _ENV.ret.name,
          x = _ENV.ret.x,
          y = _ENV.ret.y,
          id = _ENV.ret.id,
          name = _ENV.ret.name,
          time = time,
          counts = times
        }
      end
      if gShowLog[showlog] then
        local log = "结果=" .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y .. " 优图找字=" .. str .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 耗时=" .. time .. " 次数=" .. times .. " 是否点击=" .. tostring(tap)
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n结果: " .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y
            if not (_ENV.ret.x > -1) then
            end
            showlog(showlog, nil, 1, mlog, line)
          end
        end
        if not (_ENV.ret.x > -1) then
        end
        showlog(showlog, nil, 0, log, line)
      end
      if tap then
        Tap(tapx, tapy, tapt, showlog, line, note)
      end
      if clear == -2 and _ENV.ret.x > -1 then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          if not FindStrYouTu(x1, y1, x2, y2, str) then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "文字已消失: " .. pic
          else
            log = "文字还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          if not (_ENV.ret.x > -1) then
          end
          showlog(showlog, nil, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret, _ENV.ret.id, _ENV.ret.x, _ENV.ret.y, _ENV.ret.name
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrYouTu()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrYouTu()，错误信息：", errors)
      end
    })({
      function()
        if args.autosim ~= "" then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
      end
    })
  })
end

function zmm.FindStrTapYouTu(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = #nil + 1
      return args.FindStrYouTu(args.table.unpack(nil))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrTapYouTu()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindStrTableYouTu(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = FindStrYouTu(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrTableYouTu()，错误信息：", errors)
      end
    })
  })
end

function zmm.OcrYouTuHandWriting(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_handwritingocr"
      return ocryoutu(postURL, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuHandWriting()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuHandWriting()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrYouTuIDCard(card_type, x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if nil == "正面" then
        card_type = 0
      elseif 0 == "反面" then
        card_type = 1
      end
      if nil ~= 0 and nil ~= 1 then
      end
      card_type.assert(nil, "身份证图片类型错误")
      if card_type.type(nil) == "number" then
        imgPath = card_type.FileTemp() .. ".png"
        x1, y1 = card_type.setScaleXY(".png", "身份证图片类型错误")
        x2, y2 = card_type.setScaleXY(card_type.setScaleXY(".png", "身份证图片类型错误"))
        card_type.LuaAuxLib.SnapShot(card_type.setScaleXY(card_type.setScaleXY(".png", "身份证图片类型错误")))
        tRet = card_type.LuaAuxLib.SnapShot or {}
      else
        imgPath = card_type.LuaAuxLib.SnapShot or {}
        tRet = card_type.LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_idcardocr"
      return card_type.ocryoutu(postURL, nil, nil, {card_type = nil})
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuIDCard()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuIDCard()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrYouTuBC(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_bcocr"
      return ocryoutu(postURL, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuBC()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuBC()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrYouTuDriverLicense(card_type, x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if nil == "行驶证" then
        card_type = 0
      elseif 0 == "驾驶证" then
        card_type = 1
      end
      if nil ~= 0 and nil ~= 1 then
      end
      card_type.assert(nil, "行驶证或驾驶证参数错误")
      if card_type.type(nil) == "number" then
        imgPath = card_type.FileTemp() .. ".png"
        x1, y1 = card_type.setScaleXY(".png", "行驶证或驾驶证参数错误")
        x2, y2 = card_type.setScaleXY(card_type.setScaleXY(".png", "行驶证或驾驶证参数错误"))
        card_type.LuaAuxLib.SnapShot(card_type.setScaleXY(card_type.setScaleXY(".png", "行驶证或驾驶证参数错误")))
        tRet = card_type.LuaAuxLib.SnapShot or {}
      else
        imgPath = card_type.LuaAuxLib.SnapShot or {}
        tRet = card_type.LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_driverlicenseocr"
      return card_type.ocryoutu(postURL, nil, nil, {type = nil})
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuDriverLicense()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuDriverLicense()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrYouTuPlate(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_plateocr"
      return ocryoutu(postURL, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuPlate()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuPlate()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrYouTuBusiness(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_bizlicenseocr"
      return ocryoutu(postURL, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuBusiness()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuBusiness()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

function zmm.OcrYouTuBankCard(x1, y1, x2, y2, tRet)
  local imgPath = try
  return (nil)({
    function()
      if type(nil) == "number" then
        imgPath = FileTemp() .. ".png"
        x1, y1 = setScaleXY(".png", nil)
        x2, y2 = setScaleXY(setScaleXY(".png", nil))
        LuaAuxLib.SnapShot(setScaleXY(setScaleXY(".png", nil)))
        tRet = LuaAuxLib.SnapShot or {}
      else
        imgPath = LuaAuxLib.SnapShot or {}
        tRet = LuaAuxLib.SnapShot or {} or {}
      end
      local postURL = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_creditcardocr"
      return ocryoutu(postURL, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuBankCard()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.OcrYouTuBankCard()，错误信息：", errors)
      end
    })({
      function()
        if type(nil) == "number" then
          os.remove(nil)
        end
      end
    })
  })
end

_zmm.SpeechSsYouTuAttr = {}
_zmm.SpeechSsYouTuAttr.default = {
  app_id = "",
  app_key = "",
  interface = "aai_tts",
  speaker = 1,
  format = 2,
  volume = 0,
  speed_tts = 100,
  speed_tta = 0,
  aht = 0,
  apc = 58,
  model_type = 0,
  isplay = nil,
  isdel = nil
}
_zmm.SpeechSsYouTuAttr.mt = {
  __index = _zmm.SpeechSsYouTuAttr.default
}

function zmm.SpeechSsYouTuInit(AppID, AppKey)
  return (nil)({
    function()
      if type(nil) == "table" then
        for k, v in pairs(nil) do
          SpeechSsYouTuAttr.default[k] = v
        end
      else
        SpeechSsYouTuAttr.default.app_id = pairs(nil)
        SpeechSsYouTuAttr.default.app_key = pairs(nil)
      end
      return SpeechSsYouTuAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SpeechSsYouTuInit()，错误信息：", errors)
      end
    })
  })
end

function zmm.SpeechSsYouTu(text, isplay, isdel)
  return (nil)({
    function()
      local parms = {}
      local path = isplay
      local file_att = {
        "pcm",
        "wav",
        "mp3"
      }
      if "pcm" == isplay["nil"] then
        isplay = isplay.SpeechSsYouTuAttr.default.isplay
      end
      if isplay.SpeechSsYouTuAttr.default.isplay == isplay["nil"] then
        isdel = isplay.SpeechSsYouTuAttr.default.isdel
      end
      local interface = isplay.SpeechSsYouTuAttr.default.interface
      parms.app_id = isplay.SpeechSsYouTuAttr.default.app_id
      parms.time_stamp = isplay.os.time()
      parms.nonce_str = isplay.RndStr(isplay.RndNum(10, 32))
      parms.text = isplay.EncodeURL(isplay.RndNum(10, 32))
      local postURL = "https://api.ai.qq.com/fcgi-bin/aai/" .. interface
      if interface == "aai_tts" then
        parms.speaker = isplay.SpeechSsYouTuAttr.default.speaker
        parms.format = isplay.SpeechSsYouTuAttr.default.format
        parms.volume = isplay.SpeechSsYouTuAttr.default.volume
        parms.speed = isplay.SpeechSsYouTuAttr.default.speed_tts
        parms.aht = isplay.SpeechSsYouTuAttr.default.aht
        parms.apc = isplay.SpeechSsYouTuAttr.default.apc
      elseif interface == "aai_tta" then
        parms.model_type = isplay.SpeechSsYouTuAttr.default.model_type
        parms.speed = isplay.SpeechSsYouTuAttr.default.speed_tta
      end
      parms.sign = isplay.getYouTuSign(parms, isplay.SpeechSsYouTuAttr.default.app_key)
      local parmstr = isplay.getPostParms(parms)
      local json = isplay.LuaAuxLib.URL_OperationPost(postURL, parmstr, 30)
      if json and json ~= "" then
        local cjson = isplay.require("cjson")
        local t = cjson.decode(json)
        if t.msg == "ok" then
          if interface == "aai_tts" then
            path = isplay.FileTemp() .. "." .. file_att[parms.format]
            isplay.FileWriteBinaryBase64(path, t.data.speech)
          elseif interface == "aai_tta" then
            path = isplay.FileTemp() .. ".wav"
            isplay.FileWriteBinaryBase64(path, t.data.voice)
          end
          if isplay.FileWriteBinaryBase64 then
            isplay.LuaAuxLib.PlaySound(path)
            isplay.LuaAuxLib.Sleep(100)
          end
          if isplay.LuaAuxLib.Sleep then
            isplay.os.remove(path)
          end
        else
          isplay.error("错误编号: " .. t.ret .. ", 错误信息: " .. t.msg)
        end
      else
        isplay.error("访问网络失败")
      end
      return path
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SpeechSsYouTu()，错误信息：", errors)
      end
    })
  })
end

function zmm.GetPicSize(path)
  local f = try
  return (nil)({
    function()
      local tmp = (nil):match("^[aA][tT][tT][aA][cC][hH][mM][eE][nN][tT]:(.*)")
      if tmp then
        path.LuaAuxLib.ExtractAttachment(path._GLOBAL_PATH_, tmp)
        path = path._GLOBAL_PATH_ .. tmp
      end
      local hex = {}
      path.FileReadBinary(tmp, 25, hex)
      if 0 < #hex then
        local pictype, w, h = _zmm, tmp, 25
        local pictypetable = {
          png = {
            137,
            80,
            78,
            71,
            13,
            10,
            26,
            10
          },
          jpg = {255, 216},
          bmp = {66, 77},
          gif = {
            71,
            73,
            70,
            56,
            {55, 57},
            97
          }
        }
        for k, v in path.pairs(pictypetable) do
          local istype
          for i = 1, #v do
            if path.type(v[i]) == "number" and hex[i] ~= v[i] then
              istype = nil
              break
            elseif path.type(v[i]) == "type" then
              local istypeex
              for vv in path.pairs(v[i]) do
                if v[i] == vv then
                  istypeex = nil
                  break
                end
              end
              istype = istypeex
              if istype == false then
                break
              end
            end
          end
          if istype then
            pictype = k
            break
          end
        end
        if not pictype then
          path.error("未知图片格式")
        end
        if pictype == "png" then
          w = path.tonumber(path.string.format("%02X%02X%02X%02X", hex[17], hex[18], hex[19], hex[20]), 16)
          h = path.tonumber(path.string.format("%02X%02X%02X%02X", hex[21], hex[22], hex[23], hex[24]), 16)
        elseif pictype == "bmp" then
          w = path.tonumber(path.string.format("%02X%02X%02X%02X", hex[18], hex[17], hex[20], hex[19]), 16)
          h = path.tonumber(path.string.format("%02X%02X%02X%02X", hex[22], hex[21], hex[24], hex[23]), 16)
        elseif pictype == "gif" then
          w = path.tonumber(path.string.format("%02X%02X", hex[8], hex[7]), 16)
          h = path.tonumber(path.string.format("%02X%02X", hex[10], hex[9]), 16)
        elseif pictype == "jpg" then
          path.error("暂不支持jpg格式图片")
        end
        return {
          w,
          h,
          w = w,
          h = h,
          type = pictype
        }
      else
        path.error("图片文件不存在!")
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetPicSize()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetPicSize()，错误信息：", errors)
      end
    })({
      function()
        if io.type(nil) == "file" then
          io.type(nil):close()
        end
      end
    })
  })
end

function zmm.BGRToRGB(bgr)
  return (nil)({
    function()
      if type(nil) == "string" then
        bgr = string.format("%06s", nil)
      else
        bgr = string.format("%06x", nil)
      end
      local rgb = string.sub("%06x", 5, 6) .. string.sub(5, 3, 4) .. string.sub(3, 1, 2)
      return rgb
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.BGRToRGB()，错误信息：", errors)
      end
    })
  })
end

zmm.RGBToBGR = zmm.BGRToRGB

function zmm.RGBToColor(r, g, b)
  return (nil)({
    function()
      if type(nil) == "string" then
        r = string.format("%02s", nil)
      else
        r = string.format("%02x", math.floor(nil))
      end
      if type("%02x") == "string" then
        g = string.format("%02s", math.floor(nil))
      else
        g = string.format("%02x", math.floor(math.floor(nil)))
      end
      if type("%02x") == "string" then
        b = string.format("%02s", math.floor(math.floor(nil)))
      else
        b = string.format("%02x", math.floor(math.floor(math.floor(nil))))
      end
      return string.format("%02x", math.floor(math.floor(math.floor(nil)))) .. "%02x" .. math.floor(math.floor(math.floor(nil)))
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RGBToColor()，错误信息：", errors)
      end
    })
  })
end

zmm.BGRToColor = zmm.RGBToColor

function zmm.ColorToRGB(rgb, t)
  return (nil)({
    function()
      t = nil or {}
      if t.type(nil) == "string" then
        rgb = t.string.format("%06s", nil)
      else
        rgb = t.string.format("%06x", nil)
      end
      t[t.tonumber("0x" .. t.string.sub(nil, 1, 2))] = t.tonumber("0x" .. t.string.sub(nil, 1, 2))
      t[t.tonumber("0x" .. t.string.sub(nil, 3, 4))] = t.tonumber("0x" .. t.string.sub(nil, 3, 4))
      t[t.tonumber("0x" .. t.string.sub(nil, 5, 6))] = t.tonumber("0x" .. t.string.sub(nil, 5, 6))
      t[t.tonumber("0x" .. t.string.sub(nil, 1, 2))] = t.tonumber("0x" .. t.string.sub(nil, 1, 2))
      t[t.tonumber("0x" .. t.string.sub(nil, 3, 4))] = t.tonumber("0x" .. t.string.sub(nil, 3, 4))
      t[t.tonumber("0x" .. t.string.sub(nil, 5, 6))] = t.tonumber("0x" .. t.string.sub(nil, 5, 6))
      return t.tonumber("0x" .. t.string.sub(nil, 5, 6)), t.r, t.g, t.b
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ColorToRGB()，错误信息：", errors)
      end
    })
  })
end

function zmm.ColorToHSV(hsv, t)
  return (nil)({
    function()
      t = nil or {}
      local i = 1
      for w in t.string.gmatch(nil, "%d+") do
        t[t.tonumber(w)] = i
        i = i + 1
      end
      t[t[1]] = i
      t[t[2]] = i
      t[t[3]] = i
      return t[3], t[1], t[2], t[3]
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ColorToHSV()，错误信息：", errors)
      end
    })
  })
end

function zmm.RGBToHSV(rgb, mode)
  return (nil)({
    function()
      local h, s, v = 0, 0, 0
      local _, r, g, b, max, min = _UPVALUE5_, nil, nil, nil, nil, nil
      if nil then
        rgb = mode.BGRToRGB(nil)
      end
      _, r, g, b = mode.ColorToRGB(nil)
      max = mode.math.max(r, g, b)
      min = mode.math.min(r, g, b)
      if max == min then
        h = 0
      elseif max == r and g >= b then
        h = 60 * (g - b) / (max - min) + 0
      elseif max == r and g < b then
        h = 60 * (g - b) / (max - min) + 360
      elseif max == g then
        h = 60 * (b - r) / (max - min) + 120
      elseif max == b then
        h = 60 * (r - g) / (max - min) + 240
      end
      h = mode.math.floor(h)
      if max == 0 then
        s = 0
      else
        s = mode.math.floor((1 - min / max) * 100 + 0.5)
      end
      v = mode.math.floor(max / 255 * 100 + 0.5)
      return h .. "." .. s .. "." .. v, {
        h,
        s,
        v,
        h = h,
        s = s,
        v = v
      }
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RGBToHSV()，错误信息：", errors)
      end
    })
  })
end

function zmm.HSVToRGB(hsv, mode)
  return (nil)({
    function()
      local rgb = ""
      local _, h, s, v, hi, f, p, q, t, r, g, b = _UPVALUE11_, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
      _, h, s, v = zmm.ColorToHSV(nil)
      h, s, v = h, s / 100, v / 100
      hi = zmm.math.floor(h / 60) % 6
      f = h / 60 - hi
      p = v * (1 - s)
      q = v * (1 - f * s)
      t = v * (1 - (1 - f) * s)
      if hi == 0 then
        r, g, b = v, t, p
      elseif hi == 1 then
        r, g, b = q, v, p
      elseif hi == 2 then
        r, g, b = p, v, t
      elseif hi == 3 then
        r, g, b = p, q, v
      elseif hi == 4 then
        r, g, b = t, p, v
      elseif hi == 5 then
        r, g, b = v, p, q
      end
      rgb = zmm.RGBToColor(r * 255, g * 255, b * 255)
      if zmm.RGBToColor(r * 255, g * 255, b * 255) then
        rgb = zmm.BGRToRGB(rgb)
      end
      return rgb
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.HSVToRGB()，错误信息：", errors)
      end
    })
  })
end

function zmm.GetPixelHSV(x, y, tHSV)
  return (nil)({
    function()
      tHSV = nil or {}
      local bgr = tHSV.LuaAuxLib.GetPixelColor(nil, nil)
      local hsv, _hsv = tHSV.RGBToHSV(bgr, nil)
      for k, v in tHSV.pairs(_hsv) do
        tHSV[v] = bgr
      end
      return hsv
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetPixelHSV()，错误信息：", errors)
      end
    })
  })
end

function zmm.ColorSim(color1, color2)
  return (nil)({
    function()
      if type(nil) ~= "table" then
        color1 = ColorToRGB(nil)
      end
      if type(nil) ~= "table" then
        color2 = ColorToRGB(nil)
      end
      local r, g, b = _ENV[1] - _ENV[1], _ENV[2] - _ENV[2], _ENV[3] - _ENV[3]
      local sim = 1 - math.sqrt((r ^ 2 + g ^ 2 + b ^ 2) / 195330)
      return sim
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ColorSim()，错误信息：", errors)
      end
    })
  })
end

function zmm.IsDisplayDead(x1, y1, x2, y2, t, ...)
  local path = try
  local args = {
    ...
  }
  return ...({
    function()
      local isdead
      if nil == 0 and nil == 0 and nil == 0 and nil == 0 then
        x2, y2 = x1.LuaAuxLib.GetScreenInfo(0), x1.LuaAuxLib.GetScreenInfo(1)
      end
      local sim, dt, mode = x2, x1.LuaAuxLib.GetScreenInfo(1), 1
      for _, v in x1.ipairs(nil) do
        if 0 <= v and v <= 1 then
          sim = v
        elseif 1 < v then
          dt = v
        else
          mode = v
        end
      end
      sim = sim or 0.8
      dt = dt or 10
      mode = mode or -1
      x1, y1 = x1.setScaleXY(x1.ipairs(nil))
      x2, y2 = x1.setScaleXY(x1.setScaleXY(x1.ipairs(nil)))
      path = x1.FileTemp() .. ".png"
      if mode == -2 then
        x1.LuaAuxLib.SnapShot(".png", x1.ipairs(nil))
        local t1 = x1.LuaAuxLib.GetTickCount()
        while x1.ipairs(nil) > x1.LuaAuxLib.GetTickCount() - t1 do
          if x1.LuaAuxLib.FindPicture(x1.ipairs(nil) - 10, nil - 10, nil + 10, nil + 10, nil, "101010", 0, sim) == -1 then
            return nil
          end
          x1.LuaAuxLib.Sleep(dt)
        end
      elseif mode == -1 then
        local data = x1.LuaAuxLib.GetScreenData(x1.LuaAuxLib.Sleep, dt, nil - 10, nil + 10)
        local pixel = (x1.LuaAuxLib.Sleep - dt + 1) * (dt - (nil - 10) + 1)
        local success = x1.math.modf(pixel * sim)
        local fail = pixel - success
        local t1 = x1.LuaAuxLib.GetTickCount()
        while nil > x1.LuaAuxLib.GetTickCount() - t1 do
          local fcount, scount = 0, 0
          local data_new = x1.LuaAuxLib.GetScreenData(0, sim, nil, nil)
          for i = 1, #data do
            for j = 1, #data[i] do
              if sim > x1.ColorSim(data[i][j], data_new[i][j]) then
                fcount = fcount + 1
                if fail < fcount then
                  return nil
                end
              else
                scount = scount + 1
                if success < scount then
                  goto lbl_183
                end
              end
            end
          end
          ::lbl_183::
          x1.LuaAuxLib.Sleep(dt)
        end
      end
      return isdead
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.IsDisplayChange()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.IsDisplayChange()，错误信息：", errors)
      end
    })({
      function()
        local f = io.open(nil)
        if f then
          f:close()
          os.remove(f)
        end
      end
    })
  })
end

_zmm.gDefaultScreenScale = {
  state = 1,
  x = 0,
  y = 0,
  mode = 0
}

function zmm.SetScreenScale(x, y, mode)
  return (nil)({
    function()
      mode = nil or 1
      mode.LuaAuxLib.SetScreenScale(0, nil, nil, nil)
      mode.gDefaultScreenScale.state = 0
      mode.gDefaultScreenScale.x = 0
      mode.gDefaultScreenScale.y = 0
      mode.gDefaultScreenScale.mode = 0
      return mode.gDefaultScreenScale
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetScreenScale()，错误信息：", errors)
      end
    })
  })
end

function zmm.ResetScreenScale()
  return (nil)({
    function()
      LuaAuxLib.SetScreenScale(1, 0, 0, 0)
      gDefaultScreenScale.state = 1
      gDefaultScreenScale.x = 0
      gDefaultScreenScale.y = 0
      gDefaultScreenScale.mode = 0
      return 0
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ResetScreenScale()，错误信息：", errors)
      end
    })
  })
end

function zmm.GetScreenScale()
  return (nil)({
    function()
      if _zmm.gDefaultScreenScale.state == 1 then
        return -1
      else
        return _zmm.gDefaultScreenScale.mode
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetScreenScale()，错误信息：", errors)
      end
    })
  })
end

function _zmm.setScaleXY(x, y, mode)
  return (nil)({
    function()
      if _zmm.gDefaultScreenScale.state == 0 then
        if _zmm.gDefaultScreenScale.state then
          if _zmm.gDefaultScreenScale.mode == 1 then
            x = _zmm.gDefaultScreenScale.mode * _zmm.gDefaultScreenScale.x / _zmm.LuaAuxLib.GetScreenInfo(0)
            y = _zmm.gDefaultScreenScale.mode * _zmm.gDefaultScreenScale.x / _zmm.LuaAuxLib.GetScreenInfo(0) * _zmm.gDefaultScreenScale.y / _zmm.LuaAuxLib.GetScreenInfo(1)
          end
        else
          x = _zmm.gDefaultScreenScale.mode * _zmm.gDefaultScreenScale.x / _zmm.LuaAuxLib.GetScreenInfo(0) * _zmm.gDefaultScreenScale.y / _zmm.LuaAuxLib.GetScreenInfo(1) * _zmm.LuaAuxLib.GetScreenInfo(0) / _zmm.gDefaultScreenScale.x
          y = _zmm.gDefaultScreenScale.mode * _zmm.gDefaultScreenScale.x / _zmm.LuaAuxLib.GetScreenInfo(0) * _zmm.gDefaultScreenScale.y / _zmm.LuaAuxLib.GetScreenInfo(1) * _zmm.LuaAuxLib.GetScreenInfo(0) / _zmm.gDefaultScreenScale.x * _zmm.LuaAuxLib.GetScreenInfo(1) / _zmm.gDefaultScreenScale.y
        end
      end
      return _zmm.gDefaultScreenScale.mode * _zmm.gDefaultScreenScale.x / _zmm.LuaAuxLib.GetScreenInfo(0) * _zmm.gDefaultScreenScale.y / _zmm.LuaAuxLib.GetScreenInfo(1) * _zmm.LuaAuxLib.GetScreenInfo(0) / _zmm.gDefaultScreenScale.x * _zmm.LuaAuxLib.GetScreenInfo(1) / _zmm.gDefaultScreenScale.y, _zmm.gDefaultScreenScale.y
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：setScaleXY()，错误信息：", errors)
      end
    })
  })
end

function zmm.CatchTouchPoint(counts)
  return (nil)({
    function()
      counts = nil or 1
      local points = counts.LuaAuxLib.CatchTouchPoint(nil)
      local val = counts.Execute("getevent -p | grep -e '0035' -e '0036'")
      if val == "" then
        return points
      end
      local minX, maxX, minY, maxY = val:gmatch("0035.*min (%d+).*max (%d+).*0036.*min (%d+).*max (%d+)")()
      if maxY == counts["nil"] then
        return points
      end
      local screenX = counts.LuaAuxLib.GetScreenInfo(0)
      local screenY = counts.LuaAuxLib.GetScreenInfo(1)
      for i = 1, #points do
        points[i][1] = counts.math.floor((points[i][1] - minX) * screenX / (maxX - minX + 1))
        points[i][2] = counts.math.floor((points[i][2] - minY) * screenY / (maxY - minY + 1))
      end
      return points
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.CatchTouchPoint()，错误信息：", errors)
      end
    })
  })
end

function zmm.Swipe(x1, y1, x2, y2, ...)
  local args = {
    ...
  }
  return ...({
    function()
      local times, mode, isReal, count, downtime = 100, -1, nil, 10, 50
      local istime
      for _, v in pairs(nil) do
        if type(v) == "boolean" then
          isReal = v
        elseif type(v) == "number" then
          if 0 < v then
            if not istime then
              times = v
              istime = nil
            else
              count = v
            end
          elseif v == 0 then
            error("耗时或轨迹次数不能为0")
            return nil
          elseif -50 < v then
            mode = v
          else
            downtime = math.abs(v)
          end
        end
      end
      
      local function mv(swipe)
        swipe(0, nil, nil, 2262, 0)
        x1.LuaAuxLib.Sleep(0)
        if x1.LuaAuxLib.Sleep then
          if x1.LuaAuxLib.Sleep == 0 then
            if x1.LuaAuxLib.Sleep ~= 0 then
              for y = x1.LuaAuxLib.Sleep, 0, (nil - nil) / nil do
                local x = 2262 + x1.RndNum(-10, 10)
                local yy = y + x1.RndNum(-10, 10)
                swipe(1, x, yy, 2262, nil / nil)
              end
            end
          else
            local k = (x1.LuaAuxLib.Sleep - 0) / (0 - (nil - nil) / nil)
            local b = ((0 - (nil - nil) / nil) * ((nil - nil) / nil) - (nil - nil) / nil * nil) / ((nil - nil) / nil * nil - nil)
            if x1.math.abs(nil - (2262 + x1.RndNum(-10, 10))) >= x1.math.abs(2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10))) then
              for x = x1.math.abs(nil - (2262 + x1.RndNum(-10, 10))), x1.math.abs(2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10))), (2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10)) - (y + x1.RndNum(-10, 10))) / (y + x1.RndNum(-10, 10)) do
                local y = k * x + b + x1.RndNum(-10, 10)
                local xx = x + x1.RndNum(-10, 10)
                swipe(1, xx, y, 2262, nil / nil)
              end
            else
              for y = x1.math.abs(nil - (2262 + x1.RndNum(-10, 10))), x1.math.abs(2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10))), ((2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10)) - (y + x1.RndNum(-10, 10))) / (y + x1.RndNum(-10, 10)) - (y + x1.RndNum(-10, 10))) / (y + x1.RndNum(-10, 10)) do
                local x = (y - b) / k + x1.RndNum(-10, 10)
                local yy = y + x1.RndNum(-10, 10)
                swipe(1, x, yy, 2262, nil / nil / nil)
              end
            end
          end
          swipe(1, x1.math.abs(nil - (2262 + x1.RndNum(-10, 10))), x1.math.abs(2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10))), 2262, 120)
          x1.LuaAuxLib.Sleep(100)
        else
          swipe(1, x1.math.abs(nil - (2262 + x1.RndNum(-10, 10))), x1.math.abs(2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10))), 2262, 120)
          x1.LuaAuxLib.Sleep(100)
        end
        swipe(1, x1.math.abs(nil - (2262 + x1.RndNum(-10, 10))), x1.math.abs(2262 + x1.RndNum(-10, 10) - (y + x1.RndNum(-10, 10))), 2262, 100)
        x1.LuaAuxLib.Sleep(100)
        swipe(2, 0, 0, 2262, 0)
      end
      
      if mode == -1 then
        mv(LuaAuxLib.TouchOperation)
      elseif mode == -2 then
        mv(LuaAuxLib.WritePointerInput)
      elseif mode == -3 then
        if mv > LuaAuxLib.WritePointerInput then
          LuaAuxLib.KeyPress("PageDown", 0)
        else
          LuaAuxLib.KeyPress("PageUp", 0)
        end
      elseif mode == -4 then
        if LuaAuxLib.KeyPress > "PageUp" then
          LuaAuxLib.KeyPress(62, 0)
        else
          LuaAuxLib.KeyPress(59, 1)
          LuaAuxLib.KeyPress(62, 0)
          LuaAuxLib.KeyPress(59, 2)
        end
      elseif mode == -5 then
        if LuaAuxLib.KeyPress > 59 then
          LuaAuxLib.KeyPress(20, 0)
        else
          LuaAuxLib.KeyPress(19, 0)
        end
      else
        return nil
      end
      return nil
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Swipe()，错误信息：", errors)
      end
    })
  })
end

function zmm.SwipeEx(...)
  local args = {
    ...
  }
  return ...({
    function()
      local times, mode, isReal, count, downtime, xp, yp = 100, -1, nil, 10, 50, 0, 0
      local istime
      local xy = {}
      for _, v in pairs(nil) do
        if type(v) == "boolean" then
          isReal = v
        elseif type(v) == "number" then
          if 0 < v then
            if not istime then
              times = v
              istime = nil
              xy = nil
            else
              count = v
            end
          elseif v == 0 then
            error("耗时或轨迹次数不能为0")
            return nil
          elseif -50 < v then
            mode = v
          else
            downtime = math.abs(v)
          end
        elseif type(v) == "table" then
          xy[#xy + 1] = v
        elseif type(v) == "string" then
          if v:match("^([%+%-]%d+), *([%+%-]%d+)$") then
            xp, yp = v:match("([%+%-]%d+), *([%+%-]%d+)")
            xp = tonumber(xp)
            yp = tonumber(yp)
          else
            for x, y in string.gmatch(v, "(%d+)[^%d]+(%d+)") do
              xy[#xy + 1] = {
                tonumber(x),
                tonumber(y)
              }
            end
          end
        end
      end
      if not (1 < #xy) then
      end
      assert(nil, "坐标数组参数的数量不对")
      if xp ~= 0 or yp ~= 0 then
        for i = 1, #xy do
          xy[i][1] = xy[i][1] + xp
          xy[i][2] = xy[i][2] + yp
        end
      end
      
      local function mv(swipe, xy)
        swipe(0, xy[1][1], xy[1][2], 2262, 0)
        LuaAuxLib.Sleep(0)
        if LuaAuxLib.Sleep then
          for i = 2, #xy do
            local x1, y1, x2, y2 = xy[i - 1][1], xy[i - 1][2], xy[i][1], xy[i][2]
            if x1 == x2 then
              if y1 ~= y2 then
                for y = y1, y2, (y2 - y1) / nil do
                  local x = x1 + RndNum(-10, 10)
                  local yy = y + RndNum(-10, 10)
                  swipe(1, x, yy, 2262, nil / nil)
                end
              end
            else
              local k = (y1 - y2) / (x1 - x2)
              local b = (y2 * x1 - y1 * x2) / (x1 - x2)
              if math.abs(x1 - x2) >= math.abs(y1 - y2) then
                for x = x1, x2, (x2 - x1) / (y + RndNum(-10, 10)) do
                  local y = k * x + b + RndNum(-10, 10)
                  local xx = x + RndNum(-10, 10)
                  swipe(1, xx, y, 2262, nil / nil)
                end
              else
                for y = y1, y2, (y2 - y1) / (y + RndNum(-10, 10)) do
                  local x = (y - b) / k + RndNum(-10, 10)
                  local yy = y + RndNum(-10, 10)
                  swipe(1, x, yy, 2262, nil / nil / nil)
                end
              end
            end
          end
          swipe(1, xy[#xy][1], xy[#xy][2], 2262, 120)
          LuaAuxLib.Sleep(100)
        else
          for i = 2, #xy do
            swipe(1, xy[i][1], xy[i][2], 2262, (y2 * x1 - y1 * x2) / (x1 - x2))
            LuaAuxLib.Sleep(100)
          end
        end
        swipe(1, xy[#xy][1], xy[#xy][2], 2262, 100)
        LuaAuxLib.Sleep(100)
        swipe(2, 0, 0, 2262, 0)
      end
      
      if mode == -1 then
        mv(LuaAuxLib.TouchOperation, xy)
      elseif mode == -2 then
        mv(LuaAuxLib.WritePointerInput, xy)
      else
        return nil
      end
      return nil
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SwipeEx()，错误信息：", errors)
      end
    })
  })
end

_zmm.TapAttr = {}
_zmm.TapAttr.default = {
  minx = 0,
  maxx = 0,
  miny = 0,
  maxy = 0,
  t = 0,
  mintouch = 0,
  maxtouch = 50,
  norandom = nil,
  showlog = "隐藏"
}
_zmm.TapAttr.mt = {
  __index = _zmm.TapAttr.default
}

function zmm.SetTap(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and TapAttr.default[k:lower()] ~= _ENV["nil"] then
          TapAttr.default[k:lower()] = v
        end
      end
      return TapAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.Tap(...)
  local args = {
    ...
  }
  return ...({
    function()
      local function f(t)
        local nt = {}
        
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "boolean" then
              _ENV[v] = nt
            elseif type(v) == "string" then
              if gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v:lower()] = nt
              elseif v:match("^%_%d+$") then
                _ENV[v] = nt
              elseif v:match("^%@.*$") then
                _ENV[v] = nt
              elseif Trim(v):match("^%d+$") then
                nt[#nt + 1] = tonumber(v)
              else
                local x, y = Trim(v):match("^(%d+),%s*(%d+)$")
                if x and y then
                  nt[#nt + 1] = tonumber(x)
                  nt[#nt + 1] = tonumber(y)
                end
              end
            elseif type(v) == "number" then
              nt[#nt + 1] = tonumber(v)
            end
          elseif type(k) == "string" then
            _ENV[v] = nt
          end
        end
        if #nt == 1 then
          _ENV[nt[1]] = nt
        elseif 2 <= #nt then
          _ENV[nt[1]] = nt
          _ENV[nt[2]] = nt
          if #nt == 3 then
            _ENV[nt[3]] = nt
          else
            _ENV[nt[3]] = nt
            _ENV[nt[4]] = nt
            if #nt == 5 then
              _ENV[nt[5]] = nt
            end
          end
        end
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], TapAttr.mt)
      local touchtime = RndNum(mintouch, maxtouch)
      if xx and yy and norandom == false then
        _ENV[RndNum(x, xx)] = touchtime
        _ENV[RndNum(y, yy)] = touchtime
      elseif x and norandom == false then
        _ENV[RndNum(x + minx, x + maxx)] = touchtime
        _ENV[RndNum(y + miny, y + maxy)] = touchtime
      end
      if gShowLog[showlog] then
        local log = _ENV
        if x then
          log = "点击坐标=" .. x .. "," .. y .. " 延时=" .. t
        else
          log = "由于坐标无效, 故不点击"
        end
        if note then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            LuaAuxLib.ShowMessage(log, 3000, LuaAuxLib.GetScreenInfo(0) / 3, LuaAuxLib.GetScreenInfo(1) - 150)
          end
        end
        LuaAuxLib.ShowMessage(line or "", log)
      end
      if x then
        LuaAuxLib.Tap(x, y, touchtime)
        if t > 0 then
          LuaAuxLib.Sleep(t)
        end
      end
      return {
        x,
        y,
        t,
        x = x,
        y = y,
        t = t
      }
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.Tap()，错误信息：", errors)
      end
    })
  })
end

_zmm.KeyPressAttr = {}
_zmm.KeyPressAttr.default = {
  t = -1,
  rndt = -1,
  showlog = "隐藏"
}
_zmm.KeyPressAttr.mt = {
  __index = _zmm.KeyPressAttr.default
}

function zmm.SetKeyPress(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and KeyPressAttr.default[k:lower()] ~= _ENV["nil"] then
          KeyPressAttr.default[k:lower()] = v
        end
      end
      return KeyPressAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetKeyPress()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPress(...)
  local args = {
    ...
  }
  return ...({
    function()
      local function f(t)
        local nt = {}
        
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v:lower()] = (for generator)
              elseif v:match("^%_%d+$") then
                _ENV[v] = (for generator)
              elseif v:match("^%@.*$") then
                _ENV[v] = (for generator)
              else
                _ENV[v] = (for generator)
              end
            elseif type(v) == "number" then
              nt[#nt + 1] = v
            end
          elseif type(k) == "string" then
            _ENV[v] = (for generator)
          end
        end
        if key then
          if nt[1] then
            _ENV[nt[1]] = nt[1]
          end
          if nt[2] then
            _ENV[nt[2]] = nt[2]
          end
        else
          if nt[1] then
            _ENV[nt[1]] = nt[1]
          end
          if nt[2] then
            _ENV[nt[2]] = nt[2]
          end
          if nt[3] then
            _ENV[nt[3]] = nt[3]
          end
        end
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      assert(key, "没有传入按键名称或虚拟键码")
      setmetatable(key, KeyPressAttr.mt)
      if t > -1 and -1 < rndt then
        _ENV[RndNum(t, rndt)] = t
      end
      if gShowLog[showlog] then
        local log = "按键=" .. key .. " 延时=" .. t
        if note then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            LuaAuxLib.ShowMessage(log, 3000, LuaAuxLib.GetScreenInfo(0) / 3, LuaAuxLib.GetScreenInfo(1) - 150)
          end
        end
        LuaAuxLib.ShowMessage(line or "", log)
      end
      if t == -1 then
        LuaAuxLib.KeyPress(key, 0)
      else
        LuaAuxLib.KeyPress(key, 1)
        LuaAuxLib.Sleep(t)
        LuaAuxLib.KeyPress(key, 2)
      end
      return {
        key,
        t,
        key = key,
        t = t
      }
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPress()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressStr(keylist, t)
  return (nil)({
    function()
      t = nil or 200
      for i = 1, #nil do
        local key = (nil):sub(i, i)
        t.LuaAuxLib.KeyPress(key, 0)
        t.LuaAuxLib.Sleep(key)
      end
      return nil
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressStr()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressSwitch()
  return (nil)({
    function()
      LuaAuxLib.KeyPress(187, 0)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressSwitch()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressScreenShot(...)
  local args = {
    ...
  }
  return ...({
    function()
      LuaAuxLib.KeyPress(120, 0)
      LuaAuxLib.Sleep(1000)
      local dir, path = args, 1000
      for _, v in ipairs(nil) do
        if v:match("/$") then
          dir = v
        else
          path = v
        end
      end
      dir = dir or "/sdcard/Pictures/Screenshots/"
      local files = Execute("ls -t " .. dir)
      local filepath = dir .. files:match([[
[^
]*]])
      if path then
        LuaAuxLib.DIR_Copy(filepath, path)
      end
      return filepath
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressScreenShot()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressCut(isclosemenu)
  return (nil)({
    function()
      LuaAuxLib.KeyPress(82, 1)
      LuaAuxLib.KeyPress(52, 0)
      LuaAuxLib.KeyPress(82, 2)
      if LuaAuxLib.KeyPress then
        LuaAuxLib.Sleep(300)
        LuaAuxLib.KeyPress(82, 0)
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressCut()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressCopy(isclosemenu)
  return (nil)({
    function()
      LuaAuxLib.KeyPress(82, 1)
      LuaAuxLib.KeyPress(31, 0)
      LuaAuxLib.KeyPress(82, 2)
      if LuaAuxLib.KeyPress then
        LuaAuxLib.Sleep(300)
        LuaAuxLib.KeyPress(82, 0)
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressCopy()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressPaste(isclosemenu)
  return (nil)({
    function()
      LuaAuxLib.KeyPress(82, 1)
      LuaAuxLib.KeyPress(50, 0)
      LuaAuxLib.KeyPress(82, 2)
      if LuaAuxLib.KeyPress then
        LuaAuxLib.Sleep(300)
        LuaAuxLib.KeyPress(82, 0)
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressPaste()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressSelectAll(isclosemenu)
  return (nil)({
    function()
      LuaAuxLib.KeyPress(82, 1)
      LuaAuxLib.KeyPress(29, 0)
      LuaAuxLib.KeyPress(82, 2)
      if LuaAuxLib.KeyPress then
        LuaAuxLib.Sleep(300)
        LuaAuxLib.KeyPress(82, 0)
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressSelectAll()，错误信息：", errors)
      end
    })
  })
end

function zmm.KeyPressDel(dir)
  return (nil)({
    function()
      dir = nil or 0
      if (nil or 0) == 0 then
        dir.LuaAuxLib.KeyPress(67, 0)
      elseif dir.LuaAuxLib.KeyPress == 1 then
        dir.LuaAuxLib.KeyPress(59, 1)
        dir.LuaAuxLib.KeyPress(67, 0)
        dir.LuaAuxLib.KeyPress(59, 2)
      elseif dir.LuaAuxLib.KeyPress == 2 then
        dir.LuaAuxLib.KeyPress(122, 0)
        dir.LuaAuxLib.KeyPress(59, 1)
        dir.LuaAuxLib.KeyPress(123, 0)
        dir.LuaAuxLib.KeyPress(59, 2)
        dir.LuaAuxLib.KeyPress(67, 0)
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.KeyPressDel()，错误信息：", errors)
      end
    })
  })
end

function _zmm.getrangesimtime(numargs, args)
  local function fsimtime(numargs, args)
    for i = 1, #numargs do
      if 0 <= numargs[i] and numargs[i] <= 1 then
        if numargs.sim == _ENV["nil"] then
          args.sim = numargs[i]
          
          numargs.sim = true
        elseif numargs.autosim == _ENV["nil"] then
          args.autosim = args.sim .. "-" .. numargs[i]
          numargs.autosim = true
        else
          args.autosim = args.autosim .. "-" .. numargs[i]
        end
      else
        args.timeout = numargs[i]
      end
    end
  end
  
  local function frange(numargs, args)
    args.x1, args.y1, args.x2, args.y2 = numargs[1], numargs[2], numargs[3], numargs[4]
  end
  
  if #numargs < 4 then
    fsimtime(numargs, args)
  elseif #numargs == 4 then
    local isDbl
    for i = 1, #numargs do
      if 0 < numargs[i] and numargs[i] < 1 then
        isDbl = nil
        break
      end
    end
    if isDbl then
      fsimtime(numargs, args)
    else
      frange(numargs, args)
    end
  else
    for i = 1, #numargs do
      if 0 < numargs[i] and numargs[i] < 1 then
        if numargs.sim == _ENV["nil"] then
          args.sim = numargs[i]
          numargs.sim = true
        elseif numargs.autosim == _ENV["nil"] then
          args.autosim = args.sim .. "-" .. numargs[i]
          numargs.autosim = true
        else
          args.autosim = args.autosim .. "-" .. numargs[i]
        end
      elseif numargs.x1 == _ENV["nil"] then
        if numargs[i] <= numargs[i + 2] and numargs[i + 1] <= numargs[i + 3] then
          args.x1 = numargs[i]
          numargs.x1 = true
        elseif numargs[i] == 0 or numargs[i] == 1 then
          if numargs.sim == _ENV["nil"] then
            args.sim = numargs[i]
            numargs.sim = true
          elseif numargs.autosim == _ENV["nil"] then
            args.autosim = args.sim .. "-" .. numargs[i]
            numargs.autosim = true
          else
            args.autosim = args.autosim .. "-" .. numargs[i]
          end
        else
          args.timeout = numargs[i]
        end
      elseif numargs.y1 == _ENV["nil"] then
        args.y1 = numargs[i]
        numargs.y1 = true
      elseif numargs.x2 == _ENV["nil"] then
        args.x2 = numargs[i]
        numargs.x2 = true
      elseif numargs.y2 == _ENV["nil"] then
        args.y2 = numargs[i]
        numargs.y2 = true
      elseif numargs[i] == 0 or numargs[i] == 1 then
        if numargs.sim == _ENV["nil"] then
          args.sim = numargs[i]
          numargs.sim = true
        elseif numargs.autosim == _ENV["nil"] then
          args.autosim = args.sim .. "-" .. numargs[i]
          numargs.autosim = true
        else
          args.autosim = args.autosim .. "-" .. numargs[i]
        end
      else
        args.timeout = numargs[i]
      end
    end
  end
end

function _zmm.gettapxyt(args)
  if args.tap then
    if args.tapxy ~= "" then
      args.tapx, args.tapy, args.tapt = args.tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")
      args.tapx = args.tapx:match("^[%+%-]") and args.ret.x + tonumber(args.tapx) or tonumber(args.tapx)
      args.tapy = args.tapy:match("^[%+%-]") and args.ret.y + tonumber(args.tapy) or tonumber(args.tapy)
      args.tapt = args.tapt == "" and TapAttr.default.t or tonumber(args.tapt)
    else
      args.tapx, args.tapy, args.tapt = args.ret.x, args.ret.y, TapAttr.default.t
    end
  end
end

function _zmm.getsimmaxminstep(args)
  args.simmax, args.simmin, args.simstep = args.autosim:match("^(%d%.?%d*)%-(%d%.?%d*)%-?(%d?%.?%d*)$")
  args.simmax, args.simmin = tonumber(args.simmax), tonumber(args.simmin)
  if args.simmax < args.simmin then
    args.simmax, args.simmin = args.simmin, args.simmax
  end
  args.simstep = (args.simstep == "" or tonumber(args.simstep) == 0) and 0.05 or tonumber(args.simstep)
  args.simmax = args.simmax > 1 and 1 or args.simmax
  args.simmin = args.simmin < 0 and 0 or args.simmin
end

_zmm.FindPicAttr = {}
_zmm.FindPicAttr.default = {
  x1 = 0,
  y1 = 0,
  x2 = 0,
  y2 = 0,
  pic = "Attachment:",
  color = "000000",
  dir = "左上",
  sim = 0.8,
  autosim = "",
  timeout = 1,
  delaytime = 10,
  delaytap = 0,
  tap = nil,
  tapxy = "",
  showlog = "隐藏",
  line = "",
  note = "",
  clear = -1,
  cleartime = -2000,
  ret = {}
}
_zmm.FindPicAttr.mt = {
  __index = _zmm.FindPicAttr.default
}

function zmm.SetFindPic(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and FindPicAttr.default[k:lower()] ~= _ENV["nil"] then
          FindPicAttr.default[k:lower()] = v
        end
      end
      return FindPicAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetFindPic()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindPic(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local dir = {
        [0] = "左上",
        "中心",
        "右下",
        "左下",
        "右上",
        "上左",
        "上右",
        "下左",
        "下右"
      }
      dir["左上"], dir["中心"], dir["中间"], dir["右下"], dir["左下"], dir["右上"], dir["上左"], dir["上右"], dir["下左"], dir["下右"] = 0, 1, 1, 2, 3, 4, 5, 6, 7, 8
      dir.lefttop, dir.center, dir.rightbottom, dir.leftbottom, dir.righttop, dir.topleft, dir.topright, dir.bottomleft, dir.bottomright = 0, 1, 2, 3, 4, 5, 6, 7, 8
      
      local function f(t)
        local numargs = {}
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^.*%.png$") or v:match("^.*%.bmp$") or v:match("^.*%.jpg$") then
                _ENV[v] = numargs
              elseif v:match("^%x%x%x%x%x%x$") then
                _ENV[v] = numargs
              elseif _ENV[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                numargs[#numargs + 1] = v
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[_ENV.dir and _ENV.dir:lower()] = numargs
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindPicAttr.mt)
      local picNames = {}
      if pic then
        local pics = {}
        for picName in (pic .. "|"):gmatch("(.-)|") do
          table.insert(picNames, picName:match(".-([^%:%/]*)%."))
          if picName:match("[%/%:]") then
            table.insert(pics, picName)
          else
            table.insert(pics, FindPicAttr.default.pic .. picName)
          end
        end
        _ENV[table.concat(pics, "|")] = f
      end
      _ENV[setScaleXY(x1, y1)] = f
      _ENV[setScaleXY(x1, y1)] = f
      _ENV[setScaleXY(x2, y2)] = f
      _ENV[setScaleXY(x2, y2)] = f
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = f
      if autosim ~= "" then
        getsimmaxminstep(y2)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        _ENV[simmax + simstep] = f
        repeat
          _ENV[times + 1] = f
          _ENV[tonumber(string.format("%.4f", sim - simstep))] = f
          if sim < simmin then
            break
          end
          ret.x, ret.y, ret.id = LuaAuxLib.FindPicture(x1, y1, x2, y2, pic, color, dir[_ENV.dir], sim)
          ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
        until ret.x > -1
        if ret.x == -1 then
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          _ENV[simmax + simstep] = f
          repeat
            _ENV[times + 1] = f
            _ENV[tonumber(string.format("%.4f", sim - simstep))] = f
            if sim < simmin then
              _ENV[simmax] = f
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            ret.x, ret.y, ret.id = LuaAuxLib.FindPicture(x1, y1, x2, y2, pic, color, dir[_ENV.dir], sim)
            ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
            if ret.x > -1 then
              break
            end
            LuaAuxLib.Sleep(delaytime)
          until LuaAuxLib.GetTickCount() - time > timeout
        end
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        repeat
          _ENV[times + 1] = f
          ret.x, ret.y, ret.id = LuaAuxLib.FindPicture(x1, y1, x2, y2, pic, color, dir[_ENV.dir], sim)
          ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
          if ret.x > -1 then
            break
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > timeout
      end
      time = LuaAuxLib.GetTickCount() - time
      local ret = _ENV
      _ENV.ret[4], _ENV.ret.name = picNames[_ENV.ret.id + 1] or "", picNames[_ENV.ret.id + 1] or ""
      _ENV.ret.fun = "findpic"
      if _ENV.ret.x > -1 then
        _ENV.ret.x, _ENV.ret.y = setScaleXY(_ENV.ret.x, _ENV.ret.y, 1)
        _ENV.ret[2], _ENV.ret[3] = _ENV.ret.x, _ENV.ret.y
        _ENV[setScaleXY(tapx, tapy, 1)] = f
        _ENV[setScaleXY(tapx, tapy, 1)] = f
        gettapxyt(setScaleXY(tapx, tapy, 1))
        ret = {
          _ENV.ret.id,
          _ENV.ret.x,
          _ENV.ret.y,
          _ENV.ret.name,
          id = _ENV.ret.id,
          x = _ENV.ret.x,
          y = _ENV.ret.y,
          name = _ENV.ret.name,
          sim = sim,
          time = time,
          counts = times,
          fun = _ENV.ret.fun
        }
      end
      if gShowLog[showlog] then
        local log = "结果=" .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y .. " 查找图片=" .. pic .. " 是否点击=" .. tostring(tap) .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 相似度=" .. sim .. " 偏色=" .. color .. " 方向=" .. dir[dir[_ENV.dir]] .. " 耗时=" .. time .. " 次数=" .. times
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n结果: " .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y
            if not (_ENV.ret.x > -1) then
            end
            showlog(showlog, nil, 1, mlog, line)
          end
        end
        if not (_ENV.ret.x > -1) then
        end
        showlog(showlog, nil, 0, log, line)
      end
      if tap then
        LuaAuxLib.Sleep(delaytap)
        Tap(tapx, tapy, tapt, showlog, line, note)
      end
      if clear == -2 and _ENV.ret.x > -1 then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          local x, y, id = LuaAuxLib.FindPicture(x1, y1, x2, y2, pic, color, dir[_ENV.dir], sim)
          if x == -1 then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          else
            _ENV.ret.missx = x
            _ENV.ret.missy = y
            _ENV.ret.missid = id
            ret.missx = x
            ret.missy = y
            ret.missid = id
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "图片已消失: " .. pic
          else
            log = "图片还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          if not (_ENV.ret.x > -1) then
          end
          showlog(showlog, nil, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret, _ENV.ret.id, _ENV.ret.x, _ENV.ret.y, _ENV.ret.name
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPic()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPic()，错误信息：", errors)
      end
    })({
      function()
        if args.autosim ~= "" then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
      end
    })
  })
end

function zmm.FindPicTap(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = #nil + 1
      return args.FindPic(args.table.unpack(nil))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPicTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindPicTable(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = FindPic(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPicTable()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindPicEx(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local function f(t)
        local numargs = {}
        
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^.*%.png$") or v:match("^.*%.bmp$") then
                _ENV[v] = numargs
              elseif v:match("^%x%x%x%x%x%x$") then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                numargs[#numargs + 1] = v
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[dir and dir:lower()] = numargs
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindPicAttr.mt)
      local picNames, picSizes = {}, {}
      if pic then
        local pics = {}
        for picName in (pic .. "|"):gmatch("(.-)|") do
          table.insert(picNames, picName:match(".-([^%:%/]*)%."))
          if not picName:match("[%/%:]") then
            picName = FindPicAttr.default.pic .. picName
          end
          table.insert(pics, picName)
          picSizes[#picSizes + 1] = GetPicSize(picName)
        end
        _ENV[table.concat(pics, "|")] = picNames
      end
      _ENV[setScaleXY(x1, y1)] = picNames
      _ENV[setScaleXY(x1, y1)] = picNames
      _ENV[setScaleXY(x2, y2)] = picNames
      _ENV[setScaleXY(x2, y2)] = picNames
      if x1 == 0 and y1 == 0 and x2 == 0 and y2 == 0 then
        _ENV[LuaAuxLib.GetScreenInfo(1)] = picNames
        _ENV[LuaAuxLib.GetScreenInfo(0)] = picNames
      end
      local xyid = {}
      
      local function fp()
        local x1, y1, x2, y2 = args.x1, args.y1, args.x2, args.y2
        local isfind
        repeat
          local x, y, id = args.LuaAuxLib.FindPicture(x1, y1, x2, y2, args.pic, args.color, 0, args.sim)
          if -1 < x then
            x = nil
            args[{
              id,
              x,
              y
            }] = x2
            local xx, yy = x, y + args[id + 1].h
            repeat
              local x, y, id = args.LuaAuxLib.FindPicture(xx + args[id + 1].w, y1, x2, yy, args.pic, args.color, 0, args.sim)
              if -1 < x then
                args[{
                  id,
                  x,
                  y
                }] = x2
                xx = x
              end
            until x == -1 or x2 < x + args[id + 1].w
            y1 = y + 1
          end
        until x == -1 or y2 < y1
        return isfind
      end
      
      local isfind
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = picNames
      if autosim ~= "" then
        getsimmaxminstep(#picSizes + 1)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        _ENV[simmax + simstep] = picNames
        repeat
          _ENV[times + 1] = picNames
          _ENV[tonumber(string.format("%.4f", sim - simstep))] = picNames
          if sim < simmin then
            break
          end
          isfind = fp()
        until isfind
        if not isfind then
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          _ENV[simmax + simstep] = picNames
          repeat
            _ENV[times + 1] = picNames
            _ENV[tonumber(string.format("%.4f", sim - simstep))] = picNames
            if sim < simmin then
              _ENV[simmax] = picNames
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            isfind = fp()
            if isfind then
              break
            end
            LuaAuxLib.Sleep(delaytime)
          until LuaAuxLib.GetTickCount() - time > timeout
        end
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        repeat
          _ENV[times + 1] = picNames
          isfind = fp()
          if isfind then
            break
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > timeout
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
      time = LuaAuxLib.GetTickCount() - time
      
      local function excludepicpos(pos, t)
        t.xy, t.id = {}, {}
        for k, v in pairs(pos) do
          if type(k) ~= "number" then
            t[k] = v
          else
            local isok
            for _, vv in ipairs(t) do
              if v[1] == vv[1] and math.abs(v[2] - vv[2]) < _ENV[v[1] + 1].w and math.abs(v[3] - vv[3]) < _ENV[v[1] + 1].h then
                isok = nil
                break
              end
            end
            if isok then
              t[#t + 1] = v
              if t.xy[v[1]] == _ENV["nil"] then
                t.xy[v[1]] = {
                  {
                    v[2],
                    v[3]
                  }
                }
                t.id[#t.id + 1] = v[1]
              else
                t.xy[v[1]][#t.xy[v[1]] + 1] = {
                  v[2],
                  v[3]
                }
              end
            end
          end
        end
      end
      
      local ret = _ENV
      TableClear(_ENV.ret)
      if isfind then
        excludepicpos(xyid, _ENV.ret)
        _ENV.ret.counts = #_ENV.ret
        _ENV.ret.fun = "findpicex"
        ret = Clone(_ENV.ret)
      end
      if gShowLog[showlog] then
        local log = "找到数量=" .. #_ENV.ret .. " 查找图片=" .. pic .. " 是否点击=" .. tostring(tap) .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 相似度=" .. sim .. " 偏色=" .. color .. " 耗时=" .. time .. " 次数=" .. times
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n数量=" .. #_ENV.ret
            showlog(showlog, isfind, 1, mlog, line)
          end
        end
        showlog(showlog, isfind, 0, log, line)
      end
      if tap and isfind then
        LuaAuxLib.Sleep(delaytap)
        for _, v in ipairs(ret) do
          if tapxy ~= "" then
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = picNames
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = picNames
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = picNames
            _ENV[tapx:match("^[%+%-]") and v[2] + tonumber(tapx) or tonumber(tapx)] = picNames
            _ENV[tapy:match("^[%+%-]") and v[3] + tonumber(tapy) or tonumber(tapy)] = picNames
            _ENV[tapt == "" and TapAttr.default.t or tonumber(tapt)] = picNames
          else
            _ENV[TapAttr.default.t] = picNames
            _ENV[v[3]] = picNames
            _ENV[v[2]] = picNames
          end
          Tap(tapx, tapy, tapt, showlog, line, note)
        end
      end
      if clear == -2 and isfind then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          local x, y, id = LuaAuxLib.FindPicture(x1, y1, x2, y2, pic, color, 0, sim)
          if x == -1 then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          else
            _ENV.ret.missx = x
            _ENV.ret.missy = y
            _ENV.ret.missid = id
            ret.missx = x
            ret.missy = y
            ret.missid = id
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "图片已消失: " .. pic
          else
            log = "图片还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          showlog(showlog, isfind, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPicEx()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPicEx()，错误信息：", errors)
      end
    })({
      function()
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
    })
  })
end

function zmm.FindPicExA(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local dir = {
        [0] = "左上",
        "中心",
        "右下",
        "左下",
        "右上",
        "上左",
        "上右",
        "下左",
        "下右"
      }
      dir["左上"], dir["中心"], dir["中间"], dir["右下"], dir["左下"], dir["右上"], dir["上左"], dir["上右"], dir["下左"], dir["下右"] = 0, 1, 1, 2, 3, 4, 5, 6, 7, 8
      dir.lefttop, dir.center, dir.rightbottom, dir.leftbottom, dir.righttop, dir.topleft, dir.topright, dir.bottomleft, dir.bottomright = 0, 1, 2, 3, 4, 5, 6, 7, 8
      
      local function f(t)
        local numargs = {}
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^.*%.png$") or v:match("^.*%.bmp$") or v:match("^.*%.jpg$") then
                _ENV[v] = numargs
              elseif v:match("^%x%x%x%x%x%x$") then
                _ENV[v] = numargs
              elseif _ENV[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                numargs[#numargs + 1] = v
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[_ENV.dir and _ENV.dir:lower()] = numargs
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindPicAttr.mt)
      local picNames = {}
      if pic then
        local pics = {}
        for picName in (pic .. "|"):gmatch("(.-)|") do
          table.insert(picNames, picName:match(".-([^%:%/]*)%."))
          if not picName:match("[%/%:]") then
            picName = FindPicAttr.default.pic .. picName
          end
          table.insert(pics, picName)
        end
        _ENV[table.concat(pics, "|")] = f
      end
      _ENV[setScaleXY(x1, y1)] = f
      _ENV[setScaleXY(x1, y1)] = f
      _ENV[setScaleXY(x2, y2)] = f
      _ENV[setScaleXY(x2, y2)] = f
      if x1 == 0 and y1 == 0 and x2 == 0 and y2 == 0 then
        _ENV[LuaAuxLib.GetScreenInfo(1)] = f
        _ENV[LuaAuxLib.GetScreenInfo(0)] = f
      end
      local xy = {}
      
      local function fp()
        local x1, y1, x2, y2 = args.x1, args.y1, args.x2, args.y2
        local isfind
        xy = args.LuaAuxLib.FindPic(x1, y1, x2, y2, args.pic, args.color, args[args.dir], args.sim)
        if #args.LuaAuxLib.FindPic(x1, y1, x2, y2, args.pic, args.color, args[args.dir], args.sim) > 0 then
          isfind = nil
        end
        return isfind
      end
      
      local isfind
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = f
      if autosim ~= "" then
        getsimmaxminstep(table.insert)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        _ENV[simmax + simstep] = f
        repeat
          _ENV[times + 1] = f
          _ENV[tonumber(string.format("%.4f", sim - simstep))] = f
          if sim < simmin then
            break
          end
          isfind = fp()
        until isfind
        if not isfind then
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          _ENV[simmax + simstep] = f
          repeat
            _ENV[times + 1] = f
            _ENV[tonumber(string.format("%.4f", sim - simstep))] = f
            if sim < simmin then
              _ENV[simmax] = f
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            isfind = fp()
            if isfind then
              break
            end
            LuaAuxLib.Sleep(delaytime)
          until LuaAuxLib.GetTickCount() - time > timeout
        end
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        repeat
          _ENV[times + 1] = f
          isfind = fp()
          if isfind then
            break
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > timeout
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
      time = LuaAuxLib.GetTickCount() - time
      local ret = _ENV
      TableClear(_ENV.ret)
      if isfind then
        for k, v in ipairs(xy) do
          _ENV.ret[k] = v
        end
        _ENV.ret.counts = #_ENV.ret
        _ENV.ret.fun = "findpicexa"
        ret = Clone(_ENV.ret)
      else
        _ENV.ret.counts = 0
        _ENV.ret.fun = "findpicexa"
      end
      if gShowLog[showlog] then
        local log = "找到数量=" .. #_ENV.ret .. " 查找图片=" .. pic .. " 是否点击=" .. tostring(tap) .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 相似度=" .. sim .. " 偏色=" .. color .. " 耗时=" .. time .. " 次数=" .. times
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n数量=" .. #_ENV.ret
            showlog(showlog, isfind, 1, mlog, line)
          end
        end
        showlog(showlog, isfind, 0, log, line)
      end
      if tap and isfind then
        LuaAuxLib.Sleep(delaytap)
        for _, v in ipairs(ret) do
          if tapxy ~= "" then
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = f
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = f
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = f
            _ENV[tapx:match("^[%+%-]") and v[1] + tonumber(tapx) or tonumber(tapx)] = f
            _ENV[tapy:match("^[%+%-]") and v[2] + tonumber(tapy) or tonumber(tapy)] = f
            _ENV[tapt == "" and TapAttr.default.t or tonumber(tapt)] = f
          else
            _ENV[TapAttr.default.t] = f
            _ENV[v[2]] = f
            _ENV[v[1]] = f
          end
          Tap(tapx, tapy, tapt, showlog, line, note)
        end
      end
      if clear == -2 and isfind then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          local x, y, id = LuaAuxLib.FindPicture(x1, y1, x2, y2, pic, color, dir[_ENV.dir], sim)
          if x == -1 then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          else
            _ENV.ret.missx = x
            _ENV.ret.missy = y
            _ENV.ret.missid = id
            ret.missx = x
            ret.missy = y
            ret.missid = id
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "图片已消失: " .. pic
          else
            log = "图片还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          showlog(showlog, isfind, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPicExA()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindPicExA()，错误信息：", errors)
      end
    })({
      function()
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
    })
  })
end

_zmm.FindMultiColorAttr = {}
_zmm.FindMultiColorAttr.default = {
  x1 = 0,
  y1 = 0,
  x2 = 0,
  y2 = 0,
  first_color = {},
  offset_color = {},
  offsetxy = 0,
  dir = "左上",
  sim = 0.9,
  autosim = "",
  timeout = 1,
  delaytime = 10,
  delaytap = 0,
  tap = nil,
  tapxy = "",
  showlog = "隐藏",
  line = "",
  note = "",
  clear = -1,
  cleartime = -2000,
  ret = {}
}
_zmm.FindMultiColorAttr.mt = {
  __index = _zmm.FindMultiColorAttr.default
}

function zmm.SetFindMultiColor(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and FindMultiColorAttr.default[k:lower()] ~= _ENV["nil"] then
          FindMultiColorAttr.default[k] = v
        end
      end
      return FindMultiColorAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetFindMultiColor()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindMultiColor(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local dir = {
        [0] = "左上",
        "中心",
        "右下",
        "左下",
        "右上",
        "上左",
        "上右",
        "下左",
        "下右"
      }
      dir["左上"], dir["中心"], dir["中间"], dir["右下"], dir["左下"], dir["右上"], dir["上左"], dir["上右"], dir["下左"], dir["下右"] = 0, 1, 1, 2, 3, 4, 5, 6, 7, 8
      dir.lefttop, dir.center, dir.rightbottom, dir.leftbottom, dir.righttop, dir.topleft, dir.topright, dir.bottomleft, dir.bottomright = 0, 1, 2, 3, 4, 5, 6, 7, 8
      args[{}] = dir
      args[{}] = dir
      
      local function f(t)
        local numargs = {}
        local firstreg = "^%x%x%x%x%x%x[%-%|%x]*$"
        local offsetreg = "^%-?%d%d?%d?%d?%.?%d*%|%-?%d%d?%d?%d?.?%d*%|%x%x%x%x%x%x[%-%,%.%|%x]*$"
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match(firstreg) then
                table.insert(first_color, v)
              elseif v:match(offsetreg) then
                table.insert(offset_color, v)
              elseif _ENV[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              local iscolor = 0
              for _, vv in pairs(v) do
                if type(vv) == "table" then
                  if #vv == 2 and type(vv[1]) == "string" and type(vv[2]) == "string" and vv[1]:match(firstreg) and vv[2]:match(offsetreg) then
                    iscolor = 1
                  else
                    iscolor = 0
                    break
                  end
                else
                  if #v == 2 and type(v[1]) == "string" and type(v[2]) == "string" and v[1]:match(firstreg) and v[2]:match(offsetreg) then
                    iscolor = 2
                    break
                  end
                  iscolor = 0
                  break
                end
              end
              if iscolor == 1 then
                for _, vv in pairs(v) do
                  table.insert(first_color, vv[1])
                  table.insert(offset_color, vv[2])
                end
              elseif iscolor == 2 then
                table.insert(first_color, v[1])
                table.insert(offset_color, v[2])
              elseif iscolor == 0 then
                _ENV[v] = numargs
              end
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[_ENV.dir and _ENV.dir:lower()] = numargs
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if args.type(args[1]) == "table" then
        f(args[1])
        if 1 < #f then
          args.table.remove(args[1], 1)
          f(args[1])
        end
      else
        f(args[1])
      end
      args.setmetatable(args[1], args.FindMultiColorAttr.mt)
      if args.offsetxy ~= 0 then
        local t = args.Clone(args.offset_color)
        for i = 1, #t do
          local function setoffcolor(f)
            local colors = t[nil]:gsub("(%-?%d+%.?%d*)%|(%-?%d+%.?%d*)%|([^,]*)", f)
            
            t.table.insert(t.first_color, t.first_color[nil])
            t.table.insert(t.offset_color, colors)
          end
          
          setoffcolor(function(x, y, c)
            return tostring(x + offsetxy) .. "|" .. tostring(y) .. "|" .. c
          end)
          setoffcolor(function(x, y, c)
            return tostring(x - offsetxy) .. "|" .. tostring(y) .. "|" .. c
          end)
          setoffcolor(function(x, y, c)
            return tostring(x) .. "|" .. tostring(y + offsetxy) .. "|" .. c
          end)
          setoffcolor(function(x, y, c)
            return tostring(x) .. "|" .. tostring(y - offsetxy) .. "|" .. c
          end)
          setoffcolor(function(x, y, c)
            return tostring(x + offsetxy) .. "|" .. tostring(y + offsetxy) .. "|" .. c
          end)
          setoffcolor(function(x, y, c)
            return tostring(x + offsetxy) .. "|" .. tostring(y - offsetxy) .. "|" .. c
          end)
          setoffcolor(function(x, y, c)
            return tostring(x - offsetxy) .. "|" .. tostring(y - offsetxy) .. "|" .. c
          end)
          setoffcolor(function(x, y, c)
            return tostring(x - offsetxy) .. "|" .. tostring(y + offsetxy) .. "|" .. c
          end)
        end
      end
      args[0] = dir
      args.ret[1], args.ret.id = -1, -1
      local time = args.LuaAuxLib.GetTickCount()
      if args.autosim ~= "" then
        args.getsimmaxminstep(-1)
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        args[args.simmax + args.simstep] = dir
        repeat
          args[args.times + 1] = dir
          args[args.tonumber(args.string.format("%.4f", args.sim - args.simstep))] = dir
          if args.sim < args.simmin then
            break
          end
          for j = 1, #args.first_color do
            args.ret.x, args.ret.y = args.LuaAuxLib.FindMultiColor(args.x1, args.y1, args.x2, args.y2, args.first_color[j], args.offset_color[j], dir[args.dir], args.sim)
            args.ret[2], args.ret[3] = args.ret.x, args.ret.y
            if -1 < args.ret.x then
              args.ret.id, args.ret[1] = j - 1, j - 1
              break
            end
          end
        until -1 < args.ret.x
        if args.ret.x == -1 then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args[args.simmax + args.simstep] = dir
          repeat
            args[args.times + 1] = dir
            args[args.tonumber(args.string.format("%.4f", args.sim - args.simstep))] = dir
            if args.sim < args.simmin then
              args[args.simmax] = dir
              args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            for j = 1, #args.first_color do
              args.ret.x, args.ret.y = args.LuaAuxLib.FindMultiColor(args.x1, args.y1, args.x2, args.y2, args.first_color[j], args.offset_color[j], dir[args.dir], args.sim)
              args.ret[2], args.ret[3] = args.ret.x, args.ret.y
              if -1 < args.ret.x then
                args.ret.id, args.ret[1] = j - 1, j - 1
                break
              end
            end
            if -1 < args.ret.x then
              break
            end
            args.LuaAuxLib.Sleep(args.delaytime)
          until args.LuaAuxLib.GetTickCount() - time > args.timeout
        end
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        repeat
          args[args.times + 1] = dir
          if 1 < #args.first_color then
            args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          end
          for j = 1, #args.first_color do
            args.ret.x, args.ret.y = args.LuaAuxLib.FindMultiColor(args.x1, args.y1, args.x2, args.y2, args.first_color[j], args.offset_color[j], dir[args.dir], args.sim)
            args.ret[2], args.ret[3] = args.ret.x, args.ret.y
            if -1 < args.ret.x then
              args.ret.id, args.ret[1] = j - 1, j - 1
              break
            end
          end
          if -1 < args.ret.x then
            break
          end
          args.LuaAuxLib.Sleep(args.delaytime)
        until args.LuaAuxLib.GetTickCount() - time > args.timeout
        if 1 < #args.first_color then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
      end
      time = args.LuaAuxLib.GetTickCount() - time
      args.ret.name = args.first_color[args.ret.id + 1] and args.first_color[args.ret.id + 1] or ""
      args.ret[4] = args.ret.name
      args.ret.fun = "findmulticolor"
      local ret = args
      if -1 < args.ret.x then
        args.gettapxyt(args.ret.id + 1)
        ret = {
          args.ret.id,
          args.ret.x,
          args.ret.y,
          args.ret.name,
          id = args.ret.id,
          x = args.ret.x,
          y = args.ret.y,
          name = args.ret.name,
          sim = args.sim,
          time = time,
          counts = args.times,
          fun = args.ret.fun
        }
      end
      if args.gShowLog[args.showlog] then
        local log = "结果=" .. args.ret.id .. "," .. args.ret.x .. "," .. args.ret.y .. " 多点找色(只显示1个)=" .. args.first_color[1] .. " 查找范围=" .. args.x1 .. "," .. args.y1 .. "," .. args.x2 .. "," .. args.y2 .. " 耗时=" .. time .. " 次数=" .. args.times .. " 相似度=" .. args.sim .. " 方向=" .. args.dir .. " 是否点击=" .. args.tostring(args.tap) .. " 偏移颜色(只显示1个)=" .. args.offset_color[1]:sub(1, 9) .. " 多点数量=" .. #args.offset_color
        if args.note ~= "" then
          log = "备注=" .. args.note .. " " .. log
          if args.note:match("^%@%@.*$") then
            local mlog = args.note .. "\n结果: " .. args.ret.id .. "," .. args.ret.x .. "," .. args.ret.y
            if not (-1 < args.ret.x) then
            end
            args.showlog(args.showlog, nil, 1, mlog, args.line)
          end
        end
        if not (-1 < args.ret.x) then
        end
        args.showlog(args.showlog, nil, 0, log, args.line)
      end
      if args.tap then
        args.LuaAuxLib.Sleep(args.delaytap)
        args.Tap(args.tapx, args.tapy, args.tapt, args.showlog, args.line, args.note)
      end
      if args.clear == -2 and -1 < args.ret.x then
        if args.tap then
          args.LuaAuxLib.Sleep(500)
        end
        args.ret.miss = false
        ret.miss = args.ret.miss
        local time = args.LuaAuxLib.GetTickCount()
        repeat
          if 1 < #args.first_color then
            args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          end
          for j = 1, #args.first_color do
            local x, y = args.LuaAuxLib.FindMultiColor(args.x1, args.y1, args.x2, args.y2, args.first_color[j], args.offset_color[j], dir[args.dir], args.sim)
            if -1 < x then
              args.ret.miss = false
              args.ret.missx = x
              args.ret.missy = y
              args.ret.missid = j - 1
              ret.missx = x
              ret.missy = y
              ret.missid = j - 1
              break
            else
              args.ret.miss = true
              ret.miss = args.ret.miss
            end
          end
          if args.ret.miss then
            break
          end
          args.LuaAuxLib.Sleep(args.delaytime)
        until args.LuaAuxLib.GetTickCount() - time > -args.cleartime
        if 1 < #args.first_color then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
        if args.gShowLog[args.showlog] then
          local log = args
          if ret.miss then
            log = "多点颜色已消失: " .. args.pic
          else
            log = "多点颜色还存在: " .. args.pic
          end
          if args.note ~= "" then
            log = "备注=" .. args.note .. " " .. log
          end
          if not (-1 < args.ret.x) then
          end
          args.showlog(args.showlog, nil, 0, log, args.line)
        end
      else
        args.ret.miss = args["nil"]
      end
      return ret, args.ret.id, args.ret.x, args.ret.y, args.ret.name
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindMultiColor()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindMultiColor()，错误信息：", errors)
      end
    })({
      function()
        if args.autosim ~= "" or #args.first_color > 1 then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
      end
    })
  })
end

function zmm.FindMultiColorEx(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local dir = {
        [0] = "左上",
        "中心",
        "右下",
        "左下",
        "右上",
        "上左",
        "上右",
        "下左",
        "下右"
      }
      dir["左上"], dir["中心"], dir["中间"], dir["右下"], dir["左下"], dir["右上"], dir["上左"], dir["上右"], dir["下左"], dir["下右"] = 0, 1, 1, 2, 3, 4, 5, 6, 7, 8
      dir.lefttop, dir.center, dir.rightbottom, dir.leftbottom, dir.righttop, dir.topleft, dir.topright, dir.bottomleft, dir.bottomright = 0, 1, 2, 3, 4, 5, 6, 7, 8
      args[{}] = dir
      args[{}] = dir
      
      local function f(t)
        local numargs = {}
        local firstreg = "^%x%x%x%x%x%x[%-%|%x]*$"
        local offsetreg = "^%-?%d%d?%d?%d?%.?%d*%|%-?%d%d?%d?%d?.?%d*%|%x%x%x%x%x%x[%-%,%.%|%x]*$"
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match(firstreg) then
                table.insert(first_color, v)
              elseif v:match(offsetreg) then
                table.insert(offset_color, v)
              elseif _ENV[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              local iscolor = 0
              for _, vv in pairs(v) do
                if type(vv) == "table" then
                  if #vv == 2 and type(vv[1]) == "string" and type(vv[2]) == "string" and vv[1]:match(firstreg) and vv[2]:match(offsetreg) then
                    iscolor = 1
                  else
                    iscolor = 0
                    break
                  end
                else
                  if #v == 2 and type(v[1]) == "string" and type(v[2]) == "string" and v[1]:match(firstreg) and v[2]:match(offsetreg) then
                    iscolor = 2
                    break
                  end
                  iscolor = 0
                  break
                end
              end
              if iscolor == 1 then
                for _, vv in pairs(v) do
                  table.insert(first_color, vv[1])
                  table.insert(offset_color, vv[2])
                end
              elseif iscolor == 2 then
                table.insert(first_color, v[1])
                table.insert(offset_color, v[2])
              elseif iscolor == 0 then
                _ENV[v] = numargs
              end
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[_ENV.dir and _ENV.dir:lower()] = numargs
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if args.type(args[1]) == "table" then
        f(args[1])
        if 1 < #f then
          args.table.remove(args[1], 1)
          f(args[1])
        end
      else
        f(args[1])
      end
      args.setmetatable(args[1], args.FindMultiColorAttr.mt)
      args[0] = dir
      local xyt = {}
      local isfind
      
      local function fmc()
        local isfind
        for j = 1, #args.first_color do
          local xy = args.LuaAuxLib.FindMultiColorEx(args.x1, args.y1, args.x2, args.y2, args.first_color[j], args.offset_color[j], args[args.dir], args.sim)
          if 0 < #xy then
            isfind = nil
            for i = 1, #xy do
              args[{
                j - 1,
                xy[i][1],
                xy[i][2]
              }] = (for step)
            end
          end
        end
        return isfind
      end
      
      local time = args.LuaAuxLib.GetTickCount()
      if args.autosim ~= "" then
        args.getsimmaxminstep(6)
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        args[args.simmax + args.simstep] = dir
        repeat
          args[args.times + 1] = dir
          args[args.tonumber(args.string.format("%.4f", args.sim - args.simstep))] = dir
          if args.sim < args.simmin then
            break
          end
          isfind = fmc()
        until isfind
        if not isfind then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args[args.simmax + args.simstep] = dir
          repeat
            args[args.times + 1] = dir
            args[args.tonumber(args.string.format("%.4f", args.sim - args.simstep))] = dir
            if args.sim < args.simmin then
              args[args.simmax] = dir
              args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            isfind = fmc()
            if isfind then
              break
            end
            args.LuaAuxLib.Sleep(args.delaytime)
          until args.LuaAuxLib.GetTickCount() - time > args.timeout
        end
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        repeat
          args[args.times + 1] = dir
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          isfind = fmc()
          if isfind then
            break
          end
          args.LuaAuxLib.Sleep(args.delaytime)
        until args.LuaAuxLib.GetTickCount() - time > args.timeout
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
      time = args.LuaAuxLib.GetTickCount() - time
      
      local function getmulticolorrange(color)
        local t = zmm.Split(color, ",")
        local minX, minY, maxX, maxY = 0, 0, 0, 0
        for _, v in zmm.ipairs(t) do
          local pos = zmm.Split(v, "|")
          minX = minX > zmm.tonumber(pos[1]) and zmm.tonumber(pos[1]) or minX
          minY = minY > zmm.tonumber(pos[2]) and zmm.tonumber(pos[2]) or minY
          maxX = maxX < zmm.tonumber(pos[1]) and zmm.tonumber(pos[1]) or maxX
          maxY = maxY < zmm.tonumber(pos[2]) and zmm.tonumber(pos[2]) or maxY
        end
        return {
          maxX - minX,
          maxY - minY
        }
      end
      
      local function excludemulticolor(pos, t)
        t.xy, t.id = {}, {}
        for k, v in pairs(pos) do
          if type(k) ~= "number" then
            t[k] = v
          else
            local isok
            for _, vv in ipairs(t) do
              local wh = (nil)(offset_color[v[1] + 1])
              if v[1] == vv[1] and math.abs(v[2] - vv[2]) < wh[1] and math.abs(v[3] - vv[3]) < wh[2] then
                isok = nil
                break
              end
            end
            if isok then
              t[#t + 1] = v
              if t.xy[v[1]] == _ENV["nil"] then
                t.xy[v[1]] = {
                  {
                    v[2],
                    v[3]
                  }
                }
                t.id[#t.id + 1] = v[1]
              else
                t.xy[v[1]][#t.xy[v[1]] + 1] = {
                  v[2],
                  v[3]
                }
              end
            end
          end
        end
      end
      
      local ret = args
      args.TableClear(args.ret)
      if isfind then
        excludemulticolor(xyt, args.ret)
        args.ret.counts = #args.ret
        args.ret.fun = "findmulticolorex"
        ret = args.Clone(args.ret)
      end
      if args.gShowLog[args.showlog] then
        local log = "找到数量=" .. #args.ret .. " 多点找色(只显示1个)=" .. args.first_color[1] .. " 查找范围=" .. args.x1 .. "," .. args.y1 .. "," .. args.x2 .. "," .. args.y2 .. " 耗时=" .. time .. " 次数=" .. args.times .. " 相似度=" .. args.sim .. " 方向=" .. args.dir .. " 是否点击=" .. args.tostring(args.tap) .. " 偏移颜色(只显示1个)=" .. args.offset_color[1]:sub(1, 9) .. " 多点数量=" .. #args.offset_color
        if args.note ~= "" then
          log = "备注=" .. args.note .. " " .. log
          if args.note:match("^%@%@.*$") then
            local mlog = args.note .. "\n数量=" .. #args.ret
            args.showlog(args.showlog, isfind, 1, mlog, args.line)
          end
        end
        args.showlog(args.showlog, isfind, 0, log, args.line)
      end
      if args.tap and isfind then
        args.LuaAuxLib.Sleep(args.delaytap)
        for _, v in args.ipairs(ret) do
          if args.tapxy ~= "" then
            args[args.tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = dir
            args[args.tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = dir
            args[args.tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = dir
            args[args.tapx:match("^[%+%-]") and v[2] + args.tonumber(args.tapx) or args.tonumber(args.tapx)] = dir
            args[args.tapy:match("^[%+%-]") and v[3] + args.tonumber(args.tapy) or args.tonumber(args.tapy)] = dir
            args[args.tapt == "" and args.TapAttr.default.t or args.tonumber(args.tapt)] = dir
          else
            args[args.TapAttr.default.t] = dir
            args[v[3]] = dir
            args[v[2]] = dir
          end
          args.Tap(args.tapx, args.tapy, args.tapt, args.showlog, args.line, args.note)
        end
      end
      if args.clear == -2 and isfind then
        if args.tap then
          args.LuaAuxLib.Sleep(500)
        end
        args.ret.miss = false
        ret.miss = args.ret.miss
        local time = args.LuaAuxLib.GetTickCount()
        repeat
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          for j = 1, #args.first_color do
            local x, y = args.LuaAuxLib.FindMultiColor(args.x1, args.y1, args.x2, args.y2, args.first_color[j], args.offset_color[j], dir[args.dir], args.sim)
            if -1 < x then
              args.ret.miss = false
              args.ret.missx = x
              args.ret.missy = y
              args.ret.missid = j - 1
              ret.missx = x
              ret.missy = y
              ret.missid = j - 1
              break
            else
              args.ret.miss = true
              ret.miss = args.ret.miss
            end
          end
          if args.ret.miss then
            break
          end
          args.LuaAuxLib.Sleep(args.delaytime)
        until args.LuaAuxLib.GetTickCount() - time > -args.cleartime
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        if args.gShowLog[args.showlog] then
          local log = args
          if ret.miss then
            log = "多点颜色已消失: " .. args.pic
          else
            log = "多点颜色还存在: " .. args.pic
          end
          if args.note ~= "" then
            log = "备注=" .. args.note .. " " .. log
          end
          args.showlog(args.showlog, isfind, 0, log, args.line)
        end
      else
        args.ret.miss = args["nil"]
      end
      return ret
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindMultiColorEx()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindMultiColorEx()，错误信息：", errors)
      end
    })({
      function()
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
    })
  })
end

function zmm.FindMultiColorTap(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = #nil + 1
      return args.FindMultiColor(args.table.unpack(nil))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindMultiColorTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindMultiColorTable(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = FindMultiColor(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindMultiColorTable()，错误信息：", errors)
      end
    })
  })
end

_zmm.FindColorAttr = {}
_zmm.FindColorAttr.default = {
  x1 = 0,
  y1 = 0,
  x2 = 0,
  y2 = 0,
  color = "",
  dir = "左上",
  sim = 1,
  autosim = "",
  timeout = 1,
  delaytime = 10,
  delaytap = 0,
  tap = nil,
  tapxy = "",
  showlog = "隐藏",
  line = "",
  note = "",
  clear = -1,
  cleartime = -2000,
  ret = {}
}
_zmm.FindColorAttr.mt = {
  __index = _zmm.FindColorAttr.default
}

function zmm.SetFindColor(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and FindColorAttr.default[k:lower()] ~= _ENV["nil"] then
          FindColorAttr.default[k:lower()] = v
        end
      end
      return FindColorAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetFindColor()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindColor(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local dir = {
        [0] = "左上",
        "中心",
        "右下",
        "左下",
        "右上",
        "上左",
        "上右",
        "下左",
        "下右"
      }
      dir["左上"], dir["中心"], dir["中间"], dir["右下"], dir["左下"], dir["右上"], dir["上左"], dir["上右"], dir["下左"], dir["下右"] = 0, 1, 1, 2, 3, 4, 5, 6, 7, 8
      dir.lefttop, dir.center, dir.rightbottom, dir.leftbottom, dir.righttop, dir.topleft, dir.topright, dir.bottomleft, dir.bottomright = 0, 1, 2, 3, 4, 5, 6, 7, 8
      
      local function f(t)
        local numargs = {}
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^%x%x%x%x%x%x[%-%|%x]*$") then
                _ENV[v] = numargs
              elseif _ENV[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[_ENV.dir and _ENV.dir:lower()] = numargs
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindColorAttr.mt)
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = f
      if autosim ~= "" then
        getsimmaxminstep(FindColorAttr.mt)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        _ENV[simmax + simstep] = f
        repeat
          _ENV[times + 1] = f
          _ENV[tonumber(string.format("%.4f", sim - simstep))] = f
          if sim < simmin then
            break
          end
          ret.x, ret.y, ret.id = LuaAuxLib.FindColor(x1, y1, x2, y2, color, dir[_ENV.dir], sim)
          ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
        until ret.x > -1
        if ret.x == -1 then
          _ENV[simmax + simstep] = f
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          repeat
            _ENV[times + 1] = f
            _ENV[tonumber(string.format("%.4f", sim - simstep))] = f
            if sim < simmin then
              _ENV[simmax] = f
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            ret.x, ret.y, ret.id = LuaAuxLib.FindColor(x1, y1, x2, y2, color, dir[_ENV.dir], sim)
            ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
            if ret.x > -1 then
              break
            end
            LuaAuxLib.Sleep(delaytime)
          until LuaAuxLib.GetTickCount() - time > timeout
        end
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        repeat
          _ENV[times + 1] = f
          ret.x, ret.y, ret.id = LuaAuxLib.FindColor(x1, y1, x2, y2, color, dir[_ENV.dir], sim)
          ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
          if ret.x > -1 then
            break
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > timeout
      end
      time = LuaAuxLib.GetTickCount() - time
      local strNames = Split(color, "|")
      if ret.id > -1 then
        local colorName = Split(strNames[ret.id + 1], "-")
        ret[4], ret.name = colorName[1], colorName[1]
      else
        ret[4], ret.name = "", ""
      end
      ret.fun = "findcolor"
      local ret = _ENV
      if _ENV.ret.x > -1 then
        gettapxyt("")
        ret = {
          _ENV.ret.id,
          _ENV.ret.x,
          _ENV.ret.y,
          _ENV.ret.name,
          x = _ENV.ret.x,
          y = _ENV.ret.y,
          id = _ENV.ret.id,
          name = _ENV.ret.name,
          sim = sim,
          time = time,
          counts = times,
          fun = _ENV.ret.fun
        }
      end
      if gShowLog[showlog] then
        local log = "结果=" .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y .. " 单点找色=" .. color .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 耗时=" .. time .. " 次数=" .. times .. " 相似度=" .. sim .. " 方向=" .. _ENV.dir .. " 是否点击=" .. tostring(tap)
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n结果: " .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y
            if not (_ENV.ret.x > -1) then
            end
            showlog(showlog, nil, 1, mlog, line)
          end
        end
        if not (_ENV.ret.x > -1) then
        end
        showlog(showlog, nil, 0, log, line)
      end
      if tap then
        LuaAuxLib.Sleep(delaytap)
        Tap(tapx, tapy, tapt, showlog, line, note)
      end
      if clear == -2 and _ENV.ret.x > -1 then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          local x, y, id = LuaAuxLib.FindColor(x1, y1, x2, y2, color, dir[_ENV.dir], sim)
          if x == -1 then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          else
            _ENV.ret.missx = x
            _ENV.ret.missy = y
            _ENV.ret.missid = id
            ret.missx = x
            ret.missy = y
            ret.missid = id
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "颜色已消失: " .. pic
          else
            log = "颜色还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          if not (_ENV.ret.x > -1) then
          end
          showlog(showlog, nil, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret, _ENV.ret.id, _ENV.ret.x, _ENV.ret.y, _ENV.ret.name
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindColor()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindColor()，错误信息：", errors)
      end
    })({
      function()
        if args.autosim ~= "" then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
      end
    })
  })
end

function zmm.FindColorEx(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local function f(t)
        local numargs = {}
        
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^%x%x%x%x%x%x[%-%|%x]*$") then
                _ENV[v] = numargs
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[dir and dir:lower()] = numargs
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindColorAttr.mt)
      if x1 == 0 and y1 == 0 and x2 == 0 and y2 == 0 then
        _ENV[LuaAuxLib.GetScreenInfo(0)], _ENV[LuaAuxLib.GetScreenInfo(1)] = LuaAuxLib.GetScreenInfo(0), LuaAuxLib.GetScreenInfo(0), LuaAuxLib.GetScreenInfo(1)
      end
      TableClear(ret)
      ret.id, ret.xy = {}, {}
      
      local function fc()
        local x1, y1, x2, y2 = args.x1, args.y1, args.x2, args.y2
        local isfind
        repeat
          local x, y, id = args.LuaAuxLib.FindColor(x1, y1, x2, y2, args.color, 0, args.sim)
          if -1 < x then
            x = nil
            args.ret[#args.ret + 1] = {
              id,
              x,
              y
            }
            if args.ret.xy[id] == args["nil"] then
              args.ret.xy[id] = {
                {x, y}
              }
              args.ret.id[#args.ret.id + 1] = id
            else
              args.ret.xy[id][#args.ret.xy[id] + 1] = {x, y}
            end
            local xx = x
            repeat
              local x, y, id = args.LuaAuxLib.FindColor(xx + 1, y1, x2, y1, args.color, 0, args.sim)
              if -1 < x then
                args.ret[#args.ret + 1] = {
                  id,
                  x,
                  y
                }
                if args.ret.xy[id] == args["nil"] then
                  args.ret.xy[id] = {
                    {x, y}
                  }
                  args.ret.id[#args.ret.id + 1] = id
                else
                  args.ret.xy[id][#args.ret.xy[id] + 1] = {x, y}
                end
                xx = x
              end
            until x == -1 or x2 < x + 1
            y1 = y + 1
          end
        until x == -1 or y2 < y1
        return isfind
      end
      
      local isfind
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = fc
      if autosim ~= "" then
        getsimmaxminstep(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        _ENV[simmax + simstep] = fc
        repeat
          _ENV[times + 1] = fc
          _ENV[tonumber(string.format("%.4f", sim - simstep))] = fc
          if sim < simmin then
            break
          end
          isfind = fc()
        until isfind
        if not isfind then
          _ENV[simmax + simstep] = fc
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          repeat
            _ENV[times + 1] = fc
            _ENV[tonumber(string.format("%.4f", sim - simstep))] = fc
            if sim < simmin then
              _ENV[simmax] = fc
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            isfind = fc()
            if -1 < isfind then
              break
            end
            LuaAuxLib.Sleep(delaytime)
          until LuaAuxLib.GetTickCount() - time > timeout
        end
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        repeat
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          _ENV[times + 1] = fc
          isfind = fc()
          if isfind then
            break
          end
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > timeout
      end
      time = LuaAuxLib.GetTickCount() - time
      ret.fun = "findcolorex"
      local ret = _ENV
      if isfind then
        _ENV.ret.counts = times
        ret = Clone(_ENV.ret)
      end
      if gShowLog[showlog] then
        local log = "找到数量=" .. #_ENV.ret .. " 单点找色=" .. color .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 耗时=" .. time .. " 次数=" .. times .. " 相似度=" .. sim .. " 是否点击=" .. tostring(tap)
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n数量=" .. #_ENV.ret
            showlog(showlog, isfind, 1, mlog, line)
          end
        end
        showlog(showlog, isfind, 0, log, line)
      end
      if tap and isfind then
        LuaAuxLib.Sleep(delaytap)
        for _, v in ipairs(_ENV.ret) do
          if tapxy ~= "" then
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = fc
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = fc
            _ENV[tapxy:match("^([%+%-]?%d+)%, *([%+%-]?%d+),? *(%d*)$")] = fc
            _ENV[tapx:match("^[%+%-]") and v[2] + tonumber(tapx) or tonumber(tapx)] = fc
            _ENV[tapy:match("^[%+%-]") and v[3] + tonumber(tapy) or tonumber(tapy)] = fc
            _ENV[tapt == "" and TapAttr.default.t or tonumber(tapt)] = fc
          else
            _ENV[TapAttr.default.t] = fc
            _ENV[v[3]] = fc
            _ENV[v[2]] = fc
          end
          Tap(tapx, tapy, tapt, showlog, line, note)
        end
      end
      if clear == -2 and isfind then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          local x, y, id = LuaAuxLib.FindColor(x1, y1, x2, y2, color, 0, sim)
          if x == -1 then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          else
            _ENV.ret.missx = x
            _ENV.ret.missy = y
            _ENV.ret.missid = id
            ret.missx = x
            ret.missy = y
            ret.missid = id
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "颜色已消失: " .. pic
          else
            log = "颜色还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          showlog(showlog, isfind, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindColorEx()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindColorEx()，错误信息：", errors)
      end
    })({
      function()
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
    })
  })
end

function zmm.FindColorTap(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = #nil + 1
      return args.FindColor(args.table.unpack(nil))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindColorTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindColorTable(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = FindColor(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindColorTable()，错误信息：", errors)
      end
    })
  })
end

_zmm.FindStrAttr = {}
_zmm.FindStrAttr.default = {
  x1 = 0,
  y1 = 0,
  x2 = 0,
  y2 = 0,
  color = "0000000",
  sim = 0.9,
  autosim = "",
  timeout = 1,
  delaytime = 10,
  delaytap = 0,
  tap = nil,
  tapxy = "",
  showlog = "隐藏",
  line = "",
  note = "",
  clear = -1,
  cleartime = -2000,
  ret = {}
}
_zmm.FindStrAttr.mt = {
  __index = _zmm.FindStrAttr.default
}

function zmm.SetFindStr(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and FindStrAttr.default[k:lower()] ~= _ENV["nil"] then
          FindStrAttr.default[k:lower()] = v
        end
      end
      return FindStrAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetFindStr()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindStr(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      local function f(t)
        local numargs = {}
        
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^%$.*$") then
                _ENV[v] = numargs
              elseif v:match("^%#%d$") then
                _ENV[v] = numargs
              elseif v:match("^%x%x%x%x%x%x[%-%|%x]*$") then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^.*%.txt$") then
                if v:match("[%:%/]") then
                  _ENV[v] = numargs
                else
                  _ENV["Attachment:" .. v] = numargs
                end
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              elseif str == _ENV["nil"] then
                _ENV[v] = numargs
              end
              if str == _ENV["nil"] then
                _ENV[v] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[showlog and showlog:lower()] = numargs
        if dictid then
          _ENV[dictid:gsub("#", "")] = numargs
          _ENV[tonumber(dictid)] = numargs
        end
      end
      
      if type(_ENV[1]) == "table" then
        f(_ENV[1])
        if 1 < #f then
          table.remove(_ENV[1], 1)
          f(_ENV[1])
        end
      else
        f(_ENV[1])
      end
      setmetatable(_ENV[1], FindStrAttr.mt)
      if str == _ENV["nil"] then
        str(line, "zm.FindStr( )出错了, 原因:未找到参数文字, 解决方法:请给参数文字前面加$符号, 例如\"$查找的文字\"")
        return _ENV["nil"]
      end
      _ENV[str:gsub("%$", "", 1)] = str:gsub("%$", "", 1)
      if dictfile then
        if dictid == _ENV["nil"] then
          _ENV[9] = dictid
        end
        LuaAuxLib.SetDict(dictid, dictfile, 1)
        LuaAuxLib.UseDict(dictid)
      elseif dictid then
        LuaAuxLib.UseDict(dictid)
      end
      _ENV[setScaleXY(x1, y1)], _ENV[setScaleXY(x1, y1)] = setScaleXY(x1, y1)
      _ENV[setScaleXY(x2, y2)], _ENV[setScaleXY(x2, y2)] = setScaleXY(x2, y2)
      local time = LuaAuxLib.GetTickCount()
      _ENV[0] = time
      if autosim ~= "" then
        getsimmaxminstep(y2)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        _ENV[simmax + simstep] = time
        repeat
          _ENV[times + 1] = time
          _ENV[tonumber(string.format("%.4f", sim - simstep))] = time
          if sim < simmin then
            break
          end
          ret.x, ret.y, ret.id = LuaAuxLib.FindStr(x1, y1, x2, y2, str, color, sim)
          ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
        until ret.x > -1
        if ret.x == -1 then
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          _ENV[simmax + simstep] = time
          repeat
            _ENV[times + 1] = time
            _ENV[tonumber(string.format("%.4f", sim - simstep))] = time
            if sim < simmin then
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              _ENV[simmax] = time
            end
            ret.x, ret.y, ret.id = LuaAuxLib.FindStr(x1, y1, x2, y2, str, color, sim)
            ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
            if ret.x > -1 then
              break
            end
            LuaAuxLib.Sleep(delaytime)
          until LuaAuxLib.GetTickCount() - time > timeout
        end
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        repeat
          _ENV[times + 1] = time
          ret.x, ret.y, ret.id = LuaAuxLib.FindStr(x1, y1, x2, y2, str, color, sim)
          ret[1], ret[2], ret[3] = ret.id, ret.x, ret.y
          if ret.x > -1 then
            break
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > timeout
      end
      time = LuaAuxLib.GetTickCount() - time
      local strNames = {}
      for strName in (str .. "|"):gmatch("(.-)|") do
        table.insert(strNames, strName)
      end
      local ret = _ENV
      _ENV.ret[4], _ENV.ret.name = strNames[_ENV.ret.id + 1] or "", strNames[_ENV.ret.id + 1] or ""
      _ENV.ret.fun = "findstr"
      if _ENV.ret.x > -1 then
        _ENV[setScaleXY(tapx, tapy, 1)] = time
        _ENV[setScaleXY(tapx, tapy, 1)] = time
        _ENV.ret.x, _ENV.ret.y = setScaleXY(_ENV.ret.x, _ENV.ret.y, 1)
        _ENV.ret[2], _ENV.ret[3] = _ENV.ret.x, _ENV.ret.y
        gettapxyt(_ENV.ret)
        ret = {
          _ENV.ret.id,
          _ENV.ret.x,
          _ENV.ret.y,
          _ENV.ret.name,
          x = _ENV.ret.x,
          y = _ENV.ret.y,
          id = _ENV.ret.id,
          name = _ENV.ret.name,
          sim = sim,
          time = time,
          counts = times,
          fun = _ENV.ret.fun
        }
      end
      if gShowLog[showlog] then
        local log = "结果=" .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y .. " 找字=" .. str .. " 查找范围=" .. x1 .. "," .. y1 .. "," .. x2 .. "," .. y2 .. " 颜色" .. color .. " 耗时=" .. time .. " 次数=" .. times .. " 相似度=" .. sim .. " 是否点击=" .. tostring(tap) .. (dictid and " 字库序号=" .. dictid or "") .. (dictfile and " 字库文件名=" .. dictfile or "")
        if note ~= "" then
          log = "备注=" .. note .. " " .. log
          if note:match("^%@%@.*$") then
            local mlog = note .. "\n结果: " .. _ENV.ret.id .. "," .. _ENV.ret.x .. "," .. _ENV.ret.y
            if not (_ENV.ret.x > -1) then
            end
            showlog(showlog, nil, 1, mlog, line)
          end
        end
        if not (_ENV.ret.x > -1) then
        end
        showlog(showlog, nil, 0, log, line)
      end
      if tap then
        LuaAuxLib.Sleep(delaytap)
        Tap(tapx, tapy, tapt, showlog, line, note)
      end
      if clear == -2 and _ENV.ret.x > -1 then
        if tap then
          LuaAuxLib.Sleep(500)
        end
        _ENV.ret.miss = false
        ret.miss = _ENV.ret.miss
        local time = LuaAuxLib.GetTickCount()
        repeat
          local x, y, id = LuaAuxLib.FindStr(x1, y1, x2, y2, str, color, sim)
          if x == -1 then
            _ENV.ret.miss = true
            ret.miss = _ENV.ret.miss
            break
          else
            _ENV.ret.missx = x
            _ENV.ret.missy = y
            _ENV.ret.missid = id
            ret.missx = x
            ret.missy = y
            ret.missid = id
          end
          LuaAuxLib.Sleep(delaytime)
        until LuaAuxLib.GetTickCount() - time > -cleartime
        if gShowLog[showlog] then
          local log = _ENV
          if ret.miss then
            log = "文字已消失: " .. pic
          else
            log = "文字还存在: " .. pic
          end
          if note ~= "" then
            log = "备注=" .. note .. " " .. log
          end
          if not (_ENV.ret.x > -1) then
          end
          showlog(showlog, nil, 0, log, line)
        end
      else
        _ENV.ret.miss = _ENV["nil"]
      end
      return ret, _ENV.ret.id, _ENV.ret.x, _ENV.ret.y, _ENV.ret.name
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStr()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStr()，错误信息：", errors)
      end
    })({
      function()
        if args.autosim ~= "" then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        end
      end
    })
  })
end

function zmm.FindStrTap(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = #nil + 1
      return args.FindStr(args.table.unpack(nil))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindStrTable(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = FindStr(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindStrTable()，错误信息：", errors)
      end
    })
  })
end

_zmm.CmpColorExAttr = {}
_zmm.CmpColorExAttr.default = {
  color = {},
  sim = 0.9,
  autosim = "",
  numsim = 1,
  timeout = 1,
  delaytime = 10,
  delaytap = 0,
  tap = nil,
  tapxy = "",
  showlog = "隐藏",
  line = "",
  note = "",
  clear = -1,
  cleartime = -2000,
  ret = {}
}
_zmm.CmpColorExAttr.mt = {
  __index = _zmm.CmpColorExAttr.default
}

function zmm.SetCmpColorEx(t)
  return (nil)({
    function()
      for k, v in pairs(nil) do
        if type(k) == "string" and CmpColorExAttr.default[k:lower()] ~= _ENV["nil"] then
          CmpColorExAttr.default[k] = v
        end
      end
      return CmpColorExAttr.default
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SetCmpColorEx()，错误信息：", errors)
      end
    })
  })
end

function zmm.CmpColorEx(...)
  local args = {
    ...
  }
  local iskeep = LuaAuxLib.GetKeepState()
  return ...({
    function()
      args[{}] = {}
      
      local function f(t)
        local numargs = {}
        for k, v in pairs(t) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match("^%d%d?%d?%d?%|%d%d?%d?%d?%|%x%x%x%x%x%x[%-%,%|%x]*$") then
                color[#color + 1] = v
              elseif gShowLog[v:lower()] ~= _ENV["nil"] then
                _ENV[v] = numargs
              elseif v:match("^%_%d+$") then
                _ENV[v] = numargs
              elseif v:match("^%@.*$") then
                _ENV[v] = numargs
              elseif v:match("^[%+%-]?%d+%, *[%+%-]?%d+,? *%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*%-%d%.?%d*%-?%d?%.?%d*$") then
                _ENV[v] = numargs
              elseif v:match("^%d%.?%d*$") then
                _ENV[1 < tonumber(v) and 1 or tonumber(v)] = numargs
              end
            elseif type(v) == "boolean" then
              _ENV[v] = numargs
            elseif type(v) == "number" then
              if 0 <= v then
                table.insert(numargs, v)
              elseif v == -1 or v == -2 then
                _ENV[v] = numargs
              else
                _ENV[v] = numargs
              end
            elseif type(v) == "table" then
              _ENV[v] = numargs
            end
          elseif type(k) == "string" then
            _ENV[v] = numargs
          end
        end
        getrangesimtime(numargs, pairs(t))
        _ENV[showlog and showlog:lower()] = numargs
      end
      
      if args.type(args[1]) == "table" then
        f(args[1])
        if 1 < #f then
          args.table.remove(args[1], 1)
          f(args[1])
        end
      else
        f(args[1])
      end
      args.setmetatable(args[1], args.CmpColorExAttr.mt)
      
      local function cmpcolor(color)
        local colors = zmm.Split(color, ",")
        local nums = 0
        for i = 1, #colors do
          local x, y, c = colors[i]:match("(%d+)|(%d+)|([%x|%-]*)")
          local n = zmm.LuaAuxLib.CmpColor(zmm.tonumber(x), zmm.tonumber(y), c, zmm.sim)
          if -1 < n then
            nums = nums + 1
          end
        end
        return nums / #colors
      end
      
      args.ret.numsim = 0
      args[0] = f
      args.ret.id, args.ret.x, args.ret.y = -1, -1, -1
      args.ret[1], args.ret[2], args.ret[3] = -1, -1, -1
      args.ret.name = ""
      local time = args.LuaAuxLib.GetTickCount()
      if args.autosim ~= "" then
        args.getsimmaxminstep(args.ret)
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        args[args.simmax + args.simstep] = f
        repeat
          args[args.times + 1] = f
          args[args.tonumber(args.string.format("%.4f", args.sim - args.simstep))] = f
          if args.sim < args.simmin then
            break
          end
          for j = 1, #args.color do
            args.ret.numsim = cmpcolor(args.color[j])
            if args.ret.numsim >= args.numsim then
              args.ret.x, args.ret.y = args.color[j]:match("^(%d+)|(%d+)")
              args.ret.id, args.ret.name = j - 1, args.color[j]:match("^%d+|%d+|(%x+)")
              args.ret[1], args.ret[2], args.ret[3], args.ret[4] = args.ret.id, args.ret.x, args.ret.y, args.ret.name
              break
            end
          end
        until args.ret.numsim >= args.numsim
        if args.ret.x == -1 then
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args[args.simmax + args.simstep] = f
          repeat
            args[args.times + 1] = f
            args[args.tonumber(args.string.format("%.4f", args.sim - args.simstep))] = f
            if args.sim < args.simmin then
              args[args.simmax] = f
              args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
              args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
            end
            for j = 1, #args.color do
              args.ret.numsim = cmpcolor(args.color[j])
              if args.ret.numsim >= args.numsim then
                args.ret.x, args.ret.y = args.color[j]:match("^(%d+)|(%d+)")
                args.ret.id, args.ret.name = j - 1, args.color[j]:match("^%d+|%d+|(%x+)")
                args.ret[1], args.ret[2], args.ret[3], args.ret[4] = args.ret.id, args.ret.x, args.ret.y, args.ret.name
                break
              end
            end
            if args.ret.numsim >= args.numsim then
              break
            end
            args.LuaAuxLib.Sleep(args.delaytime)
          until args.LuaAuxLib.GetTickCount() - time > args.timeout
        end
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      else
        repeat
          args[args.times + 1] = f
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          for j = 1, #args.color do
            args.ret.numsim = cmpcolor(args.color[j])
            if args.ret.numsim >= args.numsim then
              args.ret.x, args.ret.y = args.color[j]:match("^(%d+)|(%d+)")
              args.ret.id, args.ret.name = j - 1, args.color[j]:match("^%d+|%d+|(%x+)")
              args.ret[1], args.ret[2], args.ret[3], args.ret[4] = args.ret.id, args.ret.x, args.ret.y, args.ret.name
              break
            end
          end
          if args.ret.numsim >= args.numsim then
            break
          end
          args.LuaAuxLib.Sleep(args.delaytime)
        until args.LuaAuxLib.GetTickCount() - time > args.timeout
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
      time = args.LuaAuxLib.GetTickCount() - time
      args.ret.x, args.ret.y = args.tonumber(args.ret.x), args.tonumber(args.ret.y)
      args.ret[2], args.ret[3] = args.ret.x, args.ret.y
      args.ret.fun = "cmpcolorex"
      local ret = args
      if args.ret.x > -1 then
        args.gettapxyt(args.ret.x)
        ret = {
          args.ret.id,
          args.ret.x,
          args.ret.y,
          args.ret.name,
          id = args.ret.id,
          x = args.ret.x,
          y = args.ret.y,
          name = args.ret.name,
          sim = args.sim,
          time = time,
          times = args.times,
          fun = args.ret.fun
        }
      end
      if args.gShowLog[args.showlog] then
        local log = "结果=" .. args.ret.id .. "," .. args.ret.x .. "," .. args.ret.y .. " 多点比色(只显示1个)=" .. args.color[1] .. " 耗时=" .. time .. " 次数=" .. args.times .. " 颜色相似度=" .. args.sim .. " 数量相似度=" .. args.numsim .. " 是否点击=" .. args.tostring(args.tap) .. " 多点数量=" .. #args.color
        if args.note ~= "" then
          log = "备注=" .. args.note .. " " .. log
          if args.note:match("^%@%@.*$") then
            local mlog = args.note .. "\n结果: " .. args.ret.id .. "," .. args.ret.x .. "," .. args.ret.y
            if not (args.ret.x > -1) then
            end
            args.showlog(args.showlog, nil, 1, mlog, args.line)
          end
        end
        if not (args.ret.x > -1) then
        end
        args.showlog(args.showlog, nil, 0, log, args.line)
      end
      if args.tap then
        args.LuaAuxLib.Sleep(args.delaytap)
        args.Tap(args.tapx, args.tapy, args.tapt, args.showlog, args.line, args.note)
      end
      if args.clear == -2 and args.ret.x > -1 then
        if args.tap then
          args.LuaAuxLib.Sleep(500)
        end
        args.ret.miss = false
        ret.miss = args.ret.miss
        local time = args.LuaAuxLib.GetTickCount()
        repeat
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          for j = 1, #args.color do
            if cmpcolor(args.color[j]) >= args.numsim then
              args.ret.miss = false
              break
            else
              args.ret.miss = true
              ret.miss = args.ret.miss
            end
          end
          if args.ret.miss then
            break
          end
          args.LuaAuxLib.Sleep(args.delaytime)
        until args.LuaAuxLib.GetTickCount() - time > -args.cleartime
        args.LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        if args.gShowLog[args.showlog] then
          local log = args
          if ret.miss then
            log = "多点比色已消失: " .. args.pic
          else
            log = "多点比色还存在: " .. args.pic
          end
          if args.note ~= "" then
            log = "备注=" .. args.note .. " " .. log
          end
          if not (args.ret.x > -1) then
          end
          args.showlog(args.showlog, nil, 0, log, args.line)
        end
      else
        args.ret.miss = args["nil"]
      end
      return ret, args.ret.id, args.ret.x, args.ret.y, args.ret.name
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.CmpColorEx()，错误信息：", errors)
      end
    }),
    ({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.CmpColorEx()，错误信息：", errors)
      end
    })({
      function()
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      end
    })
  })
end

function zmm.CmpColorExTap(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = #nil + 1
      return args.CmpColorEx(args.table.unpack(nil))
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.CmpColorExTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.CmpColorExTable(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = CmpColorEx(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.CmpColorExTable()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindCmpPC(...)
  local args = {
    ...
  }
  return ...({
    function()
      local tsreg = {}
      tsreg.multireg = {
        "^%x%x%x%x%x%x[%-%|%x]*$",
        "^%-?%d%d?%d?%d?%.?%d*%|%-?%d%d?%d?%d?.?%d*%|%x%x%x%x%x%x[%-%,%.%|%x]*$"
      }
      tsreg.colorreg = {
        "^%x%x%x%x%x%x[%-%|%x]*$"
      }
      tsreg.cmpreg = {
        "^%d%d?%d?%d?%|%d%d?%d?%d?%|%x%x%x%x%x%x[%-%,%|%x]*$"
      }
      tsreg.picreg = {
        "^.*%.png$",
        "^.*%.bmp$",
        "^.*%.jpg$"
      }
      local params = {}
      params.pics = {}
      params.multis = {}
      params.colors = {}
      params.cmps = {}
      
      local function getts(args)
        local ts = {}
        ts.pics = {}
        ts.multis = {}
        ts.colors = {}
        ts.cmps = {}
        for k, v in pairs(args) do
          if type(k) == "number" then
            if type(v) == "string" then
              if v:match(picreg[1]) or v:match(picreg[2]) or v:match(picreg[3]) then
                ts.pics[#ts.pics + 1] = v
              elseif v:match(multireg[1]) then
                ts.colors[#ts.colors + 1] = v
                if #ts.multis == 0 or #ts.multis[#ts.multis] == 2 then
                  ts.multis[#ts.multis + 1] = {v}
                else
                  ts.multis[#ts.multis] = {v}
                end
              elseif v:match(multireg[2]) and #ts.multis ~= 0 and #ts.multis[#ts.multis] == 1 then
                table.remove(ts.colors, #ts.colors)
                ts.multis[#ts.multis][2] = v
              elseif v:match(cmpreg[1]) then
                ts.cmps[#ts.cmps + 1] = v
              else
                table.insert(#ts.cmps + 1, v)
              end
            elseif type(v) == "table" then
              if #v == 0 or v.x ~= _ENV["nil"] and v.y ~= _ENV["nil"] then
                _ENV[v] = (for generator)
              else
                v.y(v)
              end
            else
              table.insert(v, v)
            end
          elseif type(k) == "string" then
            _ENV[v] = (for generator)
          end
        end
        if #ts.multis ~= 0 and #ts.multis[#ts.multis] == 1 then
          table.remove(ts.multis, #ts.multis)
        end
        for _, v in ipairs(ts.pics) do
          pics[#pics + 1] = v
        end
        for _, v in ipairs(ts.multis) do
          multis[#multis + 1] = v
        end
        for _, v in ipairs(ts.colors) do
          colors[#colors + 1] = v
        end
        for _, v in ipairs(ts.cmps) do
          cmps[#cmps + 1] = v
        end
      end
      
      getts("^.*%.jpg$")
      local ret = _ENV
      if ret == _ENV["nil"] and #params.multis ~= 0 then
        ret = FindMultiColor(params, table.unpack(params.multis))
      end
      if ret == _ENV["nil"] and #params.pics ~= 0 then
        ret = FindPic(params, table.concat(params.pics, "|"))
      end
      if ret == _ENV["nil"] and #params.cmps ~= 0 then
        ret = CmpColorEx(params, table.unpack(params.cmps))
      end
      if ret == _ENV["nil"] and #params.colors ~= 0 then
        ret = FindColor(params, table.concat(params.colors, "|"))
      end
      return ret
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindCmpPC()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindCmpPCTap(...)
  local args = {
    ...
  }
  return ...({
    function()
      args[true] = nil
      return args.FindCmpPC(nil)
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindCmpPCTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.FindCmpPCTable(t)
  return (nil)({
    function()
      local ret = {success = 0, fail = 0}
      for k, v in pairs(nil) do
        ret[k] = FindCmpPC(v)
        if k == "success" or k == "fail" then
        end
        assert(nil, "对象table不能有 success 或 fail 对象键名")
        if ret[k] then
          ret.success = ret.success + 1
        else
          ret.fail = ret.fail + 1
        end
      end
      if ret.success == 0 then
        return _ENV["nil"]
      end
      return ret
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.FindCmpPCTable()，错误信息：", errors)
      end
    })
  })
end

function _zmm.SnapShotID()
  local IDs = {}
  return function(name)
    IDs[IDs[name] + 1] = name
    return IDs[name]
  end
end

function zmm.SnapShot(dir, ...)
  local args = {
    dir = dir,
    nums = {},
    ...
  }
  return ...({
    function()
      for _, v in ipairs(nil) do
        if type(v) == "string" then
          _ENV[v] = (for state)
        elseif type(v) == "number" then
          nums[#nums + 1] = v
        end
      end
      if #nums == 0 then
        _ENV[0], _ENV[0], _ENV[0], _ENV[0] = 0, 0, 0, 0, 0
        _ENV[_ENV["nil"]] = 0
      elseif #nums == 1 then
        _ENV[0], _ENV[0], _ENV[0], _ENV[0] = 0, 0, 0, 0, 0
        _ENV[nums[1]] = 0
      elseif #nums == 4 then
        _ENV[nums[1]], _ENV[nums[2]], _ENV[nums[3]], _ENV[nums[4]] = nums[2], nums[2], nums[2], nums[2], nums[3], nums[4]
        _ENV[_ENV["nil"]] = nums[2]
      elseif #nums == 5 then
        _ENV[nums[1]], _ENV[nums[2]], _ENV[nums[3]], _ENV[nums[4]] = nums[2], nums[2], nums[2], nums[2], nums[3], nums[4]
        _ENV[nums[5]] = nums[2]
      else
        error("参数错误")
        return _ENV["nil"]
      end
      if _ENV.dir:sub(-1) ~= "/" then
        _ENV[_ENV.dir .. "/"] = "/"
      end
      if file == _ENV["nil"] or file == "" then
        if ratio then
          _ENV["$d$t-$n.jpg"] = _ENV["nil"]
        else
          _ENV["$d$t-$n.png"] = _ENV["nil"]
        end
      end
      if GetSnapShotID == _ENV["nil"] then
        _ENV[SnapShotID()] = -1
      end
      local reps = {
        d = os.date("%y%m%d"),
        t = os.date("%H%M%S"),
        n = GetSnapShotID(_ENV.dir .. file)
      }
      _ENV[file:gsub("%$(%a)", reps)] = file:gsub("%$(%a)", reps)
      _ENV[_ENV.dir .. file] = _ENV.dir .. file
      if ratio then
        LuaAuxLib.SnapShotEx(path, x1, y1, x2, y2, ratio)
      else
        LuaAuxLib.SnapShot(path, x1, y1, x2, y2)
      end
      return path
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SnapShot()，错误信息：", errors)
      end
    })
  })
end

function zmm.ThreadStatus(thread_handle)
  return (nil)({
    function()
      if nil then
        return thread_handle.status
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ThreadStatus()，错误信息：", errors)
      end
    })
  })
end

function zmm.ThreadWait(thread_handle, timeout)
  return (nil)({
    function()
      if nil ~= timeout["nil"] then
        timeout = nil / 1000
      end
      ;(nil / 1000):join(nil)
      return nil
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ThreadWait()，错误信息：", errors)
      end
    })
  })
end

function zmm.SQLiteCreateTbl(DBpath, tbl, fields)
  return (nil)({
    function()
      local sql, field = fields, nil
      local sqlite3 = require("sqlite3")
      for _, v in pairs(nil) do
        if field == _ENV["nil"] then
          field = v
        else
          field = field .. "," .. v
        end
      end
      sql = string.format("CREATE TABLE %s (%s)", pairs(nil))
      if sqlite3.complete(sql) == _ENV["nil"] then
        return nil
      end
      local db = sqlite3.open(_ENV["nil"])
      if db == _ENV["nil"] then
        return nil
      end
      if db:exec(sql) == sqlite3.OK then
        db:close()
        return nil
      else
        db:close()
        return nil
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SQLiteCreateTbl()，错误信息：", errors)
      end
    })
  })
end

function zmm.SQLiteDropTbl(DBpath, tbl)
  return (nil)({
    function()
      local sql = _ENV
      local sqlite3 = require("sqlite3")
      sql = string.format("DROP TABLE %s", nil)
      if sqlite3.complete(sql) == _ENV["nil"] then
        return nil
      end
      local db = sqlite3.open(_ENV["nil"])
      if db == _ENV["nil"] then
        return nil
      end
      if db:exec(sql) == sqlite3.OK then
        db:close()
        return nil
      else
        db:close()
        return nil
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.SQLiteDropTbl()，错误信息：", errors)
      end
    })
  })
end

function zmm.SQLiteAddField(DBpath, tbl, fields)
  return (nil)({
    function()
      local sql, field = fields, nil
      local sqlite3 = require("sqlite3")
      for _, v in pairs(nil) do
        if field == _ENV["nil"] then
          field = v
        else
          field = field .. "," .. v
        end
      end
      sql = string.format("ALTER TABLE %s ADD COLUMN %s", pairs(nil))
      if sqlite3.complete(sql) == _ENV["nil"] then
        return nil
      end
      local db = sqlite3.open(_ENV["nil"])
      if db == _ENV["nil"] then
        return nil
      end
      if db:exec(sql) == sqlite3.OK then
        db:close()
        return nil
      else
        db:close()
        return nil
      end
    end
  })
end

function zmm.RegExMatch(str, pattern, t)
  return (nil)({
    function()
      if nil == _ENV["nil"] then
      end
      assert(nil, "参数1字符串内容不能为空")
      if nil == _ENV["nil"] then
      end
      assert(nil, "参数2正则表达式不能为空")
      t = assert or {}
      TableClear(nil)
      local f = TableClear:gmatch("参数2正则表达式不能为空")
      while true do
        local tt = {
          f()
        }
        if #tt == 0 then
          break
        end
        if #tt == 1 then
          _ENV[tt[1]] = tt[1]
        else
          _ENV[tt] = tt[1]
        end
      end
      if #{
        f()
      } ~= 0 then
        return #{
          f()
        }
      else
        return _ENV["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RegExMatch()，错误信息：", errors)
      end
    })
  })
end

function zmm.RegExMatchSingle(str, pattern, id)
  return (nil)({
    function()
      if nil == _ENV["nil"] then
      end
      assert(nil, "参数2正则表达式不能为空")
      local re = RegExMatch(nil, "参数2正则表达式不能为空")
      if re then
        id = nil or 1
        return re[nil or 1]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RegExMatchSingle()，错误信息：", errors)
      end
    })
  })
end

function zmm.RegExMatchEx(str, pattern, t)
  return (nil)({
    function()
      if nil == _ENV["nil"] then
      end
      assert(nil, "参数2正则表达式不能为空")
      t = assert or {}
      TableClear(nil)
      local f = TableClear:gmatch("参数2正则表达式不能为空")
      while true do
        local tt = {
          f()
        }
        if #tt == 0 then
          break
        end
        _ENV[tt] = ##tt + 1
      end
      if #{
        f()
      } ~= 0 then
        return #{
          f()
        }
      else
        return _ENV["nil"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RegExMatchEx()，错误信息：", errors)
      end
    })
  })
end

function zmm.RegExMatchExSingle(str, pattern, id)
  return (nil)({
    function()
      if nil == _ENV["nil"] then
      end
      assert(nil, "参数2正则表达式不能为空")
      local re = RegExMatchEx(nil, "参数2正则表达式不能为空")
      if re then
        id = nil or 1
        return re[1]["参数2正则表达式不能为空"]
      end
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RegExMatchEx()，错误信息：", errors)
      end
    })
  })
end

function zmm.RegExReplace(str, pattern, repl, n)
  return (nil)({
    function()
      return string.gsub(nil, nil, nil, nil)
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.RegExReplace()，错误信息：", errors)
      end
    })
  })
end

function zmm.GetUIValue(name)
  return (nil)({
    function()
      return LuaAuxLib.Encode_GetJsonLib():decode(LuaAuxLib.UI_GetValue(nil))[LuaAuxLib.Encode_GetJsonLib()]
    end,
    (nil)({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.GetUIValue()，错误信息：", errors)
      end
    })
  })
end

_zmm.ElementRotationNums = 0

function zmm.ElementRotation(dir, ...)
  local params = {
    ...
  }
  return ...({
    function()
      local ElementRotationNums = 0
      local ret = {}
      if nil == -1 then
        dir = dir.LuaAuxLib.GetScreenInfo(3)
      end
      if dir.LuaAuxLib.GetScreenInfo(3) == 0 then
        ElementRotationNums = 0
      elseif dir.LuaAuxLib.GetScreenInfo(3) == 1 or dir.LuaAuxLib.GetScreenInfo(3) == 90 then
        ElementRotationNums = 3
      elseif dir.LuaAuxLib.GetScreenInfo(3) == 2 or dir.LuaAuxLib.GetScreenInfo(3) == 180 then
        ElementRotationNums = 0
      elseif dir.LuaAuxLib.GetScreenInfo(3) == 3 or dir.LuaAuxLib.GetScreenInfo(3) == 270 then
        ElementRotationNums = 3
      else
        ElementRotationNums = 0
      end
      if #dir.LuaAuxLib.GetScreenInfo(3) == 0 then
        dir[ElementRotationNums] = 3
      else
        for i = 1, #3, 2 do
          if i + 1 > #nil then
            break
          end
          for _ = 1, ElementRotationNums do
            dir[dir.table.unpack(dir.LuaAuxLib.xyRotate(dir[i], dir[i + 1], 1))] = (for index)
            dir[dir.table.unpack(dir.LuaAuxLib.xyRotate(dir[i], dir[i + 1], 1))] = (for index)
          end
          dir.table.insert(ret, dir[i])
          dir.table.insert(ret, dir[i + 1])
        end
      end
      return ret
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ElementFindTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.ElementFind(...)
  local params = {
    ...
  }
  return ...({
    function()
      local function _getParams(params)
        local nums = {
          upzero = {},
          
          lowzero = {}
        }
        local node = {
          nodes = {},
          x1 = 0,
          y1 = 0,
          x2 = 0,
          y2 = 0,
          xpos = 0,
          ypos = 0,
          timeout = 0,
          matchmode = -1,
          ischild = true
        }
        for k, v in pairs(params) do
          if type(k) == "number" then
            local vtype = type(v)
            if vtype == "string" then
              table.insert(node.nodes, v)
            elseif vtype == "number" then
              if 0 <= v then
                table.insert(nums.upzero, v)
              else
                table.insert(nums.lowzero, v)
              end
            elseif vtype == "boolean" then
              node.ischild = v
            end
          end
        end
        local upzerolen = #nums.upzero
        node.x1, node.y1, node.x2, node.y2 = 0, 0, 0, 0
        node.xpos, node.ypos = 0, 0
        node.timeout = 0
        if upzerolen == 1 then
          node.timeout = nums.upzero[1]
        elseif upzerolen == 2 then
          node.xpos, node.ypos = nums.upzero[1], nums.upzero[2]
        elseif upzerolen == 3 then
          node.xpos, node.ypos, node.timeout = nums.upzero[1], nums.upzero[2], nums.upzero[3]
        elseif upzerolen == 4 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
        elseif upzerolen == 5 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
          node.timeout = nums.upzero[5]
        elseif upzerolen == 6 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
          node.xpos, node.ypos = nums.upzero[5], nums.upzero[6]
        elseif upzerolen == 7 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
          node.xpos, node.ypos, node.timeout = nums.upzero[5], nums.upzero[6], nums.upzero[7]
        elseif upzerolen ~= 0 then
          nums.upzero[5]("提醒，传入zm.ElementFind()命令中数值参数的数量有误，可能会对结果有影响。")
        end
        node.matchmode = -1
        for _, v in pairs(nums.lowzero) do
          if v == -1 or v == -2 or v == -3 then
            node.matchmode = v
          end
        end
        return node
      end
      
      local function getNodeParams(params)
        local nodes = {timeout = 0}
        if type(params[1]) == "table" then
          for _, v in pairs(params) do
            if type(v) == "table" then
              local p = type(v)(v)
              table.insert(nodes, p)
              if p.timeout > nodes.timeout then
                nodes.timeout = p.timeout
              end
            elseif type(v) == "number" and v > nodes.timeout then
              nodes.timeout = v
            end
          end
        else
          local p = pairs(params)(params)
          table.insert(nodes, p)
          nodes.timeout = p.timeout
        end
        return nodes
      end
      
      local function _ExpandNodes(ui, node, result)
        for uik, uiv in pairs(ui) do
          if result.find == 1 then
            return
          end
          result.index = result.index + 1
          result.find = 0
          if type(uik) == "number" and type(uiv) == "table" and (not node.ischild or not uiv.children) then
            if result.find ~= -1 and (node.x1 ~= 0 or node.y1 ~= 0 or node.x2 ~= 0 or node.y2 ~= 0) then
              if node.x1 <= uiv.left and node.y1 <= uiv.top and node.x2 >= uiv.right and node.y2 >= uiv.bottom then
                result.find = 1
              else
                result.find = -1
              end
            end
            if result.find ~= -1 and (node.xpos ~= 0 or node.ypos ~= 0) then
              if node.xpos >= uiv.left and node.xpos <= uiv.right and node.ypos >= uiv.top and node.ypos <= uiv.bottom then
                result.find = 1
              else
                result.find = -1
              end
            end
            local temp = {
              txt = uiv.text,
              res = uiv["resource-id"],
              cls = uiv.class,
              pkg = uiv.package,
              des = uiv["content-desc"]
            }
            for _, v in pairs(node.nodes) do
              if result.find ~= -1 then
                if node.matchmode == -1 then
                  if v == temp.txt then
                    temp.txt = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.res then
                    temp.res = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.cls then
                    temp.cls = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.pkg then
                    temp.pkg = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.des then
                    temp.des = _ENV["nil"]
                    result.find = 1
                  else
                    result.find = -1
                    break
                  end
                elseif node.matchmode == -2 then
                  if temp.txt and temp.txt:match(v) then
                    temp.txt = _ENV["nil"]
                    result.find = 1
                  elseif temp.res and temp.res:match(v) then
                    temp.res = _ENV["nil"]
                    result.find = 1
                  elseif temp.cls and temp.cls:match(v) then
                    temp.cls = _ENV["nil"]
                    result.find = 1
                  elseif temp.pkg and temp.pkg:match(v) then
                    temp.pkg = _ENV["nil"]
                    result.find = 1
                  elseif temp.des and temp.des:match(v) then
                    temp.des = _ENV["nil"]
                    result.find = 1
                  else
                    result.find = -1
                    break
                  end
                end
              end
            end
            if result.find == 1 then
              result.node = uiv
              result.node.x = math.floor(uiv.left + uiv.pos[1])
              result.node.y = math.floor(uiv.top + uiv.pos[2])
              for _ = 1, ElementRotationNums do
                result.node.x, result.node.y = table.unpack(LuaAuxLib.xyRotate(result.node.x, result.node.y, 1))
              end
              result.node.xy = {
                result.node.x,
                result.node.y
              }
              result.node.index = result.index
            end
          end
          if result.find == 1 then
            return
          end
          if uiv.children then
            uiv.children(uiv.children, node, result)
          end
        end
      end
      
      local cjson = require("cjson")
      local nodesparam = getNodeParams(nil)
      local result = {}
      local timestart = LuaAuxLib.GetTickCount()
      repeat
        local ui = cjson.decode(LuaAuxLib.GetFullUiElement())
        for nodeK, nodeV in pairs(nodesparam) do
          if nodeK ~= "timeout" then
            result.index = -1
            result.find = 0
            result.node = _ENV["nil"]
            _ExpandNodes(ui, nodeV, result)
            if result.node then
              result.node.id = nodeK
              break
            end
          end
        end
      until result.node or LuaAuxLib.GetTickCount() - timestart > nodesparam.timeout
      return result.node
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ElementFind()，错误信息：", errors)
      end
    })
  })
end

function zmm.ElementFindTap(...)
  local params = {
    ...
  }
  return ...({
    function()
      local node = zmm.ElementFind(zmm.table.unpack(nil))
      if node then
        zmm.Tap(node.x, node.y, "hide")
      end
      return node
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ElementFindTap()，错误信息：", errors)
      end
    })
  })
end

function zmm.ElementFindEx(...)
  local params = {
    ...
  }
  return ...({
    function()
      local function _getParams(params)
        local nums = {
          upzero = {},
          
          lowzero = {}
        }
        local node = {
          nodes = {},
          x1 = 0,
          y1 = 0,
          x2 = 0,
          y2 = 0,
          xpos = 0,
          ypos = 0,
          timeout = 0,
          matchmode = -1,
          ischild = true
        }
        for k, v in pairs(params) do
          if type(k) == "number" then
            local vtype = type(v)
            if vtype == "string" then
              table.insert(node.nodes, v)
            elseif vtype == "number" then
              if 0 <= v then
                table.insert(nums.upzero, v)
              else
                table.insert(nums.lowzero, v)
              end
            elseif vtype == "boolean" then
              node.ischild = v
            end
          end
        end
        local upzerolen = #nums.upzero
        node.x1, node.y1, node.x2, node.y2 = 0, 0, 0, 0
        node.xpos, node.ypos = 0, 0
        node.timeout = 0
        if upzerolen == 1 then
          node.timeout = nums.upzero[1]
        elseif upzerolen == 2 then
          node.xpos, node.ypos = nums.upzero[1], nums.upzero[2]
        elseif upzerolen == 3 then
          node.xpos, node.ypos, node.timeout = nums.upzero[1], nums.upzero[2], nums.upzero[3]
        elseif upzerolen == 4 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
        elseif upzerolen == 5 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
          node.timeout = nums.upzero[5]
        elseif upzerolen == 6 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
          node.xpos, node.ypos = nums.upzero[5], nums.upzero[6]
        elseif upzerolen == 7 then
          node.x1, node.y1, node.x2, node.y2 = nums.upzero[1], nums.upzero[2], nums.upzero[3], nums.upzero[4]
          node.xpos, node.ypos, node.timeout = nums.upzero[5], nums.upzero[6], nums.upzero[7]
        elseif upzerolen ~= 0 then
          nums.upzero[5]("提醒，传入zm.ElementFind()命令中数值参数的数量有误，可能会对结果有影响。")
        end
        node.matchmode = -1
        for _, v in pairs(nums.lowzero) do
          if v == -1 or v == -2 or v == -3 then
            node.matchmode = v
          end
        end
        return node
      end
      
      local function getNodeParams(params)
        local nodes = {timeout = 0}
        if type(params[1]) == "table" then
          for _, v in pairs(params) do
            if type(v) == "table" then
              local p = type(v)(v)
              table.insert(nodes, p)
              if p.timeout > nodes.timeout then
                nodes.timeout = p.timeout
              end
            elseif type(v) == "number" and v > nodes.timeout then
              nodes.timeout = v
            end
          end
        else
          local p = pairs(params)(params)
          table.insert(nodes, p)
          nodes.timeout = p.timeout
        end
        return nodes
      end
      
      local function _ExpandNodesEx(ui, node, result)
        for uik, uiv in pairs(ui) do
          result.index = result.index + 1
          result.find = 0
          if type(uik) == "number" and type(uiv) == "table" and (not node.ischild or not uiv.children) then
            if result.find ~= -1 and (node.x1 ~= 0 or node.y1 ~= 0 or node.x2 ~= 0 or node.y2 ~= 0) then
              if node.x1 <= uiv.left and node.y1 <= uiv.top and node.x2 >= uiv.right and node.y2 >= uiv.bottom then
                result.find = 1
              else
                result.find = -1
              end
            end
            if result.find ~= -1 and (node.xpos ~= 0 or node.ypos ~= 0) then
              if node.xpos >= uiv.left and node.xpos <= uiv.right and node.ypos >= uiv.top and node.ypos <= uiv.bottom then
                result.find = 1
              else
                result.find = -1
              end
            end
            local temp = {
              txt = uiv.text,
              res = uiv["resource-id"],
              cls = uiv.class,
              pkg = uiv.package,
              des = uiv["content-desc"]
            }
            for _, v in pairs(node.nodes) do
              if result.find ~= -1 then
                if node.matchmode == -1 then
                  if v == temp.txt then
                    temp.txt = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.res then
                    temp.res = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.cls then
                    temp.cls = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.pkg then
                    temp.pkg = _ENV["nil"]
                    result.find = 1
                  elseif v == temp.des then
                    temp.des = _ENV["nil"]
                    result.find = 1
                  else
                    result.find = -1
                    break
                  end
                elseif node.matchmode == -2 then
                  if temp.txt and temp.txt:match(v) then
                    temp.txt = _ENV["nil"]
                    result.find = 1
                  elseif temp.res and temp.res:match(v) then
                    temp.res = _ENV["nil"]
                    result.find = 1
                  elseif temp.cls and temp.cls:match(v) then
                    temp.cls = _ENV["nil"]
                    result.find = 1
                  elseif temp.pkg and temp.pkg:match(v) then
                    temp.pkg = _ENV["nil"]
                    result.find = 1
                  elseif temp.des and temp.des:match(v) then
                    temp.des = _ENV["nil"]
                    result.find = 1
                  else
                    result.find = -1
                    break
                  end
                end
              end
            end
            if result.find == 1 then
              table.insert(result.node, uiv)
              result.node[#result.node].x = math.floor(uiv.left + uiv.pos[1])
              result.node[#result.node].y = math.floor(uiv.top + uiv.pos[2])
              for _ = 1, ElementRotationNums do
                result.node[#result.node].x, result.node[#result.node].y = table.unpack(LuaAuxLib.xyRotate(result.node[#result.node].x, result.node[#result.node].y, 1))
              end
              result.node[#result.node].xy = {
                result.node[#result.node].x,
                result.node[#result.node].y
              }
              result.node[#result.node].index = result.index
            end
          end
          if uiv.children then
            uiv.children(uiv.children, node, result)
          end
        end
      end
      
      local cjson = require("cjson")
      local nodesparam = getNodeParams(nil)
      local result = {}
      local timestart = LuaAuxLib.GetTickCount()
      repeat
        local ui = cjson.decode(LuaAuxLib.GetFullUiElement())
        for nodeK, nodeV in pairs(nodesparam) do
          if nodeK ~= "timeout" then
            result.index = -1
            result.find = 0
            result.node = {}
            _ExpandNodesEx(ui, nodeV, result)
            if 0 < #result.node then
              result.node.id = nodeK
              result.node.counts = #result.node
              break
            end
          end
        end
      until 0 < #result.node or LuaAuxLib.GetTickCount() - timestart > nodesparam.timeout
      return result.node
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ElementFind()，错误信息：", errors)
      end
    })
  })
end

function zmm.ElementFindExTap(...)
  local params = {
    ...
  }
  return ...({
    function()
      local node = zmm.ElementFindEx(zmm.table.unpack(nil))
      if node then
        for _, v in zmm.ipairs(node) do
          zmm.Tap(v.x, v.y, "hide")
          zmm.Delay(250)
        end
      end
      return node
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ElementFindTap()，错误信息：", errors)
      end
    })
  })
end

_zmm.ElementKeys = {
  index = "index",
  id = "index",
  text = "text",
  txt = "text",
  class = "class",
  cls = "class",
  package = "package",
  pkg = "package",
  checkable = "checkable",
  checked = "checked",
  clickable = "clickable",
  enabled = "enabled",
  focusable = "focusable",
  focused = "focused",
  scrollable = "scrollable",
  password = "password",
  selected = "selected",
  bounds = "bounds",
  range = "bounds",
  left = "left",
  x1 = "left",
  top = "top",
  y1 = "top",
  right = "right",
  x2 = "right",
  bottom = "bottom",
  y2 = "bottom",
  width = "width",
  w = "width",
  height = "height",
  h = "height",
  size = "size",
  s = "size",
  x = "x",
  y = "y",
  xy = "xy",
  ischild = "ischild",
  matchmode = "matchmode",
  m = "matchmode",
  timeout = "timeout",
  t = "timeout"
}
_zmm.ElementKeys["resource-id"], _zmm.ElementKeys.res = "resource-id", "resource-id"
_zmm.ElementKeys["content-desc"], _zmm.ElementKeys.des = "content-desc", "content-desc"
_zmm.ElementKeys["long-clickable"], _zmm.ElementKeys.lck = "long-clickable", "long-clickable"

function zmm.ElementFindS(...)
  local params = {
    ...
  }
  return ...({
    function()
      local function _getParams(params)
        local node = {
          keystr = {},
          
          keybool = {},
          offsetlen = 5,
          timeout = 0,
          matchmode = -1,
          ischild = true
        }
        for k, v in pairs(params) do
          if type(k) == "string" then
            if ElementKeys[k] then
              node[ElementKeys[k]] = v
              if ElementKeys[k] == "text" or ElementKeys[k] == "class" or ElementKeys[k] == "resource-id" or ElementKeys[k] == "package" or ElementKeys[k] == "content-desc" then
                node.keystr[ElementKeys[k]] = v
              elseif ElementKeys[k] == "checkable" or ElementKeys[k] == "checked" or ElementKeys[k] == "clickable" or ElementKeys[k] == "enabled" or ElementKeys[k] == "focusable" or ElementKeys[k] == "focused" or ElementKeys[k] == "scrollable" or ElementKeys[k] == "password" or ElementKeys[k] == "selected" or ElementKeys[k] == "long-clickable" then
                node.keybool[ElementKeys[k]] = v
              end
            elseif node[k] then
              node[k] = v
            end
          end
        end
        if node.index then
          node.maxid = 0
          local tp = type(node.index)
          if tp == "number" then
            node.maxid = node.index
          elseif tp == "table" then
            for _, v in ipairs(node.index) do
              local tp = type(v)
              if tp == "number" then
                if v > node.maxid then
                  node.maxid = v
                end
              elseif tp == "table" and v[2] > node.maxid then
                node.maxid = v[2]
              end
            end
          end
        end
        if node.bounds then
          local pattern = "(%d+)[^%d]+(%d+)[^%d]+(%d+)[^%d]+(%d+)"
          if type(node.bounds) == "string" then
            node.bounds = {
              string.match(node.bounds, pattern)
            }
          elseif type(node.bounds) ~= "table" then
            error("bounds必须是字符串或数组")
          end
          for k, v in ipairs(node.bounds) do
            if type(v) == "string" then
              if v:match(pattern) then
                node.bounds[k] = {
                  v:match(pattern)
                }
                for i, n in ipairs(node.bounds[k]) do
                  node.bounds[k][i] = tonumber(n)
                end
              else
                node.bounds[k] = tonumber(v)
              end
            end
          end
        end
        return node
      end
      
      local function getNodeParams(params)
        local nodes = {timeout = 0}
        for _, v in pairs(params) do
          if type(v) == "table" then
            local p = type(v)(v)
            table.insert(nodes, p)
            if p.timeout > nodes.timeout then
              nodes.timeout = p.timeout
            end
          elseif type(v) == "number" and v > nodes.timeout then
            nodes.timeout = v
          end
        end
        return nodes
      end
      
      local check = {}
      
      function check.index(id, lvl)
        local tp = type(id)
        if tp == "number" then
          if id == lvl then
            return 1
          end
        elseif tp == "table" then
          for _, v in ipairs(id) do
            local tp = type(v)
            if tp == "number" then
              if v == lvl then
                return 1
              end
            elseif tp == "table" and lvl >= v[1] and lvl <= v[2] then
              return 1
            end
          end
        end
        return -1
      end
      
      function check.str(paramstr, uistr, mode)
        local function diff(paramstr, uistr, mode)
          if mode == -1 then
            if paramstr ~= uistr then
            end
            return nil
          elseif mode == -2 then
            return uistr:match(paramstr)
          end
        end
        
        local tp = type(paramstr)
        if tp == "string" then
          if diff(paramstr, uistr, mode) then
            return 1
          end
        elseif tp == "table" then
          for _, v in ipairs(paramstr) do
            if diff(v, uistr, mode) then
              return 1
            end
          end
        end
        return -1
      end
      
      function check.bounds(argbounds, left, top, right, bottom, offset)
        local tp = type(argbounds[1])
        if tp == "number" then
          if left >= argbounds[1] - offset and top >= argbounds[2] - offset and right <= argbounds[3] + offset and bottom <= argbounds[4] + offset then
            return 1
          end
        elseif tp == "table" then
          for _, v in ipairs(argbounds) do
            if left >= v[1] - offset and top >= v[2] - offset and right <= v[3] + offset and bottom <= v[4] + offset then
              return 1
            end
          end
        end
        return -1
      end
      
      function check.size(size, left, top, right, bottom, offset)
        local tp = type(size[1])
        if tp == "number" then
          if offset >= math.abs(right - left - size[1]) and offset >= math.abs(bottom - top - size[2]) then
            return 1
          end
        elseif tp == "table" then
          for _, v in ipairs(size) do
            if offset >= math.abs(right - left - v[1]) and offset >= math.abs(bottom - top - v[2]) then
              return 1
            end
          end
        end
        return -1
      end
      
      function check.xy(xy, left, top, right, bottom, offset)
        local tp = type(xy[1])
        if tp == "number" then
          if left - offset <= xy[1] and xy[1] <= right + offset and top - offset <= xy[2] and xy[2] <= bottom + offset then
            return 1
          end
        elseif tp == "table" then
          for _, v in ipairs(xy) do
            if left - offset <= v[1] and v[1] <= right + offset and top - offset <= v[2] and v[2] <= bottom + offset then
              return 1
            end
          end
        end
        return -1
      end
      
      local function _ExpandNodes(ui, node, result)
        for uik, uiv in pairs(ui) do
          if result.find == 1 or node.maxid and node.maxid == result.index and result.find == -1 then
            return
          end
          result.index = result.index + 1
          result.find = 0
          if type(uik) == "number" and type(uiv) == "table" and (not node.ischild or not uiv.children) then
            if result.find ~= -1 and node.index then
              result.find = index(node.index, result.index)
            end
            if result.find ~= -1 then
              for kstr, vstr in pairs(node.keystr) do
                if result.find ~= -1 then
                  result.find = str(vstr, uiv[kstr], node.matchmode)
                end
              end
            end
            if result.find ~= -1 then
              for kbool, vbool in pairs(node.keybool) do
                if result.find ~= -1 then
                  result.find = vbool == uiv[kbool] and 1 or -1
                end
              end
            end
            if result.find ~= -1 and node.bounds then
              result.find = bounds(node.bounds, uiv.left, uiv.top, uiv.right, uiv.bottom, node.offsetlen)
            end
            if result.find ~= -1 and node.size then
              result.find = size(node.size, uiv.left, uiv.top, uiv.right, uiv.bottom, node.offsetlen)
            end
            if result.find ~= -1 and node.xy then
              result.find = xy(node.xy, uiv.left, uiv.top, uiv.right, uiv.bottom, node.offsetlen)
            end
            if result.find == 1 then
              result.node = uiv
              result.node.x = math.floor(result.node.left + result.node.pos[1])
              result.node.y = math.floor(result.node.top + result.node.pos[2])
              for _ = 1, ElementRotationNums do
                result.node.x, result.node.y = table.unpack(LuaAuxLib.xyRotate(result.node.x, result.node.y, 1))
              end
              result.node.xy = {
                result.node.x,
                result.node.y
              }
              result.node.index = result.index
            end
          end
          if result.find == 1 or node.maxid and node.maxid == result.index and result.find == -1 then
            return
          end
          if uiv.children then
            uiv.children(uiv.children, node, result)
          end
        end
      end
      
      local cjson = require("cjson")
      local nodesparam = getNodeParams(nil)
      local result = {}
      local timestart = LuaAuxLib.GetTickCount()
      repeat
        local ui = cjson.decode(LuaAuxLib.GetFullUiElement())
        for nodeK, nodeV in pairs(nodesparam) do
          if nodeK ~= "timeout" then
            result.index = -1
            result.find = 0
            result.node = _ENV["nil"]
            _ExpandNodes(ui, nodeV, result)
            if result.node then
              result.node.id = nodeK
              break
            end
          end
        end
      until result.node or LuaAuxLib.GetTickCount() - timestart > nodesparam.timeout
      return result.node
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ElementFindS()，错误信息：", errors)
      end
    })
  })
end

function zmm.ElementFindSTap(...)
  local params = {
    ...
  }
  return ...({
    function()
      local node = zmm.ElementFindS(zmm.table.unpack(nil))
      if node then
        zmm.Tap(node.x, node.y, "hide")
      end
      return node
    end,
    ...({
      function(errors)
        ;(nil)("发生运行时错误！错误代码：zm.ElementFindSTap()，错误信息：", errors)
      end
    })
  })
end

function _zmm.Init()
  local json = LuaAuxLib.URL_OperationGet(_URL_ .. "?ver=" .. _VER_ .. "&version=" .. _VERSION_ .. "&week=" .. os.date("%W"), 3)
  local t = _ENV
  if json == _ENV["nil"] or json == "" or json:match("成功") == _ENV["nil"] then
  else
    t = LuaAuxLib.Encode_GetJsonLib():decode(json)
    if t then
      _ENV[t.download or _URL_DOWNLOAD_] = t
      local site = _URL_analytics_:match("https?://[^/]*/")
      if t.droplist and t.droplist:match(site) then
        _ENV[t.analytics] = t
      end
      _ENV[t.qqgroup or _QQ_GROUP_] = t
      _ENV[t.version or _NEW_VERSION_] = t
      _ENV[t.ver or _NEW_VER_] = t
      _ENV[t.info or _INFO_] = t
      local json = readzmconfig()
      if json then
        json.newversion = _NEW_VERSION_
        json.info = _INFO_
        json.newver = _NEW_VER_
        writezmconfig(json)
      end
    end
  end
  _ENV[function()
  end] = t
  return t
end

function zmm.Init(pwd)
  if pwd == "zimaoxy.com" then
    _zmm[true] = pwd
  end
  _zmm.os.execute("cd " .. _zmm.__MQM_RUNNER_LOCAL_PATH_GLOBAL_NAME__)
  _zmm.os.execute("▁▂▃▄▅▆▇█  欢迎使用紫猫插件V" .. _zmm._VERSION_ .. "版，QQ交流群" .. _zmm._QQ_GROUP_ .. "  █▇▆▅▄▃▂▁")
  _zmm.os.execute("正在初始化运行环境与各种函数库中...")
  _zmm.CreatePluginDir()
  _zmm.RndInitSeed()
  _zmm.InitBase64()
  _zmm.InitLockBox()
  _zmm.InitLockBox("************  紫猫学院( https://zimaoxy.com/ )：插件已初始化完毕  ************")
  _zmm.analytics()
  _zmm[function()
  end] = _zmm._VERSION_
  return nil
end

function zmm.Test(mode, wd)
  ;(nil)("紫猫老师专用测试函数, 无实际功能, 请勿调用")
  if mode == 345911220 then
    ;(nil)("==============================================")
    if wd then
      if wd == "LuaAuxLib" then
        for k, v in traceprint.pairs(traceprint.LuaAuxLib) do
          ;(nil)("LuaAuxLib", k, v, traceprint.type(v))
          if traceprint.type(v) == "table" then
            for kk, vv in traceprint.pairs(v) do
              traceprint.type(v)("table", k, kk, vv, traceprint.type(vv))
            end
          end
        end
      else
        for k, v in traceprint.pairs(traceprint.LuaAuxLib) do
          if wd and k:match(wd) then
            k:match(wd)("LuaAuxLib", k, v, traceprint.type(v))
          end
        end
      end
    else
      for k, v in traceprint.pairs(traceprint._G) do
        k:match(wd)("_G", k, v, traceprint.type(v))
        if traceprint.type(v) == "table" then
          for kk, vv in traceprint.pairs(v) do
            traceprint.type(v)("table", k, kk, vv, traceprint.type(vv))
          end
        end
      end
    end
  end
end

_ENV[QMPlugin] = _zmm
_ENV[_ENV] = _zmm
_ENV[{}] = _zmm
local SHver = 2.5
local Ver_LastUpd = 20160905
_ENV[function()
  local iRet, sRet = pcall(function()
    return __MQM_RUNNER_LOCAL_PATH_GLOBAL_NAME__:match("(.+)/[^/]") .. "/"
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
_ENV[function(fn)
  local tPath = TempPath()
  if tPath == "" then
    return ""
  elseif fn == nil then
    return tPath .. "shs_temp.txt"
  else
    return tPath .. fn .. ".txt"
  end
end] = _zmm
_ENV[function(cmd)
  sh_init()
  local iRet, sRet = pcall(function()
    local tFile = TempFile()
    if tFile == "" then
      return ""
    else
      cmd = "" .. " > " .. tFile
      local ret = os.execute(" > ")
      return TrimEx(ReadFile(tFile, nil), "\r\n ")
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.execute = execute
_ENV[function()
  return __MQM_RUNNER_LOCAL_PATH_GLOBAL_NAME__:match("(.+)/[^/]") .. "/"
end] = _zmm
_ENV[function(old)
  local NewTable = {}
  for k, v in pairs(old) do
    NewTable[k] = v
  end
  return NewTable
end] = _zmm
_ENV[function(old)
  local NewArray = {}
  for k, v in ipairs(old) do
    NewArray[k] = v
  end
  return NewArray
end] = _zmm
_ENV[function(...)
  LuaAuxLib.TracePrint(...)
end] = _zmm
_ENV[function(str, format)
  return str:match(format)
end] = _zmm
_ENV[function(str, f, s)
  return str:gsub(f, s)
end] = _zmm
_ENV[function()
  LuaAuxLib.URL_OperationGet("http://monster.gostats.cn/bin/count/a_480985/t_5/i_1/counter.png", 3)
  _ENV[function()
  end] = function()
  end
end] = _zmm
_ENV[function(str, filt)
  sh_init()
  local iRet, sRet = pcall(function()
    local retstr = ""
    for i = 1, string.len(nil) do
      if string.find(nil, string.sub(nil, i, i)) == _ENV["nil"] then
        retstr = string.sub(_ENV["nil"], i, -1)
        break
      end
    end
    return retstr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.LTrimEx = LTrimEx
_ENV[function(str, filt)
  sh_init()
  local iRet, sRet = pcall(function()
    local retstr = ""
    for i = string.len(nil), 1, -1 do
      if string.find(nil, string.sub(nil, i, i)) == _ENV["nil"] then
        retstr = string.sub(_ENV["nil"], 1, i)
        break
      end
    end
    return retstr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.RTrimEx = RTrimEx
_ENV[function(str, filt)
  sh_init()
  local tmpstr = _ENV
  tmpstr = LTrimEx(str, filt)
  return RTrimEx(tmpstr, filt)
end] = _zmm
QMPlugin.TrimEx = TrimEx

function QMPlugin.DelPartStr(str, sval, eval)
  sh_init()
  local iRet, sRet = pcall(function()
    local LStr = string.sub(nil, 1, nil - 1)
    local RStr = string.sub(1, nil - 1 + 1, -1)
    local RetStr = LStr .. RStr
    return RetStr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.DelFilStr(str, filter)
  sh_init()
  local iRet, sRet = pcall(function()
    local RetStr, TmpLStr, TmpRStr, s, e = _UPVALUE4_, nil, nil, nil, nil
    while true do
      s, e = str.string.find(RetStr, nil, e)
      if s ~= str["nil"] then
        TmpLStr = str.string.sub(RetStr, 1, s - 1)
        TmpRStr = str.string.sub(RetStr, e + 1, -1)
        RetStr = TmpLStr .. TmpRStr
      else
        break
      end
    end
    return RetStr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.CountStr(str, substr)
  sh_init()
  local iRet, sRet = pcall(function()
    local count = 0
    for k in string.gmatch(nil, nil) do
      count = count + 1
    end
    return count
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.LeftDel(str, num)
  sh_init()
  local iRet, sRet = pcall(function()
    return (nil):sub(nil + 1, -1)
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.RightDel(str, num)
  sh_init()
  local iRet, sRet = pcall(function()
    return (nil):sub(1, (nil):len() - nil)
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.RndChr()
  sh_init()
  local iRet, sRet = pcall(function()
    local x, n = _UPVALUE1_, nil
    local chr = string.char
    n = math.random(19968, 40869)
    x = chr(bit32.bor(224, bit32.extract(n, 12, 4))) .. chr(bit32.bor(128, bit32.extract(n, 6, 6))) .. chr(bit32.bor(128, bit32.extract(n, 0, 6)))
    return x
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

_ENV[function(xml)
  sh_init()
  local iRet, sRet = pcall(function()
    local tXml = {}
    local i = 1
    for k in (nil):gmatch("<node[^>]+/?>") do
      tXml[i] = {}
      for w, y in k:gmatch("([^ ]+)=([^ ]+)") do
        tXml[i][w] = y
      end
      i = i + 1
    end
    return tXml
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.XmlToTable = XmlToTable

function QMPlugin.FindXmlKey(Xml, key, val, key1)
  local iRet, sRet = pcall(function()
    local tXml = XmlToTable(nil)
    local i = 1
    for i = 1, #tXml do
      if tXml[i][nil] == "\"" .. nil .. "\"" then
        return tXml[i]["\"" .. nil .. "\""]:match("\"(.+)\"")
      end
    end
    return ""
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.FindXmlKeyA(Xml, key, val, key1)
  local iRet, sRet = pcall(function()
    local tXml = XmlToTable(nil)
    local tmptable = {}
    for i = 1, #tXml do
      if tXml[i][nil] == "\"" .. nil .. "\"" then
        table.insert(tmptable, tXml[i]["\""]:match("\"(.+)\""))
      end
    end
    if tmptable[1] == _ENV["nil"] then
      return _ENV["nil"]
    else
      return tmptable
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end

_ENV[function(tblXml, tblList, key)
  sh_init()
  local iRet, sRet = pcall(function()
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end] = _zmm

function QMPlugin.UrlToChar(str)
  sh_init()
  local iRet, sRet = pcall(function()
    _ENV[string.gsub(nil, "%%(%x%x)", function(h)
      return string.char(tonumber(h, 16))
    end)] = string.gsub(nil, "%%(%x%x)", function(h)
      return string.char(tonumber(h, 16))
    end)
    return s
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end

function QMPlugin.CharToUrl(str)
  sh_init()
  local iRet, sRet = pcall(function()
    _ENV[string.gsub(nil, "([^%w%.%- ])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)] = string.gsub(nil, "([^%w%.%- ])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)
    return string.gsub(s, " ", "+")
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end

function QMPlugin.Filter(arr, substr, tpe)
  sh_init()
  local iRet, sRet = pcall(function()
    local tarr = {}
    for k, v in ipairs(nil) do
      if nil then
        if string.find(v, nil) ~= _ENV["nil"] then
          table.insert(tarr, v)
        end
      elseif string.find(v, v) == _ENV["nil"] then
        table.insert(tarr, v)
      end
    end
    return tarr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return arr
  end
end

function QMPlugin.Sort(arr, comp)
  sh_init()
  local iRet, sRet = pcall(function()
    local t = {}
    local j = 1
    _ENV[CopyTable(nil)] = t
    table.sort(tarr)
    if table.sort then
      for i = #tarr, 1, -1 do
        t[j] = tarr[i]
        j = j + 1
      end
      return t
    else
      return tarr
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return arr
  end
end

function QMPlugin.Remove(arr, ipos)
  sh_init()
  local iRet, sRet = pcall(function()
    _ENV[CopyTable(nil)] = CopyTable(nil)
    table.remove(tarr, nil + 1)
    return tarr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return arr
  end
end

function QMPlugin.insert(arr, ipos, value)
  sh_init()
  local iRet, sRet = pcall(function()
    _ENV[CopyTable(nil)] = CopyTable(nil)
    table.insert(tarr, nil + 1, nil)
    return tarr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return arr
  end
end

function QMPlugin.RemoveDup(tbl)
  sh_init()
  local iRet, sRet = pcall(function()
    local a = {}
    local b = {}
    for _, v in ipairs(nil) do
      a[v] = 0
    end
    for k, v in pairs(a) do
      table.insert(b, k)
    end
    return b
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.ChangePos(arr, a, b)
  sh_init()
  local iRet, sRet = pcall(function()
    local tmptbl
    local tmpval = arr[nil + 1]
    arr.table.remove(tmptbl, nil + 1)
    arr.table.insert(tmptbl, nil + 1 + 1, tmpval)
    return tmptbl
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.RndEx(min, max)
  sh_init()
  local iRet, sRet = pcall(function()
    return math.random(nil, nil)
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return 0
  end
end

function QMPlugin.RndBool()
  sh_init()
  local iRet, sRet = pcall(function()
    local tmpnum = math.random(2) - 1
    if tmpnum == 0 then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.RandArray(arr)
  sh_init()
  local iRet, sRet = pcall(function()
    local index = _ENV
    index = math.random(1, #nil)
    return _ENV[index]
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.RanDiffarr(arr, num)
  sh_init()
  local iRet, sRet = pcall(function()
    if nil == nil or nil > #nil then
      num = #nil
    end
    local Lines = {}
    for _ = 1, nil do
      local n = num.math.random(#nil)
      Lines[#Lines + 1] = num[n]
      num.table.remove(num[n], n)
    end
    return Lines
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

_ENV[function(path, isdel)
  local iRet, sRet = pcall(function()
    local f = io.open(nil, "r")
    if f == nil then
      return ""
    end
    local ret = f:read("*all")
    f:close()
    if f.close then
      os.remove(f)
    end
    return ret
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
_ENV[function(path, isdel)
  local iRet, sRet = pcall(function()
    local Lines = {}
    local f = io.open(nil, "r")
    if f == nil then
      return _ENV["nil"]
    end
    for v in f:lines() do
      table.insert(Lines, v)
    end
    f:close()
    if f.close then
      os.remove(f)
    end
    return Lines
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end] = _zmm
_ENV[function(path, str, mode)
  local iRet, sRet = pcall(function()
    if nil == mode["nil"] then
      mode = "w"
    end
    local f = mode.io.open(mode["nil"], nil)
    if f == mode["nil"] then
      return ""
    end
    local ret = f:write(nil)
    f:close()
    return mode.ReadFile(f)
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
_ENV[function(path)
  local f = io.open(path, "r")
  if f then
    return nil
  else
    return nil
  end
end] = _zmm

function QMPlugin.GetFileType(path)
  sh_init()
  local iRet, sRet = pcall(function()
    _ENV[string.find(nil, "%.")], _ENV[string.find(nil, "%.")] = string.find(nil, "%.")
    local str = string.sub(string.find(nil, "%."))
    if str then
      return str
    else
      return ""
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetFileName(path)
  sh_init()
  local iRet, sRet = pcall(function()
    path = "/" .. nil
    local ret = path
    for w in path.string.gmatch(nil, "/([^/]+)") do
      ret = w
    end
    return ret
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetTempFile(Path, Prefix, Postfix, Lenght)
  sh_init()
  local iRet, sRet = pcall(function()
    local RndText, RetText = _ENV, nil
    for i = 1, nil do
      if RndText == Lenght["nil"] then
        RndText = Lenght.math.random(nil)
      else
        RndText = RndText .. Lenght.math.random(nil)
      end
    end
    RetText = 1 .. nil .. RndText .. nil
    local f = Lenght.io.open(RetText, "a+")
    f:close()
    return RetText
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.ScanPath(path, filter)
  sh_init()
  local iRet, sRet = pcall(function()
    if string.sub(nil, -1, -1) ~= "/" then
      path = string.sub(nil, -1, -1) .. "/"
    end
    local tpath = TempFile("scan")
    os.execute("ls -F -a " .. -1 .. " > " .. tpath)
    local f = io.open(tpath, "r")
    local file = {}
    local folder = {}
    for v in f:lines() do
      if string.find(v, "d ") then
        _ENV[string.find(v, " ")] = tpath
        v = string.sub(v, sPos + 1, -1)
        table.insert(folder, v)
      elseif string.find(v, "- ") then
        _ENV[string.find(v, " ")] = tpath
        v = string.sub(v, sPos + 1, -1)
        table.insert(file, v)
      end
    end
    os.remove(tpath)
    f:close()
    if f.close ~= _ENV["nil"] then
      return folder
    else
      return file
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.ScanPathEx(path)
  sh_init()
  local iRet, sRet = pcall(function()
    if string.sub(nil, -1, -1) ~= "/" then
      path = string.sub(nil, -1, -1) .. "/"
    end
    local tscan = TempFile("scan")
    os.execute("ls -F -a -R " .. -1 .. " > " .. tscan)
    local file = {}
    local tpath = ""
    local f = io.open(tscan, "r")
    for v in f:lines() do
      if v:find("/") ~= nil then
        v = RTrimEx(v, ":")
        tpath = v .. "/"
      else
        local s, e = v:find("- ")
        if s then
          v = tpath .. v:sub(e + 1, -1)
          v = v:gsub("//", "/")
          table.insert(file, v)
        end
      end
    end
    f:close()
    return file
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.Chmod(path, per)
  sh_init()
  if per == 0 then
    ChmodEx(path, 666)
  elseif per == 1 then
    ChmodEx(path, 444)
  elseif per == 2 then
    ChmodEx(path, 777)
  end
end

_ENV[function(path, per)
  sh_init()
  return os.execute("chmod " .. per .. " " .. path)
end] = _zmm
QMPlugin.ChmodEx = ChmodEx

function QMPlugin.WriteFileLine(path, line, str)
  sh_init()
  local iRet, sRet = pcall(function()
    local t = {}
    _ENV[io.open(nil, "r")] = t
    if f == _ENV["nil"] then
      _ENV[io.open(_ENV["nil"], "w")] = t
      f:close()
      _ENV[io.open(f, "r")] = t
    end
    for i in f:lines() do
      table.insert(t, i)
    end
    if f:lines() > #t then
      line = #t + 1
    end
    table.insert(t, f:lines())
    f:close()
    _ENV[io.open(f, "w")] = t
    for _, v in ipairs(t) do
      f:write(v .. "\r\n")
    end
    f:close()
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.FindFileDelete(findpath, filename)
  sh_init()
  execute(string.format("find %s -name '%s' | xargs rm -rf", findpath, filename))
end

_ENV[function(path, str, repl)
  sh_init()
  local iRet, sRet = pcall(function()
    local result = _ENV
    local retText = ReadFile(nil)
    if retText == "" then
      return ""
    end
    if retText:find(nil) == _ENV["nil"] then
      return ""
    end
    local tmpstr = retText:gsub(nil, nil)
    WriteFile(nil, tmpstr)
    return tmpstr
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.ReplaceFile = ReplaceFile

function QMPlugin.ReadFileBase(path)
  sh_init()
  local iRet, sRet = pcall(function()
    _ENV[io.open(nil, "rb")] = io.open(nil, "rb")
    if f == nil then
      return _ENV
    end
    _ENV[f:read("*all")] = f:read("*all")
    f:close()
    local key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    return (bytes:gsub(".", function(x)
      local r, key = "", x:byte()
      for i = 8, 1, -1 do
        r = r .. (key % 2 ^ i - key % 2 ^ (i - 1) > 0 and "1" or "0")
      end
      return r
    end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
      if #x < 6 then
        return ""
      end
      local c = 0
      for i = 1, 6 do
        c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
      end
      return (1):sub(c + 1, c + 1)
    end) .. ({
      "",
      "==",
      "="
    })[#bytes % 3 + 1]
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.ReadFileSize(path)
  sh_init()
  local iRet, sRet = pcall(function()
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.ReadFileSize(path)
  sh_init()
  local iRet, sRet = pcall(function()
    local size = _ENV
    local f = io.open(nil)
    if f then
      size = f:seek("end")
      f:close()
    else
      return -1
    end
    return size
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

local Html = {}
local isAutoSave
local isInit
local HtmlData = ""
local HtmlPage = ""
_ENV[function()
  local iRet, sRet = pcall(function()
    if Html.HtmlLevel == Html["nil"] then
      Html[1] = Html.HtmlLevel
    end
    if Html.TempletItem == Html["nil"] then
      Html["<p class='class{$level}'>{$data}</p>"] = Html.TempletItem
    end
    if Html.HtmlPath == Html["nil"] then
      Html[Html.TempPath() .. "log_" .. Html.os.date("%Y%m%d%H%M") .. ".html"] = Html.TempPath() .. "log_" .. Html.os.date("%Y%m%d%H%M") .. ".html"
    end
    if Html.HtmlTitle == Html["nil"] then
      Html["日志记录系统"] = Html.HtmlTitle
    end
    if Html.TempletPage == Html["nil"] then
      Html[([[
		<html>
		<head>
		<meta charset='utf-8'>
		<title>{$title}</title>
		<style type='text/css'>
		.title {background-color : #000000;color : #FFFF00;font-family : Microsoft YaHei;font-size : 24pt;margin : 0;padding : 0;text-align : center;}
		.null {background-color : #000000;color : #FFFFFF;font-family : SimSun;font-size : 10pt;margin : 0;padding : 9px;}
		.class0 {background-color : #000000;color : #FFFFFF;font-family : SimSun;font-size : 10pt;margin : 0;padding : 0;text-indent : 16px;text-align : left;}
		.class1 {background-color : #000000;color : #00FF00;font-family : SimSun;font-size : 10pt;margin : 0;padding : 0;text-indent : 16px;text-align : left;}
		.class2 {background-color : #000000;color : #FF8000;font-family : SimSun;font-size : 10pt;margin : 0;padding : 0;text-indent : 16px;text-align : left;}
		.class3 {background-color : #000000;color : #FF0000;font-family : SimSun;font-size : 10pt;margin : 0;padding : 0;text-indent : 16px;text-align : left;}
		</style>
		</head>
		<body>
		<p class='null'></p>
		<p class='title'>{$title}</p>
		<p class='null'></p>
		{$data}
		</body>
		</html>
	]])] = Html.TempletPage
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm

function QMPlugin.AddLog(LogText, Level)
  sh_init()
  local iRet, sRet = pcall(function()
    if nil then
      isInit.Init()
      isInit = nil
    end
    local tmpLevel, tmpCode, tmpData = Html, nil, nil
    tmpLevel = isInit.HtmlLevel
    isInit[isInit.TempletPage] = tmpCode
    if isInit.TempletPage ~= isInit["nil"] then
    end
    tmpData = isInit.string.gsub(isInit.TempletItem, "{$level}", tmpLevel)
    tmpData = isInit.string.gsub(tmpData, "{$data}", isInit.os.date("[%H:%M:%S] ") .. "[%H:%M:%S] ")
    HtmlData = isInit.string.gsub(tmpData, "{$data}", isInit.os.date("[%H:%M:%S] ") .. "[%H:%M:%S] ") .. tmpData .. "\n"
    isInit[isInit.string.gsub(isInit.TempletPage, "{$title}", isInit.HtmlTitle)] = tmpCode
    isInit[isInit.string.gsub(isInit.tmpPage, "{$data}", isInit.HtmlTitle)] = tmpCode
    HtmlPage = isInit.tmpPage
    if isInit.tmpPage then
      isInit.WriteFile(isInit.HtmlPath, "{$data}", "w")
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.Save(path)
  sh_init()
  local iRet, sRet = pcall(function()
    Init()
    if HtmlPath == _ENV["nil"] then
      _ENV[TempPath() .. "log_" .. os.date("%Y%m%d%H%M") .. ".html"] = "log_"
    end
    if TempPath() .. "log_" .. os.date("%Y%m%d%H%M") .. ".html" ~= _ENV["nil"] then
      WriteFile(_ENV["nil"], os.date("%Y%m%d%H%M"), "w")
    else
      WriteFile(HtmlPath, os.date("%Y%m%d%H%M"), "w")
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.AutoSave(mode)
  if mode then
    isAutoSave = mode
  end
end

function QMPlugin.SetTemplet(tbl)
  Html[tbl.HtmlLevel] = tbl
  Html[tbl.TempletItem] = tbl
  Html[tbl.HtmlPath] = tbl
  Html[tbl.HtmlTitle] = tbl
  Html[tbl.TempletPage] = tbl
end

function QMPlugin.GetTemplet()
  Init()
  return Init
end

function QMPlugin.GetMAC()
  sh_init()
  local iRet, sRet = pcall(function()
    local info, s, e, retMac = _UPVALUE3_, nil, nil, nil
    if FileExist("/sys/class/net/wlan0/address") then
      retMac = execute("cat /sys/class/net/wlan0/address")
    else
      info = execute("getprop")
      s, e = info:find("mac")
      if s then
        retMac = info:find("%[(%w%w:%w%w:%w%w:%w%w:%w%w:%w%w)%]", s + 1)
        _ENV[info:find("%[(%w%w:%w%w:%w%w:%w%w:%w%w:%w%w)%]", s + 1)] = info
        _ENV[info:find("%[(%w%w:%w%w:%w%w:%w%w:%w%w:%w%w)%]", s + 1)] = info
      end
    end
    retMac = retMac or ""
    return retMac
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.SetIME(pattern)
  sh_init()
  local iRet, sRet = pcall(function()
    local imelist = {
      "com.baidu.input_mi/.ImeService",
      "com.iflytek.inputmethod/.FlyIME",
      "com.google.android.inputmethod.pinyin",
      "com.xinshuru.inputmethod/.FTInputService",
      "com.jb.gokeyboard/.GoKeyboard",
      "com.cootek.smartinputv5.tablet/com.cootek.smartinput5.TouchPalIME",
      "com.tencent.qqpinyin/.QQPYInputMethodService",
      "com.baidu.input/.ImeService",
      "com.komoxo.octopusime/com.komoxo.chocolateime.LatinIME",
      "com.cyjh.mobileanjian/.input.inputkb",
      "com.sohu.inputmethod.sogou/.SogouIME"
    }
    os.execute("ime set " .. imelist["com.google.android.inputmethod.pinyin"])
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.Install(path)
  sh_init()
  os.execute("pm install -r " .. string.format("%s", path))
end

function QMPlugin.Uninstall(PackageName)
  sh_init()
  os.execute("pm uninstall  " .. string.format("%s", PackageName))
end

function QMPlugin.GetNotification(PackageName)
  sh_init()
  local iRet, sRet = pcall(function()
    local s, e, pkgname, info = _UPVALUE3_, nil, nil, nil
    info = execute("dumpsys notification")
    repeat
      s, e = string.find(info, "pkg=[^ ]+", e)
      if s == _ENV["nil"] then
        return ""
      end
      pkgname = string.sub(info, s + 4, e)
      if pkgname == string.sub(info, s + 4, e) then
        s, e = string.find(info, "tickerText=[^\r\n]+", e)
        if s == _ENV["nil"] then
          return ""
        end
        _ENV[string.sub(info, s + 11, e)] = s
        return tickertext
      end
    until s == nil
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetIP()
  sh_init()
  local iRet, sRet = pcall(function()
    local iplist = {
      "http://1212.ip138.com/ic.asp",
      "http://ip.chinaz.com/getip.aspx"
    }
    local retip = ""
    for _, v in ipairs(iplist) do
      retip = LuaAuxLib.URL_OperationGet(v, 5)
      if ret ~= "" then
        break
      end
    end
    return retip:match("%d+%.%d+%.%d+%.%d+")
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetTopActivity(tpe)
  sh_init()
  local ret = execute("dumpsys activity top ")
  if tpe and tpe == 1 then
    return string.match(ret, "ACTIVITY ([^/]+)")
  elseif tpe and tpe == 2 then
    return string.match(ret, "ACTIVITY .-/([^ ]+)")
  else
    return string.match(ret, "ACTIVITY ([^ ]+)")
  end
end

_ENV[function(tpe)
  sh_init()
  local iRet, sRet = pcall(function()
    local sRet = tpe
    local appList = {}
    if nil == 0 then
      sRet = tpe.execute("pm list packages -3")
    elseif tpe.execute("pm list packages -3") == 1 then
      sRet = tpe.execute("pm list packages -s")
    end
    for k in sRet:gmatch("package:([^\r\n]+)") do
      tpe.table.insert(appList, tpe.TrimEx(k, " "))
    end
    return appList
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.GetAppList = GetAppList

function QMPlugin.ControlWifi(mode)
  sh_init()
  if mode then
    os.execute("svc wifi enable")
  else
    os.execute("svc wifi disable")
  end
end

function QMPlugin.ControlData(mode)
  sh_init()
  if mode then
    os.execute("svc data enable")
  else
    os.execute("svc data disable")
  end
end

function QMPlugin.IsConnectWifi()
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = _ENV
    ret = execute("dumpsys wifi")
    if ret:find("enabled") then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetAndroidVer()
  sh_init()
  return execute("getprop ro.build.version.release")
end

function QMPlugin.Reboot()
  sh_init()
  os.execute("reboot")
end

function QMPlugin.ShutDown()
  sh_init()
  os.execute("reboot -p")
end

function QMPlugin.IsVM()
  sh_init()
  local iRet, sRet = pcall(function()
    local retinfo = execute("cat /proc/cpuinfo")
    if retinfo ~= "" then
      if retinfo:find("model name") and retinfo:find("vendor_id") then
        return nil
      else
        return nil
      end
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return nil
  end
end

function QMPlugin.GetBatteryState()
  sh_init()
  local iRet, sRet = pcall(function()
    local state = _ENV
    local path = TempFile("Battery")
    os.execute("dumpsys battery > " .. path)
    local ret = execute("dumpsys battery")
    if string.find(ret, "AC powered: true") then
      state = 1
    elseif string.find(ret, "USB powered: true") then
      state = 2
    elseif string.find(ret, "Wireless powered: true") then
      state = 3
    else
      state = 0
    end
    return state
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return 0
  end
end

function QMPlugin.IsBluetooth()
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = execute("getprop bluetooth.status")
    if ret == "on" then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return nil
  end
end

function QMPlugin.RunUrl(url, ID)
  sh_init()
  local tmpact = _ENV
  if ID == 0 then
    tmpact = "com.qihoo.browser/.BrowserActivity"
  elseif ID == 1 then
    tmpact = "com.tencent.mtt.x86/.MainActivity"
  elseif ID == 2 then
    tmpact = "com.dolphin.browser.xf/mobi.mgeek.TunnyBrowser.MainActivity"
  elseif ID == 3 then
    tmpact = "com.oupeng.browser/com.opera.android.OperaMainActivity"
  elseif ID == 4 then
    tmpact = "com.mx.browser/.MxBrowserActivity"
  elseif ID == 5 then
    tmpact = "com.UCMobile/com.uc.browser.InnerUCMobile"
  end
  os.execute(string.format("am start -n %s -d %s", tmpact, url))
end

function QMPlugin.WeiXinUrl(packagename, url)
  sh_init()
  os.execute(string.format("am start -n %s/.plugin.webview.ui.tools.WebViewUI -d '%s'", packagename, url))
end

function QMPlugin.OpenWeb(url)
  sh_init()
  if url:find("http://") == _ENV["nil"] then
    url = "http://" .. url
  end
  os.execute(string.format("am start -a android.intent.action.VIEW -d " .. url))
end

function QMPlugin.ExistApp(pkgname)
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = execute("pm list packages")
    if ret:find(nil) then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return nil
  end
end

function QMPlugin.SetTime(d, t)
  sh_init()
  os.execute("date -s " .. d .. "." .. t)
end

function QMPlugin.DisableApp(pkgname)
  sh_init()
  os.execute("pm disable " .. pkgname)
end

function QMPlugin.EnableApp(pkgname)
  sh_init()
  os.execute("pm enable  " .. pkgname)
end

function QMPlugin.GetNavigationBar()
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = execute("dumpsys window windows")
    local _, _, pos1, pos2 = ret:find("NavigationBar.-mFrame=%[%d+,(%d+)%]%[%d+,(%d+)%]")
    if pos1 then
      return tonumber(pos2 - pos1)
    else
      return 0
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return 0
  end
end

function QMPlugin.GetStatusBar()
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = execute("dumpsys window windows")
    local _, _, h, h1 = ret:find("StatusBar.-mFrame=%[%d+,(%d+)%]%[%d+,(%d+)%]")
    if h ~= _ENV["nil"] then
      return tonumber(h1 - h)
    else
      return 0
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return 0
  end
end

function QMPlugin.GetScreen(tpe)
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = execute("dumpsys window")
    local info = {}
    info[1], info[2], info[3] = ret:find("init=(%d+)x(%d+) (%d+)dpi")
    _ENV[ret:find("init=(%d+)x(%d+) (%d+)dpi")] = ret
    _ENV[ret:find("init=(%d+)x(%d+) (%d+)dpi")] = ret
    if info[1] then
      return info[info[1] - 1]
    else
      return 0
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return 0
  end
end

function QMPlugin.GetRAM()
  sh_init()
  local iRet, sRet = pcall(function()
    local Total, Free = _UPVALUE1_, nil
    local path = TempFile("RAM")
    os.execute("dumpsys meminfo > " .. path)
    local text = ReadFile(path)
    Total = string.find(text, "Total RAM: (%d+)")
    _ENV[string.find(text, "Total RAM: (%d+)")] = Total
    _ENV[string.find(text, "Total RAM: (%d+)")] = Total
    Free = string.find(text, "Free RAM: (%d+)")
    _ENV[string.find(text, "Free RAM: (%d+)")] = Total
    _ENV[string.find(text, "Free RAM: (%d+)")] = Total
    if Free ~= _ENV["nil"] then
      return string.format("%d", tonumber(Free) / tonumber(Total) * 100)
    else
      return 0
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return 0
  end
end

function QMPlugin.AppVersion(packagename)
  sh_init()
  local retVer = execute(string.format("dumpsys package %s ", packagename))
  return retVer:match("versionName=(.-)\n")
end

function QMPlugin.AppFirstInstallTime(packagename)
  sh_init()
  local InsTime = execute(string.format("dumpsys package %s ", packagename))
  return InsTime:match("firstInstallTime=(.-)\n")
end

function QMPlugin.AppLastUpdateTime(packagename)
  sh_init()
  local UpdateTime = execute(string.format("dumpsys package %s ", packagename))
  return UpdateTime:match("lastUpdateTime=(.-)\n")
end

function QMPlugin.UpdatePicture(picturepath)
  sh_init()
  os.execute("am broadcast -a android.intent.action.MEDIA_MOUNTED -d file://" .. picturepath)
end

function QMPlugin.IsScreenOn()
  sh_init()
  local ret = execute("dumpsys power"):match("mLightSensorEnabled=(.-) ")
  if ret:find("ture") then
    return nil
  else
    return nil
  end
end

function QMPlugin.OpenAirplane()
  sh_init()
  os.execute("settings put global airplane_mode_on 1")
  os.execute("am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true")
end

function QMPlugin.CloseAirplane()
  sh_init()
  os.execute("settings put global airplane_mode_on 0")
  os.execute("am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false")
end

function QMPlugin.IsAutoBrightness()
  sh_init()
  _ENV[execute("settings get system screen_brightness_mode")] = execute("settings get system screen_brightness_mode")
  if ret == 1 then
    return nil
  elseif ret == 0 then
    return nil
  end
end

function QMPlugin.SetAutoBrightness(mode)
  sh_init()
  if mode == 0 then
    os.execute("settings put system screen_brightness_mode 0")
  elseif mode == 1 then
    os.execute("settings put system screen_brightness_mode 1")
  end
end

function QMPlugin.GetBrightness()
  sh_init()
  local ret = execute("settings get system screen_brightness")
  if ret ~= "" then
    return tonumber(ret)
  else
    return -1
  end
end

function QMPlugin.SetBrightness(val)
  sh_init()
  os.execute("settings put system screen_brightness " .. val)
end

function QMPlugin.GetScreenSleep()
  sh_init()
  local itime = execute("settings get system screen_off_timeout")
  if itime ~= "" then
    return tonumber(itime) / 1000
  else
    return -1
  end
end

function QMPlugin.SetScreenSleep(val)
  sh_init()
  os.execute("settings put system screen_off_timeout " .. val * 1000)
end

function QMPlugin.SetNavigationBar(isDisplay)
  sh_init()
  local iRet, sRet = pcall(function()
    local path = "/system/build.prop"
    if Mount("/system") ~= true then
      return nil
    end
    local mode = _ENV
    if "/system" then
      mode = 0
    else
      mode = 1
    end
    if ChmodEx(path, "777") ~= true then
      return nil
    end
    local retText = ReadFile(path)
    if retText:find("qemu%.hw%.mainkeys=%w") then
      retText = retText:gsub("qemu%.hw%.mainkeys=%w", "qemu.hw.mainkeys=" .. mode)
      ReplaceFile(path, "qemu%.hw%.mainkeys=%w", "qemu.hw.mainkeys=" .. mode)
    else
      WriteFile(path, [[

qemu.hw.mainkeys=]] .. mode, "a+")
    end
    retText = ReadFile(path)
    if retText:find("qemu%.hw%.mainkeys=%w") then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetSIMState()
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = execute("getprop gsm.sim.state")
    if ret:find("READY") ~= _ENV["nil"] then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return nil
  end
end

_ENV[function(pgknamearr)
  sh_init()
  local localpath = temppath() .. "list"
  local localpath1 = temppath() .. "ps"
  os.execute("ls /data/app/ > " .. localpath)
  os.execute("ps > " .. localpath1)
  local f = _ENV
  _ENV[ReadFile(localpath)] = pgknamearr
  _ENV[ReadContent:gsub("-[12]%.apk", "")] = pgknamearr
  _ENV[ReadContent:gsub("-[12]%.apk", "")] = pgknamearr
  f = io.open(localpath, "w")
  f:write(ReadContent)
  f:close()
  _ENV[ReadFile(localpath1)] = pgknamearr
  for l in io.lines(localpath) do
    _ENV[0] = pgknamearr
    if string.find(ReadContent, l) then
      for i, v in ipairs(pgknamearr) do
        if v == l then
          _ENV[1] = pgknamearr
          break
        end
      end
      if n == 0 then
        os.execute("am force-stop " .. l)
      end
    end
  end
end] = _zmm

function QMPlugin.KillClean(pgknamearr)
  sh_init()
  local iRet, sRet = pcall(function()
    local locallist = GetAppList(0)
    local RunList = execute("ps")
    for _, v in locallist, pgknamearr, nil do
      if RunList:find(v) then
        for _, v1 in RunList:find(v), pgknamearr, v do
          if v1 ~= v then
            os.execute("am force-stop " .. v)
          end
        end
      end
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return nil
  end
end

function QMPlugin.AppClean(packagename)
  sh_init()
  execute(string.format("pm clear %s", packagename))
end

function QMPlugin.CallState()
  sh_init()
  local ret = execute("dumpsys telephony.registry")
  if ret ~= "" then
    return match("mCallState=(.-)\n")
  else
    return ""
  end
end

function QMPlugin.CallIncomingNumber()
  sh_init()
  local ret = execute("dumpsys telephony.registry")
  if ret ~= "" then
    return match("mCallIncomingNumber=(.-)\n")
  else
    return ""
  end
end

function QMPlugin.GetUpTime()
  sh_init()
  local rettime = execute("cat /proc/uptime ")
  rettime = string.find(rettime, "([^ ]+)")
  _ENV[string.find(rettime, "([^ ]+)")] = rettime
  _ENV[string.find(rettime, "([^ ]+)")] = rettime
  if rettime then
    return tonumber(rettime)
  else
    return 0
  end
end

function QMPlugin.GetIME()
  sh_init()
  local retstr = execute("ime list -s")
  local retIME = {}
  for v in string.gmatch(retstr, [[
([^
]+)]]) do
    table.insert(retIME, v)
  end
  return retIME
end

function QMPlugin.KeepScreenOn(isOn)
  sh_init()
  local iRet, sRet = pcall(function()
    if nil then
      isOn.os.execute("svc power stayon true")
    else
      isOn.os.execute("svc power stayon false")
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetHttp(url, t, header)
  sh_init()
  local path = TempFile("GET")
  if t == _ENV["nil"] then
    t = 30
  end
  if header == _ENV["nil"] then
    os.execute(string.format("curl --connect-timeout %s -o %s '%s' ", t, path, url))
  else
    os.execute(string.format("curl --connect-timeout %s -H '%s' -o %s '%s'", t, header, path, url))
  end
  _ENV[ReadFile(path, nil)] = url
  return result
end

function QMPlugin.GetHttpFile(url, filepath, header)
  sh_init()
  if header == nil then
    os.execute(string.format("curl -o '%s' '%s' ", filepath, url))
  else
    os.execute(string.format("curl -o %s -H '%s' '%s' ", filepath, header, url))
  end
end

function QMPlugin.PostHttp(url, post, t, header)
  sh_init()
  local path = TempFile("POST")
  if t == _ENV["nil"] then
    t = 30
  end
  if header == _ENV["nil"] then
    os.execute(string.format("curl -o %s -d '%s' --connect-timeout %s '%s'", path, post, t, url))
  else
    os.execute(string.format("curl -o %s -d '%s' --connect-timeout %s -H '%s' '%s'", path, post, t, header, url))
  end
  _ENV[ReadFile(path, nil)] = url
  return result
end

function QMPlugin.PostHttpC(url, post, cookie_path, t, header)
  sh_init()
  local path = TempFile("POST")
  if t == nil then
    t = 30
  end
  if header == nil then
    os.execute(string.format("curl -o %s -d '%s' -b '%s' --connect-timeout %s '%s'", path, post, cookie_path, t, url))
  else
    os.execute(string.format("curl -o %s -d '%s' -b '%s' --connect-timeout %s -H '%s' '%s'", path, post, cookie_path, t, header, url))
  end
  _ENV[ReadFile(path, nil)] = url
  return result
end

function QMPlugin.GetHttpC(url, cookie_path, t, header)
  sh_init()
  local path = TempFile("GET")
  if t == nil then
    t = 30
  end
  if header == nil then
    os.execute(string.format("curl -o %s -b '%s' --connect-timeout %s '%s'", path, cookie_path, t, url))
  else
    os.execute(string.format("curl -o %s -b '%s' --connect-timeout %s -H '%s' '%s'", path, cookie_path, t, header, url))
  end
  _ENV[ReadFile(path, nil)] = url
  return result
end

function QMPlugin.RegexFind(str, pattern)
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = {}
    for v in string.gmatch(nil, nil) do
      table.insert(ret, v)
    end
    return ret
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return arr
  end
end

function QMPlugin.RegexFindEx(str, pattern)
  sh_init()
  local t1 = {}
  local i = 1
  local ePos = _ENV
  repeat
    local ta = {
      string.find(str, pattern, ePos)
    }
    ePos = ta[2]
    if ta[1] ~= _ENV["nil"] then
      t1[i] = ta
      table.remove(t1[i], 1)
      table.remove(t1[i], 1)
      i = i + 1
    end
  until ta[1] == _ENV["nil"]
  return t1
end

_ENV[function(DBpath, tbl, field, where, req)
  sh_init()
  local iRet, sRet = pcall(function()
    if nil == "" then
      if nil == "" then
        return where.execute(where.string.format("sqlite3 %s 'select %s from %s'", nil, nil, nil))
      else
        return where.execute(where.string.format("sqlite3 %s 'select %s from %s %s'", where.string.format("sqlite3 %s 'select %s from %s'", nil, nil, nil)))
      end
    elseif where.execute == "" then
      return where.execute(where.string.format("sqlite3 %s 'select %s from %s where %s'", where.string.format("sqlite3 %s 'select %s from %s %s'", where.string.format("sqlite3 %s 'select %s from %s'", nil, nil, nil))))
    else
      return where.execute(where.string.format("sqlite3 %s 'select %s from %s where %s %s'", where.string.format("sqlite3 %s 'select %s from %s where %s'", where.string.format("sqlite3 %s 'select %s from %s %s'", where.string.format("sqlite3 %s 'select %s from %s'", nil, nil, nil)))))
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.SQLSelect = SQLSelect
_ENV[function(DBpath, tbl, valtbl)
  sh_init()
  local iRet, sRet = pcall(function()
    local key, val = valtbl, nil
    for k, v in pairs(nil) do
      if key == _ENV["nil"] then
        key = k
      else
        key = key .. "," .. k
      end
      if val == _ENV["nil"] then
        val = string.format("\"%s\"", v)
      else
        val = val .. "," .. string.format("\"%s\"", v)
      end
    end
    local ret = os.execute(string.format("sqlite3 %s 'insert into %s(%s) values(%s)'", nil, nil, key, val))
    if ret then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm
QMPlugin.SQLInsert = SQLInsert

function QMPlugin.SQLUpdate(DBpath, tbl, valtbl, where)
  sh_init()
  local iRet, sRet = pcall(function()
    local str, ret = valtbl, nil
    for k, v in pairs(nil) do
      if str == _ENV["nil"] then
        str = string.format("%s = \"%s\"", k, v)
      else
        str = str .. "," .. string.format("%s = \"%s\"", k, v)
      end
    end
    if pairs(nil) == "" then
      ret = os.execute(string.format("sqlite3 %s 'update %s set %s '", nil, nil, str))
    else
      ret = os.execute(string.format("sqlite3 %s 'update %s set %s where %s'", string.format("sqlite3 %s 'update %s set %s '", nil, nil, str)))
    end
    if ret then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.SQLDelete(DBpath, tbl, where)
  sh_init()
  local iRet, sRet = pcall(function()
    local ret = where
    if nil == "" then
      ret = where.os.execute(where.string.format("sqlite3 %s 'delete from %s '", nil, nil))
    else
      ret = where.os.execute(where.string.format("sqlite3 %s 'delete from %s where %s'", where.string.format("sqlite3 %s 'delete from %s '", nil, nil)))
    end
    if ret then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.LastSMS()
  sh_init()
  local iRet, sRet = pcall(function()
    local dbpath = "/data/data/com.android.providers.telephony/databases/mmssms.db"
    return SQLSelect(dbpath, "sms", "body", "", "order by date desc limit 0, 1")
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.GetSMS(number)
  sh_init()
  local iRet, sRet = pcall(function()
    local dbpath = "/data/data/com.android.providers.telephony/databases/mmssms.db"
    if (nil):len() == 11 then
      number = "+86" .. nil
    end
    return number.SQLSelect(dbpath, "sms", "body", "address=\"" .. nil .. "\" ")
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.AppendPhone(contact)
  sh_init()
  local iRet, sRet = pcall(function()
    local dbpath = "/data/data/com.providers.contacts/databases/contacts2.db"
    local maxID, nickname, phone, ret = _UPVALUE3_, nil, nil, nil
    if Mount("/data/data") == fale then
      return nil
    elseif ChmodEx(dbpath, 777) == false then
      return nil
    end
    local maxID = tonumber(SQLSelect(dbpath, "data", "max(raw_contact_id)", "", ""))
    local i = 1
    for k, v in pairs(SQLSelect(dbpath, "data", "max(raw_contact_id)", "", "")) do
      nickname = k
      ret = SQLInsert(dbpath, "data", {
        data1 = nickname,
        raw_contact_id = maxID + 1,
        mimetype_id = 7
      })
      if v:find("|") then
        phone = LuaAuxLib.StringSplit(v, "|")
        for i = 1, #phone do
          ret = SQLInsert(dbpath, "data", {
            data1 = phone[i],
            raw_contact_id = maxID + 1,
            mimetype_id = 7
          })
        end
      else
        phone = v
        ret = SQLInsert(dbpath, "data", {
          data1 = phone,
          raw_contact_id = maxID + 1,
          mimetype_id = 7
        })
      end
      maxID = maxID + 1
      if ret == false then
        break
      end
    end
    if ret then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

function QMPlugin.type(varname)
  sh_init()
  return type(varname)
end

function QMPlugin.GetVer()
  sh_init()
  return sh_init
end

function QMPlugin.IsDisplayChange(x, y, x1, y1, t, delay)
  sh_init()
  local PicPath, t1, intx, inty = _UPVALUE3_, nil, nil, nil
  PicPath = __MQM_RUNNER_LOCAL_PATH_GLOBAL_NAME__ .. "TmpPic.png"
  t1 = LuaAuxLib.GetTickCount()
  LuaAuxLib.SnapShot(PicPath, x, y, x1, y1)
  while LuaAuxLib.GetTickCount() - t1 < t * 1000 do
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    intx = LuaAuxLib.FindPicture(x - 10, y - 10, x1 + 10, y1 + 10, PicPath, "101010", 0, 0.8)
    if intx == -1 then
      LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      return nil
    end
    LuaAuxLib.Sleep(delay * 1000)
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  return nil
end

function QMPlugin.iif(exp, rtrue, rfalse)
  sh_init()
  if exp == false or exp == 0 then
    return rfalse
  else
    return rtrue
  end
end

function QMPlugin.Eqv(t1, t2)
  sh_init()
  if type(t1) == "boolean" and type(t2) == "boolean" then
    if t1 == t2 then
      return nil
    else
      return nil
    end
  else
    local i1, i2, ir = _UPVALUE2_, nil, nil
    i1 = tonumber(t1)
    i2 = tonumber(t2)
    ir = 0
    for i = 0, 31 do
      local b1 = bit32.band(2 ^ i, i1)
      local b2 = bit32.band(2 ^ i, i2)
      if b1 == b2 then
        ir = bit32.bor(ir, 2 ^ i)
      end
    end
    return ir
  end
end

function QMPlugin.Xor(t1, t2)
  sh_init()
  local i1, i2 = _UPVALUE1_, nil
  i1 = tonumber(t1)
  i2 = tonumber(t2)
  return bit32.bxor(i1, i2)
end

local log = {}

function QMPlugin.LogPath(path, sign)
  sh_init()
  if sign == _ENV["nil"] then
    sign = 0
  end
  _ENV[path] = sign
end

function QMPlugin.OutLog(msg, sign)
  if log.sign == log["nil"] then
    sign = 0
  end
  local t = log.os.date("[%H:%M:%S]")
  local f = log.io.open(log.sign, "a")
  log.assert(f, "日志路径错误")
  f:write(t .. "\t" .. msg .. "\r\n")
  f:close()
end

_ENV[function(path)
  sh_init()
  local localpath, text, tmppath, tmpret = _UPVALUE3_, nil, nil, nil
  
  local function a()
    localpath = localpath.TempFile("mount")
    localpath.os.execute("mount > " .. nil)
    text = localpath.ReadFile("mount > " .. nil)
    tmppath, tmpret = localpath.string.match("mount > " .. nil, [[

([^ ]+ ]] .. nil .. ")([^,]+)")
  end
  
  a()
  os.execute("mount -o rw,remount " .. tmppath)
  a()
  if string.find(tmpret, "rw") then
    return nil
  else
    return nil
  end
end] = _zmm
QMPlugin.Mount = Mount
_ENV[function(path)
  sh_init()
  local iRet, sRet = pcall(function()
    local ret, tmppath, tmpret = _UPVALUE2_, nil, nil
    ret = execute("mount")
    tmppath, tmpret = string.match(ret, [[

([^ ]+ ]] .. nil .. ")([^,]+)")
    if tmppath ~= "" then
      os.execute("mount -o rw,remount " .. tmppath)
    else
      return nil
    end
    ret = execute("mount")
    tmppath, tmpret = string.match(ret, [[

([^ ]+ ]] .. nil .. ")([^,]+)")
    if tmppath ~= "" then
      os.execute("mount -o rw,remount " .. tmppath)
    else
      return nil
    end
    if string.find(tmpret, "rw") then
      return nil
    else
      return nil
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return nil
  end
end] = _zmm

function QMPlugin.GetUIXml()
  sh_init()
  local iRet, sRet = pcall(function()
    os.execute("uiautomator dump ")
    return ReadFile(TempPath() .. "window_dump.xml")
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

local t = {}

function QMPlugin.TimeSign(id)
  sh_init()
  _ENV[os.time()] = os.time()
end

function QMPlugin.Timer(id, diff)
  sh_init()
  local t1 = os.time()
  if diff <= t1 - _ENV[id] then
    _ENV[os.time()] = diff
    return nil
  else
    return nil
  end
end

function QMPlugin.Base64En(data)
  sh_init()
  local key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  return (data:gsub(".", function(x)
    local r, key = "", x:byte()
    for i = 8, 1, -1 do
      r = r .. (key % 2 ^ i - key % 2 ^ (i - 1) > 0 and "1" or "0")
    end
    return r
  end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    for i = 1, 6 do
      c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
    end
    return (1):sub(c + 1, c + 1)
  end) .. ({
    "",
    "==",
    "="
  })[#data % 3 + 1]
end

function QMPlugin.Base64De(data)
  sh_init()
  local key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  data = string.gsub(data, "[^" .. key .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "=" then
      return ""
    end
    local r, f = "", (nil):find(x) - 1
    for i = 6, 1, -1 do
      r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
    end
    return r
  end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    for i = 1, 8 do
      c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
    end
    return string.char(c)
  end))
end

function QMPlugin.Coordinate(ScreenX, ScreenY, Time)
  sh_init()
  local localpath = temppath() .. "Coordinate"
  os.execute("getevent -pl>" .. localpath)
  _ENV[io.open(localpath, "r+")] = ScreenX
  _ENV[file:read("*l")] = ScreenX
  while data ~= _ENV["nil"] do
    _ENV[file:read("*l")] = ScreenX
    if data ~= _ENV["nil"] then
      _ENV[_ENV["nil"]] = ScreenX
      _ENV[data:find("ABS_MT_POSITION_X.*max%s+(%d*)")] = ScreenX
      _ENV[data:find("ABS_MT_POSITION_X.*max%s+(%d*)")] = ScreenX
      _ENV[data:find("ABS_MT_POSITION_X.*max%s+(%d*)")] = ScreenX
      if find ~= _ENV["nil"] then
        _ENV[find] = ScreenX
      end
      _ENV[_ENV["nil"]] = ScreenX
      _ENV[data:find("ABS_MT_POSITION_Y.*max%s+(%d*)")] = ScreenX
      _ENV[data:find("ABS_MT_POSITION_Y.*max%s+(%d*)")] = ScreenX
      _ENV[data:find("ABS_MT_POSITION_Y.*max%s+(%d*)")] = ScreenX
      if find ~= _ENV["nil"] then
        _ENV[find] = ScreenX
      end
    end
  end
  _ENV[tostring(times)] = ScreenX
  os.execute("getevent -l -c " .. Time .. ">" .. localpath)
  _ENV[io.open(localpath, "r+")] = ScreenX
  _ENV[file:read("*l")] = ScreenX
  while data ~= _ENV["nil"] do
    _ENV[file:read("*l")] = ScreenX
    if data ~= _ENV["nil"] then
      if data:find("ABS_MT_POSITION_X") ~= _ENV["nil"] then
        _ENV[math.floor(tonumber(data:sub(59, 62), 16) * ScreenX / maxx)] = ScreenX
      elseif data:find("ABS_MT_POSITION_Y") ~= _ENV["nil"] then
        _ENV[math.floor(tonumber(data:sub(59, 62), 16) * ScreenY / maxy)] = ScreenX
      end
    end
  end
  os.remove(localpath)
  local C = {}
  C[1] = x
  C[2] = y
  return C
end

local function digit_to(n, s)
  if type(n) ~= "number" then
  end
  assert(nil, "arg #1 error: need a number value.")
  if type(s) ~= "string" then
  end
  assert(nil, "arg #2 error: need a string value.")
  if not (1 < #s) then
  end
  assert(nil, "arg #2 error: too short.")
  local fl = math.floor
  local i = 0
  while n > (#s) ^ i do
    i = i + 1
    goto lbl_39
    do break end
    ::lbl_39::
  end
  local ret = ""
  while 0 <= i do
    if n >= (#s) ^ i then
      local tmp = fl(n / (#s) ^ i)
      n = n - tmp * (#s) ^ i
      ret = ret .. s:sub(tmp + 1, tmp + 1)
    elseif ret ~= "" then
      ret = ret .. s:sub(1, 1)
    end
    i = i - 1
  end
  return ret
end

local function to_digit(ns, s)
  if type(ns) ~= "string" then
  end
  assert(nil, "arg #1 error: need a string value.")
  if type(s) ~= "string" then
  end
  assert(nil, "arg #2 error: need a string value.")
  if not (1 < #s) then
  end
  assert(nil, "arg #2 error: too short.")
  local ret = 0
  for i = 1, #ns do
    local fd = s:find(ns:sub(i, i))
    if not fd then
      return _ENV["nil"]
    end
    fd = fd - 1
    ret = ret + fd * (#s) ^ (#ns - i)
  end
  return ret
end

local function s2h(str, spacer)
  return (string.gsub(str, "(.)", function(c)
    return string.format("%02x%s", string.byte(c), c or "")
  end))
end

local function h2s(h)
  return (h:gsub("(%x%x)[ ]?", function(w)
    return string.char(tonumber(w, 16))
  end))
end

function QMPlugin.Unicode2Utf8(us)
  sh_init()
  local u16p = {56320, 55296}
  local u16b = 1023
  local u16fx = ""
  local padl = {
    ["0"] = 7,
    ["1"] = 11,
    ["11"] = 16,
    ["111"] = 21
  }
  local padm = {}
  for k, v in pairs(padl) do
    padm[v] = k
  end
  local map = {
    7,
    11,
    16,
    21
  }
  return (string.gsub(us, "\\[Uu](%x%x%x%x)", function(uc)
    local ud = tonumber(uc, 16)
    for i, v in ipairs(16) do
      if v <= ud and ud < v + nil then
        ud = ud - v + (i - 1) * 64
        if i - 1 > 0 then
          u16fx = (i - 1)(ud, "01")
          return ""
        end
        local bi = ("")(ud, "01")
        uc = string.format("%x", (nil)(nil .. string.rep("0", 10 - #bi) .. bi, "01"))
        u16fx = ""
        ud = tonumber(uc, 16)
        break
      end
    end
    local bins = ipairs(16)(ud, "01")
    local pads = ""
    for _, i in ipairs(nil) do
      if i >= #bins then
        pads = _ENV[i]
        break
      end
    end
    while #bins < _ENV[pads] do
      bins = "0" .. bins
    end
    local tmp = ""
    if pads ~= "0" then
      tmp = bins
      bins = ""
    end
    while 0 < #tmp do
      bins = "10" .. string.sub(tmp, -6, -1) .. bins
      tmp = string.sub(tmp, 1, -7)
    end
    return (string.gsub(string.format("%x", (-7)(pads .. bins, "01")), "(%x%x)", function(w)
      return string.char(tonumber(w, 16))
    end))
  end))
end

function QMPlugin.Utf82Unicode(s, upper)
  sh_init()
  local uec = 0
  s = s:gsub("\\", "\\")
  if upper then
    upper = "\\U"
  else
    upper = "\\u"
  end
  local loop1 = string.gsub(s(s), "(%x%x)", function(w)
    local wc = tonumber(w, 16)
    if 127 < wc then
      if 0 < w then
        uec = w - 1
        if w - 1 == 0 then
          return w .. "/"
        end
        return w
      end
      local bi = (w .. "/")(wc, "01")
      bi = string.sub(bi, 2, -1)
      while string.sub(bi, 1, 1) == "1" do
        bi = string.sub(bi, 2, -1)
        uec = string.sub(bi, 2, -1) + 1
      end
      return "u/" .. w
    elseif 0 < string.sub(bi, 2, -1) then
      uec = 0
      return w .. "/"
    end
    return w
  end)
  local u16p = {56320, 55296}
  local u16id = 65536
  local loop2 = string.gsub(loop1, "u/(%x%x*)/", function(w)
    local wc = tonumber(w, 16)
    local tmp = _ENV
    local bi = (16)(wc, "01")
    tmp = ""
    while 8 < #bi do
      tmp = string.sub(bi, -6, -1) .. tmp
      bi = string.sub(bi, 1, -9)
    end
    bi = bi .. tmp
    while string.sub(bi, 1, 1) == "1" do
      bi = string.sub(bi, 2, -1)
    end
    wc = string.sub(bi, 2, -1)(bi, "01")
    if string.sub(bi, 2, -1)(bi, "01") <= wc then
      wc = wc - string.sub(bi, 2, -1)(bi, "01")
      tmp = string.sub(bi, 2, -1)(bi, "01")(wc, "01")
      tmp = string.rep("0", 20 - #tmp) .. tmp
      local low = string.rep("0", 20 - #tmp)(string.sub(tmp, -10, -1), "01") + _ENV[1]
      local high = _ENV[1](string.sub(tmp, 1, -11), "01") + _ENV[2]
      tmp = string.format("%4x", low)
      return string.format("%4x", low)("%4x" .. string.format("%4x", high) .. "%4x" .. string.format("%4x", low))
    end
    local h = string.format("%x", wc)
    if #h % 2 ~= 0 then
      h = "0" .. h
    end
    return ("0")(h .. h)
  end)
  return loop1(loop2)
end

function QMPlugin.ToTime(Date, format)
  sh_init()
  local iRet, sRet = pcall(function()
    local Year, Month, Day, Hour, Min, Sec = _UPVALUE5_, nil, nil, nil, nil, nil
    _ENV[{}] = Year
    Year, Month, Day, Hour, Min, Sec = ({}):find(nil)
    _ENV[({}):find(nil)] = Year
    _ENV[({}):find(nil)] = Year
    Time.year = Year
    Time.month = Month
    Time.day = Day
    Time.hour = Hour
    Time.min = Min
    Time.sec = Sec
    if next(Time) then
      return os.time(Time)
    else
      return 0
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end

function QMPlugin.SecToDay(Sec)
  sh_init()
  local iRet, sRet = pcall(function()
    local Day, Hour, Min = 0, 0, 0
    if nil < 0 then
      return "0天0小时0分0秒"
    end
    Sec = Sec.tonumber(nil)
    for i = 1, nil / 60 do
      Min = Min + 1
      if Min == 60 then
        Min = 0
        Hour = Hour + 1
      end
      if Hour == 24 then
        Hour = 0
        Day = Day + 1
      end
    end
    Sec = 1 % 60
    return Day .. "天" .. Hour .. "小时" .. Min .. "分" .. nil .. "秒"
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end

function QMPlugin.GetDistance(lat1, lng1, lat2, lng2)
  sh_init()
  
  local function rad(d)
    return d * math.pi / 180
  end
  
  local radLat1 = rad(lat1)
  local radLat2 = rad(lat2)
  return math.floor(2 * math.asin(math.sqrt(math.pow(math.sin((radLat1 - radLat2) / 2), 2) + math.cos(radLat1) * math.cos(radLat2) * math.pow(math.sin((rad(lng1) - rad(lng2)) / 2), 2))) * 6378.137 * 10000) / 10000
end

function QMPlugin.CompareTime(Year, Month, Day, Hour, Min, Sec)
  sh_init()
  local NowNetTime = LuaAuxLib.URL_OperationGet("http://52xiaov.com/getipinfo.php"):match("秒数%):(.-)</body>")
  if NowNetTime == _ENV["nil"] then
    return _ENV
  else
    NowNetTime = tonumber(NowNetTime)
  end
  local Time = {}
  Time.year = Year
  Time.month = Month
  Time.day = Day
  Time.hour = Hour
  Time.min = Min
  Time.sec = Sec
  local ExpireTime = os.time(Time)
  if NowNetTime > ExpireTime then
    return -1
  else
    return ExpireTime - NowNetTime
  end
end

function QMPlugin.LateTime(late, Year, Month, Day)
  sh_init()
  local starttime = _ENV
  if Day ~= _ENV["nil"] then
    local Time = {}
    Time.year = Year
    Time.month = Month
    Time.day = Day
    starttime = os.time(Time)
  else
    starttime = os.time()
  end
  return os.date("%Y-%m-%d", starttime + tonumber(late) * 24 * 60 * 60)
end

function QMPlugin.GetNetTime()
  sh_init()
  local iRet, sRet = pcall(function()
    local timetext = execute("curl --connect-timeout 10 -I www.taobao.com")
    local Time = {}
    if timetext == _ENV["nil"] then
      return ""
    end
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    _ENV[string.find(timetext, "Date: (%a+), (%d+) (%a+) (%d+) (%d+):(%d+):(%d+)")] = timetext
    Time = {
      Jan = 1,
      Feb = 2,
      Mar = 3,
      Apr = 4,
      May = 5,
      Jun = 6,
      Jul = 7,
      Aug = 8,
      Sep = 9,
      Oct = 10,
      Nov = 11,
      Dec = 12
    }
    if year == _ENV["nil"] then
      return _ENV["nil"]
    else
      return string.format("%s/%s/%s %s:%s:%s", year, Time[mouth], day, tonumber(hour) + 8, min, sec)
    end
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return _ENV["nil"]
  end
end

function QMPlugin.Eval(expr)
  sh_init()
  local iRet, sRet = pcall(function()
    _ENV[load("return " .. nil)] = load("return " .. nil)
    return f()
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end

_ENV[function(r, g, b)
  sh_init()
  local iRet, sRet = pcall(function()
    local R, G, B
    local max = r.math.max(R, G, B)
    local min = r.math.min(R, G, B)
    if R == max then
      r[(G - B) / (max - min)] = max
    end
    if G == max then
      r[2 + (B - R) / (max - min)] = max
    end
    if B == max then
      r[4 + (R - G) / (max - min)] = max
    end
    r[r.math.floor(r.H * 60 + 0.5)] = max
    if r.H < 0 then
      r[r.H + 360] = max
    end
    r[r.math.floor(r.math.max(R, G, B) / 255 * 100 + 0.5)] = max
    r[r.math.floor((max - min) / max * 100 + 0.5)] = max
    return {
      r.H,
      r.S,
      r.V
    }
  end)
  if iRet == true then
    return sRet
  else
    print(sRet)
    return ""
  end
end] = _zmm

function QMPlugin.GetUnixTime(tim)
  local tmpstr = tim .. " "
  local tDate = {}
  tDate.year, tDate.month, tDate.day, tDate.hour, tDate.min, tDate.sec = tmpstr:find("(%d-)%-(%d-)%-(%d-) (%d-):(%d-):(%d-) ")
  _ENV[tmpstr:find("(%d-)%-(%d-)%-(%d-) (%d-):(%d-):(%d-) ")] = tim
  _ENV[tmpstr:find("(%d-)%-(%d-)%-(%d-) (%d-):(%d-):(%d-) ")] = tim
  if tDate.year then
    return os.time(tDate)
  else
    return 0
  end
end

_ENV[QMPlugin] = _zmm
_ENV[_ENV] = _zmm
_ENV[{}] = _zmm

function QMPlugin.Start(thread_func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
  _ENV[function()
    ThreadHelper.InitThread()
    ThreadHelper.InitThread(nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
  end] = thread_func
  return ThreadHelper.CreateThread()
end

function QMPlugin.Stop(thread_handle)
  thread_handle:cancel()
end

function QMPlugin.Wait(thread_handle)
  thread_handle:join()
end

function QMPlugin.SetShareVar(key, value)
  key = string.upper(tostring(key))
  Thread_SharedVariableStore:set(key, value)
end

function QMPlugin.GetShareVar(key)
  key = string.upper(tostring(key))
  return Thread_SharedVariableStore:get(key)
end

function QMPlugin.Lock()
  ThreadHelper.Lock()
end

function QMPlugin.Release()
  ThreadHelper.Release()
end

_ENV[QMPlugin] = _zmm
_ENV[_ENV] = _zmm
_ENV[{}] = _zmm

function QMPlugin.Year(time)
  if time == nil then
    time = os.time()
  end
  return os.date("*t", time).year
end

function QMPlugin.Month(time)
  if time == nil then
    time = os.time()
  end
  return os.date("*t", time).month
end

function QMPlugin.Day(time)
  if time == nil then
    time = os.time()
  end
  return os.date("*t", time).day
end

function QMPlugin.Hour(time)
  if time == nil then
    time = os.time()
  end
  return os.date("*t", time).hour
end

function QMPlugin.Minute(time)
  if time == nil then
    time = os.time()
  end
  return os.date("*t", time).min
end

function QMPlugin.Second(time)
  if time == nil then
    time = os.time()
  end
  return os.date("*t", time).sec
end

function QMPlugin.WeekDay(time)
  if time == nil then
    time = os.time()
  end
  _ENV[os.date("*t", time).wday - 1] = time
  if weekday == 0 then
    _ENV[7] = time
  end
  return weekday
end

function QMPlugin.YearDay(time)
  if time == nil then
    time = os.time()
  end
  return os.date("*t", time).yday
end

function QMPlugin.Format(format, time)
  if time == nil then
    time = os.time()
  end
  if format == nil then
    format = "%Y-%m-%d %H:%M:%S"
  end
  return os.date(format, time)
end

_ENV[QMPlugin] = _zmm
_ENV[_ENV] = _zmm
_ENV[{}] = _zmm
id46.id494e5458 = _ENV["nil"]
id46.id494e5458 = 1
id46.id494e5459 = _ENV["nil"]

function id46.ide698bee7a4ba()
  local ide698bee7a4ba3a41 = _ENV
  ide698bee7a4ba3a41 = Thread.GetShareVar("线程")
  LuaAuxLib.TracePrint("F_8:", id46.id494e5458, ide698bee7a4ba3a41)
end

function id46.ide5a49ae782b9e695b0e7bb84(ide5a49ae782b9e695b0e7bb843ae695b0e7bb84)
  local ReturnValueVar = _ENV
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  for ide5a49ae782b9e695b0e7bb843a49 = 0, LuaAuxLib.TableSize(ide5a49ae782b9e695b0e7bb843ae695b0e7bb84) - 1, 7 do
    id46.id494e5458, id46.id494e5459 = LuaAuxLib.FindMultiColor(ide5a49ae782b9e695b0e7bb843ae695b0e7bb84[ide5a49ae782b9e695b0e7bb843a49 + 1 + 1] - 2, ide5a49ae782b9e695b0e7bb843ae695b0e7bb84[ide5a49ae782b9e695b0e7bb843a49 + 2 + 1] - 2, ide5a49ae782b9e695b0e7bb843ae695b0e7bb84[ide5a49ae782b9e695b0e7bb843a49 + 3 + 1] + 2, ide5a49ae782b9e695b0e7bb843ae695b0e7bb84[ide5a49ae782b9e695b0e7bb843a49 + 4 + 1] + 2, ide5a49ae782b9e695b0e7bb843ae695b0e7bb84[ide5a49ae782b9e695b0e7bb843a49 + 5 + 1], ide5a49ae782b9e695b0e7bb843ae695b0e7bb84[ide5a49ae782b9e695b0e7bb843a49 + 6 + 1], 0, 1)
    if id46.id494e5458 > -1 and id46.id494e5459 > -1 then
      ReturnValueVar = LuaAuxLib.NewArray(ide5a49ae782b9e695b0e7bb843ae695b0e7bb84[ide5a49ae782b9e695b0e7bb843a49 + 1], id46.id494e5458, id46.id494e5459, ide5a49ae782b9e695b0e7bb843a49 / 7)
      LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      return ReturnValueVar
    end
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  ReturnValueVar = LuaAuxLib.NewArray("未知页面", -1, -1, -1)
  return ReturnValueVar
end

function id46.ide5a49ae782b9e695b0e7bb84e69da1e4bbb6(ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84)
  local ReturnValueVar = _ENV
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  for ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 = 0, LuaAuxLib.TableSize(ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84) - 1, 8 do
    if ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 1 + 1] == true then
      id46.id494e5458, id46.id494e5459 = LuaAuxLib.FindMultiColor(ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 2 + 1], ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 3 + 1], ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 4 + 1], ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 5 + 1], ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 6 + 1], ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 7 + 1], 0, 1)
      if id46.id494e5458 > -1 and id46.id494e5459 > -1 then
        ReturnValueVar = LuaAuxLib.NewArray(ide5a49ae782b9e695b0e7bb84e69da1e4bbb63ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 + 1], id46.id494e5458, id46.id494e5459, ide5a49ae782b9e695b0e7bb84e69da1e4bbb63a49 / 8)
        LuaAuxLib.KeepReleaseScreenSnapshot(nil)
        return ReturnValueVar
      end
    end
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  ReturnValueVar = LuaAuxLib.NewArray("未知页面", -1, -1, -1)
  return ReturnValueVar
end

function id46.ide5a49ae782b9e695b0e7bb8432(ide5a49ae782b9e695b0e7bb84323a58, ide5a49ae782b9e695b0e7bb84323a59, ide5a49ae782b9e695b0e7bb84323a5831, ide5a49ae782b9e695b0e7bb84323a5931, ide5a49ae782b9e695b0e7bb84323ae695b0e7bb84)
  local ReturnValueVar = _ENV
  for ide5a49ae782b9e695b0e7bb84323a49 = 0, LuaAuxLib.TableSize(ide5a49ae782b9e695b0e7bb84323ae695b0e7bb84) - 1, 3 do
    id46.id494e5458, id46.id494e5459 = LuaAuxLib.FindMultiColor(ide5a49ae782b9e695b0e7bb84323a58, ide5a49ae782b9e695b0e7bb84323a59, ide5a49ae782b9e695b0e7bb84323a5831, ide5a49ae782b9e695b0e7bb84323a5931, ide5a49ae782b9e695b0e7bb84323ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84323a49 + 1 + 1], ide5a49ae782b9e695b0e7bb84323ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84323a49 + 2 + 1], 0, 1)
    if id46.id494e5458 > -1 and id46.id494e5459 > -1 then
      ReturnValueVar = LuaAuxLib.NewArray(ide5a49ae782b9e695b0e7bb84323ae695b0e7bb84[ide5a49ae782b9e695b0e7bb84323a49 + 1], id46.id494e5458, id46.id494e5459)
      return ReturnValueVar
    end
  end
  ReturnValueVar = LuaAuxLib.NewArray("未知页面", id46.id494e5458, id46.id494e5459)
  return ReturnValueVar
end

function id46.ide5a49ae782b9e689be(ide5a49ae782b9e689be3a5831, ide5a49ae782b9e689be3a5931, ide5a49ae782b9e689be3a5832, ide5a49ae782b9e689be3a5932, ide5a49ae782b9e689be3ae782b9e587bbe889b2, ide5a49ae782b9e689be3ae5a49ae889b2)
  local ReturnValueVar = _ENV
  id46.id494e5458, id46.id494e5459 = LuaAuxLib.FindMultiColor(ide5a49ae782b9e689be3a5831, ide5a49ae782b9e689be3a5931, ide5a49ae782b9e689be3a5832, ide5a49ae782b9e689be3a5932, ide5a49ae782b9e689be3ae782b9e587bbe889b2, ide5a49ae782b9e689be3ae5a49ae889b2, 0, 1)
  if id46.id494e5458 > -1 and id46.id494e5459 > -1 then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end

function id46.ide58cbae59f9fe689be(ide58cbae59f9fe689be3a5831, ide58cbae59f9fe689be3a5931, ide58cbae59f9fe689be3a5832, ide58cbae59f9fe689be3a5932, ide58cbae59f9fe689be3ae5a49ae889b2)
  local ReturnValueVar = _ENV
  ;(function()
    local _ret_val_ = _ENV
    id46.id494e5458, id46.id494e5459, _ret_val_ = LuaAuxLib.FindColor(nil, nil, nil, nil, nil, 0, 1)
    return _ret_val_
  end)()
  if id46.id494e5458 > -1 and -1 < id46.id494e5459 then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end

function id46.ide58892e58aa8(ide58892e58aa83a5831, ide58892e58aa83a5931, ide58892e58aa83a5832, ide58892e58aa83a5932, ide58892e58aa83ae697b6e995bf)
  LuaAuxLib.TouchOperation(0, ide58892e58aa83a5831, ide58892e58aa83a5931, _ENV, 0)
  LuaAuxLib.Sleep(111)
  LuaAuxLib.TouchOperation(1, ide58892e58aa83a5832, ide58892e58aa83a5932, _UPVALUE1_, 0)
  LuaAuxLib.Sleep(ide58892e58aa83ae697b6e995bf)
  LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
end

function id46.ide58f91e982aee4bbb6(ide58f91e982aee4bbb63ae6a087e9a298, ide58f91e982aee4bbb63ae58685e5aeb9)
  LuaAuxLib.SendSimpleEmail("smtp.qq.com", "185599477@qq.com", "dmfwcyvzcimobhgi", ide58f91e982aee4bbb63ae6a087e9a298, ide58f91e982aee4bbb63ae58685e5aeb9, "57075654@qq.com")
end

function id46.ide59cb0e59bbee59d90e6a087e8bf9ee68ea5(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b5b7e782b9, ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae7bb88e782b9, ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2)
  local ReturnValueVar, ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae69fa5e689bee58897e8a1a8 = _UPVALUE1_, nil
  ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae69fa5e689bee58897e8a1a8 = LuaAuxLib.NewArray(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b5b7e782b9)
  local ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b7afe7babf = _ENV
  ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b7afe7babf = LuaAuxLib.NewArray("0-0")
  local ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae689bee8bf87 = _ENV
  ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae689bee8bf87 = LuaAuxLib.NewArray(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b5b7e782b9)
  while true do
    for ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a43 = 0, LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae69fa5e689bee58897e8a1a8) - 1 do
      for ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a49 = 0, LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2) - 1, 3 do
        if ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a49 + 1] == ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae69fa5e689bee58897e8a1a8[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a43 + 1] then
          local ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a5a44 = _ENV
          for ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a5a47 = 0, LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae689bee8bf87) - 1 do
            if ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae689bee8bf87[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a5a47 + 1] == ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a49 + 2 + 1] then
              ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a5a44 = nil
              break
            end
            ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a5a44 = nil
          end
          if ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a5a44 == false then
            ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae69fa5e689bee58897e8a1a8[LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae69fa5e689bee58897e8a1a8) - 1 + 1 + 1] = ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a49 + 2 + 1]
            ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae689bee8bf87[LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae689bee8bf87) - 1 + 1 + 1] = ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a49 + 2 + 1]
            local ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a42 = _ENV
            ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a42 = ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a49 + 1 + 1]
            local ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a4c = _ENV
            for ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a44 = 0, LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a42) - 1, 2 do
              ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a4c = (((ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a4c .. "-") .. ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a42[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a44 + 1]) .. "-") .. ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a42[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a44 + 1 + 1]
            end
            ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b7afe7babf[LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b7afe7babf) - 1 + 1 + 1] = ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b7afe7babf[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a43 + 1] .. ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a4c
          end
          if ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae59cbae699afe58887e68da2[ide59cb0e59bbee59d90e6a087e8bf9ee68ea53a49 + 2 + 1] == ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae7bb88e782b9 then
            ReturnValueVar = ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b7afe7babf[LuaAuxLib.TableSize(ide59cb0e59bbee59d90e6a087e8bf9ee68ea53ae8b7afe7babf) - 1 + 1]
            return ReturnValueVar
          end
        end
      end
    end
  end
  return ReturnValueVar
end

function id46.ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb84(ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843ae695b0e7bb84, ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a58, ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a59, ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a42, ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843ae698bee7a4bae8be93e587ba)
  for ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a49 = 0, ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a58 do
    ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843ae695b0e7bb84[ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a49 + 1] = {0}
    for ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a41 = 0, ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a59 do
      ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843ae695b0e7bb84[ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a49 + 1][ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a41 + 1] = ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a42
    end
  end
  if ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843ae698bee7a4bae8be93e587ba == 1 then
    for ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a49 = 0, LuaAuxLib.TableSize(ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843ae695b0e7bb84) - 1 do
      LuaAuxLib.TracePrint("F_132:", table.concat(ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843ae695b0e7bb84[ide696b0e5bbbae4ba8ce7bbb4e695b0e7bb843a49 + 1], "-"))
    end
  end
end

function id46.ide7baa6e58886(ide7baa6e588863a41, ide7baa6e588863a42)
  local ReturnValueVar, ide7baa6e588863ae69c80e5a4a7e585ace7baa6 = _UPVALUE1_, nil
  if ide7baa6e588863a42 < ide7baa6e588863a41 then
    ide7baa6e588863ae69c80e5a4a7e585ace7baa6 = ide7baa6e588863a42
  else
    ide7baa6e588863ae69c80e5a4a7e585ace7baa6 = ide7baa6e588863a41
  end
  for ide7baa6e588863a49 = ide7baa6e588863ae69c80e5a4a7e585ace7baa6, 1, -1 do
    local ide7baa6e588863a4141 = _ENV
    ide7baa6e588863a4141 = ide7baa6e588863a41 % ide7baa6e588863a49
    local ide7baa6e588863a4242 = _ENV
    ide7baa6e588863a4242 = ide7baa6e588863a42 % ide7baa6e588863a49
    if ide7baa6e588863a4141 == 0 and ide7baa6e588863a4242 == 0 then
      LuaAuxLib.TracePrint("F_147:", "最大公约数" .. ide7baa6e588863a49)
      ReturnValueVar = {
        ide7baa6e588863a41 / ide7baa6e588863a49,
        ide7baa6e588863a42 / ide7baa6e588863a49
      }
      break
    end
  end
  return ReturnValueVar
end

function id46.ide8be93e585a5(ide8be93e585a53a41)
  LuaAuxLib.SetClipText(ide8be93e585a53a41)
  LuaAuxLib.Sleep(555)
  zm.KeyPressPaste()
end

function id46.ide5a49ae58886e5818fe7a7bb()
  local ReturnValueVar, ide5a49ae58886e5818fe7a7bb3a5059 = _UPVALUE1_, nil
  if LuaAuxLib.GetScreenInfo(0) > LuaAuxLib.GetScreenInfo(1) then
    ide5a49ae58886e5818fe7a7bb3a5059 = LuaAuxLib.GetScreenInfo(0) / (LuaAuxLib.GetScreenInfo(1) / 720) - 1280
    LuaAuxLib.SetScreenScale(0, 1280 + ide5a49ae58886e5818fe7a7bb3a5059, 720, _ENV)
  else
    ide5a49ae58886e5818fe7a7bb3a5059 = LuaAuxLib.GetScreenInfo(1) / (LuaAuxLib.GetScreenInfo(0) / 720) - 1280
    LuaAuxLib.SetScreenScale(0, 720, 1280 + ide5a49ae58886e5818fe7a7bb3a5059, _ENV)
  end
  ReturnValueVar = ide5a49ae58886e5818fe7a7bb3a5059
  return ReturnValueVar
end

function id46.ide688aae59bbe()
  local ReturnValueVar, ide688aae59bbe3a41 = _UPVALUE1_, nil
  ide688aae59bbe3a41 = ("/sdcard/ATU/" .. LuaAuxLib.VBS_Relpace(os.date("%Y/%m/%d"), "/", "", _ENV)) .. "/"
  local ide688aae59bbe3a42 = _ENV
  ide688aae59bbe3a42 = LuaAuxLib.DIR_Create(ide688aae59bbe3a41)
  LuaAuxLib.SnapShot((((((ide688aae59bbe3a41 .. DateTime.Hour()) .. ":") .. DateTime.Minute()) .. ":") .. DateTime.Second()) .. ".png", _UPVALUE3_, "", _ENV, nil)
  LuaAuxLib.TracePrint("F_174:", (((((("截图至" .. ide688aae59bbe3a41) .. DateTime.Hour()) .. ":") .. DateTime.Minute()) .. ":") .. DateTime.Second()) .. ".png")
  return ReturnValueVar
end

function id46.ide9818de58e86e69687e4bbb6(ide9818de58e86e69687e4bbb63ae8b7afe5be84, ide9818de58e86e69687e4bbb63ae7b1bbe59e8b)
  local ReturnValueVar, ide9818de58e86e69687e4bbb63a46494c45415252 = _UPVALUE1_, nil
  if ide9818de58e86e69687e4bbb63ae7b1bbe59e8b == 1 then
    ide9818de58e86e69687e4bbb63a46494c45415252 = ShanHai.ScanPath("/sdcard/" .. ide9818de58e86e69687e4bbb63ae8b7afe5be84, 1)
  else
    ide9818de58e86e69687e4bbb63a46494c45415252 = ShanHai.ScanPath("/sdcard/" .. ide9818de58e86e69687e4bbb63ae8b7afe5be84)
  end
  ReturnValueVar = ide9818de58e86e69687e4bbb63a46494c45415252
  return ReturnValueVar
end

function id46.ide59bbee78987e69fa5e79c8b()
  local ReturnValueVar, ide59bbee78987e69fa5e79c8b3a41 = _UPVALUE1_, nil
  ide59bbee78987e69fa5e79c8b3a41 = id46.ide9818de58e86e69687e4bbb6("ATU", 1)
  LuaAuxLib.TracePrint("F_188:", table.concat(ide59bbee78987e69fa5e79c8b3a41, "-"))
  LuaAuxLib.UI_NewLayout("下拉选择日期", 0, 80, 10)
  LuaAuxLib.UI_AddSpinner("下拉选择日期", "日期选择", LuaAuxLib.Encode_GetJsonLib():encode(ide59bbee78987e69fa5e79c8b3a41), 0, 50, 30)
  LuaAuxLib.UI_Show("下拉选择日期")
  local ide59bbee78987e69fa5e79c8b3a4141 = _ENV
  ide59bbee78987e69fa5e79c8b3a4141 = LuaAuxLib.Encode_GetJsonLib():decode(LuaAuxLib.UI_GetValue("日期选择"))
  LuaAuxLib.TracePrint("F_193:", ide59bbee78987e69fa5e79c8b3a4141["日期选择"], ide59bbee78987e69fa5e79c8b3a41[ide59bbee78987e69fa5e79c8b3a4141["日期选择"] + 1])
  local ide59bbee78987e69fa5e79c8b3a574a = _ENV
  ide59bbee78987e69fa5e79c8b3a574a = ide59bbee78987e69fa5e79c8b3a41[ide59bbee78987e69fa5e79c8b3a4141["日期选择"] + 1]
  LuaAuxLib.TracePrint("F_195:", "ATU/" .. ide59bbee78987e69fa5e79c8b3a41[ide59bbee78987e69fa5e79c8b3a4141["日期选择"] + 1])
  local ide59bbee78987e69fa5e79c8b3a424242 = _ENV
  ide59bbee78987e69fa5e79c8b3a424242 = id46.ide9818de58e86e69687e4bbb6("ATU/" .. ide59bbee78987e69fa5e79c8b3a41[ide59bbee78987e69fa5e79c8b3a4141["日期选择"] + 1], 0)
  LuaAuxLib.TracePrint("F_197:", table.concat(ide59bbee78987e69fa5e79c8b3a424242, "-"))
  for TempVar, ide59bbee78987e69fa5e79c8b3a414141 in pairs(ide59bbee78987e69fa5e79c8b3a424242) do
    LuaAuxLib.UI_NewLayout("查看图片", 0, 720, 2222)
    local ide59bbee78987e69fa5e79c8b3a4c4a = _ENV
    ide59bbee78987e69fa5e79c8b3a4c4a = "/sdcard/ATU/" .. ide59bbee78987e69fa5e79c8b3a574a
    LuaAuxLib.TracePrint("F_201:", ide59bbee78987e69fa5e79c8b3a414141, (ide59bbee78987e69fa5e79c8b3a4c4a .. "/") .. ide59bbee78987e69fa5e79c8b3a414141)
    local ide59bbee78987e69fa5e79c8b3a41414141 = _ENV
    ide59bbee78987e69fa5e79c8b3a41414141 = (ide59bbee78987e69fa5e79c8b3a4c4a .. "/") .. ide59bbee78987e69fa5e79c8b3a414141
    LuaAuxLib.TracePrint("F_203:", ide59bbee78987e69fa5e79c8b3a41414141)
    LuaAuxLib.UI_AddImageView("查看图片", "图片", ide59bbee78987e69fa5e79c8b3a41414141, 720, 1280)
    LuaAuxLib.UI_Show("查看图片")
  end
  return ReturnValueVar
end

function id46.ide7bd91e7bb9ce697b6e997b4()
  local ReturnValueVar, ide7bd91e7bb9ce697b6e997b43ae697a5e69c9f, ide7bd91e7bb9ce697b6e997b43ae697b6e997b4, ide7bd91e7bb9ce697b6e997b43a4647 = _UPVALUE3_, nil, nil, nil
  ide7bd91e7bb9ce697b6e997b43a4647 = LuaAuxLib.StringSplit(LuaAuxLib.DEVICE_GetDeviceInfo(4), " ")
  ide7bd91e7bb9ce697b6e997b43ae697a5e69c9f = LuaAuxLib.StringSplit(ide7bd91e7bb9ce697b6e997b43a4647[1], "-")
  ide7bd91e7bb9ce697b6e997b43ae697b6e997b4 = LuaAuxLib.StringSplit(ide7bd91e7bb9ce697b6e997b43a4647[2], ":")
  ReturnValueVar = table.concat(ide7bd91e7bb9ce697b6e997b43ae697a5e69c9f, "") .. table.concat(ide7bd91e7bb9ce697b6e997b43ae697b6e997b4, "")
  return ReturnValueVar
end

function id46.ide6a8aae7ab96e8bdace68da2(ide6a8aae7ab96e8bdace68da23a535a, ide6a8aae7ab96e8bdace68da23a5059)
  local ReturnValueVar = _ENV
  if LuaAuxLib.GetScreenInfo(0) > LuaAuxLib.GetScreenInfo(1) then
    for ide6a8aae7ab96e8bdace68da23a49 = 0, LuaAuxLib.TableSize(ide6a8aae7ab96e8bdace68da23a535a) - 1, 7 do
      local ide6a8aae7ab96e8bdace68da23a41 = _ENV
      ide6a8aae7ab96e8bdace68da23a41 = ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 1 + 1]
      local ide6a8aae7ab96e8bdace68da23a42 = _ENV
      ide6a8aae7ab96e8bdace68da23a42 = ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 2 + 1]
      local ide6a8aae7ab96e8bdace68da23a43 = _ENV
      ide6a8aae7ab96e8bdace68da23a43 = ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 3 + 1]
      local ide6a8aae7ab96e8bdace68da23a44 = _ENV
      ide6a8aae7ab96e8bdace68da23a44 = ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 4 + 1]
      ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 4 + 1] = 720 - ide6a8aae7ab96e8bdace68da23a41
      ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 3 + 1] = ide6a8aae7ab96e8bdace68da23a44 + ide6a8aae7ab96e8bdace68da23a5059
      ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 2 + 1] = 720 - ide6a8aae7ab96e8bdace68da23a43
      ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 1 + 1] = ide6a8aae7ab96e8bdace68da23a42
      local ide6a8aae7ab96e8bdace68da23a4647 = _ENV
      ide6a8aae7ab96e8bdace68da23a4647 = LuaAuxLib.StringSplit(ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 6 + 1], ",")
      for TempVar = 0, LuaAuxLib.TableSize(ide6a8aae7ab96e8bdace68da23a4647) - 1 do
        ide6a8aae7ab96e8bdace68da23a41 = TempVar
        local ide6a8aae7ab96e8bdace68da23a46474647 = _ENV
        ide6a8aae7ab96e8bdace68da23a46474647 = LuaAuxLib.StringSplit(ide6a8aae7ab96e8bdace68da23a4647[ide6a8aae7ab96e8bdace68da23a41 + 1], "|")
        ide6a8aae7ab96e8bdace68da23a4647[ide6a8aae7ab96e8bdace68da23a41 + 1] = (((ide6a8aae7ab96e8bdace68da23a46474647[2] .. "|") .. 0 - ide6a8aae7ab96e8bdace68da23a46474647[1]) .. "|") .. ide6a8aae7ab96e8bdace68da23a46474647[3]
      end
      ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 6 + 1] = table.concat(ide6a8aae7ab96e8bdace68da23a4647, ",")
    end
  else
    for ide6a8aae7ab96e8bdace68da23a49 = 0, LuaAuxLib.TableSize(ide6a8aae7ab96e8bdace68da23a535a) - 1, 7 do
      ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 4 + 1] = ide6a8aae7ab96e8bdace68da23a535a[ide6a8aae7ab96e8bdace68da23a49 + 4 + 1] + ide6a8aae7ab96e8bdace68da23a5059
    end
  end
  ReturnValueVar = ide6a8aae7ab96e8bdace68da23a535a
  return ReturnValueVar
end

function id46.ide4b8ade997b4e5ad97e7aca6(ide4b8ade997b4e5ad97e7aca63ae6ba90e7a081, ide4b8ade997b4e5ad97e7aca63ae5b7a6, ide4b8ade997b4e5ad97e7aca63ae58fb3)
  local ReturnValueVar, ide4b8ade997b4e5ad97e7aca63ae5b7a6e4b8aae695b0 = _UPVALUE1_, nil
  ide4b8ade997b4e5ad97e7aca63ae5b7a6e4b8aae695b0 = LuaAuxLib.TableSize(ide4b8ade997b4e5ad97e7aca63ae5b7a6) - 1
  local ide4b8ade997b4e5ad97e7aca63ae58f96e5b7a6 = _ENV
  ide4b8ade997b4e5ad97e7aca63ae58f96e5b7a6 = string.sub(ide4b8ade997b4e5ad97e7aca63ae6ba90e7a081, 0, LuaAuxLib.VBS_InStr(ide4b8ade997b4e5ad97e7aca63ae6ba90e7a081, ide4b8ade997b4e5ad97e7aca63ae58fb3, 1, _ENV) - 1)
  local ide4b8ade997b4e5ad97e7aca63ae58f96e58fb3 = _ENV
  ide4b8ade997b4e5ad97e7aca63ae58f96e58fb3 = string.sub(ide4b8ade997b4e5ad97e7aca63ae58f96e5b7a6, -(LuaAuxLib.TableSize(ide4b8ade997b4e5ad97e7aca63ae58f96e5b7a6) - LuaAuxLib.VBS_InStrRev(ide4b8ade997b4e5ad97e7aca63ae58f96e5b7a6, ide4b8ade997b4e5ad97e7aca63ae5b7a6, -1, _ENV) - ide4b8ade997b4e5ad97e7aca63ae5b7a6e4b8aae695b0))
  ReturnValueVar = ide4b8ade997b4e5ad97e7aca63ae58f96e58fb3
  return ReturnValueVar
end

function id46.id5843()
  LuaAuxLib.Sleep(1000)
  for id58433a49 = 10, 1, -1 do
    LuaAuxLib.ShowMessage(tostring("加载完成后自动关闭"), 0, 0, 0)
    LuaAuxLib.Sleep(1000)
  end
  local id58433a494e5458, id58433a494e5459 = _UPVALUE1_, 1
  id58433a494e5458, id58433a494e5459 = LuaAuxLib.FindMultiColor(444, 696, 553, 1161, "333333-111111", "26|-7|333333-111111,26|8|333333-111111,8|2|FFFFFF-111111", 0, 1)
  if -1 < id58433a494e5458 and -1 < id58433a494e5459 then
    LuaAuxLib.TracePrint("F_254:", id58433a494e5458, id58433a494e5459)
    LuaAuxLib.Tap(id58433a494e5458, id58433a494e5459, 0)
  end
end

function id46.ide695b0e68daee58aa0e8bdbd()
  local ide695b0e68daee58aa0e8bdbd3ae9809ae794a8 = _ENV
  ide695b0e68daee58aa0e8bdbd3ae9809ae794a8 = LuaAuxLib.URL_OperationGet("https://api.shimo.im/files/J9K8gGhjgYTGk9J8?html=true", _ENV)
  local ide695b0e68daee58aa0e8bdbd3ae5b9bfe5918a = _ENV
  ide695b0e68daee58aa0e8bdbd3ae5b9bfe5918a = LuaAuxLib.StringSplit(ide695b0e68daee58aa0e8bdbd3ae9809ae794a8, "广告广告")
  LuaAuxLib.UI_NewLayout("数据加载", 2, _UPVALUE1_, nil)
  LuaAuxLib.UI_AddTextView("数据加载", "公告", "正在加载数据,请勿关闭……", _UPVALUE1_, nil)
  for ide695b0e68daee58aa0e8bdbd3a49 = 1, LuaAuxLib.TableSize(ide695b0e68daee58aa0e8bdbd3ae5b9bfe5918a) - 1 - 1 do
    LuaAuxLib.UI_AddTextView("数据加载", "公告", " ", _UPVALUE1_, nil)
    LuaAuxLib.UI_AddWebView("数据加载", "GG", ide695b0e68daee58aa0e8bdbd3ae5b9bfe5918a[ide695b0e68daee58aa0e8bdbd3a49 + 1], 10, 10)
  end
  Thread.Start(id46.id5843)
  LuaAuxLib.UI_Show("数据加载")
end

function id46.ide5b08fe7b2bee781b5e5908ee58fb0(ide5b08fe7b2bee781b5e5908ee58fb03a5a48, ide5b08fe7b2bee781b5e5908ee58fb03a4d4d)
  local ReturnValueVar = _ENV
  LuaAuxLib.TracePrint("F_276:", LuaAuxLib.URL_OperationPost("http://author.mobileanjian.com/Account/LoginCheck", ((("UserName=" .. ide5b08fe7b2bee781b5e5908ee58fb03a5a48) .. "&Password=") .. ide5b08fe7b2bee781b5e5908ee58fb03a4d4d) .. "&IsChecked=false", _ENV))
  zm.Init()
  local ide5b08fe7b2bee781b5e5908ee58fb03a434f = _ENV
  ide5b08fe7b2bee781b5e5908ee58fb03a434f = ".ASPXAUTH=11B90F0F4926C9DAFBA548EC4E2FEC2BB8CCB55BDCD672CB776C0937EBD734C4418D8D68461BDFCECAFD6192A8AC86BCF342F923030388A7A562BE120ADE37A5372783BEDED888896F3263DE2826CC44493F6EDED13A61288386786FFC85FD14F5F80CF00134A87F779C235935EE2C73EE0EA7E1CD16335D79C53E67C6E97D70"
  local ide5b08fe7b2bee781b5e5908ee58fb03a4653 = _ENV
  ide5b08fe7b2bee781b5e5908ee58fb03a4653 = {
    url = "http://author.mobileanjian.com/Main?IsLoginIn=True",
    code = "UTF-8",
    setcookie = zm.FileTemp(),
    cookie = ide5b08fe7b2bee781b5e5908ee58fb03a434f
  }
  ReturnValueVar = zm.HttpGet(ide5b08fe7b2bee781b5e5908ee58fb03a4653)
  return ReturnValueVar
end

function id46.ide99a8fe69cbae5ad97e7aca6(ide99a8fe69cbae5ad97e7aca63ae587a0e4bd8de695b0)
  local ReturnValueVar, ide99a8fe69cbae5ad97e7aca63a534a = _UPVALUE1_, nil
  ide99a8fe69cbae5ad97e7aca63a534a = LuaAuxLib.Encode_Md5(tostring(LuaAuxLib.GetTickCount()))
  ReturnValueVar = string.sub(ide99a8fe69cbae5ad97e7aca63a534a, 0, ide99a8fe69cbae5ad97e7aca63ae587a0e4bd8de695b0)
  return ReturnValueVar
end

function id46.ide8bf9be588b64ee8bdac3130(ide8bf9be588b64ee8bdac31303a41, ide8bf9be588b64ee8bdac31303a4e)
  local ReturnValueVar = _ENV
  ide8bf9be588b64ee8bdac31303a41 = LuaAuxLib.UTF8_StringReverse(ide8bf9be588b64ee8bdac31303a41)
  local ide8bf9be588b64ee8bdac31303a4a5a = _ENV
  ide8bf9be588b64ee8bdac31303a4a5a = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    A = 10,
    B = 11,
    C = 12,
    D = 13,
    E = 14,
    F = 15,
    a = 10,
    b = 11,
    c = 12,
    d = 13,
    e = 14,
    f = 15
  }
  local ide8bf9be588b64ee8bdac31303a4a47 = _ENV
  ide8bf9be588b64ee8bdac31303a4a47 = 0
  for ide8bf9be588b64ee8bdac31303a49 = 1, LuaAuxLib.TableSize(ide8bf9be588b64ee8bdac31303a41) do
    ide8bf9be588b64ee8bdac31303a4a47 = ide8bf9be588b64ee8bdac31303a4a5a[LuaAuxLib.VBS_STRMID(ide8bf9be588b64ee8bdac31303a41, ide8bf9be588b64ee8bdac31303a49, 1)] * ide8bf9be588b64ee8bdac31303a4e ^ (ide8bf9be588b64ee8bdac31303a49 - 1) + ide8bf9be588b64ee8bdac31303a4a47
  end
  ReturnValueVar = ide8bf9be588b64ee8bdac31303a4a47
  return ReturnValueVar
end
