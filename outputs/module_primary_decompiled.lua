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

local function print(...)
  LuaAuxLib.TracePrint(":", ...)
end

local sh = {}
_ENV[sh] = _zmm

function sh.Read(FileName)
  local iRet, sRet = pcall(function()
    local f = io.open(nil, "r")
    local ret = _ENV
    if f then
      ret = f:read("*all")
      f:close()
      return ret
    end
    return _ENV
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.ReadLines(FileName)
  local iRet, sRet = pcall(function()
    local f = io.open(nil, "r")
    local tRet = {}
    local sRet = ""
    if f then
      while sRet do
        sRet = f:read("*line")
        if sRet then
          sRet = string.gsub(sRet, "[\r\n]", "")
          table.insert(tRet, sRet)
        end
      end
      f:close()
      return tRet
    end
    return ""
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.ReadLine(FileName, LineNum)
  local iRet, sRet = pcall(function()
    local tLines = sh.ReadLines(nil)
    if nil == 0 then
      LineNum = 1
    end
    if tLines and 1 <= #tLines then
      return tLines[1]
    end
    return ""
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.LinesNumber(FileName)
  local iRet, sRet = pcall(function()
    local tLines = sh.ReadLines(nil)
    if tLines then
      return #tLines
    end
    return 0
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.Write(FileName, ...)
  local arg = {
    ...
  }
  local iRet, sRet = pcall(function()
    local f = io.open(nil, "w")
    if f then
      f:write(table.concat(nil))
      f:close()
    end
  end)
  if iRet == true then
    return sRet
  else
    ...(sRet)
    return ""
  end
end

function sh.WriteLine(FileName, LineNum, Content)
  local iRet, sRet = pcall(function()
    local tLines = sh.ReadLines(nil)
    if tLines and nil <= #tLines then
      sh.table.insert(tLines, nil, nil)
      sh.WriteLines(tLines, tLines)
    end
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.WriteLines(FileName, Lines)
  local iRet, sRet = pcall(function()
    local f = io.open(nil, "w+")
    if f then
      for index, value in ipairs("w+") do
        f:write(value .. "\n")
      end
      f:close()
    end
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.Append(FileName, ...)
  local arg = {
    ...
  }
  local iRet, sRet = pcall(function()
    local f = io.open(nil, "a+")
    if f then
      f:write(table.concat(nil))
      f:close()
    end
  end)
  if iRet == true then
    return sRet
  else
    ...(sRet)
    return ""
  end
end

function sh.DeleteLine(FileName, LineNum)
  local iRet, sRet = pcall(function()
    local tLines = sh.ReadLines(nil)
    if nil > #tLines then
      LineNum = #tLines
    end
    if tLines and #tLines <= #tLines then
      sh.table.remove(tLines, nil)
      sh.WriteLines(tLines, tLines)
    end
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.Bytes(FileName)
  local iRet, sRet = pcall(function()
    local size = 0
    local f = io.open(nil, "rb")
    if f then
      size = f:seek("end")
      f:close()
    end
    return size
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

function sh.Length(FileName)
  local iRet, sRet = pcall(function()
    local fileLength = 0
    local strContent = sh.Read(nil)
    strContent = sh.string.gsub(strContent, "[\r\n]", "")
    local len = #strContent
    local left = len
    local cnt = 0
    local arr = {
      0,
      192,
      224,
      240,
      248,
      252
    }
    while left ~= 0 do
      local tmp = sh.string.byte(strContent, -left)
      local i = #arr
      while arr[i] do
        if tmp >= arr[i] then
          left = left - i
          break
        end
        i = i - 1
      end
      cnt = cnt + 1
    end
    fileLength = cnt
    return fileLength
  end)
  if iRet == true then
    return sRet
  else
    ;(nil)(sRet)
    return ""
  end
end

_ENV[QMPlugin] = _zmm
_ENV[_ENV] = _zmm
_ENV[function()
  local ReturnValueVar, ide4bfa1e681afe694b6e99b863a58 = _UPVALUE1_, nil
  ide4bfa1e681afe694b6e99b863a58 = 514
  local ide4bfa1e681afe694b6e99b863a59 = _ENV
  ide4bfa1e681afe694b6e99b863a59 = 151
  _ENV[zm.OcrBaiDu(667, 103, 707, 243)] = ReturnValueVar
  ide68993e5bc80e8838ce58c85()
  for ide4bfa1e681afe694b6e99b863a49 = 0, 7 do
    if ide4bfa1e681afe694b6e99b863a49 == 4 then
      ide4bfa1e681afe694b6e99b863a59 = ide4bfa1e681afe694b6e99b863a59 + 430
      ide4bfa1e681afe694b6e99b863a58 = 514
    end
    LuaAuxLib.Tap(ide4bfa1e681afe694b6e99b863a58, ide4bfa1e681afe694b6e99b863a59, 0)
    LuaAuxLib.Sleep(1111)
    ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] = zm.OcrBaiDu(522, 782, 561, 950)
    LuaAuxLib.Sleep(333)
    if ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] == "米龙的缸中之脑" then
      ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] = "米戈的缸中之脑"
    end
    if ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] == "米龙的以太之拳" then
      ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] = "米戈的以太之拳"
    end
    if ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] == "米龙的铜肩" then
      ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] = "米戈的铜肩"
    end
    if ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] == "米龙的铜护腿" then
      ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] = "米戈的铜护腿"
    end
    if ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] == "米龙的液压之服" then
      ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1] = "米戈的液压之服"
    end
    LuaAuxLib.TracePrint("_186:", ide4bfa1e681afe694b6e99b863a49, ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1])
    LuaAuxLib.ShowMessage(tostring(ide4bfa1e681afe694b6e99b863a49 .. ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1]), _UPVALUE2_, ide8a792e889b2e8a385e5a487[ide4bfa1e681afe694b6e99b863a49 + 1], ide4bfa1e681afe694b6e99b863a49 + 1)
    ide4bfa1e681afe694b6e99b863a58 = ide4bfa1e681afe694b6e99b863a58 - 100
  end
  ide585b3e997ade8838ce58c85()
  return ReturnValueVar
end] = _zmm
_ENV[function(ide5a49ae782b9e689be3a5831, ide5a49ae782b9e689be3a5931, ide5a49ae782b9e689be3a5832, ide5a49ae782b9e689be3a5932, ide5a49ae782b9e689be3ae782b9e587bbe889b2, ide5a49ae782b9e689be3ae5a49ae889b2)
  local ReturnValueVar = _ENV
  _ENV[LuaAuxLib.FindMultiColor(ide5a49ae782b9e689be3a5831, ide5a49ae782b9e689be3a5931, ide5a49ae782b9e689be3a5832, ide5a49ae782b9e689be3a5932, ide5a49ae782b9e689be3ae782b9e587bbe889b2, ide5a49ae782b9e689be3ae5a49ae889b2, 0, 1)] = ide5a49ae782b9e689be3a5831
  _ENV[LuaAuxLib.FindMultiColor(ide5a49ae782b9e689be3a5831, ide5a49ae782b9e689be3a5931, ide5a49ae782b9e689be3a5832, ide5a49ae782b9e689be3a5932, ide5a49ae782b9e689be3ae782b9e587bbe889b2, ide5a49ae782b9e689be3ae5a49ae889b2, 0, 1)] = ide5a49ae782b9e689be3a5831
  if id494e5458 > -1 and id494e5459 > -1 then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function(ide58cbae59f9fe689be3a5831, ide58cbae59f9fe689be3a5931, ide58cbae59f9fe689be3a5832, ide58cbae59f9fe689be3a5932, ide58cbae59f9fe689be3ae5a49ae889b2)
  local ReturnValueVar = _ENV
  ;(function()
    local _ret_val_ = _ENV
    _ret_val_ = LuaAuxLib.FindColor(nil, nil, nil, nil, nil, 0, 1)
    _ENV[LuaAuxLib.FindColor(nil, nil, nil, nil, nil, 0, 1)] = _ret_val_
    _ENV[LuaAuxLib.FindColor(nil, nil, nil, nil, nil, 0, 1)] = _ret_val_
    return _ret_val_
  end)()
  if id494e5458 > -1 and -1 < id494e5459 then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function(ide6af94e889b23a5345)
  local ReturnValueVar = _ENV
  if LuaAuxLib.CmpColorEx(ide6af94e889b23a5345, 1) == 1 then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function(ide689bee59bbe3a5831, ide689bee59bbe3a5931, ide689bee59bbe3a5832, ide689bee59bbe3a5932, ide689bee59bbe3a5345)
  local ReturnValueVar = _ENV
  ;(function()
    local _ret_val_ = _ENV
    _ret_val_ = LuaAuxLib.FindPicture(nil, nil, nil, nil, nil, "000000", 0, 0)
    _ENV[LuaAuxLib.FindPicture(nil, nil, nil, nil, nil, "000000", 0, 0)] = _ret_val_
    _ENV[LuaAuxLib.FindPicture(nil, nil, nil, nil, nil, "000000", 0, 0)] = _ret_val_
    return _ret_val_
  end)()
  if id494e5458 > -1 and -1 < id494e5459 then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function(ide58892e58aa83a5831, ide58892e58aa83a5931, ide58892e58aa83a5832, ide58892e58aa83a5932, ide58892e58aa83ae697b6e995bf)
  LuaAuxLib.TouchOperation(0, ide58892e58aa83a5831, ide58892e58aa83a5931, _ENV, 0)
  LuaAuxLib.Sleep(333)
  LuaAuxLib.TouchOperation(1, ide58892e58aa83a5832, ide58892e58aa83a5932, _UPVALUE1_, 0)
  LuaAuxLib.Sleep(ide58892e58aa83ae697b6e995bf)
  LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
end] = _zmm
_ENV[function(ide58f91e982aee4bbb63ae6a087e9a298, ide58f91e982aee4bbb63ae58685e5aeb9)
  LuaAuxLib.SendSimpleEmail("smtp.qq.com", "185599477@qq.com", "dmfwcyvzcimobhgi", ide58f91e982aee4bbb63ae6a087e9a298, ide58f91e982aee4bbb63ae58685e5aeb9, "57075654@qq.com")
end] = _zmm
_ENV[function()
  local ReturnValueVar, ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0, ide8a792e889b2e4bd8de7bdae3ae7a7bbe58aa858, ide8a792e889b2e4bd8de7bdae3ae7a7bbe58aa859 = _UPVALUE3_, nil, nil, nil
  Thread.SetShareVar("路径", _ENV)
  Thread.SetShareVar("有方向", 0)
  _ENV[Thread.GetShareVar("杀大怪")] = ReturnValueVar
  if ide69d80e5a4a7e680aa == 0 then
    _ENV[Thread.GetShareVar("居中")] = ReturnValueVar
    ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 = Thread.GetShareVar("看小图数")
    ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 = ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 + 1
    if ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 == 4 then
      LuaAuxLib.TouchOperation(0, 362, 452, _ENV, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.TouchOperation(1, 262 - ide5b185e4b8ad, 512 + ide5b185e4b8ad, _UPVALUE1_, 0)
      LuaAuxLib.Sleep(11)
      Thread.SetShareVar("看小图数", ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0)
    elseif ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 == 1 then
      LuaAuxLib.TouchOperation(0, 362, 452, _ENV, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.TouchOperation(1, 462 + ide5b185e4b8ad, 512 + ide5b185e4b8ad, _UPVALUE1_, 0)
      LuaAuxLib.Sleep(11)
      Thread.SetShareVar("看小图数", ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0)
    elseif ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 == 2 then
      LuaAuxLib.TouchOperation(0, 362, 452, _ENV, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.TouchOperation(1, 462 + ide5b185e4b8ad, 392 - ide5b185e4b8ad, _UPVALUE1_, 0)
      LuaAuxLib.Sleep(11)
      Thread.SetShareVar("看小图数", ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0)
    elseif ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 == 3 then
      LuaAuxLib.TouchOperation(0, 362, 452, _ENV, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.TouchOperation(1, 262 - ide5b185e4b8ad, 392 - ide5b185e4b8ad, _UPVALUE1_, 0)
      LuaAuxLib.Sleep(11)
      Thread.SetShareVar("看小图数", ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0)
    elseif 4 < ide8a792e889b2e4bd8de7bdae3ae79c8be5b08fe59bbee695b0 then
      ide8a792e889b2e4bd8de7bdae3ae7a7bbe58aa858 = 0
      ide8a792e889b2e4bd8de7bdae3ae7a7bbe58aa859 = 0
      Thread.SetShareVar("看小图数", 0)
    end
  elseif ide69d80e5a4a7e680aa == 1 then
    Thread.SetShareVar("看小图数", 3)
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = ReturnValueVar
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = ReturnValueVar
  _ENV[LuaAuxLib.NewArray("")] = ReturnValueVar
  _ENV[LuaAuxLib.NewArray("")] = ReturnValueVar
  LuaAuxLib.TracePrint("_324:", Thread.GetShareVar("灵视"), Thread.GetShareVar("灵视次数") .. "-----------------------------------------------------------------")
  LuaAuxLib.TracePrint("_325:", "线程启动")
  LuaAuxLib.Tap(626, 1149, 0)
  LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
  LuaAuxLib.TracePrint("_328:", "关闭小地图")
  LuaAuxLib.Sleep(111)
  _ENV[Thread.GetShareVar("有门无路")] = ReturnValueVar
  local ide8a792e889b2e4bd8de7bdae3ae9a696e9a286e6bf80e6b4bb = _ENV
  ide8a792e889b2e4bd8de7bdae3ae9a696e9a286e6bf80e6b4bb = Thread.GetShareVar("首领激活")
  if LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 and ide8a792e889b2e4bd8de7bdae3ae9a696e9a286e6bf80e6b4bb == 1 then
    if 0 < ide69c89e997a8e697a0e8b7af then
      _ENV["新路"] = ReturnValueVar
      Thread.SetShareVar("有门无路", ide69c89e997a8e697a0e8b7af - 1)
      LuaAuxLib.ShowMessage(tostring("有门无路,尝试找路"), _UPVALUE2_, 1, nil)
      if Thread.GetShareVar("灵视") == 1 and 1 > Thread.GetShareVar("灵视次数") then
        LuaAuxLib.TracePrint("_341:", "有门无路点灵视")
        LuaAuxLib.Sleep(555)
        LuaAuxLib.Tap(61, 735, 0)
        LuaAuxLib.Sleep(222)
        Thread.SetShareVar("灵视次数", 2)
        Thread.SetShareVar("灵视", 2)
        LuaAuxLib.Tap(630, 1146, 0)
        LuaAuxLib.Sleep(555)
        ide8a792e889b2e4bd8de7bdae()
      end
    else
      ide585a8e59bbee689bee997a8()
    end
  elseif Thread.GetShareVar("灵视") == 1 and 1 > Thread.GetShareVar("灵视次数") then
    LuaAuxLib.TracePrint("_362:", "不是快速下楼点灵视")
    LuaAuxLib.Sleep(555)
    LuaAuxLib.Tap(61, 735, 0)
    LuaAuxLib.Sleep(222)
    Thread.SetShareVar("灵视次数", 2)
    Thread.SetShareVar("灵视", 2)
    LuaAuxLib.Tap(627, 1219, 0)
    LuaAuxLib.Sleep(555)
    ide8a792e889b2e4bd8de7bdae()
  end
  ide689bee8a792e889b2()
  ide6b885e7a9bae695b0e7bb84()
  _ENV[id5258 - 9] = ReturnValueVar
  _ENV[id5259 + 1] = ReturnValueVar
  _ENV[id5258] = ReturnValueVar
  _ENV[id5259] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  _ENV[id5258] = ReturnValueVar
  _ENV[id5259] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  ide5be85e689bee8b7af58[ide8b7af + 1] = id5258
  ide5be85e689bee8b7af59[ide8b7af + 1] = id5259
  ide5ad98e585a5e8b5b7e782b9()
  ide5b7b2e689bee59d90e6a08758[ide5b7b2e689bee695b0 + 1] = id5258
  ide5b7b2e689bee59d90e6a08759[ide5b7b2e689bee695b0 + 1] = id5259
  _ENV[0] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  _ENV[0] = ReturnValueVar
  ide99bb7e8bebe()
  return ReturnValueVar
end] = _zmm
_ENV[function()
  _ENV[0], _ENV[0], _ENV[0] = nil, nil, nil
  if ide696b9e59091 > 3 then
    LuaAuxLib.Sleep(11)
    _ENV[0] = LuaAuxLib.Sleep
    _ENV[ide4b88ae4b8aae8b7afe6a087 + 1] = ide4b88ae4b8aae8b7afe6a087 + 1
    if ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1] == nil or ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1] == nil or 0 > ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1] or 0 > ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1] then
      _ENV[Thread.GetShareVar("杀大怪")] = Thread.GetShareVar("杀大怪")
      if ide79baee6a087 == "门" and LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 and ide69d80e5a4a7e680aa == 0 then
        Thread.SetShareVar("有门无路", 3)
        _ENV["新路"] = Thread.SetShareVar
        LuaAuxLib.TracePrint("_440:", "有门无路找开小地图")
      end
      LuaAuxLib.TracePrint("_445:", "重置找图线程" .. ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1], ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1])
      NULL = LuaAuxLib.TracePrint
      _ENV[Thread.GetShareVar("重置次数")] = Thread.GetShareVar("重置次数")
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
  end
  ide689bee8b7af()
end] = _zmm
_ENV[function()
  local ReturnValueVar, ide689bee8b7af3ae8b79de7a6bb58, ide689bee8b7af3ae8b79de7a6bb59, ide689bee8b7af3ae69d80e5ae8c424f5353 = _UPVALUE3_, nil, nil, nil
  if ide696b9e59091 == 0 then
    ide689bee8b7af3ae8b79de7a6bb58 = 8.71
    ide689bee8b7af3ae8b79de7a6bb59 = 17.41
  elseif ide696b9e59091 == 3 then
    ide689bee8b7af3ae8b79de7a6bb58 = -8.71
    ide689bee8b7af3ae8b79de7a6bb59 = 17.41
  elseif ide696b9e59091 == 2 then
    ide689bee8b7af3ae8b79de7a6bb58 = -8.71
    ide689bee8b7af3ae8b79de7a6bb59 = -17.41
  elseif ide696b9e59091 == 1 then
    ide689bee8b7af3ae8b79de7a6bb58 = 8.71
    ide689bee8b7af3ae8b79de7a6bb59 = -17.41
  end
  _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1] - ide689bee8b7af3ae8b79de7a6bb58] = ReturnValueVar
  _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1] - ide689bee8b7af3ae8b79de7a6bb59] = ReturnValueVar
  ide689bee8b7af3ae69d80e5ae8c424f5353 = Thread.GetShareVar("杀完BOSS")
  if ide689bee8b7af3ae69d80e5ae8c424f5353 == 1 and (ide689be58 < 350 or ide689be58 > 501 or ide689be59 < 630 or ide689be59 > 882) then
    _ENV[ide696b9e59091 + 1] = ReturnValueVar
    ide99bb7e8bebe()
  end
  _ENV[Thread.GetShareVar("杀大怪")] = ReturnValueVar
  _ENV[Thread.GetShareVar("重置次数")] = ReturnValueVar
  if ide9878de7bdaee6aca1e695b0 < 8 then
    Thread.SetShareVar("居中", 0)
  end
  _ENV[Thread.GetShareVar("居中")] = ReturnValueVar
  if ide9878de7bdaee6aca1e695b0 > 8 and ide5b185e4b8ad == 0 and ide69d80e5a4a7e680aa == 0 then
    LuaAuxLib.TracePrint("_490:", "达到回中点的要求" .. ide9878de7bdaee6aca1e695b0, ide5b185e4b8ad, ide69d80e5a4a7e680aa)
    if ide689be58 > 275 and ide689be58 < 397 and ide689be59 > 443 and ide689be59 < 674 then
      LuaAuxLib.TracePrint("_492:", "回中心区域")
      LuaAuxLib.ShowMessage(tostring("找不到路,回中点查找"), _UPVALUE2_, ide5b185e4b8ad, ide69d80e5a4a7e680aa)
      _ENV[ide689be58] = ReturnValueVar
      _ENV[ide689be59] = ReturnValueVar
      Thread.SetShareVar("居中", 200)
      _ENV["中心"] = ReturnValueVar
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
  end
  _ENV[Thread.GetShareVar("不通X")] = ReturnValueVar
  _ENV[Thread.GetShareVar("不通Y")] = ReturnValueVar
  if ide689be58 < 100 or ide689be58 > 585 or ide689be59 < 200 or ide689be59 > 1150 then
    _ENV[ide696b9e59091 + 1] = ReturnValueVar
    ide99bb7e8bebe()
  end
  for ide689bee8b7af3a49 = 0, LuaAuxLib.TableSize(ide4b88de9809a58) - 1 do
    if ide689be58 - ide4b88de9809a58[ide689bee8b7af3a49 + 1] > -5 and ide689be58 - ide4b88de9809a58[ide689bee8b7af3a49 + 1] < 5 and ide689be59 - ide4b88de9809a59[ide689bee8b7af3a49 + 1] > -7 and ide689be59 - ide4b88de9809a59[ide689bee8b7af3a49 + 1] < 7 then
      _ENV[ide696b9e59091 + 1] = ReturnValueVar
      ide99bb7e8bebe()
    end
  end
  for ide689bee8b7af3a49 = 0, ide7bb88e782b9e4bd8de7bdae do
    if -5 < ide689be58 - ide7bb88e782b958[ide689bee8b7af3a49 + 1] and 5 > ide689be58 - ide7bb88e782b958[ide689bee8b7af3a49 + 1] and -7 < ide689be59 - ide7bb88e782b959[ide689bee8b7af3a49 + 1] and 7 > ide689be59 - ide7bb88e782b959[ide689bee8b7af3a49 + 1] then
      _ENV[ide696b9e59091 + 1] = ReturnValueVar
      ide99bb7e8bebe()
    end
  end
  for ide689bee8b7af3a49 = 0, ide5b7b2e689bee695b0 do
    if -5 < ide689be58 - ide5b7b2e689bee59d90e6a08758[ide689bee8b7af3a49 + 1] and 5 > ide689be58 - ide5b7b2e689bee59d90e6a08758[ide689bee8b7af3a49 + 1] and -7 < ide689be59 - ide5b7b2e689bee59d90e6a08759[ide689bee8b7af3a49 + 1] and 7 > ide689be59 - ide5b7b2e689bee59d90e6a08759[ide689bee8b7af3a49 + 1] then
      _ENV[ide696b9e59091 + 1] = ReturnValueVar
      ide99bb7e8bebe()
    end
  end
  _ENV[Thread.GetShareVar("起点X")] = ReturnValueVar
  _ENV[Thread.GetShareVar("起点y")] = ReturnValueVar
  for ide689bee8b7af3a49 = 0, LuaAuxLib.TableSize(ide8b5b7e782b958) - 1 do
    if -5 < ide689be58 - ide8b5b7e782b958[ide689bee8b7af3a49 + 1] and 5 > ide689be58 - ide8b5b7e782b958[ide689bee8b7af3a49 + 1] and -7 < ide689be59 - ide8b5b7e782b959[ide689bee8b7af3a49 + 1] and 7 > ide689be59 - ide8b5b7e782b959[ide689bee8b7af3a49 + 1] then
      ide5ad98e585a5e5be85e689be()
      ide5ad98e585a5e5b7b2e689be()
      ide696b9e59091e5ad98e585a5e69687e69cac()
      _ENV[ide696b9e59091 + 1] = ReturnValueVar
      ide99bb7e8bebe()
    end
  end
  ide698afe590a6e997a8()
  ide69fa5e588b0e8a792e889b2()
  local ide689bee8b7af3ae698afe590a6e79bb8e7ad89
  ::lbl_347::
  do
    repeat
      local ide689bee8b7af3ae698afe590a6e79bb8e7ad89 = _ENV
      _ENV[Thread.GetShareVar("杀大怪")] = ReturnValueVar
      if ide69d80e5a4a7e680aa == 1 then
        ide689bee8b7af3ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59, "3837EC-080808", 1)
        if -1 < ide689bee8b7af3ae698afe590a6e79bb8e7ad89 then
          LuaAuxLib.TracePrint("_555:", "红色BOSS" .. ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, (ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59 .. "方向") .. ide696b9e59091, ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1], ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1])
          _ENV[ide689be58] = ReturnValueVar
          _ENV[ide689be59] = ReturnValueVar
          _ENV["红怪"] = ReturnValueVar
          ide696b9e59091e5ad98e585a5e69687e69cac()
          ide7a7bbe58aa8()
        end
      end
      ide689bee8b7af3ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59, "969E79|687383|687381|67A1C3|657180-010101|646F7F|646F7E|63769D|626E7D|626D7D|626d7c|626C7B|61B1DE|616C7B|616B7A|6099BC|606A79|5F6A78|5E89AB|5E78AF|5d6776|5493C1|4D8CBA-010101|4B535E|49505B|446783|417EA9|393F47", 1)
      if -1 < ide689bee8b7af3ae698afe590a6e79bb8e7ad89 and ide69fa5e588b0e8a792e889b2e5818fe5b7ae58 == 0 and ide69fa5e588b0e8a792e889b2e5818fe5b7ae59 == 0 and ide58cbae59f9fe689be(ide689be58 - 9, ide689be59 - 12, ide689be58 - 5, ide689be59 + 7, "636f7e|5D6673|5C646E|5B646D|5B6572|5b636e|575F6B|575E68|565D67-010101|545C68|535B65|515862|50565D|505660|4F565D|4F555D|4F555C|4E545B|4C5259|414447-010101|3E4144") == true then
        LuaAuxLib.TracePrint("_617:", "新路" .. ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, (ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59 .. "方向") .. ide696b9e59091, ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1], (ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1] .. "范围") .. ide689be58 - 9, ide689be59 - 12, ide689be58 - 5, (ide689be59 + 7 .. "位置") .. id494e5458, id494e5459)
        if LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 and ide79baee6a087 == "门" then
          ide5ad98e585a5e8b5b7e782b9()
          ide5ad98e585a5e5be85e689be()
          ide5ad98e585a5e5b7b2e689be()
          ide696b9e59091e5ad98e585a5e69687e69cac()
          _ENV[ide696b9e59091 + 1] = ReturnValueVar
          ide99bb7e8bebe()
        end
        if ide69d80e5a4a7e680aa == 1 then
          _ENV["新路"] = ReturnValueVar
          _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ReturnValueVar
          _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ReturnValueVar
          _ENV[8] = ReturnValueVar
          ide5ad98e585a5e8b5b7e782b9()
          ide696b9e59091e5ad98e585a5e69687e69cac()
          ide7a7bbe58aa8()
        end
        if ide69fa5e588b0e8a792e889b2e5818fe5b7ae59 == 0 then
          _ENV["新路"] = ReturnValueVar
          _ENV[ide689be58] = ReturnValueVar
          _ENV[ide689be59] = ReturnValueVar
          ide5ad98e585a5e8b5b7e782b9()
          ide696b9e59091e5ad98e585a5e69687e69cac()
          ide7a7bbe58aa8()
        end
      end
      ide689bee8b7af3ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59, "A39367-010101|817E6E|747573|737576|6D767C|6A747A|686F76-010101|677179|666F7C|656E7C|656C78|637181|646F7E|646D7B|636E7E-010101|636D7D|636C7B|636C78|626D7F|626D7C|626B79|626A76|616B7A|616B77|616A79|606A7B|606A7A|5F6A7C|5F6979|5E6B82|5E6777-010101|5D6E81|5D6B7F|5C6676-010101|5B6574-010101|5A6372|5A626B|596271|596264|586270|57616E", 1)
      if -1 < ide689bee8b7af3ae698afe590a6e79bb8e7ad89 then
        LuaAuxLib.TracePrint("_654:", id494e5458, (id494e5459 .. "有路") .. ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59)
        ide5ad98e585a5e8b5b7e782b9()
        ide5ad98e585a5e5be85e689be()
        ide5ad98e585a5e5b7b2e689be()
        ide696b9e59091e5ad98e585a5e69687e69cac()
        goto lbl_669
      end
      ide689bee8b7af3ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59, "BBBA8C-050505|C4BC83-050505|8F8F90-010101|89887C|7F827F|7E8281-010101|787F82-010101|767D80|727C81-010101|707374-010101|6E7984-010101|6C7987-010101|6C7885-010101|6A7684-010101|6A7681-010101|687483-010101|687480-010101|677281-010101|66727F-010101|66707F|65707E|655839|64707D|636E7C|626A76|626D7A|616B78|606A78|606974-010101|5F6B78|5D6874|5C6774|5B6572|5B5D5B|5B543A|5A6570|5A646D-010101|586069-010101|584f37|555D65-010101|536878|535A62-010101|525964|515760-010101|50565D-010101|504e48|4D555D|4D525C|4D4783|4B515A|474E55-010101|474C53|474B50-010101|464A4E-010101|454950|44484D-010101|42484F|42474C|42454b-010101|414448-010101|414239|404140|3F4247-000001|3F4245-010101|3E3F3C|3D3F44|3D3F43|3D3F3E|3C4042|3c3f43|3c3f3e|3C3E43|3C3E42|3C3A33|3B3F43|3B3E41|3B3D40|3B3C3E|3B3B37|3b3933|3a3c3f|3A3B3E|3A3A36|393b3e|393935|383D40|383A3C-010101|375468|37434C|373B3E|37393B-010101|373734-010101|363738|355062|353637|353535-010101|353534|353533|344D5E|344A59|343535|33393E|33383C|333333-010101|323334|323232|313132|313131|303133|303030-010101|101515|000000", 1)
      if -1 < ide689bee8b7af3ae698afe590a6e79bb8e7ad89 then
        LuaAuxLib.TracePrint("_671:", "找不通" .. ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, (ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59 .. "方向") .. ide696b9e59091, id494e5458, id494e5459)
        ide4b88de9809ae5ad98e585a5()
        goto lbl_669
      end
      local ide689bee8b7af3a52434f4c4f52 = _ENV
      ide689bee8b7af3a52434f4c4f52 = LuaAuxLib.GetPixelColor(ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59, _ENV)
      LuaAuxLib.TracePrint("_677:", id494e5458, (id494e5459 .. "未知色") .. ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58, ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59, ide689bee8b7af3a52434f4c4f52)
      _ENV[ide69fa5e588b0e8a792e889b2e5818fe5b7ae58 - 1] = ReturnValueVar
    until 100 > ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58 or 585 < ide689be58 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae58 or 200 > ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59 or 1150 < ide689be59 - ide69fa5e588b0e8a792e889b2e5818fe5b7ae59
    _ENV[ide696b9e59091 + 1] = ReturnValueVar
    ide99bb7e8bebe()
    goto lbl_347
    error("EndScript")
  end
  ::lbl_669::
  _ENV[ide696b9e59091 + 1] = ReturnValueVar
  ide99bb7e8bebe()
  return ReturnValueVar
end] = _zmm
_ENV[function()
  if ide689bee997a8(55, 153, 657, 1113) == true or ide5ae88e997a8(55, 153, 657, 1113) == true then
    LuaAuxLib.ShowMessage(tostring("有门进门"), _UPVALUE2_, 657, 1113)
    LuaAuxLib.TracePrint("_700:", "有门进门")
    _ENV["门"] = LuaAuxLib.TracePrint
  else
    if Thread.GetShareVar("灵视") == 1 and 1 > Thread.GetShareVar("灵视次数") then
      LuaAuxLib.TracePrint("_707:", "速下没有找到门,点灵视")
      LuaAuxLib.Sleep(555)
      LuaAuxLib.Tap(61, 735, 0)
      LuaAuxLib.Sleep(222)
      Thread.SetShareVar("灵视次数", 2)
      Thread.SetShareVar("灵视", 2)
      LuaAuxLib.Tap(630, 1146, 0)
      LuaAuxLib.Sleep(555)
      ide8a792e889b2e4bd8de7bdae()
    end
    LuaAuxLib.ShowMessage(tostring("没门尝试找门"), _UPVALUE2_, 0, 1113)
    LuaAuxLib.TracePrint("_719:", "没门尝试找门")
    _ENV["新路"] = LuaAuxLib.TracePrint
  end
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(19, 720, 86, 778, "66553B-101010", "1|20|66553B-101010,-32|13|806B4D-101010,-34|-3|806B4D-101010,-17|8|8BB3C1-101010") == true then
    Thread.SetShareVar("灵视", 1)
  end
end] = _zmm
_ENV[function()
  if ide79baee6a087 == "门" and ide680aae789a9 == "新路" then
    _ENV[nil] = ide680aae789a9
    ide5ad98e585a5e5be85e689be()
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide8b7afe5be84 + 1] = ide8b7afe5be84 + 1
    ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = (ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1] .. ide696b9e59091) .. "-"
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide680aae789a9 == "币" or ide680aae789a9 == "BUFF" or ide680aae789a9 == "buff" then
    _ENV[nil] = ide680aae789a9
    ide5ad98e585a5e8b5b7e782b9()
    ide5ad98e585a5e5be85e689be()
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide8b7afe5be84 + 1] = ide8b7afe5be84 + 1
    ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = (ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1] .. ide696b9e59091) .. "-"
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide680aae789a9 == "罐子" or ide680aae789a9 == "箱子" or ide680aae789a9 == "点金" then
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide680aae789a9 == "怪" or ide680aae789a9 == "红怪" then
    _ENV[LuaAuxLib.StringSplit(ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1], "怪")] = LuaAuxLib.StringSplit(ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1], "怪")
    _ENV[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1] = LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1
    _ENV[Thread.GetShareVar("允许拦路数")] = Thread.GetShareVar("允许拦路数")
    if ide68ba6e8b7afe680aa + 1 > ide58581e8aeb8e68ba6e8b7afe695b0 then
      ide5ad98e585a5e5b7b2e689be()
      _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
      ide99bb7e8bebe()
    else
      ide5ad98e585a5e8b5b7e782b9()
      ide5ad98e585a5e5be85e689be()
      ide5ad98e585a5e5b7b2e689be()
      _ENV[nil] = ide5ad98e585a5e5b7b2e689be
      _ENV[ide8b7afe5be84 + 1] = ide8b7afe5be84 + 1
      ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = ((ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1] .. "怪-") .. ide696b9e59091) .. "-"
      _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
      ide99bb7e8bebe()
    end
  end
end] = _zmm
_ENV[function()
  _ENV[ide8b7afe5be84 + 1] = ide8b7afe5be84 + 1
  ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = (ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1] .. ide696b9e59091) .. "-"
  if ide680aae789a9 ~= nil then
    ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = ((((ide689be58 .. "-") .. ide689be59) .. "-") .. ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1]) .. ide680aae789a9
    _ENV[nil], _ENV[ide680aae789a9] = ide680aae789a9, ide680aae789a9
    ide58f98e9878fe695b0e7bb84[ide58f98e9878f + 1] = ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1]
    _ENV[ide58f98e9878f + 1] = ide58f98e9878f + 1
    Thread.SetShareVar("路径", ide58f98e9878fe695b0e7bb84)
    _ENV[0], _ENV[LuaAuxLib.NewArray("")] = LuaAuxLib.NewArray(""), LuaAuxLib.NewArray("")
  end
end] = _zmm
_ENV[function()
  _ENV[LuaAuxLib.TableSize(ide7bb88e782b958) - 1 + 1] = LuaAuxLib.TableSize(ide7bb88e782b958) - 1 + 1
  ide7bb88e782b958[ide7bb88e782b9e4bd8de7bdae + 1] = ide689be58
  ide7bb88e782b959[ide7bb88e782b9e4bd8de7bdae + 1] = ide689be59
end] = _zmm
_ENV[function()
  _ENV[Thread.GetShareVar("不通X")] = Thread.GetShareVar("不通X")
  _ENV[Thread.GetShareVar("不通Y")] = Thread.GetShareVar("不通Y")
  _ENV[LuaAuxLib.TableSize(ide4b88de9809a58) - 1 + 1] = LuaAuxLib.TableSize(ide4b88de9809a58) - 1 + 1
  ide4b88de9809a58[ide4b88de9809ae4bd8de7bdae + 1] = ide689be58
  ide4b88de9809a59[ide4b88de9809ae4bd8de7bdae + 1] = ide689be59
  Thread.SetShareVar("不通X", ide4b88de9809a58)
  Thread.SetShareVar("不通Y", ide4b88de9809a59)
end] = _zmm
_ENV[function()
  _ENV[Thread.GetShareVar("起点X")] = Thread.GetShareVar("起点X")
  _ENV[Thread.GetShareVar("起点y")] = Thread.GetShareVar("起点y")
  _ENV[LuaAuxLib.TableSize(ide8b5b7e782b958) - 1 + 1] = LuaAuxLib.TableSize(ide8b5b7e782b958) - 1 + 1
  ide8b5b7e782b958[ide8b5b7e782b9e4bd8de7bdae + 1] = ide689be58
  ide8b5b7e782b959[ide8b5b7e782b9e4bd8de7bdae + 1] = ide689be59
  Thread.SetShareVar("起点X", ide8b5b7e782b958)
  Thread.SetShareVar("起点y", ide8b5b7e782b959)
end] = _zmm
_ENV[function()
  _ENV[ide5b7b2e689bee695b0 + 1] = ide5b7b2e689bee695b0 + 1
  ide5b7b2e689bee59d90e6a08758[ide5b7b2e689bee695b0 + 1] = ide689be58
  ide5b7b2e689bee59d90e6a08759[ide5b7b2e689bee695b0 + 1] = ide689be59
end] = _zmm
_ENV[function()
  _ENV[ide8b7af + 1] = ide8b7af + 1
  ide5be85e689bee8b7af58[ide8b7af + 1] = ide689be58
  ide5be85e689bee8b7af59[ide8b7af + 1] = ide689be59
end] = _zmm
_ENV[function()
  local ide689bee8a792e889b23ae8a792e889b2 = _ENV
  ide689bee8a792e889b23ae8a792e889b2 = {}
  local ide689bee8a792e889b23ae8bdace68da2 = _ENV
  ide689bee8a792e889b23ae8a792e889b2[1] = LuaAuxLib.NewArray("FFE33F-090909", "3|0|FFE33F-090909,6|0|FFE33F-090909,9|0|FFE33F-090909,12|0|FFE33F-090909,15|0|FFE33F-090909,11|-9|FEE340-090909,11|-5|FFE33F-090909,11|4|FFE33F-090909")
  ide689bee8a792e889b23ae8a792e889b2[2] = LuaAuxLib.NewArray("FCCB4D-090909", "3|0|FFCA4E-090909,6|0|FFCA4E-090909,9|0|FFCA4E-090909,12|0|FFCA4E-090909,13|2|FFCA4E-090909,8|6|FFCA4E-090909,8|-6|FFCA4E-090909")
  ide689bee8a792e889b23ae8a792e889b2[3] = LuaAuxLib.NewArray("F6C44C-090909", "3|0|F5C24B-090909,6|0|F5C24B-090909,9|0|F4C14B-090909,12|0|F3C04A-090909,13|2|F3C04A-090909,10|5|F0BF4D-090909,10|-5|F4C14B-090909")
  ide689bee8a792e889b23ae8a792e889b2[4] = LuaAuxLib.NewArray("B5A26B-090909", "3|0|B5A16B-090909,6|0|B5A16B-090909,9|0|B5A16B-090909,12|0|B5A16B,13|2|B5A16B,9|5|B5A16B,12|-4|B19E6C")
  for ide689bee8a792e889b23a49 = 0, LuaAuxLib.TableSize(ide689bee8a792e889b23ae8a792e889b2) - 1 do
    ide689bee8a792e889b23ae8bdace68da2 = ide689bee8a792e889b23ae8a792e889b2[ide689bee8a792e889b23a49 + 1]
    _ENV[LuaAuxLib.FindMultiColor(86, 160, 660, 1114, ide689bee8a792e889b23ae8bdace68da2[1], ide689bee8a792e889b23ae8bdace68da2[2], 1, 1)] = ide689bee8a792e889b23ae8a792e889b2
    _ENV[LuaAuxLib.FindMultiColor(86, 160, 660, 1114, ide689bee8a792e889b23ae8bdace68da2[1], ide689bee8a792e889b23ae8bdace68da2[2], 1, 1)] = ide689bee8a792e889b23ae8a792e889b2
    if id5258 > -1 and id5259 > -1 then
      _ENV[id5258 - 3] = ide689bee8a792e889b23ae8a792e889b2
      _ENV[id5259 - 1] = ide689bee8a792e889b23ae8a792e889b2
      LuaAuxLib.TracePrint("_889:", (("找到" .. ide689bee8a792e889b23a49) .. "角色") .. id5258, id5259)
      break
    end
  end
  if 0 > id5258 and 0 > id5259 then
    LuaAuxLib.Sleep(555)
    LuaAuxLib.TracePrint("_896:", "关闭小图,没找到角色" .. id5258, id5259, Thread.GetShareVar("看小图数"))
    if Thread.GetShareVar("看小图数") == 4 then
      LuaAuxLib.Tap(204, 117, 555)
    elseif Thread.GetShareVar("看小图数") == 1 then
      LuaAuxLib.Tap(87, 114, 555)
    elseif Thread.GetShareVar("看小图数") == 2 then
      LuaAuxLib.Tap(86, 223, 555)
    elseif Thread.GetShareVar("看小图数") == 3 then
      LuaAuxLib.Tap(206, 227, 555)
    end
    while true do
      Thread.SetShareVar("需要重置线程", nil)
      LuaAuxLib.Sleep(1111)
    end
  end
end] = _zmm
_ENV[function()
  local ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0 = _ENV
  if LuaAuxLib.CmpColorEx("657|155|595C67-050505,53|148|595C67-050505,657|1120|595C67-050505,53|1117|595C67-050505", 1) == 1 then
    LuaAuxLib.Tap(670, 1178, 0)
    LuaAuxLib.Sleep(555)
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.Tap(95, 789, 0)
  LuaAuxLib.Sleep(333)
  ide5a48de6b4bb()
  ide7ad94e9a298e6a380e6b58b(400, 364, 600, 1130)
  _ENV[Thread.GetShareVar("开始答题")] = ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0
  if ide5bc80e5a78be7ad94e9a298 == true then
    LuaAuxLib.TracePrint("_931:", "要答题了")
    ide7ad94e9a298()
  end
  _ENV[Thread.GetShareVar("杀大怪")] = ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0
  ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0 = Thread.GetShareVar("看小图数")
  if ide5a49ae782b9e689be(595, 245, 640, 429, "C7C7FF-101010", "-10|-1|C5C5FD-101010,-13|2|ABADE5-101010,-7|7|C1C1F9-101010,-5|-11|C0C0F8-101010,6|1|BBBCF4-101010") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "8D8EC2-080808", "-2|-3|272A51-080808,0|-6|C1C1F9-080808,4|-3|A4A6DE-080808,1|1|15183D-080808,-4|1|B5B6EE-080808") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "BEBEF6-050505", "8|4|8285BF-050505,12|11|ABACE4-050505,1|12|BCBCF3-050505,0|6|B7B7EF-050505") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "62627E-080808", "-3|0|0A0C20-080808,-5|0|565672-080808,-3|2|0D0F23-080808,-1|4|5F5F7B-080808") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "BEBEF6-080880", "0|3|0E102C-080880,0|6|B7B7EF-080880,10|6|C2C2FA-080880,6|2|C3C3FB-080880") == true then
    if ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0 == 4 then
      LuaAuxLib.Tap(204, 117, 0)
      LuaAuxLib.Sleep(333)
    elseif ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0 == 1 then
      LuaAuxLib.Tap(87, 114, 0)
      LuaAuxLib.Sleep(333)
    elseif ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0 == 2 then
      LuaAuxLib.Tap(86, 223, 0)
      LuaAuxLib.Sleep(333)
    elseif ide8a792e889b2e7a7bbe58aa83ae79c8be5b08fe59bbee695b0 == 3 then
      LuaAuxLib.Tap(206, 227, 0)
      LuaAuxLib.Sleep(333)
    end
  elseif ide69d80e5a4a7e680aa == 0 then
    LuaAuxLib.Tap(62, 466, 0)
    LuaAuxLib.Sleep(55)
    local ide8a792e889b2e7a7bbe58aa83a58 = _ENV
    ide8a792e889b2e7a7bbe58aa83a58 = 176
    local ide8a792e889b2e7a7bbe58aa83a59 = _ENV
    ide8a792e889b2e7a7bbe58aa83a59 = 528
    local ide8a792e889b2e7a7bbe58aa83a43 = _ENV
    ide8a792e889b2e7a7bbe58aa83a43 = 1
    for TempVar = 1, 20 do
      LuaAuxLib.Tap(ide8a792e889b2e7a7bbe58aa83a58, ide8a792e889b2e7a7bbe58aa83a59, 0)
      LuaAuxLib.Sleep(55)
      ide8a792e889b2e7a7bbe58aa83a58 = ide8a792e889b2e7a7bbe58aa83a58 + 50
      ide8a792e889b2e7a7bbe58aa83a59 = ide8a792e889b2e7a7bbe58aa83a59 + 100
      ide8a792e889b2e7a7bbe58aa83a43 = ide8a792e889b2e7a7bbe58aa83a43 + 1
      if 4 < ide8a792e889b2e7a7bbe58aa83a43 then
        ide8a792e889b2e7a7bbe58aa83a58 = ide8a792e889b2e7a7bbe58aa83a58 - 150
        ide8a792e889b2e7a7bbe58aa83a59 = ide8a792e889b2e7a7bbe58aa83a59 - 450
        ide8a792e889b2e7a7bbe58aa83a43 = 1
      end
    end
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
end] = _zmm
_ENV[function()
  local ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = _ENV
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "fec94e-090909|F8C44C-030303|F1BF4A-030303", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1056:", "找到了角色,进行坐标偏差寻找", ide689be58, ide689be59)
    if ide5a49ae782b9e689be(ide689be58 - 3, ide689be59 - 14, ide689be58, ide689be59 + 13, "5F6979", "0|1|5F6979,1|1|5F6979") == true then
      LuaAuxLib.TracePrint("_1063:", ide689be58 - 3, ide689be59 - 14, ide689be58, ide689be59 + 13 .. "有路")
      ide5ad98e585a5e8b5b7e782b9()
      ide5ad98e585a5e5be85e689be()
      ide5ad98e585a5e5b7b2e689be()
      ide696b9e59091e5ad98e585a5e69687e69cac()
      _ENV[ide696b9e59091 + 1] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
      ide99bb7e8bebe()
    else
      LuaAuxLib.TracePrint("_1073:", "角色下不通-----")
      ide5ad98e585a5e5b7b2e689be()
      _ENV[ide696b9e59091 + 1] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
      ide99bb7e8bebe()
    end
  end
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "49A1FE|3CB1FF-030303|38AFFF-030303|3296D9-090909|30ABFE-030303|2e87c4-030303|2AA4F6-030303|26A0F3|2496E2|229FF2-030303|219BEC|1589D7|0E65A0|0E6199|0484DC|00070B", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1082:", "找到了怪,进行坐标偏差寻找" .. ide689be58, ide689be59)
    _ENV[-5] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
    _ENV[1] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
  end
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "60C9FF-060606|5CC1F5-050505", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1088:", "找到了金币,进行坐标偏差寻找", ide689be58, ide689be59)
    _ENV[-8] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
    _ENV[3] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
  end
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "8D8E8F-030303|838918", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1094:", "找到了石头,进行坐标偏差寻找")
    _ENV[-6] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
  end
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "919191|87C3F0-050505", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1099:", "找到了罐子,进行坐标偏差寻找")
    _ENV[-6] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
    _ENV[0] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
  end
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "60C873", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1105:", "找到了门,进行坐标偏差寻找")
    _ENV[-3] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
  end
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "101215", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1110:", "找到了BUFF,进行坐标偏差寻找")
    _ENV[-3] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
  end
  ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 = LuaAuxLib.CmpColor(ide689be58, ide689be59, "547DDB-030303|49A1FC-030303", 1)
  if -1 < ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89 then
    LuaAuxLib.TracePrint("_1115:", "找到了箱子,进行坐标偏差寻找", ide689be58, ide689be59)
    _ENV[-4] = ide69fa5e588b0e8a792e889b23ae698afe590a6e79bb8e7ad89
  end
end] = _zmm
_ENV[function(ide689bee782b9e98791e69cba3a5831, ide689bee782b9e98791e69cba3a5931, ide689bee782b9e98791e69cba3a5832, ide689bee782b9e98791e69cba3a5932)
  local ide689bee782b9e98791e69cba3ae698afe590a6e782b9e98791 = _ENV
  ide689bee782b9e98791e69cba3ae698afe590a6e782b9e98791 = Thread.GetShareVar("是否点金")
  local ide689bee782b9e98791e69cba3ae782b9e98791e69cbae789b9e5be81 = _ENV
  ide689bee782b9e98791e69cba3ae782b9e98791e69cbae789b9e5be81 = {}
  local ide689bee782b9e98791e69cba3ae8bdace68da2 = _ENV
  ide689bee782b9e98791e69cba3ae782b9e98791e69cbae789b9e5be81[1] = LuaAuxLib.NewArray("7FA7B9-080808", "-3|-1|80A7B9-080808,-3|3|80A7B9-080808")
  ide689bee782b9e98791e69cba3ae782b9e98791e69cbae789b9e5be81[2] = LuaAuxLib.NewArray("8ABFD4-080808", "-5|0|8BC0D5-080808,-3|-2|8ABFD4-080808,-2|3|8BBFD3-080808")
  ide689bee782b9e98791e69cba3ae782b9e98791e69cbae789b9e5be81[3] = LuaAuxLib.NewArray("96D9EF-080808", "4|-3|95D8EE-080808,4|2|94D7ED-080808,6|-1|95D8EE-080808")
  for ide689bee782b9e98791e69cba3a49 = 0, LuaAuxLib.TableSize(ide689bee782b9e98791e69cba3ae782b9e98791e69cbae789b9e5be81) - 1 do
    ide689bee782b9e98791e69cba3ae8bdace68da2 = ide689bee782b9e98791e69cba3ae782b9e98791e69cbae789b9e5be81[ide689bee782b9e98791e69cba3a49 + 1]
    if ide5a49ae782b9e689be(ide689bee782b9e98791e69cba3a5831, ide689bee782b9e98791e69cba3a5931, ide689bee782b9e98791e69cba3a5832, ide689bee782b9e98791e69cba3a5932, ide689bee782b9e98791e69cba3ae8bdace68da2[1], ide689bee782b9e98791e69cba3ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1128:", (ide689bee782b9e98791e69cba3a49 .. "找到H点金机在") .. ide689bee782b9e98791e69cba3a5831, ide689bee782b9e98791e69cba3a5931, ide689bee782b9e98791e69cba3a5832, (ide689bee782b9e98791e69cba3a5932 .. "坐标") .. ide689be58, ide689be59)
      if ide79baee6a087 == "门" and LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 then
        ide4b88de9809ae5ad98e585a5()
        _ENV[ide696b9e59091 + 1] = ide689bee782b9e98791e69cba3a5831
        ide99bb7e8bebe()
      end
      if LuaAuxLib.ReadConfig("点金", _ENV, 1, nil) == false or 0 < ide689bee782b9e98791e69cba3ae698afe590a6e782b9e98791 then
        ide4b88de9809ae5ad98e585a5()
        _ENV[ide696b9e59091 + 1] = ide689bee782b9e98791e69cba3a5831
        ide99bb7e8bebe()
      end
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide689bee782b9e98791e69cba3a5831
      _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide689bee782b9e98791e69cba3a5831
      _ENV["点金"] = ide689bee782b9e98791e69cba3a5831
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
  end
end] = _zmm
_ENV[function(ide5ae88e997a83a5831, ide5ae88e997a83a5931, ide5ae88e997a83a5832, ide5ae88e997a83a5932)
  local ReturnValueVar = _ENV
  if ide5a49ae782b9e689be(ide5ae88e997a83a5831, ide5ae88e997a83a5931, ide5ae88e997a83a5832, ide5ae88e997a83a5932, "3F3EDA-101010", "5|5|3F3EDB-101010,8|19|3F3EDB-101010,-11|12|3F3EDA-101010,-11|7|3C3BCB-101010") == true or ide5a49ae782b9e689be(ide5ae88e997a83a5831, ide5ae88e997a83a5931, ide5ae88e997a83a5832, ide5ae88e997a83a5932, "3F3EDA-101010", "-13|6|3F3EDB-101010,-11|11|3E3DD6-101010,-6|16|3F3EDB-101010,9|24|3F3EDB-101010") == true or ide5a49ae782b9e689be(ide5ae88e997a83a5831, ide5ae88e997a83a5931, ide5ae88e997a83a5832, ide5ae88e997a83a5932, "3C3CCF-101010", "-5|6|3C3BCE-101010,5|12|3C3BD0-101010,8|26|3C3BD0-101010,-4|23|3D3CD2-101010") == true or ide5a49ae782b9e689be(ide5ae88e997a83a5831, ide5ae88e997a83a5931, ide5ae88e997a83a5832, ide5ae88e997a83a5932, "3F3EDB-101010", "4|11|3F3EDB-101010,-11|13|3F3EDB-101010,6|23|3F3EDB-101010") == true then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function(ide689bee997a83a5831, ide689bee997a83a5931, ide689bee997a83a5832, ide689bee997a83a5932)
  local ReturnValueVar, ide689bee997a83ae997a8 = _UPVALUE1_, nil
  ide689bee997a83ae997a8 = {}
  local ide689bee997a83ae8bdace68da2 = _ENV
  ide689bee997a83ae997a8[1] = LuaAuxLib.NewArray("67A07C-080808", "-5|-3|66A17D-080808,-7|0|689B7F-080808,-4|8|66A07C-080808")
  ide689bee997a83ae997a8[2] = LuaAuxLib.NewArray("658B7C-080808", "-5|3|62897B-080808,-4|9|62897C-080808,1|12|648A7C-080808")
  ide689bee997a83ae997a8[3] = LuaAuxLib.NewArray("618678-080808", "4|12|628879-080808,-4|12|628879-080808,-5|2|608678-080808,-5|8|628778-101010")
  ide689bee997a83ae997a8[4] = LuaAuxLib.NewArray("5FC671-080808", "-2|1|5FC671-080808,-8|3|5EC773-080808,-7|13|60C872-080808,1|12|5FC771-080808,-1|7|60C573-080808")
  ide689bee997a83ae997a8[5] = LuaAuxLib.NewArray("64B57A-080808", "6|3|63B477-080808,11|2|63B477-080808,7|-2|63B579-080808,7|-5|64AE78-080808,3|-8|64B578-080808,6|-10|64B578-080808")
  ide689bee997a83ae997a8[6] = LuaAuxLib.NewArray("5F9775-080808", "4|-7|5F9875-080808,8|2|5F9874-080808,6|6|609876-080808")
  ide689bee997a83ae997a8[7] = LuaAuxLib.NewArray("5FAD73-080808", "3|-6|60B174-080808,5|-7|60B074-080808,7|-2|5FAE72-080808,7|5|60B073-080808")
  ide689bee997a83ae997a8[8] = LuaAuxLib.NewArray("5DBF6F-050505", "8|0|5EBD71-050505,11|4|5CC16E-050505,6|-7|5DC26E-050505")
  ide689bee997a83ae997a8[9] = LuaAuxLib.NewArray("59BC6B-080808", "1|-5|5ABC6D-080808,7|-7|5ABC6B-080808,7|-3|5ABC6B-080808,8|5|5ABB6B-080808")
  ide689bee997a83ae997a8[10] = LuaAuxLib.NewArray("59BA6A-080808", "-4|1|57B169-080808,-6|7|58B96A-080808,-2|12|5ABB6A-080808,0|11|59BB6A-080808")
  ide689bee997a83ae997a8[11] = LuaAuxLib.NewArray("FFC461-050505", "4|0|FFC461-050505,7|-5|E7B767-050505,5|5|FEB842-050505")
  ide689bee997a83ae997a8[12] = LuaAuxLib.NewArray("FFC461-050505", "4|0|FFC461-050505,2|-5|FFC461-050505,3|4|FEBE51-050505")
  ide689bee997a83ae997a8[13] = LuaAuxLib.NewArray("5DBF6F-050505", "8|0|5EBD71-050505,11|4|5CC16E-050505,6|-7|5DC26E-050505")
  ide689bee997a83ae997a8[14] = LuaAuxLib.NewArray("FFC461-050505", "5|0|FFC461-050505,4|-4|FFC461-050505,5|8|FFC461-050505")
  for ide689bee997a83a49 = 0, LuaAuxLib.TableSize(ide689bee997a83ae997a8) - 1 do
    ide689bee997a83ae8bdace68da2 = ide689bee997a83ae997a8[ide689bee997a83a49 + 1]
    if ide5a49ae782b9e689be(ide689bee997a83a5831, ide689bee997a83a5931, ide689bee997a83a5832, ide689bee997a83a5932, ide689bee997a83ae8bdace68da2[1], ide689bee997a83ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1179:", (("找到" .. ide689bee997a83a49) .. "门在") .. ide689bee997a83a5831, ide689bee997a83a5931, ide689bee997a83a5832, (ide689bee997a83a5932 .. "坐标") .. ide689be58, ide689be59)
      ReturnValueVar = nil
      ide689bee997a83ae997a8 = nil
      break
    end
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90, ide8bf9be997a8e69da1e4bbb63ae4bca0e98081e580bc, ide8bf9be997a8e69da1e4bbb63ae4b88be6a5bce69da1e4bbb6 = _UPVALUE2_, nil, nil
  ide8bf9be997a8e69da1e4bbb63ae4b88be6a5bce69da1e4bbb6 = LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil)
  ide8bf9be997a8e69da1e4bbb63ae4bca0e98081e580bc = (function()
    local tmpvar = tonumber(LuaAuxLib.ReadConfig("传送值", _ENV, 1, nil))
    if tmpvar == _ENV["nil"] then
      return _ENV["nil"]
    else
      return math.floor(tmpvar)
    end
  end)()
  _ENV[Thread.GetShareVar("重置次数")] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
  _ENV[Thread.GetShareVar("装备栏")] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
  ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90 = Thread.GetShareVar("罐子")
  _ENV[Thread.GetShareVar("杀大怪")] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
  if ide8a385e5a487e6a08f == 1 and ide689bee997a8(ide689be58 + 6, ide689be59 - 10, ide689be58 + 23, ide689be59 + 7) == true then
    _ENV[ide689be58] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
    _ENV[ide689be59] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
    _ENV["门"] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
    ide696b9e59091e5ad98e585a5e69687e69cac()
    ide7a7bbe58aa8()
  end
  if ide69d80e5a4a7e680aa == 0 and ide689bee997a8(ide689be58 + 6, ide689be59 - 10, ide689be58 + 23, ide689be59 + 7) == true then
    if ide8bf9be997a8e69da1e4bbb63ae4b88be6a5bce69da1e4bbb6 == 0 and (function()
      local tmpvar = tonumber(ide9878de7bdaee6aca1e695b0)
      if tmpvar == _ENV["nil"] then
        return _ENV["nil"]
      else
        return math.floor(tmpvar)
      end
    end)() + 1 > (function()
      local tmpvar = tonumber(LuaAuxLib.ReadConfig("进门强回", _ENV, 1, nil))
      if tmpvar == _ENV["nil"] then
        return _ENV["nil"]
      else
        return math.floor(tmpvar)
      end
    end)() then
      LuaAuxLib.TracePrint("_1203:", "强回模式,找到罐子或者强回,要下楼了")
      _ENV[ide689be58] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV[ide689be59] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV["门"] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
    if ide8bf9be997a8e69da1e4bbb63ae4b88be6a5bce69da1e4bbb6 == 1 and ((function()
      local tmpvar = tonumber(ide9878de7bdaee6aca1e695b0)
      if tmpvar == _ENV["nil"] then
        return _ENV["nil"]
      else
        return math.floor(tmpvar)
      end
    end)() + 1 > (function()
      local tmpvar = tonumber(LuaAuxLib.ReadConfig("进门强回", _ENV, 1, nil))
      if tmpvar == _ENV["nil"] then
        return _ENV["nil"]
      else
        return math.floor(tmpvar)
      end
    end)() or ide689bee7bd90e5ad90(60, 164, 647, 1103) == true) then
      LuaAuxLib.TracePrint("_1213:", "找罐子模式,找到罐子或者强回,要下楼了")
      _ENV[ide689be58] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV[ide689be59] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV["门"] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
    if ide8bf9be997a8e69da1e4bbb63ae4b88be6a5bce69da1e4bbb6 == 2 then
      LuaAuxLib.TracePrint("_1223:", "快速下楼模式,找到了门")
      _ENV[ide689be58] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV[ide689be59] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV["门"] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide696b9e59091 + 1] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
    ide99bb7e8bebe()
  end
  if ide69d80e5a4a7e680aa == 1 and ide689bee997a8(ide689be58 + 6, ide689be59 - 10, ide689be58 + 23, ide689be59 + 7) == true then
    LuaAuxLib.TracePrint("_1249:", "BOSS房间按传送值回城")
    LuaAuxLib.TracePrint("_1250:", ide9878de7bdaee6aca1e695b0, ide8bf9be997a8e69da1e4bbb63ae4bca0e98081e580bc)
    if ide8bf9be997a8e69da1e4bbb63ae4bca0e98081e580bc < (function()
      local tmpvar = tonumber(ide9878de7bdaee6aca1e695b0)
      if tmpvar == _ENV["nil"] then
        return _ENV["nil"]
      else
        return math.floor(tmpvar)
      end
    end)() then
      _ENV[ide689be58] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV[ide689be59] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      _ENV["门"] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    else
      ide5ad98e585a5e5b7b2e689be()
      _ENV[ide696b9e59091 + 1] = ide8bf9be997a8e69da1e4bbb63ae7bd90e5ad90
      ide99bb7e8bebe()
    end
  end
end] = _zmm
_ENV[function(ide689bee98791e5b8813a5831, ide689bee98791e5b8813a5931, ide689bee98791e5b8813a5832, ide689bee98791e5b8813a5932)
  local ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81 = _ENV
  ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81 = {}
  local ide689bee98791e5b8813ae8bdace68da2, ide689bee98791e5b8813ae98791e5b881e789b9e5be81 = _UPVALUE1_, nil
  ide689bee98791e5b8813ae98791e5b881e789b9e5be81 = {}
  ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81[1] = LuaAuxLib.NewArray("67A1C3-080808", "3|6|66A1C3-080808,-3|2|659FC1-080808")
  ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81[2] = LuaAuxLib.NewArray("639CBF-080808", "3|-3|639CBF-080808,5|2|639CBF-080808")
  ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81[3] = LuaAuxLib.NewArray("61B1DE-080808", "2|-4|61B1DE-080808,5|1|61B1DE-080808")
  ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81[4] = LuaAuxLib.NewArray("688FA9-080808", "2|-4|688FA9-080808,5|1|688FA9-080808")
  for ide689bee98791e5b8813a49 = 0, LuaAuxLib.TableSize(ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81) - 1 do
    ide689bee98791e5b8813ae8bdace68da2 = ide689bee98791e5b8813ae696b0e8b7afe5b881e789b9e5be81[ide689bee98791e5b8813a49 + 1]
    if ide5a49ae782b9e689be(ide689bee98791e5b8813a5831, ide689bee98791e5b8813a5931, ide689bee98791e5b8813a5832, ide689bee98791e5b8813a5932, ide689bee98791e5b8813ae8bdace68da2[1], ide689bee98791e5b8813ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1278:", (("找到" .. ide689bee98791e5b8813a49) .. "新路币在") .. ide689bee98791e5b8813a5831, ide689bee98791e5b8813a5931, ide689bee98791e5b8813a5832, (ide689bee98791e5b8813a5932 .. "标") .. ide689be58, ide689be59)
      _ENV[ide689be58] = ide689bee98791e5b8813a5831
      _ENV[ide689be59] = ide689bee98791e5b8813a5831
      _ENV["币"] = ide689bee98791e5b8813a5831
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
  end
  ide689bee98791e5b8813ae98791e5b881e789b9e5be81[1] = LuaAuxLib.NewArray("5BC0F3-080808", "0|4|5CC0F4-080808,2|6|5CC0F4-080808,6|8|5CC1F5-080808")
  ide689bee98791e5b8813ae98791e5b881e789b9e5be81[2] = LuaAuxLib.NewArray("60C9FF-090909", "3|0|60C9FF-090909,3|4|60C9FF-090909,-5|2|60C9FF-090909")
  for ide689bee98791e5b8813a49 = 0, LuaAuxLib.TableSize(ide689bee98791e5b8813ae98791e5b881e789b9e5be81) - 1 do
    ide689bee98791e5b8813ae8bdace68da2 = ide689bee98791e5b8813ae98791e5b881e789b9e5be81[ide689bee98791e5b8813a49 + 1]
    if ide5a49ae782b9e689be(ide689bee98791e5b8813a5831, ide689bee98791e5b8813a5931, ide689bee98791e5b8813a5832, ide689bee98791e5b8813a5932, ide689bee98791e5b8813ae8bdace68da2[1], ide689bee98791e5b8813ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1291:", (("找到" .. ide689bee98791e5b8813a49) .. "币在") .. ide689bee98791e5b8813a5831, ide689bee98791e5b8813a5931, ide689bee98791e5b8813a5832, (ide689bee98791e5b8813a5932 .. "坐标") .. ide689be58, ide689be59)
      if ide79baee6a087 == "门" and LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 then
        ide5ad98e585a5e8b5b7e782b9()
        ide5ad98e585a5e5be85e689be()
        ide5ad98e585a5e5b7b2e689be()
        ide696b9e59091e5ad98e585a5e69687e69cac()
        _ENV[ide696b9e59091 + 1] = ide689bee98791e5b8813a5831
        ide99bb7e8bebe()
      end
      if LuaAuxLib.ReadConfig("金币", _ENV, 1, nil) == true then
        _ENV[ide689be58] = ide689bee98791e5b8813a5831
        _ENV[ide689be59] = ide689bee98791e5b8813a5831
        _ENV["币"] = ide689bee98791e5b8813a5831
        ide696b9e59091e5ad98e585a5e69687e69cac()
        ide7a7bbe58aa8()
      else
        ide5ad98e585a5e8b5b7e782b9()
        ide5ad98e585a5e5be85e689be()
        ide5ad98e585a5e5b7b2e689be()
        ide696b9e59091e5ad98e585a5e69687e69cac()
        _ENV[ide696b9e59091 + 1] = ide689bee98791e5b8813a5831
        ide99bb7e8bebe()
      end
    end
  end
end] = _zmm
_ENV[function()
  if ide689be424f5353(ide689be58 + 5, ide689be59 - 9, ide689be58 + 16, ide689be59 + 10) == true then
    LuaAuxLib.TracePrint("_1324:", "找到红在" .. ide689be58 + 5, ide689be59 - 9, ide689be58 + 16, ide689be59 + 10)
    LuaAuxLib.TracePrint("_1325:", "地图选择" .. LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil), "强回值" .. Thread.GetShareVar("重置次数"))
    if LuaAuxLib.ReadConfig("精英", _ENV, 1, nil) == true then
      if ide5ae88e997a8(ide689be58 - 15, ide689be59 - 19, ide689be58 + 26, ide689be59 + 20) == true then
        local id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb = _ENV
        id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb = Thread.GetShareVar("首领激活")
        if id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb == 1 then
          if LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) ~= 0 or LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) ~= 2 and LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) ~= 3 then
            ide5ad98e585a5e5b7b2e689be()
            ide5ad98e585a5e5be85e689be()
            _ENV[ide689be58] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
            _ENV[ide689be59] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
            _ENV["守门"] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
            ide696b9e59091e5ad98e585a5e69687e69cac()
            ide7a7bbe58aa8()
          else
            _ENV[Thread.GetShareVar("重置次数")] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
            if 3 < ide9878de7bdaee6aca1e695b0 then
              ide5ad98e585a5e5b7b2e689be()
              ide5ad98e585a5e5be85e689be()
              _ENV[ide689be58] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
              _ENV[ide689be59] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
              _ENV["守门"] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
              ide696b9e59091e5ad98e585a5e69687e69cac()
              ide7a7bbe58aa8()
            else
              ide5ad98e585a5e5b7b2e689be()
              _ENV[ide696b9e59091 + 1] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
              ide99bb7e8bebe()
            end
          end
        else
          ide5ad98e585a5e5b7b2e689be()
          _ENV[ide696b9e59091 + 1] = id424f5353e8aebee5ae9a3ae9a696e9a286e6bf80e6b4bb
          ide99bb7e8bebe()
        end
      else
        ide5ad98e585a5e5b7b2e689be()
        ide5ad98e585a5e5be85e689be()
        _ENV[ide689be58] = ide689be58
        _ENV["红怪"], _ENV[ide689be59] = ide689be59, ide689be59
        ide696b9e59091e5ad98e585a5e69687e69cac()
        ide7a7bbe58aa8()
      end
    else
      ide5ad98e585a5e5b7b2e689be()
      _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
      ide99bb7e8bebe()
    end
  end
end] = _zmm
_ENV[function(ide689be424f53533a5831, ide689be424f53533a5931, ide689be424f53533a5832, ide689be424f53533a5932)
  local ReturnValueVar = _ENV
  if ide5a49ae782b9e689be(ide689be424f53533a5831, ide689be424f53533a5931, ide689be424f53533a5832, ide689be424f53533a5932, "5F67A0-080808", "-5|1|5F67A0-080808,-5|-2|535C66-080808,-2|5|535C66-080808") == true or ide5a49ae782b9e689be(ide689be424f53533a5831, ide689be424f53533a5931, ide689be424f53533a5832, ide689be424f53533a5932, "19191A-080808", "2|4|3F3EDB-080808,3|10|19191A-080808,5|3|3F3EDB-080808") == true or ide5a49ae782b9e689be(ide689be424f53533a5831, ide689be424f53533a5931, ide689be424f53533a5832, ide689be424f53533a5932, "3F3EDB-090909", "3|-5|191919-090909,7|-3|3F3EDB-090909,7|3|191919-090909") == true then
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(ide689be58, ide689be59 - 10, ide689be58 + 16, ide689be59 + 6, "88C5F1-090909", "1|8|88C5F1-090909,3|4|88C5F1-090909,9|3|88C5F1-090909") == true then
    LuaAuxLib.TracePrint("_1391:", "有罐子" .. ide689be58, ide689be59 - 10, ide689be58 + 16, (ide689be59 + 6 .. "坐标") .. ide689be58, ide689be59)
    ide5bc80e7bd90e5ad90e69da1e4bbb6()
  end
end] = _zmm
_ENV[function()
  _ENV[Thread.GetShareVar("杀大怪")] = Thread.GetShareVar("杀大怪")
  if LuaAuxLib.ReadConfig("罐子", _ENV, 1, nil) == true or ide69d80e5a4a7e680aa == 1 then
    ide4b88de9809ae5ad98e585a5()
    _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]
    _ENV["罐子"], _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1], ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]
    ide696b9e59091e5ad98e585a5e69687e69cac()
    ide7a7bbe58aa8()
  else
    ide4b88de9809ae5ad98e585a5()
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
end] = _zmm
_ENV[function()
  if ide689bee7bd90e5ad90(ide689be58 + 7, ide689be59 - 10, ide689be58 + 16, ide689be59 + 6) == true then
    LuaAuxLib.TracePrint("_1413:", "黑罐子" .. ide689be58 + 7, ide689be59 - 10, ide689be58 + 16, (ide689be59 + 6 .. "----------") .. ide689be58, ide689be59)
    ide4b88de9809ae5ad98e585a5()
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide5a49ae782b9e689be(ide689be58, ide689be59 - 10, ide689be58 + 16, ide689be59 + 6, "909090-090909", "6|0|919191-090909,5|4|919191-090909,-1|8|919191-090909,8|8|909090-090909") == true then
    LuaAuxLib.TracePrint("_1420:", "黑石头" .. ide689be58, ide689be59 - 10, ide689be58 + 20, ide689be59 + 10)
    ide4b88de9809ae5ad98e585a5()
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide5a49ae782b9e689be(ide689be58 + 6, ide689be59 - 7, ide689be58 + 20, ide689be59 + 10, "727272-050505", "8|3|AAAAAA-050505,8|-4|AAAAAA-050505,4|-11|ABABAB-050505") == true then
    LuaAuxLib.TracePrint("_1426:", "黑箱子" .. ide689be58 + 6, ide689be59 - 7, ide689be58 + 20, ide689be59 + 10)
    ide4b88de9809ae5ad98e585a5()
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide5a49ae782b9e689be(ide689be58, ide689be59 - 7, ide689be58 + 16, ide689be59 + 6, "484B4C-050505", "5|1|484B4C-050505,5|-5|3A3D40-050505,5|8|36393C-050505") == true then
    LuaAuxLib.TracePrint("_1432:", "黑点金" .. ide689be58, ide689be59 - 7, ide689be58 + 16, ide689be59 + 6)
    ide4b88de9809ae5ad98e585a5()
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide5a49ae782b9e689be(ide689be58 + 5, ide689be59 - 10, ide689be58 + 20, ide689be59 + 10, "5FC9F1-080808", "7|3|2D5C87-080808,2|9|5FC9F1-080808") == true then
    LuaAuxLib.TracePrint("_1438:", "找到附魔机在" .. ide689be58, ide689be59 - 10, ide689be58 + 20, (ide689be59 + 10 .. "坐标") .. ide689be58, ide689be59)
    ide4b88de9809ae5ad98e585a5()
    _ENV[ide696b9e59091 + 1] = ide696b9e59091 + 1
    ide99bb7e8bebe()
  end
  if ide5a49ae782b9e689be(ide689be58 + 7, ide689be59 - 6, ide689be58 + 17, ide689be59 + 4, "BAB98B-080808", "5|1|BBBA8C-080808,2|3|BBBA8B-080808,6|9|BAB98C-080808") == true then
    LuaAuxLib.TracePrint("_1444:", "青石头" .. ide689be58 + 7, ide689be59 - 6, ide689be58 + 17, ide689be59 + 4)
    local ide698afe590a6e997a83ae5b182e695b0 = _ENV
    ide698afe590a6e997a83ae5b182e695b0 = Thread.GetShareVar("层数")
    if ide79baee6a087 == "门" and LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 then
      ide5ad98e585a5e5b7b2e689be()
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae5b182e695b0
      ide99bb7e8bebe()
    end
    if LuaAuxLib.ReadConfig("石头", _ENV, 1, nil) == 1 then
      ide5ad98e585a5e5b7b2e689be()
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae5b182e695b0
      _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae5b182e695b0
      _ENV["石头"] = ide698afe590a6e997a83ae5b182e695b0
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    elseif LuaAuxLib.ReadConfig("石头", _ENV, 1, nil) == 2 and 21 < ide698afe590a6e997a83ae5b182e695b0 then
      ide5ad98e585a5e5b7b2e689be()
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae5b182e695b0
      _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae5b182e695b0
      _ENV["石头"] = ide698afe590a6e997a83ae5b182e695b0
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    else
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae5b182e695b0
      ide99bb7e8bebe()
    end
  end
  ide8bf9be997a8e69da1e4bbb6()
  local ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81 = _ENV
  ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81 = {}
  local ide698afe590a6e997a83ae8bdace68da2 = _ENV
  ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81[1] = LuaAuxLib.NewArray("5D89AA-080808", "4|-1|5E89AB-080808,2|-4|4D555F-080808,6|3|4D555F-080808")
  ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81[2] = LuaAuxLib.NewArray("5394C2-080808", "3|-3|363D44-080808,5|6|363D44-080808,8|0|5495C3-080808")
  for ide698afe590a6e997a83a49 = 0, LuaAuxLib.TableSize(ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81) - 1 do
    ide698afe590a6e997a83ae8bdace68da2 = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81[ide698afe590a6e997a83a49 + 1]
    if ide5a49ae782b9e689be(ide689be58 + 5, ide689be59 - 10, ide689be58 + 16, ide689be59 + 6, ide698afe590a6e997a83ae8bdace68da2[1], ide698afe590a6e997a83ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1486:", "在新路的怪" .. ide698afe590a6e997a83a49)
      _ENV[Thread.GetShareVar("杀大怪")] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      if ide79baee6a087 == "门" and ide69d80e5a4a7e680aa == 0 then
        ide5ad98e585a5e5be85e689be()
        ide5ad98e585a5e5b7b2e689be()
        _ENV[nil] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        _ENV[ide8b7afe5be84 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = ((ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1] .. ide696b9e59091) .. "-") .. "怪-"
        _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide99bb7e8bebe()
      end
      _ENV[ide689be58] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV[ide689be59] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV["怪"] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
  end
  if ide5a49ae782b9e689be(ide689be58 + 5, ide689be59 - 10, ide689be58 + 16, ide689be59 + 6, "3BB1FF-080808", "0|-3|000000-080808,4|0|3CB1FF-080808,3|5|000101-080808") == true or ide5a49ae782b9e689be(ide689be58 + 5, ide689be59 - 10, ide689be58 + 16, ide689be59 + 6, "47A1DF-090909", "-3|-3|1B1E22-090909,0|4|1B1E22-090909") == true or ide5a49ae782b9e689be(ide689be58 + 5, ide689be59 - 10, ide689be58 + 16, ide689be59 + 6, "3CB0FD-090909", "-6|2|3CAFFE-090909,-4|-2|000000-090909,-1|5|000000-090909,-3|2|39AFFE-090909") == true then
    LuaAuxLib.TracePrint("_1508:", "找到怪" .. ide689be58 + 5, ide689be59 - 10, ide689be58 + 16, (ide689be59 + 6 .. "坐标") .. ide689be58, ide689be59)
    _ENV[Thread.GetShareVar("层数")] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
    local ide698afe590a6e997a83ae6b885e680aae5b182 = _ENV
    ide698afe590a6e997a83ae6b885e680aae5b182 = Thread.GetShareVar("清怪层")
    LuaAuxLib.TracePrint("_1511:", ide698afe590a6e997a83ae6b885e680aae5b182[1], ide698afe590a6e997a83ae6b885e680aae5b182[2], ide698afe590a6e997a83ae6b885e680aae5b182[3], ide698afe590a6e997a83ae5b182e695b0)
    local ide698afe590a6e997a83ae9a696e9a286e6bf80e6b4bb = _ENV
    ide698afe590a6e997a83ae9a696e9a286e6bf80e6b4bb = Thread.GetShareVar("首领激活")
    if ide698afe590a6e997a83ae9a696e9a286e6bf80e6b4bb == 0 then
      _ENV[ide689be58] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV[ide689be59] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV["怪"] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
    _ENV[Thread.GetShareVar("杀大怪")] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
    if ide79baee6a087 == "门" and ide69d80e5a4a7e680aa == 0 then
      ide5ad98e585a5e5be85e689be()
      ide5ad98e585a5e5b7b2e689be()
      _ENV[nil] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV[ide8b7afe5be84 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = ((ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1] .. ide696b9e59091) .. "-") .. "怪-"
      _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide99bb7e8bebe()
    end
    if LuaAuxLib.ReadConfig("小怪", _ENV, 1, nil) == false and ide69d80e5a4a7e680aa == 0 then
      ide5ad98e585a5e5be85e689be()
      ide5ad98e585a5e5b7b2e689be()
      _ENV[nil] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV[ide8b7afe5be84 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1] = ((ide696b9e59091e695b0e7bb84[ide4b88ae4b8aae8b7afe6a087 + 1] .. ide696b9e59091) .. "-") .. "怪-"
      _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide99bb7e8bebe()
    end
    _ENV[ide689be58] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
    _ENV[ide689be59] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
    _ENV["怪"] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
    ide696b9e59091e5ad98e585a5e69687e69cac()
    ide7a7bbe58aa8()
  end
  local ide698afe590a6e997a83ae78ab6e68081 = _ENV
  ide698afe590a6e997a83ae78ab6e68081 = {}
  ide698afe590a6e997a83ae78ab6e68081[1] = LuaAuxLib.NewArray("E8F18E-080808", "1|6|E3EC8C-080808,3|3|E6EF8D-080808,8|3|E7F18E-080808")
  ide698afe590a6e997a83ae78ab6e68081[2] = LuaAuxLib.NewArray("E4ED8D-080808", "0|-7|E6F08E-080808,7|-7|E0E98C-080808,7|-3|E8F18F-080808,7|0|E3EC8E-101010")
  ide698afe590a6e997a83ae78ab6e68081[3] = LuaAuxLib.NewArray("E5EE8D-080808", "4|-3|E1EA8B-080808,7|1|E0E98B-080808,5|3|DFE88A-080808")
  ide698afe590a6e997a83ae78ab6e68081[4] = LuaAuxLib.NewArray("B2BB7F-080808", "5|3|BBC482-080808,7|0|B8C182-080808,4|-3|BDC684-080808")
  ide698afe590a6e997a83ae78ab6e68081[5] = LuaAuxLib.NewArray("EAF490-050505", "4|3|E3EC8C-050505,6|1|E4ED8D-050505,8|-6|E5EE8D-050505")
  ide698afe590a6e997a83ae78ab6e68081[6] = LuaAuxLib.NewArray("ABB68B-050505", "3|-3|AAB48B-050505,6|1|A8B38A-050505,4|4|A8B38A-050505")
  for ide698afe590a6e997a83a49 = 0, LuaAuxLib.TableSize(ide698afe590a6e997a83ae78ab6e68081) - 1 do
    ide698afe590a6e997a83ae8bdace68da2 = ide698afe590a6e997a83ae78ab6e68081[ide698afe590a6e997a83a49 + 1]
    if ide5a49ae782b9e689be(ide689be58 + 6, ide689be59 - 10, ide689be58 + 18, ide689be59 + 7, ide698afe590a6e997a83ae8bdace68da2[1], ide698afe590a6e997a83ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1570:", (ide698afe590a6e997a83a49 .. "找到了BUFF") .. ide689be58 + 6, ide689be59 - 10, ide689be58 + 18, (ide689be59 + 7 .. "坐标") .. ide689be58, ide689be59)
      if ide79baee6a087 == "门" and LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 then
        ide5ad98e585a5e8b5b7e782b9()
        ide5ad98e585a5e5be85e689be()
        ide5ad98e585a5e5b7b2e689be()
        ide696b9e59091e5ad98e585a5e69687e69cac()
        _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide99bb7e8bebe()
      end
      if LuaAuxLib.ReadConfig("BUFF", _ENV, 1, nil) == true then
        _ENV[ide689be58] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        _ENV[ide689be59] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        buff = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide696b9e59091e5ad98e585a5e69687e69cac()
        ide7a7bbe58aa8()
      elseif 4 < ide698afe590a6e997a83a49 then
        _ENV[ide689be58] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        _ENV[ide689be59] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        buff = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide696b9e59091e5ad98e585a5e69687e69cac()
        ide7a7bbe58aa8()
      else
        ide5ad98e585a5e8b5b7e782b9()
        ide5ad98e585a5e5be85e689be()
        ide5ad98e585a5e5b7b2e689be()
        ide696b9e59091e5ad98e585a5e69687e69cac()
        _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide99bb7e8bebe()
      end
    end
  end
  ide689bee98791e5b881(ide689be58 + 8, ide689be59 - 12, ide689be58 + 18, ide689be59 + 6)
  ide5bc80e7bd90e5ad90()
  local ide698afe590a6e997a83ae992a5e58c99e789b9e5be81 = _ENV
  ide698afe590a6e997a83ae992a5e58c99e789b9e5be81 = {}
  ide698afe590a6e997a83ae992a5e58c99e789b9e5be81[1] = LuaAuxLib.NewArray("60C9FF-050505", "4|2|60C9FE-050505,12|2|60C9FF-050505,10|7|60C6FA,12|12|60C9FF")
  for ide698afe590a6e997a83a49 = 0, LuaAuxLib.TableSize(ide698afe590a6e997a83ae992a5e58c99e789b9e5be81) - 1 do
    ide698afe590a6e997a83ae8bdace68da2 = ide698afe590a6e997a83ae992a5e58c99e789b9e5be81[ide698afe590a6e997a83a49 + 1]
    if ide5a49ae782b9e689be(ide689be58 + 6, ide689be59 - 13, ide689be58 + 13, ide689be59 + 5, ide698afe590a6e997a83ae8bdace68da2[1], ide698afe590a6e997a83ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1612:", (ide698afe590a6e997a83a49 .. "正常钥匙") .. ide689be58, (ide689be59 .. "范围") .. ide689be58 + 6, ide689be59 - 13, ide689be58 + 13, ide689be59 + 5)
      _ENV[ide689be58] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV[ide689be59] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV["钥匙"] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
  end
  local ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81 = _ENV
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81 = {}
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[4] = LuaAuxLib.NewArray("5E78AF-080808", "0|4|5E78AF-080808,1|7|5E78AF-080808")
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[1] = LuaAuxLib.NewArray("537CD6-080808", "2|6|547DDB-080808,2|5|547DDB-080808,2|8|547DDB-080808")
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[2] = LuaAuxLib.NewArray("4AA2FF-080808", "-4|6|5DB8F9-080808,2|4|49A1FE-080808,2|7|49A1FE-080808")
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[3] = LuaAuxLib.NewArray("4F75CC-080808", "3|1|4F75CD-080808,4|4|4E75CC-080808,5|8|4E75CC-080808")
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[5] = LuaAuxLib.NewArray("2A375D-080808", "5|0|446AA5-080808,3|-7|446AA5-080808,5|6|446AA5-080808")
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[6] = LuaAuxLib.NewArray("4DB5F7-080808", "6|0|58BEFF-080808,1|-7|58BEFF-080808,7|6|56BAFB-080808")
  ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[7] = LuaAuxLib.NewArray("55B9F9-050505", "5|1|58BDFE-050505,5|-4|58BDFE-050505,2|-9|58BDFE-050505")
  for ide698afe590a6e997a83a49 = 0, LuaAuxLib.TableSize(ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81) - 1 do
    ide698afe590a6e997a83ae8bdace68da2 = ide698afe590a6e997a83ae7aeb1e5ad90e789b9e5be81[ide698afe590a6e997a83a49 + 1]
    if ide5a49ae782b9e689be(ide689be58 + 6, ide689be59 - 13, ide689be58 + 13, ide689be59 + 5, ide698afe590a6e997a83ae8bdace68da2[1], ide698afe590a6e997a83ae8bdace68da2[2]) == true then
      LuaAuxLib.TracePrint("_1635:", (ide698afe590a6e997a83a49 .. "正常箱子") .. ide689be58, (ide689be59 .. "范围") .. ide689be58 + 6, ide689be59 - 13, ide689be58 + 13, ide689be59 + 5)
      _ENV[Thread.GetShareVar("杀大怪")] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      if ide79baee6a087 == "门" and LuaAuxLib.ReadConfig("下楼条件", _ENV, 1, nil) == 2 and ide69d80e5a4a7e680aa == 0 then
        ide5ad98e585a5e5b7b2e689be()
        ide4b88de9809ae5ad98e585a5()
        _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide99bb7e8bebe()
      end
      if LuaAuxLib.ReadConfig("箱子", _ENV, 1, nil) == false and ide69d80e5a4a7e680aa == 0 then
        ide5ad98e585a5e5b7b2e689be()
        ide4b88de9809ae5ad98e585a5()
        _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide99bb7e8bebe()
      end
      if ide69d80e5a4a7e680aa == 1 then
        ide5ad98e585a5e5b7b2e689be()
        ide4b88de9809ae5ad98e585a5()
        _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        _ENV["箱子"] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
        ide696b9e59091e5ad98e585a5e69687e69cac()
        ide7a7bbe58aa8()
      end
      ide5ad98e585a5e5b7b2e689be()
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV["箱子"] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    end
  end
  ide689bee782b9e98791e69cba(ide689be58 + 9, ide689be59 - 10, ide689be58 + 20, ide689be59 + 6)
  id424f5353e8aebee5ae9a()
  if ide5a49ae782b9e689be(ide689be58, ide689be59 - 10, ide689be58 + 20, ide689be59 + 10, "639DBF-030303", "8|-4|67A1C3-030303,13|1|67A1C3-030303,11|5|66A1C3-030303") == true or ide5a49ae782b9e689be(ide689be58, ide689be59 - 10, ide689be58 + 20, ide689be59 + 10, "639DBF-030303", "8|-4|67A1C3-030303,13|1|67A1C3-030303,11|5|66A1C3-030303") == true or ide5a49ae782b9e689be(ide689be58, ide689be59 - 10, ide689be58 + 20, ide689be59 + 10, "60C9FF-030303", "8|-4|60C9FF-030303,9|1|65717E-030303,10|4|5FC5FA-030303") == true then
    LuaAuxLib.TracePrint("_1670:", "神秘商人买卖窗口")
    _ENV[Thread.GetShareVar("装备栏")] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
    LuaAuxLib.TracePrint("_1672:", "神秘商人买卖窗口", ide8a385e5a487e6a08f)
    if ide8a385e5a487e6a08f == 0 then
      ide5ad98e585a5e5b7b2e689be()
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1]] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      _ENV["神秘商人买卖窗口"] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide696b9e59091e5ad98e585a5e69687e69cac()
      ide7a7bbe58aa8()
    elseif ide8a385e5a487e6a08f == 1 then
      ide4b88de9809ae5ad98e585a5()
      _ENV[ide696b9e59091 + 1] = ide698afe590a6e997a83ae696b0e8b7afe680aae789b9e5be81
      ide99bb7e8bebe()
    end
  end
end] = _zmm
_ENV[function()
  LuaAuxLib.Sleep(111)
  local ide7a7bbe58aa83a52434f4c4f52 = _ENV
  if ide680aa == "新路" then
    _ENV[ide696b0e8b7afe6aca1e695b0 + 1] = ide7a7bbe58aa83a52434f4c4f52
    LuaAuxLib.TracePrint("_1711:", "新路次数" .. ide696b0e8b7afe6aca1e695b0)
    if ide696b0e8b7afe6aca1e695b0 > 2 then
      _ENV[0] = ide7a7bbe58aa83a52434f4c4f52
      while true do
        LuaAuxLib.Sleep(3333)
        LuaAuxLib.TracePrint("_1716:", "找到新路,线程等待中", ide7a7bbe58aa83a52434f4c4f52)
      end
    end
  end
  if ide680aa == "门" or ide680aa == "NULL" or ide680aa == "点金" or ide680aa == "红怪" then
    ide7a7bbe58aa83a52434f4c4f52 = LuaAuxLib.GetPixelColor(ide689be58, ide689be59, _ENV)
    LuaAuxLib.TracePrint("_1725:", "找到门或者路NULL,等待中", ide7a7bbe58aa83a52434f4c4f52)
    while true do
      LuaAuxLib.Sleep(3333)
      LuaAuxLib.TracePrint("_1728:", "找到门或者NULL,线程等待中", ide7a7bbe58aa83a52434f4c4f52)
    end
  end
  _ENV[ide69687e4bbb6e5908de4ba8c + 1] = ide7a7bbe58aa83a52434f4c4f52
  ide6b885e7a9bae695b0e7bb84()
  _ENV[0] = ide7a7bbe58aa83a52434f4c4f52
  _ENV[0] = ide7a7bbe58aa83a52434f4c4f52
  _ENV[0] = ide7a7bbe58aa83a52434f4c4f52
  _ENV[ide5ad9858] = ide7a7bbe58aa83a52434f4c4f52
  _ENV[ide5ad9859] = ide7a7bbe58aa83a52434f4c4f52
  ide5ad98e585a5e8b5b7e782b9()
  ide5b7b2e689bee59d90e6a08758[ide5b7b2e689bee695b0 + 1] = ide689be58
  ide5b7b2e689bee59d90e6a08759[ide5b7b2e689bee695b0 + 1] = ide689be59
  ide5be85e689bee8b7af58[ide8b7af + 1] = ide5ad9858
  ide5be85e689bee8b7af59[ide8b7af + 1] = ide5ad9859
  _ENV[0] = ide7a7bbe58aa83a52434f4c4f52
  _ENV[0] = ide7a7bbe58aa83a52434f4c4f52
  ide99bb7e8bebe()
end] = _zmm
_ENV[function(ide689bee7bd90e5ad903a5831, ide689bee7bd90e5ad903a5931, ide689bee7bd90e5ad903a5832, ide689bee7bd90e5ad903a5932)
  local ReturnValueVar = _ENV
  if ide5a49ae782b9e689be(ide689bee7bd90e5ad903a5831, ide689bee7bd90e5ad903a5931, ide689bee7bd90e5ad903a5832, ide689bee7bd90e5ad903a5932, "919191-050505", "0|14|919191-050505,7|7|919191-050505,-6|7|919191-050505,12|7|919191-050505") == true or ide5a49ae782b9e689be(ide689bee7bd90e5ad903a5831, ide689bee7bd90e5ad903a5931, ide689bee7bd90e5ad903a5832, ide689bee7bd90e5ad903a5932, "909090-090909", "0|9|909090-090909,7|4|909090-090909,7|3|88C5F1-090909") == true then
    LuaAuxLib.TracePrint("_1757:", "有找过罐子,可以进门了" .. ide689bee7bd90e5ad903a5831, ide689bee7bd90e5ad903a5931, ide689bee7bd90e5ad903a5832, ide689bee7bd90e5ad903a5932, ide689be58, ide689be59)
    ReturnValueVar = nil
    Thread.SetShareVar("罐子", nil)
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  File.Write(ide69687e4bbb6e5a4b9 .. "0.txt", "")
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  if ide6af94e889b2("644|1147|434782-050505,630|1148|2B2E38-050505,616|1148|434782-050505,203|1237|447853-050505,227|1231|2B502D-050505") == true then
    LuaAuxLib.TracePrint("_1784:", "打开了小地图")
    ide9878de7bdaee689bee59bbe()
    ide59f8ee9878ce59cb0e59bbe()
    ide7a59ee7a798e59586e4baba()
    ide5a587e680aae79a84e688bfe997b4()
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    _ENV[Thread.GetShareVar("重置次数")] = ReturnValueVar
    _ENV[ide9878de7bdaee6aca1e695b0 + 1] = ReturnValueVar
    LuaAuxLib.TracePrint("_1796:", LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("卡图次数", _ENV, 1, nil)), ide9878de7bdaee6aca1e695b0)
    if LuaAuxLib.VBS_Round(ide9878de7bdaee6aca1e695b0) > LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("卡图次数", _ENV, 1, nil)) then
      LuaAuxLib.Tap(632, 1149, 0)
      LuaAuxLib.Sleep(1111)
      ide5bcbae588b6e59b9ee59f8e()
    end
    Thread.SetShareVar("重置次数", ide9878de7bdaee6aca1e695b0)
    LuaAuxLib.TracePrint("_1807:", "重置次数" .. ide9878de7bdaee6aca1e695b0)
    ide5bc80e5a78be5afbbe8b7af()
    LuaAuxLib.Sleep(888)
    while true do
      LuaAuxLib.Sleep(55)
      _ENV[1] = ReturnValueVar
      ide7a7bbe58aa8e696b9e5bc8f()
    end
  else
    if ide6af94e889b2("644|1147|434782-050505,630|1148|2B2E38-050505,616|1148|434782-050505,203|1237|447853-050505,227|1231|2B502D-050505") == true then
      LuaAuxLib.Tap(632, 1149, 0)
      LuaAuxLib.Sleep(555)
      ide5b08fe59cb0e59bbe()
    end
    _ENV[0] = ReturnValueVar
    ide68898e69697e4b8ad()
    ide68898e69697e7bb9fe8aea1()
    ide9878de7bdaee689bee59bbe()
    ide8bf9be59bbe()
    ide4bbbbe58aa1e68f90e4baa4()
    ide7a59ee7a798e59586e4babae58d96e8a385e5a487()
    LuaAuxLib.TracePrint("_1854:", ("没检测到小地图,将要打开" .. "需要完成的任务数") .. ide5ae8ce68890e695b0)
    ide782b9e98791()
    if LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 2 and ide6af94e889b2("562|399|42A2C6-101010,564|423|42A4C9-101010,566|443|409CBF-101010,553|461|44ABD1-101010,572|798|26272A-080808") == true then
      Thread.SetShareVar("首领激活", 0)
    else
      Thread.SetShareVar("首领激活", 1)
    end
    ide781b5e8a786e58db7e8bdb4()
    ide68898e588a9e59381()
    _ENV[Thread.GetShareVar("回城层数")] = ReturnValueVar
    local ide5b08fe59cb0e59bbe3ae5b182e695b0 = _ENV
    ide5b08fe59cb0e59bbe3ae5b182e695b0 = Thread.GetShareVar("层数")
    LuaAuxLib.TracePrint("_1874:", ide5b08fe59cb0e59bbe3ae5b182e695b0, ide59b9ee59f8ee5b182e695b0)
    if 1000 < ide5b08fe59cb0e59bbe3ae5b182e695b0 then
      for TempVar = 1, 2 do
        LuaAuxLib.TracePrint("_1877:", "层数超了")
        LuaAuxLib.Tap(70, 866, 0)
        LuaAuxLib.Sleep(11)
      end
    end
    local ide5b08fe59cb0e59bbe3ae6a380e6b58be4bbbbe58aa1 = _ENV
    ide5b08fe59cb0e59bbe3ae6a380e6b58be4bbbbe58aa1 = Thread.GetShareVar("检测任务")
    if 0 < ide5ae9ae697b6e585b3e997ad and LuaAuxLib.GetTickCount() / 1000 / 60 > ide5ae9ae697b6e585b3e997ad then
      LuaAuxLib.KillApp("com.avalon.caveonline.cn.leiting", _ENV)
      while true do
        LuaAuxLib.KeyPress("Back", 0)
        LuaAuxLib.ShowMessage(tostring("时间到,暂停脚本并关闭游戏"), _UPVALUE2_, LuaAuxLib.Sleep, 11)
        LuaAuxLib.TracePrint("_1925:", "时间到,暂停脚本并关闭游戏")
        LuaAuxLib.Sleep(5555)
      end
    end
    if ide58cbae59f9fe689be(583, 1162, 620, 1188, "FDE23F-050505|FFCA4E-050505") == true then
      LuaAuxLib.Tap(id494e5458, id494e5459, 0)
      LuaAuxLib.Sleep(333)
      LuaAuxLib.TracePrint("_1940:", "小图有角色")
    else
      LuaAuxLib.TracePrint("_1943:", "小图没角色")
      LuaAuxLib.Tap(558, 1166, 0)
      LuaAuxLib.Tap(330, 640, 200)
      LuaAuxLib.Sleep(333)
    end
    LuaAuxLib.Sleep(555)
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    ide5b08fe59cb0e59bbe()
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  if ide6af94e889b2("596|1162|5F6979-050505") == true then
    LuaAuxLib.Tap(201, 113, 0)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(92, 219, 0)
    LuaAuxLib.Sleep(33)
  elseif ide6af94e889b2("587|1179|5F6979-050505") == true then
    LuaAuxLib.Tap(92, 219, 0)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(201, 113, 0)
    LuaAuxLib.Sleep(33)
  elseif ide6af94e889b2("587|1164|5F6979-050505") == true then
    LuaAuxLib.Tap(84, 115, 0)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(196, 227, 0)
    LuaAuxLib.Sleep(33)
  elseif ide6af94e889b2("597|1186|5F6979-050505") == true then
    LuaAuxLib.Tap(196, 227, 0)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(84, 115, 0)
    LuaAuxLib.Sleep(33)
  else
    LuaAuxLib.TracePrint("_1978:", "没找到路")
  end
  LuaAuxLib.TracePrint("_1980:", "走动")
end] = _zmm
_ENV[function()
  _ENV[LuaAuxLib.NewArray(0)] = LuaAuxLib.NewArray(0)
  _ENV[LuaAuxLib.NewArray(0)] = LuaAuxLib.NewArray(0)
  Thread.SetShareVar("不通X", ide4b88de9809a58)
  Thread.SetShareVar("不通Y", ide4b88de9809a58)
  Thread.SetShareVar("起点X", ide4b88de9809a58)
  Thread.SetShareVar("起点Y", ide4b88de9809a58)
end] = _zmm
_ENV[function(ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6)
  local ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0 = _ENV
  if ide5a49ae782b9e689be(171, 588, 288, 823, "47E8AD-080808", "-11|0|62833B-080808,-20|0|ABAFBF-080808") or ide6af94e889b2("230|480|48B1D4-080808,166|716|50BFDF-080808,227|715|48B1D4-080808,234|814|50BFDF-080808") or ide6af94e889b2("231|353|50BFDF-080808,232|667|50BFDF-080808,230|909|50BFDF-080808,171|656|50BFDF-080808,525|476|9597A2-080808,516|719|9597A2-080808,519|814|9597A2-080808") == true then
    Thread.SetShareVar("找过红怪", nil)
    _ENV[Thread.GetShareVar("全部层数")] = ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6
    _ENV[Thread.GetShareVar("准备下楼")] = ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6
    if ide58786e5a487e4b88be6a5bc == true then
      _ENV[ide585a8e983a8e5b182e695b0 + 1] = ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6
      Thread.SetShareVar("准备下楼", nil)
      Thread.SetShareVar("全部层数", ide585a8e983a8e5b182e695b0)
    end
    ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0 = Thread.GetShareVar("层数")
    ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0 = ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0 + 1
    _ENV[Thread.GetShareVar("回城层数")] = ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6
    LuaAuxLib.TracePrint("_2024:", ide59b9ee59f8ee5b182e695b0, ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0)
    if ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0 > ide59b9ee59f8ee5b182e695b0 then
      ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0 = 1111
    end
    Thread.SetShareVar("层数", ide8bf9be585a5e4b88be4b880e5b1823ae5b182e695b0)
    LuaAuxLib.TracePrint("_2029:", "进入下一层")
    LuaAuxLib.Sleep(1111)
    _ENV[Thread.GetShareVar("见BOSS次数")] = ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6
    _ENV[Thread.GetShareVar("杀大怪")] = ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6
    if ide69d80e5a4a7e680aa == 1 then
      Thread.SetShareVar("杀大怪", 0)
      _ENV[ide8a781424f5353e6aca1e695b0 + 1] = ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6
      Thread.SetShareVar("见BOSS次数", ide8a781424f5353e6aca1e695b0)
    end
    Thread.SetShareVar("检测任务", nil)
    Thread.SetShareVar("是否点金", 0)
    Thread.SetShareVar("杀完BOSS", 0)
    Thread.SetShareVar("神秘移动", 0)
    Thread.SetShareVar("转动次数", 0)
    Thread.SetShareVar("分解次数", 0)
    Thread.SetShareVar("交任务", 0)
    Thread.SetShareVar("吃料理", 0)
    Thread.SetShareVar("灵视次数", 0)
    Thread.SetShareVar("罐子", nil)
    Thread.SetShareVar("重置次数", -5)
    Thread.SetShareVar("装备栏", 0)
    LuaAuxLib.Tap(242, 873, 0)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(id494e5458, id494e5459, 0)
    LuaAuxLib.Sleep(ide8bf9be585a5e4b88be4b880e5b1823ae5bbb6e697b6 * 1000)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("610|589|3A3839-111111,610|602|322E2F-111111,611|618|373435-111111,610|644|393738-111111,610|631|332F30-111111") == true then
    LuaAuxLib.TracePrint("_2074:", "神秘商人房间")
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  end
  if ide6af94e889b2("610|589|3A3839-111111,610|602|322E2F-111111,611|618|373435-111111,610|644|393738-111111,610|631|332F30-111111") == true then
    local ide7a59ee7a798e59586e4baba3ae7a59ee7a798e7a7bbe58aa8 = _ENV
    ide7a59ee7a798e59586e4baba3ae7a59ee7a798e7a7bbe58aa8 = Thread.GetShareVar("神秘移动")
    Thread.SetShareVar("灵视次数", 2)
    LuaAuxLib.TracePrint("_2083:", "神秘商人房间2")
    if ide7a59ee7a798e59586e4baba3ae7a59ee7a798e7a7bbe58aa8 == 0 then
      LuaAuxLib.TracePrint("_2093:", "找商店")
      LuaAuxLib.Tap(629, 1147, 0)
      LuaAuxLib.Sleep(555)
      if LuaAuxLib.ReadConfig("组队", _ENV, 1, nil) == 2 and ide884b1e7a6bbe7bb84e9989f == true then
        for TempVar = 1, 2 do
          for TempVar = 1, 2 do
            LuaAuxLib.Tap(661, 215, 0)
            LuaAuxLib.Sleep(111)
          end
          LuaAuxLib.Sleep(1111)
        end
        Thread.SetShareVar("层数", -1)
        _ENV[false] = ide7a59ee7a798e59586e4baba3ae7a59ee7a798e7a7bbe58aa8
        ide5b08fe59cb0e59bbe()
      end
      LuaAuxLib.Tap(623, 850, 0)
      LuaAuxLib.Sleep(5555)
      Thread.SetShareVar("神秘移动", 1)
      ide5b08fe59cb0e59bbe()
    end
  end
end] = _zmm
_ENV[function()
  local ReturnValueVar, ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae, ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94, ide7a7bbe58aa8e696b9e5bc8f3a4d42, ide7a7bbe58aa8e696b9e5bc8f3ae5bc80e5a78be7ad94e9a298 = _UPVALUE4_, nil, nil, nil, nil
  ide7a7bbe58aa8e696b9e5bc8f3ae5bc80e5a78be7ad94e9a298 = Thread.GetShareVar("开始答题")
  _ENV[Thread.GetShareVar("路径")] = ReturnValueVar
  ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae = Thread.GetShareVar("需要重置线程")
  if ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae == true then
    LuaAuxLib.TracePrint("_2128:", "需要重置线程")
    Thread.SetShareVar("需要重置线程", nil)
    ide5b08fe59cb0e59bbe()
  end
  if ide69687e4bbb6e5908de4ba8c <= LuaAuxLib.TableSize(ide680aae789a9) - 1 then
    ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 = LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("移动间隔输入框", _ENV, 1, nil))
    Thread.SetShareVar("允许拦路数", 0)
    _ENV[LuaAuxLib.StringSplit(ide680aae789a9[ide69687e4bbb6e5908de4ba8c + 1], "-")] = ReturnValueVar
    local ide7a7bbe58aa8e696b9e5bc8f3ae5b182e695b0 = _ENV
    ide7a7bbe58aa8e696b9e5bc8f3ae5b182e695b0 = Thread.GetShareVar("层数")
    local ide7a7bbe58aa8e696b9e5bc8f3ae59b9ee59f8ee5b182e695b0 = _ENV
    ide7a7bbe58aa8e696b9e5bc8f3ae59b9ee59f8ee5b182e695b0 = Thread.GetShareVar("回城层数")
    LuaAuxLib.TracePrint("_2146:", ide7a7bbe58aa8e696b9e5bc8f3ae59b9ee59f8ee5b182e695b0, ide7a7bbe58aa8e696b9e5bc8f3ae5b182e695b0, ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1], LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil))
    LuaAuxLib.TracePrint("_2147:", (((("一共需要移动" .. LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - 2) .. "步") .. ide680aae789a9[ide69687e4bbb6e5908de4ba8c + 1]) .. "时间") .. LuaAuxLib.GetTickCount())
    LuaAuxLib.ShowMessage(tostring(((("目标" .. ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1]) .. "距离") .. LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - 2) .. "步"), 0, 0, 700)
    if ide7a7bbe58aa8e696b9e5bc8f3ae59b9ee59f8ee5b182e695b0 < ide7a7bbe58aa8e696b9e5bc8f3ae5b182e695b0 + 1 and (ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "门" or ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "守门") and (LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 2 or LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 3) then
      ide5bcbae588b6e59b9ee59f8e()
    end
    if ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "守门" then
      ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] = "红怪"
    end
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    if ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "门" and ide6af94e889b2("374|1061|376675-050505,362|1081|467D8E-050505,362|1046|3C4146-050505") == true then
      for TempVar = 1, 2 do
        LuaAuxLib.Tap(362, 1030, 0)
        LuaAuxLib.Sleep(555)
      end
      LuaAuxLib.ShowMessage(tostring("有钥匙"), _UPVALUE2_, 1, LuaAuxLib.Sleep)
      LuaAuxLib.Sleep(1111)
      ide5b08fe59cb0e59bbe()
    end
    _ENV[ide69687e4bbb6e5908de4ba8c + 1] = ReturnValueVar
    _ENV[0] = ReturnValueVar
    _ENV[0] = ReturnValueVar
    ide68898e69697e4b8ad()
    ide68898e69697e7bb9fe8aea1()
    ide59b9ee8a180()
    ide4b88de889afe78ab6e68081()
    LuaAuxLib.TracePrint("_2178:", "开始移动" .. LuaAuxLib.GetTickCount())
    if ide5a49ae782b9e689be(595, 245, 640, 429, "C7C7FF-101010", "-10|-1|C5C5FD-101010,-13|2|ABADE5-101010,-7|7|C1C1F9-101010,-5|-11|C0C0F8-101010,6|1|BBBCF4-101010") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "C4C4FC-090909", "4|6|C2C2FA-090909,13|11|B9B9F1-090909,4|16|C5C5FD-090909,-2|18|C3C3FC-090909") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "B0B1E7-090909", "-3|2|C1C1F9-090909,-5|-1|B6B7EF-090909,-2|-5|C1C1F9-090909,3|-5|C6C6FE-090909") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "8D8EC2-090909", "-2|-3|272A51-090909,0|-6|C1C1F9-090909,4|-3|A4A6DE-090909,1|1|15183D-090909,-4|1|B5B6EE-090909") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "BEBEF6-090909", "8|4|8285BF-090909,12|11|ABACE4-090909,1|12|BCBCF3-090909,0|6|B7B7EF-090909") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "62627E-090909", "-3|0|0A0C20-090909,-5|0|565672-090909,-3|2|0D0F23-090909,-1|4|5F5F7B-090909") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "BEBEF6-090909", "0|3|0E102C-090909,0|6|B7B7EF-090909,10|6|C2C2FA-090909,6|2|C3C3FB-090909") == true then
      LuaAuxLib.Sleep(22)
      LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
      for ide7a7bbe58aa8e696b9e5bc8f3a49 = 2, LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - 1 do
        if ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "怪" then
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          LuaAuxLib.TracePrint("_2187:", "中途打怪------------------------------------------")
          _ENV[0] = ReturnValueVar
          ide68898e69697e4b8ad()
          ide68898e69697e7bb9fe8aea1()
        end
        if ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "0" then
          LuaAuxLib.TouchOperation(0, 223, 235, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 + 66)
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94)
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "3" then
          LuaAuxLib.TouchOperation(0, 60, 230, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 + 66)
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94)
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "1" then
          LuaAuxLib.TouchOperation(0, 213, 88, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 + 66)
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94)
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "2" then
          LuaAuxLib.TouchOperation(0, 58, 89, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 + 66)
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94)
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "怪" and ide7a7bbe58aa8e696b9e5bc8f3a49 < LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 then
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          LuaAuxLib.Sleep(555)
          _ENV[0] = ReturnValueVar
          ide68898e69697e4b8ad()
          ide68898e69697e7bb9fe8aea1()
          LuaAuxLib.Sleep(555)
        end
      end
      LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
    else
      for ide7a7bbe58aa8e696b9e5bc8f3a49 = 2, LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - 1 do
        if ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1 + 1] == "点金" or ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1 + 1] == "神秘商人买卖窗口" then
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          ide7a7bbe58aa8e696b9e5bc8f3a4d42 = 5
          LuaAuxLib.Sleep(555)
        end
        if ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "0" then
          if ide7a7bbe58aa8e696b9e5bc8f3a4d42 == 0 then
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
          else
            LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
            LuaAuxLib.TouchOperation(0, 86 + ide99a8fe69cbae695b0 - 15, 109 + ide99a8fe69cbae695b0 - 15, _ENV, 0)
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
            ide7a7bbe58aa8e696b9e5bc8f3a4d42 = 0
          end
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "3" then
          if ide7a7bbe58aa8e696b9e5bc8f3a4d42 == 3 then
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
          else
            LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
            LuaAuxLib.TouchOperation(0, 206 + ide99a8fe69cbae695b0 - 15, 110 + ide99a8fe69cbae695b0 - 15, _ENV, 0)
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
            ide7a7bbe58aa8e696b9e5bc8f3a4d42 = 3
          end
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "1" then
          if ide7a7bbe58aa8e696b9e5bc8f3a4d42 == 1 then
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
          else
            LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
            LuaAuxLib.TouchOperation(0, 83 + ide99a8fe69cbae695b0 - 15, 218 + ide99a8fe69cbae695b0 - 15, _ENV, 0)
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
            ide7a7bbe58aa8e696b9e5bc8f3a4d42 = 1
          end
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "2" then
          if ide7a7bbe58aa8e696b9e5bc8f3a4d42 == 2 then
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
          else
            LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
            LuaAuxLib.TouchOperation(0, 204 + ide99a8fe69cbae695b0 - 15, 226 + ide99a8fe69cbae695b0 - 15, _ENV, 0)
            LuaAuxLib.Sleep(ide7a7bbe58aa8e696b9e5bc8f3ae7a7bbe58aa8e997b4e99a94 * 2)
            ide7a7bbe58aa8e696b9e5bc8f3a4d42 = 2
          end
        elseif ide7a7bbe58aa8e695b0e7bb84[ide7a7bbe58aa8e696b9e5bc8f3a49 + 1] == "怪" and ide7a7bbe58aa8e696b9e5bc8f3a49 < LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 then
          LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
          LuaAuxLib.Sleep(33)
          LuaAuxLib.KeepReleaseScreenSnapshot(nil)
          LuaAuxLib.TracePrint("_2279:", "中途打怪------------------------------------------")
          _ENV[0] = ReturnValueVar
          ide68898e69697e4b8ad()
          ide68898e69697e7bb9fe8aea1()
          ide7a7bbe58aa8e696b9e5bc8f3a4d42 = 5
          ide59b9ee8a180()
        end
      end
    end
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
    LuaAuxLib.TracePrint("_2325:", "开始下一个" .. LuaAuxLib.GetTickCount())
    do
      local TempVar = ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1]
      if TempVar == "新路" then
        _ENV[ide696b0e8b7afe6aca1e695b0 + 1] = ReturnValueVar
        LuaAuxLib.TracePrint("_2329:", "新路次数" .. ide696b0e8b7afe6aca1e695b0)
        if 2 < ide696b0e8b7afe6aca1e695b0 then
          _ENV[0] = ReturnValueVar
          ide5b08fe59cb0e59bbe()
        end
      elseif TempVar == "红怪" then
        _ENV[true] = ReturnValueVar
        _ENV[true] = ReturnValueVar
        _ENV[true] = ReturnValueVar
      elseif TempVar == "NULL" then
        LuaAuxLib.TracePrint("_2344:", "目标为空")
        ide8a792e889b2e7a7bbe58aa8()
        ide5b08fe59cb0e59bbe()
      elseif TempVar == "门" then
        Thread.SetShareVar("准备下楼", nil)
        ide5b08fe59cb0e59bbe()
      elseif TempVar == "点金" then
        local ide7a7bbe58aa8e696b9e5bc8f3ae698afe590a6e782b9e98791 = _ENV
        LuaAuxLib.TracePrint("_2353:", "点金")
        LuaAuxLib.Sleep(5555)
        ide782b9e98791()
        ide7a7bbe58aa8e696b9e5bc8f3ae698afe590a6e782b9e98791 = Thread.GetShareVar("是否点金")
        ide7a7bbe58aa8e696b9e5bc8f3ae698afe590a6e782b9e98791 = ide7a7bbe58aa8e696b9e5bc8f3ae698afe590a6e782b9e98791 + 1
        Thread.SetShareVar("是否点金", ide7a7bbe58aa8e696b9e5bc8f3ae698afe590a6e782b9e98791)
        ide5b08fe59cb0e59bbe()
      elseif TempVar == "神秘商人买卖窗口" then
        LuaAuxLib.TracePrint("_2361:", "神秘商人买卖窗口")
        LuaAuxLib.Sleep(5555)
        ide7a59ee7a798e59586e4babae58d96e8a385e5a487()
      end
    end
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    _ENV[0] = ReturnValueVar
    ide68898e69697e4b8ad()
    ide68898e69697e7bb9fe8aea1()
    ide59b9ee8a180()
    if ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "红怪" then
      ide5b08fe59cb0e59bbe()
    end
    if ide68898e69697 == 0 then
      if ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "红怪" or ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "怪" then
        LuaAuxLib.TracePrint("_2424:", "目标怪,但是没有战斗")
        ide6b885e7a9bae4b88de9809ae8b5b7e782b9()
        ide5b08fe59cb0e59bbe()
      end
    elseif ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] ~= "怪" and ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] ~= "箱子" and ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] ~= "红怪" and ide68898e69697 == 1 then
      LuaAuxLib.TracePrint("_2430:", "目标不是怪,但是战斗过")
      ide6b885e7a9bae4b88de9809ae8b5b7e782b9()
      ide5b08fe59cb0e59bbe()
    end
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    _ENV[Thread.GetShareVar("杀大怪")] = ReturnValueVar
    ide5ae9de7aeb1e680aa(ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1], 1)
    if ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == "新路" and ide69d80e5a4a7e680aa == 1 then
      ide5b08fe59cb0e59bbe()
    end
    ide7a7bbe58aa8e696b9e5bc8f()
  else
    LuaAuxLib.Sleep(111)
    ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae = Thread.GetShareVar("需要重置线程")
    LuaAuxLib.TracePrint("_2454:", ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae)
    if ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae == true then
      LuaAuxLib.TracePrint("_2456:", "需要重置线程")
      _ENV[0] = ReturnValueVar
      Thread.SetShareVar("需要重置线程", nil)
      ide5b08fe59cb0e59bbe()
    elseif ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae == nil or ide7a7bbe58aa8e696b9e5bc8f3ae99c80e8a681e9878de7bdae == false then
      LuaAuxLib.TracePrint("_2462:", ide697a0e8b7af)
      _ENV[ide697a0e8b7af + 1] = ReturnValueVar
      ide59b9ee8a180()
      if ide697a0e8b7af > 150 then
        _ENV[0] = ReturnValueVar
        ide5b08fe59cb0e59bbe()
      end
    end
    LuaAuxLib.ShowMessage(tostring("查找目标......"), 0, 0, 1900)
  end
  return ReturnValueVar
end] = _zmm
_ENV[function(ide5ae9de7aeb1e680aa3ae680aae5908d, ide5ae9de7aeb1e680aa3ae593aae6ada5e98080)
  if ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] == nil then
    ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1] = 1000
  end
  if ide68898e69697 == 1 and ide5ae9de7aeb1e680aa3ae680aae5908d == "箱子" then
    if ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - ide5ae9de7aeb1e680aa3ae593aae6ada5e98080 + 1] == "2" then
      LuaAuxLib.Tap(248, 534, 0)
      LuaAuxLib.Sleep(300)
    elseif ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - ide5ae9de7aeb1e680aa3ae593aae6ada5e98080 + 1] == "1" then
      LuaAuxLib.TracePrint("_2487:", "右上365,539")
      LuaAuxLib.Tap(365, 539, 0)
      LuaAuxLib.Sleep(300)
    elseif ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - ide5ae9de7aeb1e680aa3ae593aae6ada5e98080 + 1] == "3" then
      LuaAuxLib.TracePrint("_2491:", "左下251,733")
      LuaAuxLib.Tap(251, 733, 0)
      LuaAuxLib.Sleep(300)
    elseif ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - ide5ae9de7aeb1e680aa3ae593aae6ada5e98080 + 1] == "0" then
      LuaAuxLib.TracePrint("_2495:", "右下385,735")
      LuaAuxLib.Tap(385, 735, 0)
      LuaAuxLib.Sleep(300)
    end
    LuaAuxLib.TracePrint("_2499:", ide68898e69697, ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 - 1 + 1], ide7a7bbe58aa8e695b0e7bb84[LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 + 1])
  end
end] = _zmm
_ENV[function()
  if LuaAuxLib.CmpColorEx("67|902|50BFDF-111111,213|912|50BFDF-111111,369|903|50BFDF-111111,517|904|50BFDF-111111,684|179|2D23DB-111111", 1) == 0 and (ide5a49ae782b9e689be(644, 1000, 710, 1192, "4339DE-080808", "-10|-16|4339DE-080808,-10|-46|4339DE-080808,-10|-88|4339DE-080808") or LuaAuxLib.CmpColorEx("133|116|2D24BB-030303,131|133|2D24BB-030303,103|125|9A5C3E-030303,95|118|9A5C3E-030303,95|132|9A5C3E-030303", 1) == 1) then
    if LuaAuxLib.GetKeepState() == true then
      LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    end
    if ide5a49ae782b9e689be(644, 1000, 710, 1192, "4339DE-080808", "-10|-16|4339DE-080808,-10|-46|4339DE-080808,-10|-88|4339DE-080808") or LuaAuxLib.CmpColorEx("133|116|2D24BB-030303,131|133|2D24BB-030303,103|125|9A5C3E-030303,95|118|9A5C3E-030303,95|132|9A5C3E-030303", 1) == 1 then
      LuaAuxLib.TracePrint("_2510:", "关闭背包")
      LuaAuxLib.Tap(683, 1138, 0)
      LuaAuxLib.Sleep(3333)
      ide585b3e997ade8838ce58c85()
    end
  end
end] = _zmm
_ENV[function(ide59083e88daf3ae7a78de7b1bb)
  local ReturnValueVar = _ENV
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.TracePrint("_2524:", ide59083e88daf3ae7a78de7b1bb)
  if ide5a49ae782b9e689be(120, 342, 300, 435, "46474D", "0|4|46474D,3|4|46474D,3|8|46474D,7|8|46474D") == false then
    LuaAuxLib.Tap(42, 934, 0)
    LuaAuxLib.Sleep(555)
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  if ide58cbae59f9fe689be(124, 342, 365, 883, ide59083e88daf3ae7a78de7b1bb) == true then
    LuaAuxLib.Sleep(222)
    LuaAuxLib.Tap(id494e5458, id494e5459, 0)
    LuaAuxLib.Sleep(222)
    LuaAuxLib.Tap(id494e5458, id494e5459, 0)
    LuaAuxLib.Sleep(222)
    LuaAuxLib.Tap(id494e5458, id494e5459, 0)
    LuaAuxLib.Sleep(333)
    ReturnValueVar = nil
  else
    LuaAuxLib.TracePrint("_2542:", "没药")
    ReturnValueVar = nil
  end
  if ide5a49ae782b9e689be(120, 342, 300, 435, "46474D", "0|4|46474D,3|4|46474D,3|8|46474D,7|8|46474D") == true then
    LuaAuxLib.Tap(42, 934, 0)
    LuaAuxLib.Sleep(333)
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  ide585b3e789a9e59381e6a08f()
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ReturnValueVar, ide59b9ee8a1803ae8a180e9878f = _UPVALUE1_, nil
  ide59b9ee8a1803ae8a180e9878f = LuaAuxLib.ReadConfig("回血设置", _ENV, 1, nil) * 1.3 + 111
  if ide58cbae59f9fe689be(654, ide59b9ee8a1803ae8a180e9878f, 665, 240, "2D24BB-101010") == false and ide6a380e6b58be58f98e8baab() == false then
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    if ide58cbae59f9fe689be(30, 1197, 102, 1244, "4880A2-050505") == true then
      if ide58cbae59f9fe689be(654, ide59b9ee8a1803ae8a180e9878f, 665, 240, "2D24BB-101010") == true then
        ide585b3e789a9e59381e6a08f()
      else
        ide5bc80e789a9e59381e6a08f()
        LuaAuxLib.TracePrint("_2573:", "血量低，需要回血")
        if LuaAuxLib.ReadConfig("回血方式", _ENV, 1, nil) == 0 then
          if ide59083e88daf("18D475|115734|21FFB0") == true then
            ide59b9ee8a180()
          elseif ide59083e88daf("9C5A1F|6E4861|533818") == true then
            LuaAuxLib.TracePrint("_2587:", "有蓝药,继续回血")
            ide59b9ee8a180()
          elseif ide59083e88daf("2B2E9B|36644B|171A54") == true then
            LuaAuxLib.TracePrint("_2590:", "有红药")
            ide59b9ee8a180()
          else
            LuaAuxLib.TracePrint("_2593:", "没红没蓝,回城")
            ide59b9ee59f8e()
          end
        elseif ide59083e88daf("2B2E9B|36644B|171A54") == true then
          ide59b9ee8a180()
        elseif ide59083e88daf("18D475|115734|21FFB0") == true then
          ide59b9ee8a180()
        elseif ide59083e88daf("9C5A1F|6E4861|533818") == true then
          LuaAuxLib.TracePrint("_2610:", "有蓝药,继续回血")
          ide59b9ee8a180()
        else
          LuaAuxLib.TracePrint("_2614:", "没红没蓝药,回城-------------------------------------------------------------")
          ide59b9ee59f8e()
        end
      end
    end
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  ide585b3e789a9e59381e6a08f()
  if ide69d80e5a4a7e680aa == 1 then
    LuaAuxLib.TracePrint("_2626:", "BOSS回城")
    ide5bcbae588b6e59b9ee59f8e()
  end
  local ide59b9ee59f8e3ae59b9ee59f8ee695b0 = _ENV
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  local ide59b9ee59f8e3ae59b9ee59f8ee580bc = _ENV
  ide59b9ee59f8e3ae59b9ee59f8ee580bc = LuaAuxLib.ReadConfig("回城设置", _ENV, 1, nil) * 1.3 + 111
  if ide58cbae59f9fe689be(624, ide59b9ee59f8e3ae59b9ee59f8ee580bc, 670, 250, "2D24BB") == true then
    LuaAuxLib.TracePrint("_2633:", "不回城", ide59b9ee59f8e3ae59b9ee59f8ee580bc)
  else
    ide5bcbae588b6e59b9ee59f8e()
  end
end] = _zmm
_ENV[function()
  if ide59b9ee59f8ee58db7() == true then
    for TempVar = 1, 2 do
      LuaAuxLib.Tap(49, 843, 0)
      LuaAuxLib.TracePrint("_2643:", "回城")
      LuaAuxLib.ShowMessage(tostring("回城"), _UPVALUE2_, 0, nil)
      LuaAuxLib.Sleep(1111)
    end
    for TempVar = 1, 2 do
      LuaAuxLib.Tap(49, 843, 0)
      LuaAuxLib.TracePrint("_2649:", "回城")
      LuaAuxLib.ShowMessage(tostring("回城"), _UPVALUE2_, 0, nil)
      LuaAuxLib.Sleep(1111)
    end
    LuaAuxLib.Sleep(3333)
    ide5b08fe59cb0e59bbe()
  else
    for TempVar = 1, 2 do
      LuaAuxLib.Tap(49, 843, 0)
      LuaAuxLib.TracePrint("_2658:", "强制回城")
      LuaAuxLib.ShowMessage(tostring("回城"), _UPVALUE2_, 0, nil)
      LuaAuxLib.Sleep(1111)
    end
    Thread.Stop(ide7aa97e58fa3e6a380e6b58b)
    LuaAuxLib.Tap(307, 633, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(307, 633, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(688, 1257, 0)
    LuaAuxLib.Sleep(1111)
    LuaAuxLib.Tap(158, 722, 0)
    LuaAuxLib.Sleep(555)
    LuaAuxLib.Tap(165, 890, 0)
    LuaAuxLib.Sleep(1111)
    LuaAuxLib.Tap(204, 745, 0)
    LuaAuxLib.Sleep(2222)
    _ENV[Thread.Start(ide6a380e6b58be7aa97e58fa3)] = Thread.Start(ide6a380e6b58be7aa97e58fa3)
    LuaAuxLib.TracePrint("_2676:", "没回城卷轴")
    LuaAuxLib.Sleep(3333)
    ide5b08fe59cb0e59bbe()
  end
end] = _zmm
_ENV[function()
  local ide5a48de6b4bb3ae6adbbe4baa1e695b0 = _ENV
  if ide6af94e889b2("97|744|48B1D4-030303,98|798|2C3333-030303,98|826|2F3D3F-030303,97|846|314448-030303,98|874|2D3536-030303") == true or ide6af94e889b2("188|1005|6D737B-030303,188|768|6D737B-030303,188|553|6D737B-030303,188|308|6D737B-030303") == true then
    LuaAuxLib.Tap(95, 789, 0)
    LuaAuxLib.Sleep(1111)
    ide5a48de6b4bb3ae6adbbe4baa1e695b0 = Thread.GetShareVar("死亡数")
    ide5a48de6b4bb3ae6adbbe4baa1e695b0 = ide5a48de6b4bb3ae6adbbe4baa1e695b0 + 1
    Thread.SetShareVar("死亡数", ide5a48de6b4bb3ae6adbbe4baa1e695b0)
    LuaAuxLib.Tap(95, 789, 0)
    LuaAuxLib.Sleep(3333)
  end
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide6af94e889b2("121|848|507DC6-101010,408|112|060581-101010,280|112|070782-101010") == true or ide6af94e889b2("125|851|507DC6-080808,268|82|2EDCF4-080808,395|79|2EDCF4-080808") == true or ide6af94e889b2("125|851|507DC6-080808,532|214|DDC21F-080808,536|222|BE9208-080808") == true or ide6af94e889b2("126|852|507DC6-080808,402|208|DDC21F-080808,532|208|DDC21F-080808") == true or ide6af94e889b2("121|849|507DC6-111111,703|330|6A6167-111111,689|325|3B343A-111111,319|283|1A1619-111111,113|25|353134-111111") == true then
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.ShowMessage(tostring("'神秘商人处进行买卖"), _UPVALUE2_, nil, nil)
    LuaAuxLib.TracePrint("_2728:", "'神秘商人处进行买卖")
    for TempVar = 1, 10 do
      if ide6af94e889b2("76|901|93D3DC") == true then
        break
      else
        LuaAuxLib.Tap(81, 900, 0)
        LuaAuxLib.Sleep(1111)
      end
    end
    if LuaAuxLib.ReadConfig("装备处理", _ENV, 1, nil) == 0 or LuaAuxLib.ReadConfig("装备处理", _ENV, 1, nil) == 1 then
      local ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae4b88be68b89e6aca1e695b0 = _ENV
      ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae4b88be68b89e6aca1e695b0 = 0
      local ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8a385e5a487e88c83e59bb4 = _ENV
      ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8a385e5a487e88c83e59bb4 = 0
      while true do
        if ide5a49ae782b9e689be(230 + ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8a385e5a487e88c83e59bb4, 804, 545, 1211, "42758A-030303", "4|0|42758A-030303,9|0|42758A-030303") == true or ide5a49ae782b9e689be(230, 804, 545, 1211, "4AA6CC-030303", "4|0|42768C-030303,1|4|42758A-030303") == true or ide5a49ae782b9e689be(230, 804, 545, 1211, "3D96C2-030303", "5|0|42758A-030303,-1|5|42758A-030303") == true then
          LuaAuxLib.TracePrint("_2743:", "有金装" .. id494e5458 + 25, id494e5459 + 25)
          LuaAuxLib.ShowMessage(tostring("有金装"), _UPVALUE2_, id494e5459 + 25, 1211)
          for TempVar = 1, 10 do
            LuaAuxLib.Tap(id494e5458, id494e5459, 0)
            LuaAuxLib.Sleep(88)
          end
          LuaAuxLib.Sleep(555)
        else
          LuaAuxLib.TracePrint("_2751:", "没有金装")
          LuaAuxLib.ShowMessage(tostring("没有金装"), _UPVALUE2_, id494e5459 + 25, LuaAuxLib.Sleep)
          if ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae4b88be68b89e6aca1e695b0 < 2 then
            ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae4b88be68b89e6aca1e695b0 = ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae4b88be68b89e6aca1e695b0 + 1
            ide58892e58aa8(200, 857, 500, 847, 333)
            LuaAuxLib.Tap(250, 1012, 100)
          else
            break
          end
          if ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8a385e5a487e88c83e59bb4 == 0 then
            ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8a385e5a487e88c83e59bb4 = 25
          else
            ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8a385e5a487e88c83e59bb4 = 0
          end
        end
      end
    end
    Thread.Stop(ide7aa97e58fa3e6a380e6b58b)
    LuaAuxLib.Sleep(10)
    LuaAuxLib.Tap(644, 1151, 0)
    LuaAuxLib.Sleep(555)
    LuaAuxLib.Tap(269, 739, 0)
    LuaAuxLib.Sleep(555)
    local ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8b4ade4b9b0e59586e59381 = _ENV
    ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8b4ade4b9b0e59586e59381 = LuaAuxLib.NewArray(LuaAuxLib.ReadConfig("第三行左", _ENV, 1, nil), LuaAuxLib.ReadConfig("第二行左", _ENV, 1, nil), LuaAuxLib.ReadConfig("第一行右", _ENV, 1, nil), LuaAuxLib.ReadConfig("第一行左", _ENV, 1, nil))
    local ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae59586e59381e4bd8de7bdae = _ENV
    ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae59586e59381e4bd8de7bdae = LuaAuxLib.NewArray(295, 105, 452, 115, 573, 224, 569, 112)
    LuaAuxLib.TracePrint("_2780:", "卖完装备，买药")
    for ide7a59ee7a798e59586e4babae58d96e8a385e5a4873a49 = 0, 3 do
      if ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae8b4ade4b9b0e59586e59381[ide7a59ee7a798e59586e4babae58d96e8a385e5a4873a49 + 1] == true then
        ide58892e58aa8(ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae59586e59381e4bd8de7bdae[ide7a59ee7a798e59586e4babae58d96e8a385e5a4873a49 * 2 + 1], ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae59586e59381e4bd8de7bdae[ide7a59ee7a798e59586e4babae58d96e8a385e5a4873a49 * 2 + 1 + 1], ide7a59ee7a798e59586e4babae58d96e8a385e5a4873ae59586e59381e4bd8de7bdae[ide7a59ee7a798e59586e4babae58d96e8a385e5a4873a49 * 2 + 1], 494, 111)
        LuaAuxLib.Sleep(999)
        LuaAuxLib.Tap(348, 763, 0)
        LuaAuxLib.Sleep(555)
        LuaAuxLib.Tap(257, 743, 0)
        LuaAuxLib.ShowMessage(tostring("买完"), _UPVALUE2_, 0, 494)
        LuaAuxLib.Sleep(2555)
      end
    end
    for TempVar = 1, 3 do
      LuaAuxLib.Tap(305, 635, 0)
      LuaAuxLib.Sleep(555)
    end
    for TempVar = 1, 3 do
      LuaAuxLib.Tap(305, 888, 0)
      LuaAuxLib.Sleep(1111)
    end
    Thread.SetShareVar("装备栏", 1)
    _ENV[Thread.Start(ide6a380e6b58be7aa97e58fa3)] = ReturnValueVar
    ide5b08fe59cb0e59bbe()
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  if ide6af94e889b2("3D8DB1-050505|3D8DB1-050505|3D8DB1-050505|3D8DB1-050505") == true then
    LuaAuxLib.Tap(165, 800, 0)
    LuaAuxLib.Sleep(1111)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("656|546|48B1D4-030303,658|809|48B1D4-030303,169|348|6B8794-030303,150|570|566E79-030303,181|457|7895A3-030303") == true then
    LuaAuxLib.ShowMessage(tostring("关闭幻化"), _UPVALUE2_, nil, nil)
    LuaAuxLib.Tap(438, 1147, 0)
    LuaAuxLib.Sleep(555)
    for TempVar = 1, 5 do
      LuaAuxLib.Tap(351, 736, 0)
      LuaAuxLib.Sleep(333)
    end
    ide5b08fe59cb0e59bbe()
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("110|121|507DC6-050505,121|114|507DC6-050505,124|100|507DC6-050505,59|100|93D3DC-050505,62|82|93D3DC-050505") == true then
    LuaAuxLib.Tap(309, 634, 0)
    LuaAuxLib.Sleep(111)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("574|74|4D8FBD-101010,594|285|4D8FBD-101010,435|171|4D8FBD-101010") == true then
    LuaAuxLib.Tap(302, 640, 0)
    LuaAuxLib.Sleep(555)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("124|1075|50BFDF-050505,377|1068|50BFDF-050505,378|940|48B1D4-050505,114|937|48B1D4-050505") == true then
    LuaAuxLib.TracePrint("_2843:", "关闭宝箱页面")
    LuaAuxLib.Tap(700, 1090, 0)
    LuaAuxLib.Sleep(888)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("72|541|48B1D4-050505,64|591|50BFDF-050505,567|534|323F94-050505,576|567|3B48A8-050505") == true then
    LuaAuxLib.TracePrint("_2854:", "进入到战利品页面")
    _ENV[Thread.GetShareVar("战利品次数")] = Thread.GetShareVar("战利品次数")
    _ENV[ide68898e588a9e59381e6aca1e695b0 + 1] = ide68898e588a9e59381e6aca1e695b0 + 1
    Thread.SetShareVar("战利品次数", ide68898e588a9e59381e6aca1e695b0)
    LuaAuxLib.Tap(70, 621, 0)
    LuaAuxLib.Sleep(2222)
  end
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide6af94e889b2("697|266|333DA8-050505,687|270|3B46BD-050505,697|279|3B46BD-050505,685|279|333DA8-050505") ~= true then
    if ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") ~= true and ide6af94e889b2("181|621|F5F5F6-050505,181|628|F3F3F3-050505,181|634|D3D3D3-050505,181|646|E6E7E7-050505,181|656|E6E6E7-050505,181|660|E8E8E8-050505") ~= true and ide6af94e889b2("691|266|343EAA-050505,691|278|3B46BB-050505,686|272|3B46BD-050505") ~= true then
      goto lbl_28
    end
    ::lbl_28::
    if nil ~= true then
      goto lbl_38
    end
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.Sleep(11)
  ::lbl_38::
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  if ide6af94e889b2("697|266|333DA8-050505,687|270|3B46BD-050505,697|279|3B46BD-050505,685|279|333DA8-050505") ~= true then
    if ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") ~= true and ide6af94e889b2("181|621|F5F5F6-050505,181|628|F3F3F3-050505,181|634|D3D3D3-050505,181|646|E6E7E7-050505,181|656|E6E6E7-050505,181|660|E8E8E8-050505") ~= true and ide6af94e889b2("691|266|343EAA-050505,691|278|3B46BB-050505,686|272|3B46BD-050505") ~= true then
      goto lbl_68
    end
    ::lbl_68::
    if nil ~= true then
      goto lbl_298
    end
  end
  LuaAuxLib.TracePrint("_2871:", "战斗中")
  ide68a80e883bd()
  ide5ae89e5ae9ae4bdbfe794a8()
  Thread.SetShareVar("重置次数", 0)
  do
    local ide68898e69697e4b8ad3ae59b9ee8a180e69da1e4bbb6 = _ENV
    ide68898e69697e4b8ad3ae59b9ee8a180e69da1e4bbb6 = LuaAuxLib.ReadConfig("血量设置", _ENV, 1, nil) * 1.3 + 111
    local ide68898e69697e4b8ad3ae59b9ee8939de69da1e4bbb6 = _ENV
    ide68898e69697e4b8ad3ae59b9ee8939de69da1e4bbb6 = LuaAuxLib.ReadConfig("蓝量设置", _ENV, 1, nil) * 1.2 + 122
    local ide68898e69697e4b8ad3ae98083e8b791e8a180e9878f = _ENV
    ide68898e69697e4b8ad3ae98083e8b791e8a180e9878f = LuaAuxLib.ReadConfig("逃跑血量", _ENV, 1, nil) * 1.3 + 110
    _ENV[1] = ReturnValueVar
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    if ide58cbae59f9fe689be(624, ide68898e69697e4b8ad3ae59b9ee8a180e69da1e4bbb6, 676, 250, "2D24BB") == true or ide6af94e889b2("112|1078|B420B6-050505,111|1078|B420B6-050505") == true then
      ide585b3e789a9e59381e6a08f()
    else
      ide5bc80e789a9e59381e6a08f()
      if ide59083e88daf("2B2E9B|36644B|171A54") == false then
        LuaAuxLib.TracePrint("_2886:", "没红药了")
      end
    end
    LuaAuxLib.Sleep(11)
    if ide58cbae59f9fe689be(624, ide68898e69697e4b8ad3ae59b9ee8939de69da1e4bbb6, 676, 250, "83482B") == true or ide6af94e889b2("112|1078|B420B6-050505,111|1078|B420B6-050505") == true then
      ide585b3e789a9e59381e6a08f()
    else
      ide5bc80e789a9e59381e6a08f()
      if ide59083e88daf("9C5A1F|6E4861|533818") == false then
        LuaAuxLib.TracePrint("_2895:", "没蓝药了")
      end
    end
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    if ide58cbae59f9fe689be(624, ide68898e69697e4b8ad3ae98083e8b791e8a180e9878f, 676, 250, "2D24BB|18108E") == true or 1 > LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("逃跑血量", _ENV, 1, nil)) or ide6af94e889b2("112|1078|B420B6-050505,111|1078|B420B6-050505") == true then
      LuaAuxLib.Sleep(11)
    else
      LuaAuxLib.ShowMessage(tostring("正在逃跑"), _UPVALUE2_, LuaAuxLib.ReadConfig("逃跑血量", _ENV, 1, nil))
      LuaAuxLib.Tap(188, 633, 0)
      LuaAuxLib.Sleep(4000)
      ide5ae9de7aeb1e680aa("箱子", 2)
      _ENV[Thread.GetShareVar("不通X")] = ReturnValueVar
      _ENV[Thread.GetShareVar("不通Y")] = ReturnValueVar
      _ENV[LuaAuxLib.TableSize(ide4b88de9809a58) - 1 + 1] = ReturnValueVar
      ide4b88de9809a58[ide4b88de9809ae4bd8de7bdae + 1] = ide7a7bbe58aa8e695b0e7bb84[1]
      ide4b88de9809a59[ide4b88de9809ae4bd8de7bdae + 1] = ide7a7bbe58aa8e695b0e7bb84[2]
      Thread.SetShareVar("不通X", ide4b88de9809a58)
      Thread.SetShareVar("不通Y", ide4b88de9809a59)
      LuaAuxLib.KeepReleaseScreenSnapshot(nil)
      ide59b9ee8a180()
      ide5b08fe59cb0e59bbe()
    end
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.Sleep(11)
    ide68898e69697e4b8ad()
  end
  ::lbl_298::
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ide68a80e883bd3ae78ab6e68081 = _ENV
  ide68a80e883bd3ae78ab6e68081 = LuaAuxLib.ReadConfig("状态技能", _ENV, 1, nil)
  local ide68a80e883bd3ae8b5b7e6898b = _ENV
  ide68a80e883bd3ae8b5b7e6898b = LuaAuxLib.ReadConfig("起手技能", _ENV, 1, nil)
  if LuaAuxLib.ReadConfig("起手目标", _ENV, 1, nil) == 1 then
    _ENV[true] = ide68a80e883bd3ae78ab6e68081
  end
  if ide68a80e883bde5898de5bbb6e697b6 == true then
    LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("技能前延时", _ENV, 1, nil)))
    _ENV[false] = ide68a80e883bd3ae78ab6e68081
  end
  if LuaAuxLib.ReadConfig("自动战斗", _ENV, 1, nil) == true then
    if ide6af94e889b2("429|1177|4EB3E2-111111,438|1164|4EB3E2-111111,437|1185|4EB3E2-111111,421|1169|4EB3E2-111111") == false then
      LuaAuxLib.Tap(429, 1177, 0)
    end
    LuaAuxLib.Sleep(888)
    return
  end
  if ide78ab6e68081e4bdbfe794a8 == true then
    if ide68a80e883bd3ae78ab6e68081 == 0 then
      LuaAuxLib.Tap(105, 1187, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(105, 1187, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("状态延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae78ab6e68081 == 1 then
      LuaAuxLib.Tap(195, 1170, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(195, 1170, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("状态延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae78ab6e68081 == 2 then
      LuaAuxLib.Tap(300, 1180, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(300, 1180, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("状态延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae78ab6e68081 == 3 then
      LuaAuxLib.Tap(136, 1084, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(136, 1084, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("状态延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae78ab6e68081 == 4 then
      LuaAuxLib.Tap(247, 1080, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(247, 1080, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("状态延时", _ENV, 1, nil)))
    end
    _ENV[false] = ide68a80e883bd3ae78ab6e68081
  end
  if ide8b5b7e6898be4bdbfe794a8 == true then
    if ide68a80e883bd3ae8b5b7e6898b == 0 then
      LuaAuxLib.Tap(105, 1187, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(105, 1187, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("起手延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae8b5b7e6898b == 1 then
      LuaAuxLib.Tap(195, 1170, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(195, 1170, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("起手延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae8b5b7e6898b == 2 then
      LuaAuxLib.Tap(300, 1180, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(300, 1180, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("起手延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae8b5b7e6898b == 3 then
      LuaAuxLib.Tap(136, 1084, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(136, 1084, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("起手延时", _ENV, 1, nil)))
    end
    if ide68a80e883bd3ae8b5b7e6898b == 4 then
      LuaAuxLib.Tap(247, 1080, 0)
      LuaAuxLib.Sleep(11)
      LuaAuxLib.Tap(247, 1080, 0)
      LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("起手延时", _ENV, 1, nil)))
    end
  end
  local ide68a80e883bd3ae58fb3e4b88ae68a80e883bd = _ENV
  ide68a80e883bd3ae58fb3e4b88ae68a80e883bd = LuaAuxLib.ReadConfig("右上技能", _ENV, 1, nil) * 1.3 + 111
  local ide68a80e883bd3ae5b7a6e4b88be68a80e883bd = _ENV
  ide68a80e883bd3ae5b7a6e4b88be68a80e883bd = LuaAuxLib.ReadConfig("左下技能", _ENV, 1, nil) * 1.3 + 111
  local ide68a80e883bd3ae58fb3e4b88be68a80e883bd = _ENV
  ide68a80e883bd3ae58fb3e4b88be68a80e883bd = LuaAuxLib.ReadConfig("右下技能", _ENV, 1, nil) * 1.3 + 111
  local ide68a80e883bd3ae5b7a6e4b88ae68a80e883bd = _ENV
  ide68a80e883bd3ae5b7a6e4b88ae68a80e883bd = LuaAuxLib.ReadConfig("左上技能", _ENV, 1, nil) * 1.3 + 111
  local ide68a80e883bd3ae58fb333e68a80e883bd = _ENV
  ide68a80e883bd3ae58fb333e68a80e883bd = LuaAuxLib.ReadConfig("右3技能", _ENV, 1, nil) * 1.3 + 111
  local ide68a80e883bd3ae58f98e8baabe68a80e883bd = _ENV
  ide68a80e883bd3ae58f98e8baabe68a80e883bd = LuaAuxLib.ReadConfig("变身技能", _ENV, 1, nil) * 1.3 + 111
  LuaAuxLib.TracePrint("_3026:", ide68a80e883bd3ae58f98e8baabe68a80e883bd)
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  if 0 < LuaAuxLib.ReadConfig("变身技能", _ENV, 1, nil) + 0 and ide58cbae59f9fe689be(624, ide68a80e883bd3ae58f98e8baabe68a80e883bd, 676, 250, "2D24BB") == false and ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true then
    LuaAuxLib.Tap(181, 957, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Tap(181, 957, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Sleep(111)
  end
  if ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true then
    LuaAuxLib.Tap(153, 131, 0)
    LuaAuxLib.Sleep(111)
  end
  if 0 < LuaAuxLib.ReadConfig("右3技能", _ENV, 1, nil) + 0 and ide58cbae59f9fe689be(624, ide68a80e883bd3ae58fb333e68a80e883bd, 676, 250, "2D24BB") == false and ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true then
    LuaAuxLib.Tap(300, 1180, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Tap(300, 1180, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("右3延时", _ENV, 1, nil)))
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.Sleep(11)
  if 0 < LuaAuxLib.ReadConfig("左上技能", _ENV, 1, nil) + 0 and ide58cbae59f9fe689be(624, ide68a80e883bd3ae5b7a6e4b88ae68a80e883bd, 676, 250, "2D24BB") == false and ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true then
    LuaAuxLib.Tap(247, 1080, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Tap(247, 1080, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("左上延时", _ENV, 1, nil)))
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.Sleep(11)
  if 0 < LuaAuxLib.ReadConfig("左下技能", _ENV, 1, nil) + 0 and ide58cbae59f9fe689be(624, ide68a80e883bd3ae5b7a6e4b88be68a80e883bd, 676, 250, "2D24BB") == false and ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true then
    LuaAuxLib.Tap(136, 1084, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Tap(136, 1084, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("左下延时", _ENV, 1, nil)))
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.Sleep(11)
  if 0 < LuaAuxLib.ReadConfig("右下技能", _ENV, 1, nil) + 0 and ide58cbae59f9fe689be(624, ide68a80e883bd3ae58fb3e4b88be68a80e883bd, 676, 250, "2D24BB") == false and ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true then
    LuaAuxLib.Tap(105, 1187, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Tap(105, 1187, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("右下延时", _ENV, 1, nil)))
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  if 0 < LuaAuxLib.ReadConfig("右上技能", _ENV, 1, nil) + 0 and ide58cbae59f9fe689be(624, ide68a80e883bd3ae58fb3e4b88ae68a80e883bd, 676, 250, "2D24BB") == false and ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true then
    LuaAuxLib.Tap(195, 1170, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Tap(195, 1170, 0)
    LuaAuxLib.Sleep(11)
    LuaAuxLib.Sleep(LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("右上延时", _ENV, 1, nil)))
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
end] = _zmm
_ENV[function()
  local ide5ae89e5ae9ae4bdbfe794a83ae5bd93e5898d = _ENV
  if ide69d80e5a4a7e680aa == 1 then
    if ide68898e69697 == 0 then
      _ENV[LuaAuxLib.GetTickCount()] = ide5ae89e5ae9ae4bdbfe794a83ae5bd93e5898d
    end
    ide5ae89e5ae9ae4bdbfe794a83ae5bd93e5898d = LuaAuxLib.GetTickCount()
    if ide5ae89e5ae9ae4bdbfe794a83ae5bd93e5898d - ide8b5b7e5a78b > 5000 then
      LuaAuxLib.Tap(49, 662, 0)
      LuaAuxLib.Sleep(111)
      _ENV[LuaAuxLib.GetTickCount()] = ide5ae89e5ae9ae4bdbfe794a83ae5bd93e5898d
    end
  end
end] = _zmm
_ENV[function()
  _ENV[LuaAuxLib.FindMultiColor(599, 677, 648, 715, "343131-020202", "-6|0|343131-020202,-16|0|343131-020202,-12|5|312E2E-020202,-7|5|312D2E-020202,-2|5|322E2E-020202", 0, 1)], _ENV[LuaAuxLib.FindMultiColor(599, 677, 648, 715, "343131-020202", "-6|0|343131-020202,-16|0|343131-020202,-12|5|312E2E-020202,-7|5|312D2E-020202,-2|5|322E2E-020202", 0, 1)] = LuaAuxLib.FindMultiColor(599, 677, 648, 715, "343131-020202", "-6|0|343131-020202,-16|0|343131-020202,-12|5|312E2E-020202,-7|5|312D2E-020202,-2|5|322E2E-020202", 0, 1)
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  if id494e5458 > -1 and id494e5459 > -1 then
    _ENV[1] = id494e5459
    Thread.SetShareVar("杀大怪", 1)
    LuaAuxLib.TracePrint("_3136:", "到了奇怪的房间")
    LuaAuxLib.ShowMessage(tostring("BOSS房间"), _UPVALUE2_, 648, 715)
    local ide5a587e680aae79a84e688bfe997b43ae7a59ee7a798e7a7bbe58aa8 = _ENV
    ide5a587e680aae79a84e688bfe997b43ae7a59ee7a798e7a7bbe58aa8 = Thread.GetShareVar("神秘移动")
    Thread.SetShareVar("灵视次数", 2)
    if LuaAuxLib.ReadConfig("BOSS房", _ENV, 1, nil) == 0 then
      LuaAuxLib.TracePrint("_3143:", "选择回城")
      Thread.SetShareVar("层数", 1111)
    end
    if LuaAuxLib.ReadConfig("BOSS房", _ENV, 1, nil) == 2 then
      while true do
        LuaAuxLib.ShowMessage(tostring("BOSS房间等待"), _UPVALUE2_, 1, nil)
        LuaAuxLib.Sleep(3333)
      end
    end
    if ide5a587e680aae79a84e688bfe997b43ae7a59ee7a798e7a7bbe58aa8 == 1 then
      LuaAuxLib.Tap(632, 1151, 0)
      LuaAuxLib.Sleep(888)
      LuaAuxLib.TouchOperation(0, 202, 219, _ENV, 0)
      ide5beaee4bfa1e58f91e98081("到达BOSS房间", "到达BOSS房间")
      LuaAuxLib.TracePrint("_3158:", "BOSS房间往前走")
      LuaAuxLib.Sleep(3333)
      LuaAuxLib.TouchOperation(2, 0, 0, _ENV, 0)
      Thread.SetShareVar("神秘移动", 1)
      LuaAuxLib.Tap(600, 1224, 0)
      LuaAuxLib.Sleep(888)
      ide5b08fe59cb0e59bbe()
    end
  end
end] = _zmm
_ENV[function()
  ide9878de7bdaee689bee59bbe()
  ide6b885e7a9bae4b88de9809ae8b5b7e782b9()
  if ide680aae7babfe7a88b == 0 then
    _ENV[1], _ENV[Thread.Start(ide8a792e889b2e4bd8de7bdae)] = Thread.Start(ide8a792e889b2e4bd8de7bdae), Thread.Start(ide8a792e889b2e4bd8de7bdae)
  end
end] = _zmm
_ENV[function()
  if ide680aae7babfe7a88b == 1 then
    Thread.Stop(ide689bee680aae7babfe7a88b)
    LuaAuxLib.Sleep(33)
    _ENV[0] = LuaAuxLib.Sleep
    LuaAuxLib.TracePrint("_3213:", "关闭了开的线程")
  else
    LuaAuxLib.TracePrint("_3215:", "没检测到线程")
  end
  Thread.SetShareVar("文件名二", -1)
  _ENV[0], _ENV[nil] = Thread.SetShareVar, Thread.SetShareVar
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(598, 246, 639, 348, "3A4DC2-080808", "0|-2|3A4DC2-080808,-2|-3|3447BF-080808,-3|-1|3447BF-080808") == true then
    LuaAuxLib.ShowMessage(tostring("禁疗"), _UPVALUE2_, 639, 348)
    LuaAuxLib.Tap(49, 558, 0)
    LuaAuxLib.Sleep(555)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("202|785|4FBBDA-080808,473|505|3746BC-080808,396|498|9596A0-080808,197|407|48B1D4-080808,182|843|50BFDF-080808") == true then
    LuaAuxLib.Tap(202, 785, 0)
    LuaAuxLib.Sleep(1111)
  end
end] = _zmm
_ENV[function()
  if LuaAuxLib.ReadConfig("净化设定", _ENV, 1, nil) == true and (ide5a49ae782b9e689be(595, 245, 640, 429, "C7C7FF-101010", "-10|-1|C5C5FD-101010,-13|2|ABADE5-101010,-7|7|C1C1F9-101010,-5|-11|C0C0F8-101010,6|1|BBBCF4-101010") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "B0B1E7-101010", "-3|2|C1C1F9-101010,-5|-1|B6B7EF-101010,-2|-5|C1C1F9-101010,3|-5|C6C6FE-101010") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "8D8EC2-101010", "-2|-3|272A51-101010,0|-6|C1C1F9-101010,4|-3|A4A6DE-101010,1|1|15183D-101010,-4|1|B5B6EE-101010") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "BEBEF6-101010", "8|4|8285BF-101010,12|11|ABACE4-101010,1|12|BCBCF3-101010,0|6|B7B7EF-101010") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "62627E-101010", "-3|0|0A0C20-101010,-5|0|565672-101010,-3|2|0D0F23-101010,-1|4|5F5F7B-101010") == true or ide5a49ae782b9e689be(595, 245, 640, 429, "BEBEF6-101010", "0|3|0E102C-101010,0|6|B7B7EF-101010,10|6|C2C2FA-101010,6|2|C3C3FB-101010") == true) then
    LuaAuxLib.ShowMessage(tostring("清除不良状态"), 0, 0, 1900)
    LuaAuxLib.Tap(49, 558, 0)
    LuaAuxLib.Sleep(333)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("476|257|00F7F8-101010,479|247|18DC40-101010") == true then
    LuaAuxLib.TracePrint("_3251:", "需要实名认证")
    LuaAuxLib.ShowMessage(tostring("需要实名认证"), _UPVALUE2_, nil, nil)
    LuaAuxLib.Tap(274, 431, 0)
    LuaAuxLib.Sleep(888)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("126|544|61504D-050505,161|545|61504D-050505,163|728|61504D-050505,125|727|61504D-050505,124|679|61504D-050505,167|637|584643-050505") == true then
    LuaAuxLib.TracePrint("_3260:", "正在开始游戏 ")
    LuaAuxLib.Tap(144, 637, 0)
    LuaAuxLib.Sleep(5555)
  end
end] = _zmm
_ENV[function()
  if ide6af94e889b2("97|214|98968B-050505,95|214|C4C4B2-050505,94|226|312C30-050505,94|220|BDBDAB-050505,94|234|BABAA9-050505,96|237|C4C4B2-050505,94|240|BCBCAA-050505") == true then
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    ide782b9e98791e69d90e69699()
    LuaAuxLib.TracePrint("_3273:", "点金装备")
    LuaAuxLib.Tap(81, 841, 0)
    LuaAuxLib.Sleep(555)
    local ide782b9e987913ae4b88be68b89e6aca1e695b0 = _ENV
    ide782b9e987913ae4b88be68b89e6aca1e695b0 = 0
    while true do
      if ide5a49ae782b9e689be(207, 805, 553, 1223, "635B46-030303", "3|0|635B46-030303,6|0|635B46-030303") == true or ide5a49ae782b9e689be(207, 805, 553, 1223, "7995A2-030303", "3|0|7995A2-030303,6|0|7995A2-030303") == true or ide5a49ae782b9e689be(207, 805, 553, 1223, "9EBFCD-030303", "3|1|7995A2-030303") == true or ide5a49ae782b9e689be(207, 805, 553, 1223, "918055-030303", "3|1|635B46-030303") then
        _ENV[Thread.GetShareVar("装备")] = ide782b9e987913ae4b88be68b89e6aca1e695b0
        _ENV[ide8a385e5a487 + 1] = ide782b9e987913ae4b88be68b89e6aca1e695b0
        Thread.SetShareVar("装备", ide8a385e5a487)
        LuaAuxLib.TracePrint("_3283:", "点金" .. id494e5458, id494e5459)
        LuaAuxLib.Tap(id494e5458 + 15, id494e5459 + 15, 0)
        LuaAuxLib.Sleep(111)
        ide58892e58aa8(id494e5458 + 30, id494e5459 + 30, 319, 459, 555)
        LuaAuxLib.Sleep(555)
        break
      else
        LuaAuxLib.TracePrint("_3290:", "没白蓝装")
        LuaAuxLib.ShowMessage(tostring("没白蓝装"), _UPVALUE2_, 319, 459)
        if ide782b9e987913ae4b88be68b89e6aca1e695b0 < 2 then
          ide782b9e987913ae4b88be68b89e6aca1e695b0 = ide782b9e987913ae4b88be68b89e6aca1e695b0 + 1
          ide58892e58aa8(200, 857, 500, 847, 333)
          LuaAuxLib.Tap(250, 1012, 0)
          LuaAuxLib.Tap(250, 1012, 555)
          LuaAuxLib.Sleep(1111)
        else
          break
        end
      end
    end
    LuaAuxLib.Tap(81, 217, 0)
    LuaAuxLib.Sleep(555)
    LuaAuxLib.Tap(302, 640, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(302, 640, 0)
    LuaAuxLib.Sleep(2222)
  end
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide6af94e889b2("55|837|8FB9C7-050505,62|837|2B2A42-050505,63|840|2B2A42-050505,59|847|8BB3C1-050505") == true then
    ReturnValueVar = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide5a49ae782b9e689be(127, 67, 202, 129, "2C218F-050505", "8|0|2C218F-050505,9|5|2C218F-050505,2|10|2C218F-050505,-4|9|2C218F-050505") == true or ide5a49ae782b9e689be(127, 67, 202, 129, "676974-050505", "-2|-3|2C218F-050505,1|-5|121215-050505,4|-5|2C218F-050505,4|0|191352-050505") == true or ide5a49ae782b9e689be(127, 67, 202, 129, "B58818-050505", "0|10|B58818-050505,-15|21|B58818-050505,-34|16|B58818-050505,-25|9|B58818-050505,-28|-11|B58818-050505,-42|-1|B58818-050505,-39|10|B58818-050505") == true then
    LuaAuxLib.ShowMessage(tostring("正在选图"), _UPVALUE2_, 202, 129)
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.TracePrint("_3324:", ide585a5e58fa3)
    Thread.SetShareVar("重置次数", 0)
    if LuaAuxLib.ReadConfig("入口选择", 0, 1, nil) == 0 then
      for TempVar = 1, 3 do
        LuaAuxLib.Tap(55, 183, 0)
        LuaAuxLib.Sleep(1111)
      end
    end
    if ide6af94e889b2("96|909|48B1D4-080808,73|907|48B1D4-080808,71|1031|50BFDF-080808,95|1036|50BFDF-080808,71|1121|3D8DB1-080808") == true then
      LuaAuxLib.Tap(616, 1065, 0)
      LuaAuxLib.ShowMessage(tostring("奇遇页切换"), _UPVALUE2_, 0, LuaAuxLib.Sleep)
      LuaAuxLib.Sleep(1111)
    end
    LuaAuxLib.TracePrint("_3337:", "正在选图")
    if ide5a49ae782b9e689be(284, 536, 304, 556, "DDA310-111111", "10|-7|DDA310-111111,-1|-26|BE8B0A-111111,-15|24|BE8B0A-111111") == true or ide5a49ae782b9e689be(373, 613, 390, 636, "AB8B84-111111", "7|-17|0B0746-111111,3|-27|2219A9-111111,-7|25|2219A9-111111") == true then
      LuaAuxLib.TracePrint("_3341:", "回到第一层了")
      LuaAuxLib.ShowMessage(tostring("回到第一层"), _UPVALUE2_, 390, 636)
      LuaAuxLib.Sleep(1111)
      if ide585a5e58fa3 == 1 then
        LuaAuxLib.TracePrint("_3345:", "进一层")
        LuaAuxLib.Tap(292, 548, 0)
        LuaAuxLib.Sleep(555)
      elseif ide585a5e58fa3 == 2 then
        LuaAuxLib.Tap(384, 608, 0)
        LuaAuxLib.Sleep(555)
        LuaAuxLib.TracePrint("_3351:", "11层")
      elseif ide585a5e58fa3 == 3 then
        LuaAuxLib.TracePrint("_3353:", "21层")
        LuaAuxLib.Tap(408, 725, 0)
        LuaAuxLib.Sleep(555)
      elseif ide585a5e58fa3 == 4 then
        LuaAuxLib.TracePrint("_3357:", "31层")
        LuaAuxLib.Tap(460, 838, 0)
        LuaAuxLib.Sleep(555)
      elseif ide585a5e58fa3 == 5 then
        LuaAuxLib.TracePrint("_3361:", "41层")
        LuaAuxLib.Tap(569, 982, 0)
        LuaAuxLib.Sleep(555)
      elseif ide585a5e58fa3 == 6 then
        LuaAuxLib.TracePrint("_3365:", "51层")
        LuaAuxLib.Tap(432, 1070, 0)
        LuaAuxLib.Sleep(555)
      elseif ide585a5e58fa3 == 7 then
        LuaAuxLib.TracePrint("_3369:", "61层")
        LuaAuxLib.Tap(341, 1008, 0)
        LuaAuxLib.Sleep(555)
      elseif ide585a5e58fa3 == 8 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3376:", "71层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(253, 543, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 9 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3385:", "81层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(349, 650, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 10 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3394:", "91层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(469, 581, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 11 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3403:", "101层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(543, 694, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 12 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3412:", "111层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(507, 826, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 13 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3421:", "121层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(315, 835, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 14 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3430:", "131层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(395, 968, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 15 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3439:", "141层")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(292, 1067, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 16 then
        LuaAuxLib.TracePrint("_3445:", "图1")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(387, 624, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 17 then
        LuaAuxLib.TracePrint("_3451:", "图2")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(541, 933, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 18 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3460:", "图三")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(230, 512, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 19 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3469:", "图4")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(543, 696, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 20 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.TracePrint("_3478:", "图5")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(369, 925, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 21 then
        for TempVar = 1, 2 do
          ide58892e58aa8(307, 1072, 303, 460, 111)
          ide58892e58aa8(272, 421, 273, 422, 111)
          LuaAuxLib.Sleep(111)
        end
        LuaAuxLib.Sleep(555)
        LuaAuxLib.TracePrint("_3490:", "151")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(448, 812, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 22 then
        for TempVar = 1, 2 do
          ide58892e58aa8(307, 1072, 303, 460, 111)
          ide58892e58aa8(272, 421, 273, 422, 111)
          LuaAuxLib.Sleep(111)
        end
        LuaAuxLib.Sleep(555)
        LuaAuxLib.TracePrint("_3502:", "161")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(558, 1081, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 23 then
        for TempVar = 1, 2 do
          ide58892e58aa8(307, 1072, 303, 460, 111)
          ide58892e58aa8(272, 421, 273, 422, 111)
          LuaAuxLib.Sleep(111)
        end
        LuaAuxLib.Sleep(555)
        LuaAuxLib.TracePrint("_3514:", "171")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(405, 1043, 0)
          LuaAuxLib.Sleep(333)
        end
      elseif ide585a5e58fa3 == 24 then
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(222)
        ide58892e58aa8(307, 1072, 303, 460, 111)
        ide58892e58aa8(272, 421, 273, 422, 111)
        LuaAuxLib.Sleep(555)
        LuaAuxLib.TracePrint("_3526:", "图6")
        for TempVar = 1, 2 do
          LuaAuxLib.Tap(558, 968, 0)
          LuaAuxLib.Sleep(333)
        end
      end
      LuaAuxLib.TracePrint("_3532:", "完成选图")
      if 0 < LuaAuxLib.ReadConfig("组队", _ENV, 1, nil) then
        _ENV[true] = ReturnValueVar
        LuaAuxLib.Tap(164, 184, 0)
        LuaAuxLib.Sleep(111)
        LuaAuxLib.Tap(164, 184, 0)
        LuaAuxLib.Sleep(555)
      end
      for TempVar = 1, 3 do
        LuaAuxLib.Tap(55, 183, 0)
        LuaAuxLib.Sleep(1111)
      end
      LuaAuxLib.Sleep(3333)
      for TempVar = 1, 5 do
        LuaAuxLib.Tap(202, 790, 0)
        LuaAuxLib.Sleep(1111)
      end
    else
      LuaAuxLib.TracePrint("_3550:", "没找到一层")
      ide58892e58aa8(315, 451, 311, 1041, 0)
      LuaAuxLib.Sleep(2222)
      ide8bf9be59bbe()
    end
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(178, 255, 299, 324, "52586C-111111", "63|-38|464A7A-111111,87|-9|6E6A70-111111,69|-10|5F585E-111111") == true then
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.ShowMessage(tostring("城里"), _UPVALUE2_, 299, 324)
    LuaAuxLib.TracePrint("_3563:", "在城里")
    Thread.SetShareVar("重置次数", 0)
    Thread.SetShareVar("层数", 0)
    _ENV[Thread.GetShareVar("分解次数")] = Thread.GetShareVar("分解次数")
    _ENV[Thread.GetShareVar("转动次数")] = Thread.GetShareVar("转动次数")
    _ENV[Thread.GetShareVar("交任务")] = Thread.GetShareVar("交任务")
    _ENV[Thread.GetShareVar("吃料理")] = Thread.GetShareVar("吃料理")
    if LuaAuxLib.ReadConfig("大幸运", _ENV, 1, nil) == false and LuaAuxLib.ReadConfig("小幸运", _ENV, 1, nil) == false and LuaAuxLib.ReadConfig("大量黄金", _ENV, 1, nil) == false and LuaAuxLib.ReadConfig("少量黄金", _ENV, 1, nil) == false and LuaAuxLib.ReadConfig("大经验", _ENV, 1, nil) == false and LuaAuxLib.ReadConfig("小经验", _ENV, 1, nil) == false then
      _ENV[1] = LuaAuxLib.ReadConfig("小经验", _ENV, 1, nil)
    end
    LuaAuxLib.TracePrint("_3582:", "在城里", ide8bdace58aa8e6aca1e695b0, ide58886e8a7a3e6aca1e695b0, ide4baa4e4bbbbe58aa1, ide59083e69699e79086)
    if ide8bdace58aa8e6aca1e695b0 == 0 and LuaAuxLib.ReadConfig("大转盘", _ENV, 1, nil) == true then
      LuaAuxLib.TracePrint("_3585:", "找大转盘")
      LuaAuxLib.Tap(399, 716, 0)
      LuaAuxLib.Sleep(1111)
      ide8bdace79b98()
      ide5b08fe59cb0e59bbe()
    end
    if ide58886e8a7a3e6aca1e695b0 == 0 and LuaAuxLib.ReadConfig("装备处理", _ENV, 1, nil) == 5 then
      LuaAuxLib.TracePrint("_3595:", "装备分解")
      LuaAuxLib.Tap(450, 377, 0)
      LuaAuxLib.Sleep(1111)
      LuaAuxLib.Tap(373, 484, 0)
      LuaAuxLib.Sleep(5555)
      ide8a385e5a487e58886e8a7a3()
      ide5b08fe59cb0e59bbe()
    end
    if ide4baa4e4bbbbe58aa1 == 0 and LuaAuxLib.ReadConfig("任务", _ENV, 1, nil) == true then
      LuaAuxLib.TracePrint("_3607:", "交任务")
      LuaAuxLib.Tap(503, 518, 0)
      LuaAuxLib.Sleep(3333)
      ide4bbbbe58aa1e68f90e4baa4()
      ide5b08fe59cb0e59bbe()
    end
    if ide59083e69699e79086 == 0 then
      LuaAuxLib.TracePrint("_3616:", "吃料理")
      LuaAuxLib.Tap(481, 437, 0)
      LuaAuxLib.Sleep(1111)
      ide69699e79086e8b4ade4b9b0()
      ide5b08fe59cb0e59bbe()
    end
    if LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 0 then
      ide58ebbe588b7e59bbe()
    elseif LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 1 then
      LuaAuxLib.TracePrint("_3626:", "选沙图")
      ide6b299e4b98be79cbc()
      ide5b08fe59cb0e59bbe()
    elseif LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 2 then
      LuaAuxLib.Tap(137, 956, 0)
      LuaAuxLib.Sleep(2222)
      ide689ade69bb2e7a9bae997b4()
      ide5b08fe59cb0e59bbe()
    elseif LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 3 then
      LuaAuxLib.Tap(137, 956, 0)
      LuaAuxLib.Sleep(2222)
      ide58583e7b4a0e8af95e782bc()
      ide5b08fe59cb0e59bbe()
    elseif LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 4 then
      LuaAuxLib.Tap(137, 956, 0)
      LuaAuxLib.Sleep(2222)
      ide8999ae7a9bae7a798e5a283()
      ide5b08fe59cb0e59bbe()
    end
  end
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide6af94e889b2("323|331|7D9D84-050505,306|372|7D9D84-050505,463|462|ADB591-050505,194|486|637087-050505,615|669|9CA8B1-050505") == true then
    LuaAuxLib.TracePrint("_3654:", "进入公会")
    if LuaAuxLib.ReadConfig("地图选择", _ENV, 1, nil) == 4 then
      LuaAuxLib.Tap(632, 1150, 0)
      LuaAuxLib.Sleep(1111)
      LuaAuxLib.Tap(716, 538, 0)
      LuaAuxLib.Sleep(5555)
      ::lbl_41::
      while ide6af94e889b2("687|636|59B6CF-050505,438|410|3437D0-050505,375|574|2FD6EE-050505,301|574|EAC140-050505,236|575|18E8F8-050505") == true do
        LuaAuxLib.Tap(86, 970, 0)
        LuaAuxLib.Sleep(555)
        LuaAuxLib.Tap(564, 615, 0)
        LuaAuxLib.Sleep(1111)
      end
      if ide6af94e889b2("650|442|26272A-050505,650|447|221AA4-050505") == true or ide6af94e889b2("181|621|F5F5F6-050505,181|628|F3F3F3-050505,181|634|D3D3D3-050505,181|646|E6E7E7-050505,181|656|E6E6E7-050505,181|660|E8E8E8-050505") == true or ide6af94e889b2("691|266|343EAA-050505,691|278|3B46BB-050505,686|272|3B46BD-050505") == true or ide6af94e889b2("622|775|241D94-050505,622|779|2820A7-050505,622|783|241E98-050505,622|787|2820A6-050505") == true then
        ide68898e69697e4b8ad()
        LuaAuxLib.Sleep(8888)
        goto lbl_113
        goto lbl_41
      end
      LuaAuxLib.Tap(208, 107, 1111)
      goto lbl_41
    else
      LuaAuxLib.Tap(259, 844, 0)
      LuaAuxLib.Sleep(2222)
    end
  end
  ::lbl_113::
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide6af94e889b2("634|1035|195B7F-050505,642|1024|040002-050505,633|1021|19587C-050505,634|1013|5CE2FF-050505,619|1025|1C5E81-050505") == true then
    LuaAuxLib.Tap(387, 1196, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(94, 710, 0)
    LuaAuxLib.Sleep(3333)
  end
  if ide6af94e889b2("277|846|389AB6-050505,259|824|4BB8D7-050505,281|641|389AB6-050505,315|798|000000-050505,362|662|040002-050505") == true then
    LuaAuxLib.Tap(265, 742, 0)
    LuaAuxLib.Sleep(3333)
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  for TempVar = 1, 10 do
    if ide6af94e889b2("378|709|DC7BAF,345|656|DC7BAF,388|674|DC7BAF") == true then
      LuaAuxLib.ShowMessage(tostring("找到入口,正在进入"), _UPVALUE2_, nil, nil)
      LuaAuxLib.TracePrint("_3696:", "找到扭曲入口,正在进入")
      break
    else
      LuaAuxLib.ShowMessage(tostring("找入口"), _UPVALUE2_, nil, nil)
      ide58892e58aa8(248, 499, 255, 1054, 555)
      LuaAuxLib.Sleep(111)
      LuaAuxLib.Tap(248, 499, 0)
      LuaAuxLib.Sleep(1111)
    end
  end
  if LuaAuxLib.ReadConfig("精英模式", _ENV, 1, nil) == true then
    LuaAuxLib.Tap(360, 676, 0)
    LuaAuxLib.Sleep(555)
    LuaAuxLib.Tap(170, 1146, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(170, 1146, 0)
    LuaAuxLib.Sleep(3333)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 1 then
    LuaAuxLib.Tap(362, 677, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(362, 677, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 2 then
    LuaAuxLib.Tap(511, 749, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(511, 749, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 3 then
    LuaAuxLib.Tap(395, 974, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(395, 974, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) > 3 then
    LuaAuxLib.TracePrint("_3734:", "入口>3,需要拉动")
    ide58892e58aa8(333, 1054, 248, 499, 555)
    ide58892e58aa8(255, 505, 248, 499, 555)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(248, 499, 0)
    LuaAuxLib.Sleep(555)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 4 then
    LuaAuxLib.Tap(460, 711, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(460, 711, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 5 then
    LuaAuxLib.Tap(302, 904, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(302, 904, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) > 5 then
    LuaAuxLib.TracePrint("_3754:", "入口>5,需要拉动")
    ide58892e58aa8(333, 1054, 248, 499, 555)
    ide58892e58aa8(255, 505, 248, 499, 555)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(248, 499, 0)
    LuaAuxLib.Sleep(555)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 6 then
    LuaAuxLib.Tap(509, 682, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(509, 682, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 7 then
    LuaAuxLib.Tap(383, 1111, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(383, 1111, 0)
    LuaAuxLib.Sleep(1111)
  end
  if 0 < LuaAuxLib.ReadConfig("组队", _ENV, 1, nil) then
    _ENV[true] = LuaAuxLib.ReadConfig("组队", _ENV, 1, nil)
    LuaAuxLib.Tap(220, 191, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(220, 191, 0)
    LuaAuxLib.Sleep(555)
  end
  LuaAuxLib.Tap(122, 234, 0)
  LuaAuxLib.Sleep(3333)
  for TempVar = 1, 3 do
    LuaAuxLib.Tap(202, 790, 0)
    LuaAuxLib.Sleep(1111)
  end
  LuaAuxLib.TracePrint("_3787:", "进入地图")
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function()
  local ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e4bd8de7bdae = _ENV
  ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e4bd8de7bdae = {336, 679}
  local ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9 = _ENV
  ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9 = {
    ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e4bd8de7bdae[(LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) - 1) * 2 + 1],
    ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e4bd8de7bdae[(LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) - 1) * 2 + 1 + 1]
  }
  LuaAuxLib.TracePrint("_3794:", ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9[1], ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9[2])
  for TempVar = 1, 10 do
    if ide6af94e889b2("329|651|BE8B0A-111111,320|702|BE8B0A-111111,361|673|BE8B0A-111111,316|679|58320E-111111") == true then
      LuaAuxLib.ShowMessage(tostring("找到入口,正在进入"), _UPVALUE2_, nil, nil)
      break
    else
      LuaAuxLib.ShowMessage(tostring("找入口"), _UPVALUE2_, nil, nil)
      ide58892e58aa8(248, 499, 255, 1054, 555)
      LuaAuxLib.Sleep(111)
      LuaAuxLib.Tap(248, 499, 0)
      LuaAuxLib.Sleep(1111)
    end
  end
  if LuaAuxLib.ReadConfig("精英模式", _ENV, 1, nil) == true then
    LuaAuxLib.Tap(360, 676, 0)
    LuaAuxLib.Sleep(555)
    LuaAuxLib.Tap(198, 1145, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(198, 1145, 0)
    LuaAuxLib.Sleep(3333)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 1 then
    LuaAuxLib.Tap(ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9[1], ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9[2], 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9[1], ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e98089e68ba9[2], 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 2 then
    LuaAuxLib.Tap(425, 1055, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(425, 1055, 0)
    LuaAuxLib.Sleep(1111)
  end
  if 0 < LuaAuxLib.ReadConfig("组队", _ENV, 1, nil) then
    _ENV[true] = ide8999ae7a9bae7a798e5a2833ae585a5e58fa3e4bd8de7bdae
    LuaAuxLib.Tap(219, 193, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(219, 193, 0)
    LuaAuxLib.Sleep(555)
  end
  LuaAuxLib.Tap(122, 234, 0)
  LuaAuxLib.Sleep(3333)
  for TempVar = 1, 3 do
    LuaAuxLib.Tap(202, 790, 0)
    LuaAuxLib.Sleep(1111)
  end
  LuaAuxLib.TracePrint("_3845:", "进入地图")
end] = _zmm
_ENV[function()
  for TempVar = 1, 10 do
    if ide6af94e889b2("329|651|BE8B0A-111111,320|702|BE8B0A-111111,361|673|BE8B0A-111111,316|679|58320E-111111") == true then
      LuaAuxLib.ShowMessage(tostring("找到入口,正在进入"), _UPVALUE2_, nil, nil)
      break
    else
      LuaAuxLib.ShowMessage(tostring("找入口"), _UPVALUE2_, nil, nil)
      ide58892e58aa8(248, 499, 255, 1054, 555)
      LuaAuxLib.Sleep(111)
      LuaAuxLib.Tap(248, 499, 0)
      LuaAuxLib.Sleep(1111)
    end
  end
  if LuaAuxLib.ReadConfig("精英模式", _ENV, 1, nil) == true then
    LuaAuxLib.Tap(360, 676, 0)
    LuaAuxLib.Sleep(555)
    LuaAuxLib.Tap(198, 1145, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(198, 1145, 0)
    LuaAuxLib.Sleep(3333)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 1 then
    LuaAuxLib.Tap(342, 701, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(342, 701, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 2 then
    LuaAuxLib.Tap(421, 1053, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(421, 1053, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) > 2 then
    ide58892e58aa8(355, 1054, 248, 499, 555)
    ide58892e58aa8(255, 505, 248, 499, 555)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(248, 499, 0)
    LuaAuxLib.Sleep(555)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 3 then
    LuaAuxLib.Tap(379, 725, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(379, 725, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 4 then
    LuaAuxLib.Tap(385, 1160, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(385, 1160, 0)
    LuaAuxLib.Sleep(1111)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) > 4 then
    ide58892e58aa8(355, 1054, 248, 499, 555)
    ide58892e58aa8(255, 505, 248, 499, 555)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(248, 499, 0)
    LuaAuxLib.Sleep(555)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 5 then
    LuaAuxLib.Tap(491, 975, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(491, 975, 0)
    LuaAuxLib.Sleep(1111)
  end
  if 0 < LuaAuxLib.ReadConfig("组队", _ENV, 1, nil) then
    _ENV[true] = LuaAuxLib.ReadConfig("组队", _ENV, 1, nil)
    LuaAuxLib.Tap(219, 193, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(219, 193, 0)
    LuaAuxLib.Sleep(555)
  end
  LuaAuxLib.Tap(122, 234, 0)
  LuaAuxLib.Sleep(3333)
  for TempVar = 1, 3 do
    LuaAuxLib.Tap(202, 790, 0)
    LuaAuxLib.Sleep(1111)
  end
  LuaAuxLib.TracePrint("_3950:", "进入地图")
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function()
  LuaAuxLib.Tap(207, 976, 0)
  LuaAuxLib.Sleep(2222)
  if 0 < LuaAuxLib.ReadConfig("组队", _ENV, 1, nil) then
    LuaAuxLib.Tap(164, 185, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(164, 185, 0)
    LuaAuxLib.Sleep(555)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 1 then
    LuaAuxLib.Tap(299, 599, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(299, 599, 0)
    LuaAuxLib.Sleep(1111)
    LuaAuxLib.Tap(55, 203, 0)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 2 then
    LuaAuxLib.Tap(589, 622, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(589, 622, 0)
    LuaAuxLib.Sleep(1111)
    LuaAuxLib.Tap(55, 203, 0)
  end
  if LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil) == 3 then
    LuaAuxLib.Tap(386, 905, 0)
    LuaAuxLib.Sleep(111)
    LuaAuxLib.Tap(386, 905, 0)
    LuaAuxLib.Sleep(1111)
    LuaAuxLib.Tap(55, 203, 0)
  end
  LuaAuxLib.Sleep(3333)
  for TempVar = 1, 5 do
    LuaAuxLib.Tap(202, 790, 0)
    LuaAuxLib.Sleep(1111)
  end
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function()
  LuaAuxLib.ShowMessage(tostring("料理购买"), _UPVALUE2_, nil, nil)
  LuaAuxLib.Tap(365, 539, 0)
  LuaAuxLib.Sleep(2222)
  ide58892e58aa8(178, 524, 363, 521, 111)
  ide58892e58aa8(363, 521, 363, 744, 111)
  LuaAuxLib.Sleep(1111)
  for TempVar = 1, 3 do
    if LuaAuxLib.ReadConfig("大幸运", _ENV, 1, nil) == true then
      LuaAuxLib.Tap(469, 623, 0)
      LuaAuxLib.Sleep(333)
    end
    if LuaAuxLib.ReadConfig("小幸运", _ENV, 1, nil) == true then
      LuaAuxLib.Tap(474, 428, 0)
      LuaAuxLib.Sleep(333)
    end
    if LuaAuxLib.ReadConfig("大经验", _ENV, 1, nil) == true then
      LuaAuxLib.Tap(158, 865, 0)
      LuaAuxLib.Sleep(333)
    end
    if LuaAuxLib.ReadConfig("小经验", _ENV, 1, nil) == true then
      LuaAuxLib.Tap(158, 638, 0)
      LuaAuxLib.Sleep(333)
    end
    if LuaAuxLib.ReadConfig("少量黄金", _ENV, 1, nil) == true then
      LuaAuxLib.Tap(481, 865, 0)
      LuaAuxLib.Sleep(333)
    end
    if LuaAuxLib.ReadConfig("大量黄金", _ENV, 1, nil) == true then
      LuaAuxLib.Tap(168, 430, 0)
      LuaAuxLib.Sleep(333)
    end
    LuaAuxLib.Sleep(555)
  end
  Thread.SetShareVar("吃料理", 1)
  LuaAuxLib.Tap(594, 56, 0)
  LuaAuxLib.Sleep(555)
  LuaAuxLib.Tap(594, 56, 0)
  LuaAuxLib.Sleep(2222)
end] = _zmm
_ENV[function()
  if ide6af94e889b2("675|636|429CBB-050505,674|401|2D23DB-050505,672|699|429CBB-050505,675|575|429CBB-050505") == true or ide6af94e889b2("67|902|50BFDF-111111,213|912|50BFDF-111111,369|903|50BFDF-111111,517|904|50BFDF-111111,684|179|2D23DB-111111") == true then
    LuaAuxLib.TracePrint("_4042:", "交任务页面")
    LuaAuxLib.ShowMessage(tostring("交任务页面"), _UPVALUE2_, nil, nil)
    LuaAuxLib.Sleep(1111)
    while true do
      if ide5a49ae782b9e689be(549, 880, 575, 951, "2C2CF5-080808", "0|3|2C2CF5-080808,-3|2|2C2CF5-080808") == true then
        LuaAuxLib.Tap(536, 990, 0)
        LuaAuxLib.Sleep(4444)
        LuaAuxLib.TracePrint("_4060:", "有完成的任务")
        LuaAuxLib.ShowMessage(tostring("有完成的任务"), _UPVALUE2_, 0, 951)
      else
        LuaAuxLib.TracePrint("_4063:", "没有完成的任务")
        LuaAuxLib.ShowMessage(tostring("没有完成的任务"), _UPVALUE2_, 0, 951)
        LuaAuxLib.Sleep(333)
        break
      end
    end
    LuaAuxLib.Tap(89, 212, 0)
    LuaAuxLib.Sleep(444)
    for TempVar = 1, 5 do
      LuaAuxLib.Tap(81, 226, 0)
      LuaAuxLib.Sleep(333)
      LuaAuxLib.Tap(72, 90, 0)
      LuaAuxLib.Sleep(333)
    end
    LuaAuxLib.Tap(706, 1099, 0)
    LuaAuxLib.Sleep(888)
    LuaAuxLib.Tap(706, 1099, 0)
    LuaAuxLib.Sleep(2222)
    Thread.SetShareVar("交任务", 1)
    ide5b08fe59cb0e59bbe()
  end
end] = _zmm
_ENV[function()
  for TempVar = 1, 10 do
    if ide6af94e889b2("76|901|93D3DC") == true then
      break
    else
      LuaAuxLib.Tap(81, 900, 0)
      LuaAuxLib.Sleep(1111)
    end
  end
  local ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 = _ENV
  ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 = 0
  local ide8a385e5a487e58886e8a7a33ae8a385e5a487e88c83e59bb4 = _ENV
  ide8a385e5a487e58886e8a7a33ae8a385e5a487e88c83e59bb4 = 0
  while true do
    if ide5a49ae782b9e689be(230 + ide8a385e5a487e58886e8a7a33ae8a385e5a487e88c83e59bb4, 804, 545, 1211, "42758A-030303", "4|0|42758A-030303,9|0|42758A-030303") == true or ide5a49ae782b9e689be(230, 804, 545, 1211, "4AA6CC-030303", "4|0|42768C-030303,1|4|42758A-030303") == true or ide5a49ae782b9e689be(230, 804, 545, 1211, "3D96C2-030303", "5|0|42758A-030303,-1|5|42758A-030303") == true then
      LuaAuxLib.TracePrint("_4136:", "有金装" .. id494e5458 + 25, id494e5459 + 25)
      LuaAuxLib.ShowMessage(tostring("有金装"), _UPVALUE2_, id494e5459 + 25, 1211)
      for TempVar = 1, 10 do
        LuaAuxLib.Tap(id494e5458, id494e5459, 0)
        LuaAuxLib.Sleep(111)
      end
      LuaAuxLib.Sleep(555)
    else
      LuaAuxLib.TracePrint("_4146:", "没有金装")
      LuaAuxLib.ShowMessage(tostring("没有金装"), _UPVALUE2_, id494e5459 + 25, LuaAuxLib.Sleep)
      if ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 < 2 then
        ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 = ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 + 1
        ide58892e58aa8(200, 857, 500, 847, 333)
        LuaAuxLib.Tap(250, 1012, 100)
      else
        break
      end
      if ide8a385e5a487e58886e8a7a33ae8a385e5a487e88c83e59bb4 == 0 then
        ide8a385e5a487e58886e8a7a33ae8a385e5a487e88c83e59bb4 = 25
      else
        ide8a385e5a487e58886e8a7a33ae8a385e5a487e88c83e59bb4 = 0
      end
    end
  end
  LuaAuxLib.Tap(65, 179, 0)
  LuaAuxLib.Sleep(1111)
  for TempVar = 1, 4 do
    LuaAuxLib.Tap(309, 631, 0)
    LuaAuxLib.Sleep(555)
  end
  Thread.SetShareVar("分解次数", 1)
  while true do
    if ide5a49ae782b9e689be(666, 17, 700, 60, "467DA8", "5|5|467DA8,0|10|467DA8,-5|5|467DA8") == true then
      LuaAuxLib.TracePrint("_4178:", "打开了分解装备界面")
      LuaAuxLib.ShowMessage(tostring("打开了分解装备界面"), _UPVALUE2_, 700, 60)
      LuaAuxLib.Tap(77, 900, 0)
      LuaAuxLib.Sleep(333)
      for TempVar = 1, 18 do
        if ide5a49ae782b9e689be(230, 804, 545, 1211, "42758A-030303", "4|0|42758A-030303,9|0|42758A-030303") == true or ide5a49ae782b9e689be(230, 804, 545, 1211, "4AA6CC-030303", "4|0|42768C-030303,1|4|42758A-030303") == true or ide5a49ae782b9e689be(230, 804, 545, 1211, "3D96C2-030303", "5|0|42758A-030303,-1|5|42758A-030303") == true then
          LuaAuxLib.TracePrint("_4185:", "有金装" .. id494e5458 + 25, id494e5459 + 25)
          LuaAuxLib.ShowMessage(tostring("有金装"), _UPVALUE2_, id494e5459 + 25, 1211)
          ide58892e58aa8(id494e5458 + 20, id494e5459 + 30, id494e5458 + 25, 470, 111)
          LuaAuxLib.Sleep(333)
        else
          LuaAuxLib.TracePrint("_4194:", "没有金装")
          LuaAuxLib.ShowMessage(tostring("没有金装"), _UPVALUE2_, id494e5458 + 25, 470)
          if ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 < 2 then
            ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 = ide8a385e5a487e58886e8a7a33ae4b88be68b89e6aca1e695b0 + 1
            ide58892e58aa8(200, 857, 500, 847, 333)
            LuaAuxLib.Tap(250, 1012, 100)
          else
            LuaAuxLib.Tap(65, 179, 0)
            LuaAuxLib.Sleep(1111)
            for TempVar = 1, 4 do
              LuaAuxLib.Tap(309, 631, 0)
              LuaAuxLib.Sleep(555)
            end
            for TempVar = 1, 4 do
              LuaAuxLib.Tap(89, 110, 0)
              LuaAuxLib.Sleep(555)
            end
            LuaAuxLib.Sleep(2222)
            Thread.SetShareVar("分解次数", 1)
            ide5b08fe59cb0e59bbe()
          end
        end
      end
      LuaAuxLib.Tap(65, 179, 0)
      LuaAuxLib.Sleep(1111)
      for TempVar = 1, 4 do
        LuaAuxLib.Tap(209, 631, 0)
        LuaAuxLib.Sleep(555)
      end
      Thread.SetShareVar("分解次数", 1)
    else
      ide5b08fe59cb0e59bbe()
    end
  end
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(25, 13, 360, 215, "2EDCF4-080808", "2|-2|25BCE9-080808,5|-2|20ADE3-080808,5|-5|20ADE3-080808,1|-5|20AEE3-080808,3|1|2BD3F0-080808") == true then
    ide58892e58aa8(380, 115, 418, 426, 111)
    for TempVar = 1, 3 do
      LuaAuxLib.Sleep(1111)
    end
    LuaAuxLib.Tap(210, 814, 0)
    LuaAuxLib.Sleep(1111)
    Thread.SetShareVar("转动次数", 1)
    LuaAuxLib.TracePrint("_4245:", "转动转盘了")
  end
end] = _zmm
_ENV[function()
  LuaAuxLib.TracePrint("_4250:", "去刷图")
  if ide5a49ae782b9e689be(118, 90, 203, 286, "2C218F-010101", "0|10|2C218F,-15|21|2C218F,-34|16|2C218F,-25|9|2C218F,-28|-11|2C218F,-42|-1|2C218F,-39|10|2C218F") == true or ide5a49ae782b9e689be(118, 90, 203, 286, "B58818-010101", "0|10|B58818,-15|21|B58818,-34|16|B58818,-25|9|B58818,-28|-11|B58818,-42|-1|B58818,-39|10|B58818") == true then
    ide5b08fe59cb0e59bbe()
  elseif ide5a49ae782b9e689be(277, 521, 473, 624, "FFFFFF-080808", "-10|0|C9C442-080808,0|-9|C9C442-080808,7|-9|FFFFFF-080808,-6|6|C9C442-080808,4|6|FFFFFF-080808") == true then
    LuaAuxLib.Tap(360, 573, 0)
    LuaAuxLib.ShowMessage(tostring("找到进图口"), _UPVALUE2_, 0, 624)
    LuaAuxLib.Sleep(2222)
    ide8bf9be59bbe()
  else
    LuaAuxLib.ShowMessage(tostring("没有进图口,关闭"), _UPVALUE2_, 0, 624)
    LuaAuxLib.Tap(630, 1147, 0)
    LuaAuxLib.Sleep(1111)
  end
  LuaAuxLib.TracePrint("_4275:", "刷图")
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function(ide59f8ee9878ce689be3a58, ide59f8ee9878ce689be3a59)
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = ide59f8ee9878ce689be3a58
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = ide59f8ee9878ce689be3a58
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = ide59f8ee9878ce689be3a58
  _ENV[File.ReadLines(ide69687e4bbb6e5a4b9 .. "0.txt")] = ide59f8ee9878ce689be3a58
  _ENV[LuaAuxLib.NewArray("")] = ide59f8ee9878ce689be3a58
  _ENV[LuaAuxLib.NewArray("")] = ide59f8ee9878ce689be3a58
  if ide8a792e889b2e6aca1e695b0 == nil then
    _ENV[0] = ide59f8ee9878ce689be3a58
  end
  ide689bee8a792e889b2()
  if 0 > id5258 or 0 > id5259 then
    LuaAuxLib.Tap(630, 1147, 0)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(91, 115, 0)
    LuaAuxLib.Sleep(333)
    LuaAuxLib.Tap(191, 112, 0)
    LuaAuxLib.Sleep(333)
    ide5b08fe59cb0e59bbe()
  end
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  ide6b885e7a9bae695b0e7bb84()
  _ENV[id5258] = ide59f8ee9878ce689be3a58
  _ENV[id5259] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  ide5be85e689bee8b7af58[ide8b7af + 1] = id5258
  ide5be85e689bee8b7af59[ide8b7af + 1] = id5259
  ide8b5b7e782b958[ide8b5b7e782b9e4bd8de7bdae + 1] = id5258
  ide8b5b7e782b959[ide8b5b7e782b9e4bd8de7bdae + 1] = id5259
  ide5b7b2e689bee59d90e6a08758[ide5b7b2e689bee695b0 + 1] = id5258
  ide5b7b2e689bee59d90e6a08759[ide5b7b2e689bee695b0 + 1] = id5259
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  LuaAuxLib.Tap(631, 1149, 0)
  LuaAuxLib.TracePrint("_4323:", "关闭小地图")
  LuaAuxLib.Sleep(555)
  ::lbl_148::
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  _ENV[0] = ide59f8ee9878ce689be3a58
  if ide696b9e59091 > 3 then
    _ENV[0] = ide59f8ee9878ce689be3a58
    _ENV[ide4b88ae4b8aae8b7afe6a087 + 1] = ide59f8ee9878ce689be3a58
    if ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1] == nil or ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1] == nil or 0 > ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1] or 0 > ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1] then
      LuaAuxLib.TracePrint("_4334:", "重置找图线程" .. ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1], ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1])
      LuaAuxLib.Tap(652, 721, 0)
      LuaAuxLib.Sleep(3333)
      ide5b08fe59cb0e59bbe()
    end
  end
  local ide59f8ee9878ce689be3ae8b79de7a6bb58, ide59f8ee9878ce689be3ae8b79de7a6bb59 = _UPVALUE1_, 3333
  if ide696b9e59091 == 0 then
    ide59f8ee9878ce689be3ae8b79de7a6bb58 = 10
    ide59f8ee9878ce689be3ae8b79de7a6bb59 = 20
  elseif ide696b9e59091 == 3 then
    ide59f8ee9878ce689be3ae8b79de7a6bb58 = -10
    ide59f8ee9878ce689be3ae8b79de7a6bb59 = 20
  elseif ide696b9e59091 == 2 then
    ide59f8ee9878ce689be3ae8b79de7a6bb58 = -10
    ide59f8ee9878ce689be3ae8b79de7a6bb59 = -20
  elseif ide696b9e59091 == 1 then
    ide59f8ee9878ce689be3ae8b79de7a6bb58 = 10
    ide59f8ee9878ce689be3ae8b79de7a6bb59 = -20
  end
  _ENV[ide5be85e689bee8b7af58[ide4b88ae4b8aae8b7afe6a087 + 1] - ide59f8ee9878ce689be3ae8b79de7a6bb58] = ide59f8ee9878ce689be3a58
  _ENV[ide5be85e689bee8b7af59[ide4b88ae4b8aae8b7afe6a087 + 1] - ide59f8ee9878ce689be3ae8b79de7a6bb59] = ide59f8ee9878ce689be3a58
  if ide689be58 - ide59f8ee9878ce689be3a58 > -5 and ide689be58 - ide59f8ee9878ce689be3a58 < 5 and -10 < ide689be59 - ide59f8ee9878ce689be3a59 and 10 > ide689be59 - ide59f8ee9878ce689be3a59 then
    ide696b9e59091e5ad98e585a5e69687e69cac()
    ide59f8ee9878ce8b5b0()
  end
  for ide59f8ee9878ce689be3a49 = 0, ide5b7b2e689bee695b0 do
    if ide689be58 - ide5b7b2e689bee59d90e6a08758[ide59f8ee9878ce689be3a49 + 1] > -3 and 3 > ide689be58 - ide5b7b2e689bee59d90e6a08758[ide59f8ee9878ce689be3a49 + 1] and ide689be59 - ide5b7b2e689bee59d90e6a08759[ide59f8ee9878ce689be3a49 + 1] > -5 and ide689be59 - ide5b7b2e689bee59d90e6a08759[ide59f8ee9878ce689be3a49 + 1] < 5 then
      _ENV[ide696b9e59091 + 1] = ide59f8ee9878ce689be3a58
      goto lbl_148
    end
  end
  if ide689be58 > 383 and ide689be58 < 400 and ide689be59 > 450 and ide689be59 < 677 then
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide696b9e59091 + 1] = ide59f8ee9878ce689be3a58
    goto lbl_148
  elseif ide689be58 > 346 and ide689be58 < 402 and ide689be59 > 780 and ide689be59 < 912 then
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide696b9e59091 + 1] = ide59f8ee9878ce689be3a58
    goto lbl_148
  elseif 115 < ide689be58 and ide689be58 < 548 and ide689be59 > 906 and ide689be59 < 1105 then
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide696b9e59091 + 1] = ide59f8ee9878ce689be3a58
    goto lbl_148
  elseif ide689be58 > 423 and ide689be58 < 454 and ide689be59 > 774 and ide689be59 < 853 then
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide696b9e59091 + 1] = ide59f8ee9878ce689be3a58
    goto lbl_148
  elseif ide689be58 > 372 and ide689be58 < 381 and ide689be59 > 666 and ide689be59 < 761 then
    ide5ad98e585a5e5b7b2e689be()
    _ENV[ide696b9e59091 + 1] = ide59f8ee9878ce689be3a58
    goto lbl_148
  else
    ide5ad98e585a5e5be85e689be()
    ide5ad98e585a5e5b7b2e689be()
    ide696b9e59091e5ad98e585a5e69687e69cac()
    _ENV[ide696b9e59091 + 1] = ide59f8ee9878ce689be3a58
    goto lbl_148
  end
end] = _zmm
_ENV[function()
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  _ENV[LuaAuxLib.StringSplit(ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1], "-")] = LuaAuxLib.StringSplit(ide696b9e59091e695b0e7bb84[ide8b7afe5be84 + 1], "-")
  LuaAuxLib.TracePrint("_4415:", ("一共需要移动" .. LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1) .. "步")
  LuaAuxLib.Sleep(555)
  ide8b5b0e8b7afe696b9e5bc8f()
  LuaAuxLib.ShowMessage(tostring("找到目标"), _UPVALUE2_, "步", ide7a7bbe58aa8e695b0e7bb84)
  LuaAuxLib.Sleep(3333)
  ide8bdace79b98()
  ide8a385e5a487e58886e8a7a3()
  ide4bbbbe58aa1e68f90e4baa4()
  ide69699e79086e8b4ade4b9b0()
  ide585b3e997ade5b9bbe58c96()
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function()
  local ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0, ide6a380e6b58be7aa97e58fa33ae59b9ee59f8ee695b0, ide6a380e6b58be7aa97e58fa33ae5bc80e5a78b = _UPVALUE2_, nil, nil
  while true do
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.Sleep(444)
    ide7a681e79697()
    ide7bb84e9989fe9a1b5()
    ide4b88de889afe78ab6e68081()
    ide8bf9be585a5e4b88be4b880e5b182(2)
    ide5bc80e5a78be6b8b8e6888f()
    ide585b3e997ade8838ce58c85()
    ide585b3e997ade5ae9de7aeb1()
    ide585b3e997ade99984e9ad94e7aa97e58fa3()
    ide585b3e997ade4bb93e5ba93()
    ide694b6e8b5b7e99381e99590()
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    LuaAuxLib.Sleep(444)
    _ENV[Thread.GetShareVar("全部层数")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    _ENV[Thread.GetShareVar("战利品次数")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    _ENV[Thread.GetShareVar("见BOSS次数")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    _ENV[Thread.GetShareVar("答题次数")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    _ENV[Thread.GetShareVar("战斗次数")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0 = Thread.GetShareVar("死亡数")
    ide6a380e6b58be7aa97e58fa33ae59b9ee59f8ee695b0 = Thread.GetShareVar("回城数")
    _ENV[Thread.GetShareVar("重置次数")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    if ide9878de7bdaee6aca1e695b0 == 10 then
      ide5beaee4bfa1e58f91e98081("强回值过高,快去查看!可能卡住了", "可能卡住了,联系客服 ")
    end
    _ENV[Thread.GetShareVar("任务次数")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    _ENV[Thread.GetShareVar("时间")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    _ENV[Thread.GetShareVar("装备")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    _ENV[Thread.GetShareVar("材料")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    local ide6a380e6b58be7aa97e58fa33ae6a087e9a298 = _ENV
    ide6a380e6b58be7aa97e58fa33ae6a087e9a298 = ide697b6e997b4 .. "小时数据"
    local ide6a380e6b58be7aa97e58fa33ae58685e5aeb9 = _ENV
    ide6a380e6b58be7aa97e58fa33ae58685e5aeb9 = (((((((((((((("全部层数" .. ide585a8e983a8e5b182e695b0) .. "----战<br>斗次数") .. ide68898e69697e6aca1e695b0) .. "----答题次数") .. ide7ad94e9a298e6aca1e695b0) .. "----BOSS房次数") .. ide8a781424f5353e6aca1e695b0) .. "----任务次数") .. ide4bbbbe58aa1e6aca1e695b0) .. "----收战利品") .. ide68898e588a9e59381e6aca1e695b0) .. "----点金材料") .. ide69d90e69699) .. "----点金装备") .. ide8a385e5a487
    LuaAuxLib.ShowMessage(tostring((((((((("运行" .. LuaAuxLib.VBS_Round(LuaAuxLib.GetTickCount() / 1000 / 60)) .. "战") .. ide68898e69697e6aca1e695b0) .. "强回") .. ide9878de7bdaee6aca1e695b0) .. "题") .. ide7ad94e9a298e6aca1e695b0) .. "通") .. ide8a781424f5353e6aca1e695b0), 0, 0, 1900)
    if LuaAuxLib.VBS_Round(LuaAuxLib.GetTickCount() / 1000 / 60) > 60 * ide697b6e997b4 then
      LuaAuxLib.TracePrint("_4506:", ide6a380e6b58be7aa97e58fa33ae6a087e9a298, ide6a380e6b58be7aa97e58fa33ae58685e5aeb9)
      ide5beaee4bfa1e58f91e98081(ide6a380e6b58be7aa97e58fa33ae6a087e9a298, ide6a380e6b58be7aa97e58fa33ae58685e5aeb9)
      _ENV[ide697b6e997b4 + 1] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
      Thread.SetShareVar("时间", ide697b6e997b4)
    end
    ide6a380e6b58be7aa97e58fa33ae5bc80e5a78b = Thread.GetShareVar("开始")
    _ENV[Thread.GetShareVar("开始战斗")] = ide6a380e6b58be7aa97e58fa33ae6adbbe4baa1e695b0
    LuaAuxLib.TracePrint("_4514:", LuaAuxLib.GetTickCount() / 1000 / 60, ide6a380e6b58be7aa97e58fa33ae5bc80e5a78b, ide5bc80e5a78be68898e69697, ide68898e69697e6aca1e695b0)
    if LuaAuxLib.GetTickCount() / 1000 / 60 - ide6a380e6b58be7aa97e58fa33ae5bc80e5a78b > 5 then
      if 1 > ide68898e69697e6aca1e695b0 - ide5bc80e5a78be68898e69697 then
        ide5beaee4bfa1e58f91e98081("可能卡了,快去查看", "可能卡住了!!尝试退出当前页面")
        LuaAuxLib.TracePrint("_4518:", ide68898e69697e6aca1e695b0 - ide5bc80e5a78be68898e69697)
        LuaAuxLib.KeyPress("Back", 0)
      end
      Thread.SetShareVar("开始", LuaAuxLib.GetTickCount() / 1000 / 60)
      Thread.SetShareVar("开始战斗", ide68898e69697e6aca1e695b0)
      LuaAuxLib.Sleep(3333)
    end
    ide887aae5ae9ae68f90e98692()
    LuaAuxLib.Sleep(333)
  end
end] = _zmm
_ENV[function()
  if LuaAuxLib.ReadConfig("换装", _ENV, 1, nil) == true and ide5a4a7e680aae68898e69697 == true and ide69d80e5a4a7e680aa == 1 and ide68898e69697 == 1 then
    LuaAuxLib.TracePrint("_4535:", "杀完BOSS")
    if ide68da2e8a385e8aeb0e5bd95 ~= 2 then
      _ENV[2] = ide68da2e8a385e8aeb0e5bd95
      for TempVar = 1, 5 do
        LuaAuxLib.Tap(352, 801, 0)
        LuaAuxLib.Sleep(666)
      end
      Thread.SetShareVar("杀完BOSS", 1)
      ide68da2e8a385(2)
      for TempVar = 1, 8 do
        LuaAuxLib.Tap(87, 227, 0)
        LuaAuxLib.Sleep(333)
      end
      LuaAuxLib.TracePrint("_4548:", "开始摸箱子")
    end
  end
  _ENV[true], _ENV[false] = LuaAuxLib.TracePrint, LuaAuxLib.TracePrint
  if LuaAuxLib.ReadConfig("状态目标", _ENV, 1, nil) == 1 then
    _ENV[true] = LuaAuxLib.ReadConfig("状态目标", _ENV, 1, nil)
  else
    _ENV[false] = LuaAuxLib.ReadConfig("状态目标", _ENV, 1, nil)
  end
  _ENV[false] = LuaAuxLib.ReadConfig("状态目标", _ENV, 1, nil)
  if ide68898e69697 == 1 then
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    _ENV[Thread.GetShareVar("战斗次数")] = Thread.GetShareVar("战斗次数")
    _ENV[ide68898e69697e6aca1e695b0 + 1] = ide68898e69697e6aca1e695b0 + 1
    Thread.SetShareVar("战斗次数", ide68898e69697e6aca1e695b0)
  end
  ide58583e7b4a0e782bce78bb1e5ae9de79fb3()
  ide5a48de6b4bb()
end] = _zmm
_ENV[function(ide7ad94e9a298e6a380e6b58b3a58, ide7ad94e9a298e6a380e6b58b3a59, ide7ad94e9a298e6a380e6b58b3a5831, ide7ad94e9a298e6a380e6b58b3a5932)
  if ide5a49ae782b9e689be(ide7ad94e9a298e6a380e6b58b3a58, ide7ad94e9a298e6a380e6b58b3a59, ide7ad94e9a298e6a380e6b58b3a5831, ide7ad94e9a298e6a380e6b58b3a5932, "212162-080808", "7|0|2B2B68-080808,10|19|20ADE3-080808,4|22|2EDCF4-080808,4|0|A3A5B3-080808,4|6|A3A5B3-080808") == true then
    Thread.SetShareVar("开始答题", nil)
    _ENV[true] = ide7ad94e9a298e6a380e6b58b3a58
  end
  if ide5a49ae782b9e689be(ide7ad94e9a298e6a380e6b58b3a58, ide7ad94e9a298e6a380e6b58b3a59, ide7ad94e9a298e6a380e6b58b3a5831, ide7ad94e9a298e6a380e6b58b3a5932, "2A2B67-080808", "7|0|2E2E6A-080808,7|17|20ADE3-080808,-2|19|2EDCF4-080808,-4|35|000000-080808,6|36|137FD9-080808,9|48|252564-080808,-1|48|424276-090909") == true then
    Thread.SetShareVar("开始答题", nil)
    _ENV[true] = ide7ad94e9a298e6a380e6b58b3a58
  end
  if ide5a49ae782b9e689be(ide7ad94e9a298e6a380e6b58b3a58, ide7ad94e9a298e6a380e6b58b3a59, ide7ad94e9a298e6a380e6b58b3a5831, ide7ad94e9a298e6a380e6b58b3a5932, "383970-080808", "7|0|31316C-080808,7|15|20ADE2-080808,3|23|2EDCF4-080808,-7|31|000000-080808,6|35|127BD2-080808,8|46|2D2E6A-080808,-2|47|494A7B-090909") == true then
    Thread.SetShareVar("开始答题", nil)
    _ENV[true] = ide7ad94e9a298e6a380e6b58b3a58
  end
  if ide5a49ae782b9e689be(ide7ad94e9a298e6a380e6b58b3a58, ide7ad94e9a298e6a380e6b58b3a59, ide7ad94e9a298e6a380e6b58b3a5831, ide7ad94e9a298e6a380e6b58b3a5932, "454557-080808", "7|0|414557-080808,9|18|29B5F7-080808,0|22|4BE1F2-080808,-6|32|031012-080808,-1|48|3B4263-080808,6|48|47415A-080808") == true then
    Thread.SetShareVar("开始答题", nil)
    _ENV[true] = ide7ad94e9a298e6a380e6b58b3a58
  end
  if ide5a49ae782b9e689be(ide7ad94e9a298e6a380e6b58b3a58, ide7ad94e9a298e6a380e6b58b3a59, ide7ad94e9a298e6a380e6b58b3a5831, ide7ad94e9a298e6a380e6b58b3a5932, "1AA2D7-080808", "6|-1|2EDCF4-080808,16|-6|20ADE3-080808,13|-25|34346D-080808,5|-25|242463-080808") == true then
    Thread.SetShareVar("开始答题", nil)
    _ENV[true] = ide7ad94e9a298e6a380e6b58b3a58
  end
  if ide5a49ae782b9e689be(ide7ad94e9a298e6a380e6b58b3a58, ide7ad94e9a298e6a380e6b58b3a59, ide7ad94e9a298e6a380e6b58b3a5831, ide7ad94e9a298e6a380e6b58b3a5932, "33336C-080808", "8|0|32336D-080808,8|-3|A3A5B3-080808,1|-3|A3A5B3-080808,1|-6|424376-080808,8|-6|434477-080808,8|-8|222262-080808,4|-6|3A3B71-080808") == true then
    Thread.SetShareVar("开始答题", nil)
    _ENV[true] = ide7ad94e9a298e6a380e6b58b3a58
  end
end] = _zmm
_ENV[function()
  _ENV[zm.OcrBaiDu(452, 505, 572, 805)] = zm.OcrBaiDu(452, 505, 572, 805)
  LuaAuxLib.Sleep(333)
  if ide997aee9a298 == "" or ide997aee9a298 == nil then
    _ENV[zm.OcrBaiDu(452, 505, 572, 805)] = zm.OcrBaiDu(452, 505, 572, 805)
    LuaAuxLib.Sleep(333)
  end
end] = _zmm
_ENV[function()
  LuaAuxLib.Sleep(1111)
  ide585b3e997ade8838ce58c85()
  LuaAuxLib.Sleep(1111)
  ide585b3e789a9e59381e6a08f()
  LuaAuxLib.Sleep(1111)
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.TracePrint("_4638:", "停止窗口检测 ")
  Thread.Stop(ide7aa97e58fa3e6a380e6b58b)
  ide9878de7bdaee689bee59bbe()
  LuaAuxLib.TracePrint("_4641:", "------------------进入答题")
  _ENV[Thread.GetShareVar("答题次数")] = Thread.GetShareVar("答题次数")
  _ENV[ide7ad94e9a298e6aca1e695b0 + 1] = ide7ad94e9a298e6aca1e695b0 + 1
  LuaAuxLib.SnapShot(("pic" .. ide7ad94e9a298e6aca1e695b0) .. ".png", _UPVALUE3_, nil, nil, nil)
  Thread.SetShareVar("答题次数", ide7ad94e9a298e6aca1e695b0)
  ide6a380e6b58be997aee9a298()
  LuaAuxLib.Sleep(555)
  ide98089e9a1b9[1] = zm.OcrBaiDu(277, 410, 312, 627)
  ide98089e9a1b9[2] = zm.OcrBaiDu(277, 654, 313, 866)
  ide98089e9a1b9[3] = zm.OcrBaiDu(216, 411, 253, 623)
  ide98089e9a1b9[4] = zm.OcrBaiDu(215, 654, 249, 872)
  ide98089e9a1b9[5] = zm.OcrBaiDu(154, 410, 189, 625)
  LuaAuxLib.Sleep(333)
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  LuaAuxLib.TracePrint("_4674:", ide5908de5ad97)
  LuaAuxLib.TracePrint("_4675:", ide997aee9a298)
  LuaAuxLib.TracePrint("_4676:", ide98089e9a1b9[1])
  LuaAuxLib.TracePrint("_4677:", ide98089e9a1b9[2])
  LuaAuxLib.TracePrint("_4678:", ide98089e9a1b9[3])
  LuaAuxLib.TracePrint("_4679:", ide98089e9a1b9[4])
  LuaAuxLib.TracePrint("_4680:", ide98089e9a1b9[5])
  LuaAuxLib.Sleep(111)
  Thread.SetShareVar("开始答题", nil)
  ide5afb9e6af94e585b3e994aee5ad97()
end] = _zmm
_ENV[function()
  _ENV[zm.OcrBaiDu(274, 411, 393, 859)] = zm.OcrBaiDu(274, 411, 393, 859)
  LuaAuxLib.Sleep(333)
  LuaAuxLib.TracePrint("_4693:", ide5afb9e99499)
  if LuaAuxLib.UTF8_InStrRev(ide5afb9e99499, "对", -1, _ENV) > 0 then
    _ENV[Thread.GetShareVar("答对次数")] = Thread.GetShareVar("答对次数")
    _ENV[ide7ad94e5afb9e6aca1e695b0 + 1] = ide7ad94e5afb9e6aca1e695b0 + 1
    LuaAuxLib.TracePrint("_4697:", "共答对" .. ide7ad94e5afb9e6aca1e695b0)
    Thread.SetShareVar("答对次数", ide7ad94e5afb9e6aca1e695b0)
  elseif 0 < LuaAuxLib.UTF8_InStrRev(ide5afb9e99499, "错", -1, _ENV) then
    LuaAuxLib.TracePrint("_4701:", "答错")
  else
    _ENV[zm.OcrBaiDu(274, 411, 393, 859)] = zm.OcrBaiDu(274, 411, 393, 859)
    LuaAuxLib.Sleep(333)
  end
  LuaAuxLib.Tap(613, 1215, 0)
  for ide7ad94e9a298e588a4e696ad3a49 = 3, 1 do
    LuaAuxLib.Sleep(1111)
    LuaAuxLib.ShowMessage(tostring(ide7ad94e9a298e588a4e696ad3a49 .. "秒后进入杀怪"), _UPVALUE2_, "秒后进入杀怪", nil)
  end
  _ENV[Thread.Start(ide6a380e6b58be7aa97e58fa3)] = Thread.Start(ide6a380e6b58be7aa97e58fa3)
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function()
  local ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af, ide5afb9e6af94e585b3e994aee5ad973ae8a385e5a487e4bfa1e681af, ide5afb9e6af94e585b3e994aee5ad973ae6a5bce5b182e4bd9ce681af, ide5afb9e6af94e585b3e994aee5ad973ae88dafe58982e4bfa1e681af, ide5afb9e6af94e585b3e994aee5ad973ae6a5bce5b182e4bfa1e681af, ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e585b3e994aee5ad97 = _UPVALUE5_, nil, nil, nil, nil, nil
  ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e585b3e994aee5ad97 = LuaAuxLib.NewArray("火攻", "火防", "水攻", "水防", "木攻", "木防", "光攻", "光防", "暗攻", "暗防", "等级", "成就")
  local ide5afb9e6af94e585b3e994aee5ad973ae8a385e5a487e585b3e994aee5ad97 = _ENV
  ide5afb9e6af94e585b3e994aee5ad973ae8a385e5a487e585b3e994aee5ad97 = LuaAuxLib.NewArray("头盔", "手甲", "武器", "戒指", "肩甲", "胸甲", "腿甲", "项链")
  local ide5afb9e6af94e585b3e994aee5ad973ae6a5bce5b182e585b3e994aee5ad97 = _ENV
  ide5afb9e6af94e585b3e994aee5ad973ae6a5bce5b182e585b3e994aee5ad97 = "几层"
  local ide5afb9e6af94e585b3e994aee5ad973ae88dafe58982e585b3e994aee5ad97 = _ENV
  ide5afb9e6af94e585b3e994aee5ad973ae88dafe58982e585b3e994aee5ad97 = LuaAuxLib.NewArray("灵视", "铁镐", "疾跑", "纯净", "蘑菇", "黄金", "水晶")
  for ide5afb9e6af94e585b3e994aee5ad973a49 = 0, LuaAuxLib.TableSize(ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e585b3e994aee5ad97) - 1 do
    if 0 < LuaAuxLib.UTF8_InStrRev(ide997aee9a298, ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e585b3e994aee5ad97[ide5afb9e6af94e585b3e994aee5ad973a49 + 1], -1, _ENV) then
      _ENV[ide58583e7b4a0[ide5afb9e6af94e585b3e994aee5ad973a49 + 1]] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
      _ENV["是元素问题" .. ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e585b3e994aee5ad97[ide5afb9e6af94e585b3e994aee5ad973a49 + 1]] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
      LuaAuxLib.TracePrint("_4727:", ide585b3e994aee695b0e68dae)
      ide695b0e5ad97e5afb9e6af94()
    else
      _ENV["问题关键字不是" .. ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e585b3e994aee5ad97[ide5afb9e6af94e585b3e994aee5ad973a49 + 1]] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
      LuaAuxLib.TracePrint("_4731:", ide585b3e994aee695b0e68dae)
    end
  end
  for ide5afb9e6af94e585b3e994aee5ad973a49 = 0, LuaAuxLib.TableSize(ide5afb9e6af94e585b3e994aee5ad973ae8a385e5a487e585b3e994aee5ad97) - 1 do
    if 0 < LuaAuxLib.UTF8_InStrRev(ide997aee9a298, ide5afb9e6af94e585b3e994aee5ad973ae8a385e5a487e585b3e994aee5ad97[ide5afb9e6af94e585b3e994aee5ad973a49 + 1], -1, _ENV) then
      _ENV["问题关键字是" .. ide5afb9e6af94e585b3e994aee5ad973ae8a385e5a487e585b3e994aee5ad97[ide5afb9e6af94e585b3e994aee5ad973a49 + 1]] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
      LuaAuxLib.TracePrint("_4737:", ide585b3e994aee695b0e68dae)
      _ENV[ide8a792e889b2e8a385e5a487[ide5afb9e6af94e585b3e994aee5ad973a49 + 1]] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
      LuaAuxLib.TracePrint("_4739:", ide8a792e889b2e8a385e5a487[ide5afb9e6af94e585b3e994aee5ad973a49 + 1])
      ide8a385e5a487e5afb9e6af94()
    else
      _ENV["问题关键字不是" .. ide5afb9e6af94e585b3e994aee5ad973ae8a385e5a487e585b3e994aee5ad97[ide5afb9e6af94e585b3e994aee5ad973a49 + 1]] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
      LuaAuxLib.TracePrint("_4747:", ide585b3e994aee695b0e68dae)
    end
  end
  if 0 < LuaAuxLib.UTF8_InStrRev(ide997aee9a298, "几层", -1, _ENV) then
    _ENV["问题关键字是几层"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
    LuaAuxLib.TracePrint("_4752:", ide585b3e994aee695b0e68dae)
    _ENV[zm.OcrBaiDuNumbers(685, 1105, 715, 1278)] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
    LuaAuxLib.TracePrint("_4754:", ide695b0e68dae)
    LuaAuxLib.Sleep(333)
    ide695b0e5ad97e5afb9e6af94()
  else
    _ENV["问题关键字不是几层"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
    LuaAuxLib.TracePrint("_4759:", ide585b3e994aee695b0e68dae)
  end
  for ide5afb9e6af94e585b3e994aee5ad973a49 = 0, LuaAuxLib.TableSize(ide5afb9e6af94e585b3e994aee5ad973ae88dafe58982e585b3e994aee5ad97) - 1 do
    if 0 < LuaAuxLib.UTF8_InStrRev(ide997aee9a298, ide5afb9e6af94e585b3e994aee5ad973ae88dafe58982e585b3e994aee5ad97[ide5afb9e6af94e585b3e994aee5ad973a49 + 1], -1, _ENV) then
      if ide5afb9e6af94e585b3e994aee5ad973a49 == 0 then
        _ENV["问题关键字  灵视"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
        LuaAuxLib.TracePrint("_4768:", ide585b3e994aee695b0e68dae)
        ide781b5e8a786e695b0e9878f()
      end
      if ide5afb9e6af94e585b3e994aee5ad973a49 == 1 then
        _ENV["问题关键字 铁镐"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
        LuaAuxLib.TracePrint("_4773:", ide585b3e994aee695b0e68dae)
        ide99381e99590e695b0e9878f()
      end
      if ide5afb9e6af94e585b3e994aee5ad973a49 == 2 then
        _ENV["问题关键字  疾跑"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
        LuaAuxLib.TracePrint("_4778:", ide585b3e994aee695b0e68dae)
        ide796bee8b791e695b0e9878f()
      end
      if ide5afb9e6af94e585b3e994aee5ad973a49 == 3 then
        _ENV["问题关键字纯净"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
        LuaAuxLib.TracePrint("_4783:", ide585b3e994aee695b0e68dae)
        ide7baafe58780e695b0e9878f()
      end
      if ide5afb9e6af94e585b3e994aee5ad973a49 == 4 then
        _ENV["问题关键字  蘑菇"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
        LuaAuxLib.TracePrint("_4788:", ide585b3e994aee695b0e68dae)
        ide89891e88f87e695b0e9878f()
      end
      if ide5afb9e6af94e585b3e994aee5ad973a49 == 5 then
        _ENV["问题关键字  黄金"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
        LuaAuxLib.TracePrint("_4793:", ide585b3e994aee695b0e68dae)
        ide9bb84e98791e695b0e9878f()
      end
      if ide5afb9e6af94e585b3e994aee5ad973a49 == 6 then
        _ENV["问题关键字水晶"] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
        LuaAuxLib.TracePrint("_4798:", ide585b3e994aee695b0e68dae)
        ide6b0b4e699b6e695b0e9878f()
      end
      ide695b0e5ad97e5afb9e6af94()
    end
  end
  _ENV[Thread.Start(ide6a380e6b58be7aa97e58fa3)] = ide5afb9e6af94e585b3e994aee5ad973ae58583e7b4a0e4bfa1e681af
  local ide5afb9e6af94e585b3e994aee5ad973ae58685e5aeb9 = _ENV
  ide5afb9e6af94e585b3e994aee5ad973ae58685e5aeb9 = (((((((((((ide5908de5ad97 .. "的问题是") .. ide997aee9a298) .. "1") .. ide98089e9a1b9[1]) .. "2") .. ide98089e9a1b9[2]) .. "3") .. ide98089e9a1b9[3]) .. "4") .. ide98089e9a1b9[4]) .. "5") .. ide98089e9a1b9[5]
  ide58f91e982aee4bbb6(ide8a792e889b2e5908d .. "找不到关键字答题", ide5afb9e6af94e585b3e994aee5ad973ae58685e5aeb9)
  LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function()
  for ide8a385e5a487e5afb9e6af943a49 = 0, 4 do
    if 0 < LuaAuxLib.UTF8_InStrRev(ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1], ide695b0e68dae, -1, _ENV) then
      if ide8a385e5a487e5afb9e6af943a49 == 4 then
        LuaAuxLib.TracePrint("_4832:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "5格")
        LuaAuxLib.Tap(170, 516, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 3 then
        LuaAuxLib.TracePrint("_4836:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "4格")
        LuaAuxLib.Tap(234, 755, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 2 then
        LuaAuxLib.TracePrint("_4840:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "3格")
        LuaAuxLib.Tap(233, 517, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 1 then
        LuaAuxLib.TracePrint("_4844:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "2格")
        LuaAuxLib.Tap(295, 759, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 0 then
        LuaAuxLib.TracePrint("_4848:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "1格")
        LuaAuxLib.Tap(293, 519, 0)
        LuaAuxLib.Sleep(555)
      end
      LuaAuxLib.TracePrint("_4852:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1])
    end
    LuaAuxLib.Sleep(333)
  end
  for ide8a385e5a487e5afb9e6af943a49 = 0, 4 do
    if ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] == nil or ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] == "" then
      if ide8a385e5a487e5afb9e6af943a49 == 4 then
        LuaAuxLib.TracePrint("_4891:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "5格")
        LuaAuxLib.Tap(170, 516, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 3 then
        LuaAuxLib.TracePrint("_4895:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "4格")
        LuaAuxLib.Tap(234, 755, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 2 then
        LuaAuxLib.TracePrint("_4899:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "3格")
        LuaAuxLib.Tap(233, 517, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 1 then
        LuaAuxLib.TracePrint("_4903:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "2格")
        LuaAuxLib.Tap(295, 759, 0)
        LuaAuxLib.Sleep(555)
      elseif ide8a385e5a487e5afb9e6af943a49 == 0 then
        LuaAuxLib.TracePrint("_4907:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1] .. "1格")
        LuaAuxLib.Tap(293, 519, 0)
        LuaAuxLib.Sleep(555)
      end
      LuaAuxLib.TracePrint("_4911:", ide98089e9a1b9[ide8a385e5a487e5afb9e6af943a49 + 1])
      LuaAuxLib.TracePrint("_4912:", (("没有找到一样的答案" .. ide695b0e68dae) .. "选项") .. ide98089e9a1b9[1], ide98089e9a1b9[2], ide98089e9a1b9[3], ide98089e9a1b9[4], ide98089e9a1b9[5])
      LuaAuxLib.Tap(126, 158, 0)
      LuaAuxLib.Sleep(555)
    end
    LuaAuxLib.Sleep(333)
  end
  ide7ad94e9a298e588a4e696ad()
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if LuaAuxLib.CmpColorEx("124|124|2D24BB-050505,91|124|9A5C3E-050505,68|125|3892CB-050505", 1) == 0 then
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
  end
  if LuaAuxLib.CmpColorEx("124|124|2D24BB-050505,91|124|9A5C3E-050505,68|125|3892CB-050505", 1) == 0 then
    LuaAuxLib.TracePrint("_4933:", "打开背包找数据")
    LuaAuxLib.Tap(46, 1220, 0)
    LuaAuxLib.Sleep(2222)
    ide68993e5bc80e8838ce58c85()
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  for ide695b0e5ad97e5afb9e6af943a49 = 0, 4 do
    if ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] == nil or ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] == "" then
      LuaAuxLib.TracePrint("_4942:", ide695b0e5ad97e5afb9e6af943a49 + 1 .. "个选项是空值")
      ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] = 1
    end
  end
  _ENV[LuaAuxLib.VBS_Round(ide695b0e68dae) + 0] = LuaAuxLib.VBS_Round(ide695b0e68dae) + 0
  ide98089e9a1b9[5] = LuaAuxLib.VBS_Round(ide98089e9a1b9[5]) + 0
  ide98089e9a1b9[4] = LuaAuxLib.VBS_Round(ide98089e9a1b9[4]) + 0
  ide98089e9a1b9[3] = LuaAuxLib.VBS_Round(ide98089e9a1b9[3]) + 0
  ide98089e9a1b9[2] = LuaAuxLib.VBS_Round(ide98089e9a1b9[2]) + 0
  ide98089e9a1b9[1] = LuaAuxLib.VBS_Round(ide98089e9a1b9[1]) + 0
  LuaAuxLib.TracePrint("_4952:", ide695b0e68dae)
  if ide695b0e68dae == ide98089e9a1b9[5] then
    LuaAuxLib.TracePrint("_4954:", "答案选择5" .. ide98089e9a1b9[5])
    LuaAuxLib.Tap(174, 513, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e68dae == ide98089e9a1b9[4] then
    LuaAuxLib.TracePrint("_4958:", "答案选择4" .. ide98089e9a1b9[4])
    LuaAuxLib.Tap(231, 741, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e68dae == ide98089e9a1b9[3] then
    LuaAuxLib.TracePrint("_4962:", "答案选择3" .. ide98089e9a1b9[3])
    LuaAuxLib.Tap(234, 524, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e68dae == ide98089e9a1b9[2] then
    LuaAuxLib.TracePrint("_4966:", "答案选择2" .. ide98089e9a1b9[2])
    LuaAuxLib.Tap(293, 768, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e68dae == ide98089e9a1b9[1] then
    LuaAuxLib.TracePrint("_4970:", "答案选择1" .. ide98089e9a1b9[1])
    LuaAuxLib.Tap(292, 528, 0)
    LuaAuxLib.Sleep(555)
  end
  local ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c = _ENV
  ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c = ide98089e9a1b9[1] - ide695b0e68dae
  LuaAuxLib.TracePrint("_4976:", ide98089e9a1b9[1], ide695b0e68dae, ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c)
  for ide695b0e5ad97e5afb9e6af943a49 = 1, 4 do
    ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c = math.abs(ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c)
    if ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] == nil or ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] == "" then
      LuaAuxLib.TracePrint("_4980:", ide695b0e5ad97e5afb9e6af943a49 + 1 .. "个选项是空值")
      ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] = 1
    end
    if 0 < ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c - math.abs(ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] - ide695b0e68dae) then
      ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c = math.abs(ide98089e9a1b9[ide695b0e5ad97e5afb9e6af943a49 + 1] - ide695b0e68dae)
    end
  end
  LuaAuxLib.TracePrint("_4987:", ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c)
  LuaAuxLib.Sleep(555)
  if ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c == math.abs(ide98089e9a1b9[5] - ide695b0e68dae) then
    LuaAuxLib.TracePrint("_4990:", "答案选择5" .. ide98089e9a1b9[5])
    LuaAuxLib.Tap(174, 513, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c == math.abs(ide98089e9a1b9[4] - ide695b0e68dae) then
    LuaAuxLib.TracePrint("_4994:", "答案选择4" .. ide98089e9a1b9[4])
    LuaAuxLib.Tap(231, 741, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c == math.abs(ide98089e9a1b9[3] - ide695b0e68dae) then
    LuaAuxLib.TracePrint("_4998:", "答案选择3" .. ide98089e9a1b9[3])
    LuaAuxLib.Tap(234, 524, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c == math.abs(ide98089e9a1b9[2] - ide695b0e68dae) then
    LuaAuxLib.TracePrint("_5002:", "答案选择2" .. ide98089e9a1b9[2])
    LuaAuxLib.Tap(293, 768, 0)
    LuaAuxLib.Sleep(555)
  elseif ide695b0e5ad97e5afb9e6af943ae7bb93e69e9c == math.abs(ide98089e9a1b9[1] - ide695b0e68dae) then
    LuaAuxLib.TracePrint("_5006:", "答案选择1" .. ide98089e9a1b9[1])
    LuaAuxLib.Tap(292, 528, 0)
    LuaAuxLib.Sleep(555)
  end
  ide7ad94e9a298e588a4e696ad()
end] = _zmm
_ENV[function()
  ide68993e5bc80e8838ce58c85()
  LuaAuxLib.Sleep(1111)
  _ENV[zm.OcrBaiDuNumbers(550, 767, 585, 933)] = zm.OcrBaiDuNumbers(550, 767, 585, 933)
  LuaAuxLib.TracePrint("_5023:", "黄金" .. ide695b0e68dae)
  ide585b3e997ade8838ce58c85()
  LuaAuxLib.Sleep(1111)
end] = _zmm
_ENV[function()
  ide68993e5bc80e8838ce58c85()
  LuaAuxLib.Sleep(1111)
  _ENV[zm.OcrBaiDuNumbers(551, 955, 589, 1078)] = zm.OcrBaiDuNumbers(551, 955, 589, 1078)
  LuaAuxLib.TracePrint("_5031:", "水晶" .. ide695b0e68dae)
  ide585b3e997ade8838ce58c85()
  LuaAuxLib.Sleep(1111)
end] = _zmm
_ENV[function()
  ide5bc80e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
  if ide5a49ae782b9e689be(125, 349, 379, 870, "8BB3C1-101010", "-4|-10|35556A-101010,-15|-5|A9D3E1-101010,-21|2|496E84-101010,-9|6|688C9D-101010,0|6|7FA7B7-101010") == true then
    ide789a9e59381e695b0e9878f(id494e5458, id494e5459)
    _ENV[true] = ide789a9e59381e695b0e9878f
    LuaAuxLib.TracePrint("_5041:", "疾跑" .. ide695b0e68dae)
  else
    _ENV[0] = LuaAuxLib.TracePrint
  end
  ide585b3e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
end] = _zmm
_ENV[function()
  ide5bc80e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
  if ide5a49ae782b9e689be(125, 349, 379, 870, "DED6A5-080808", "-10|-3|05110E-080808,-1|-16|249469-080808,16|1|2BA374-080808,8|15|3B8666-080808,17|24|071724-080808") == true or ide5a49ae782b9e689be(125, 349, 379, 870, "DED6A5-101010", "10|9|EDE4B7-101010,20|-3|44AE90-101010,-12|6|275351-101010,-13|-10|276B50-101010,-4|-17|249469-101010") == true then
    ide789a9e59381e695b0e9878f(id494e5458, id494e5459)
    _ENV[true] = ide789a9e59381e695b0e9878f
    LuaAuxLib.TracePrint("_5054:", "纯净" .. ide695b0e68dae)
  else
    _ENV[0] = LuaAuxLib.TracePrint
  end
  ide585b3e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
end] = _zmm
_ENV[function()
  ide5bc80e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
  if ide5a49ae782b9e689be(125, 349, 379, 870, "5E6E7E-101010", "-12|-12|96B1C0-101010,-17|-1|5E6E7E-101010,-16|11|391720-101010,8|7|4E5B6D-101010,23|14|A76272-101010") == true then
    ide789a9e59381e695b0e9878f(id494e5458, id494e5459)
    _ENV[true] = ide789a9e59381e695b0e9878f
    LuaAuxLib.TracePrint("_5067:", "蘑菇" .. ide695b0e68dae)
  else
    _ENV[0] = LuaAuxLib.TracePrint
  end
  ide585b3e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
end] = _zmm
_ENV[function()
  ide5bc80e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
  if ide5a49ae782b9e689be(125, 349, 379, 870, "454545-080808", "18|9|454545-080808,10|16|262626-080808,7|19|000000-080808,35|25|989898-101010,38|12|8A8A8A-080808,29|41|919191-080808") == true or ide5a49ae782b9e689be(125, 349, 379, 870, "284166-101010", "-19|-6|15243A-101010,-13|-13|284166-101010,24|-1|88919A-101010,23|15|8E969F-101010,18|28|88919A-101010") == true then
    ide789a9e59381e695b0e9878f(id494e5458, id494e5459)
    _ENV[true] = ide789a9e59381e695b0e9878f
    LuaAuxLib.TracePrint("_5080:", "铁镐" .. ide695b0e68dae)
  else
    _ENV[0] = LuaAuxLib.TracePrint
  end
  ide585b3e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
end] = _zmm
_ENV[function()
  ide5bc80e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
  if ide5a49ae782b9e689be(125, 349, 379, 870, "8BB3C1-101010", "-11|5|806848-101010,-13|-3|9EB8BA-101010,-10|-11|8F9183-101010,16|-7|66553B-101010,17|9|66553B-101010") == true or ide5a49ae782b9e689be(125, 349, 379, 870, "8BB4C2-101010", "-8|-4|9EB5B6-101010,-1|-12|87A1A6-101010,9|-6|655438-101010,3|8|84A3AB-101010,-14|7|806848-101010") == true then
    ide789a9e59381e695b0e9878f(id494e5458, id494e5459)
    _ENV[true] = ide789a9e59381e695b0e9878f
    LuaAuxLib.TracePrint("_5093:", "灵视" .. ide695b0e68dae)
  else
    _ENV[0] = LuaAuxLib.TracePrint
  end
  ide585b3e789a9e59381e6a08f()
  LuaAuxLib.Sleep(888)
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(120, 342, 300, 435, "46474D", "0|4|46474D,3|4|46474D,3|8|46474D,7|8|46474D") == false then
    LuaAuxLib.Tap(42, 934, 0)
    LuaAuxLib.Sleep(333)
  end
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(120, 342, 300, 435, "46474D", "0|4|46474D,3|4|46474D,3|8|46474D,7|8|46474D") == true then
    LuaAuxLib.TracePrint("_5108:", "关物品栏")
    LuaAuxLib.Tap(42, 934, 0)
    LuaAuxLib.Sleep(333)
  end
end] = _zmm
_ENV[function(ide789a9e59381e695b0e9878f3a58, ide789a9e59381e695b0e9878f3a59)
  local ide789a9e59381e695b0e9878f3a5831 = _ENV
  ide789a9e59381e695b0e9878f3a5831 = 129
  local ide789a9e59381e695b0e9878f3a5931 = _ENV
  ide789a9e59381e695b0e9878f3a5931 = 349
  local ide789a9e59381e695b0e9878f3a5832 = _ENV
  ide789a9e59381e695b0e9878f3a5832 = 207
  local ide789a9e59381e695b0e9878f3a5932 = _ENV
  ide789a9e59381e695b0e9878f3a5932 = 428
  local ide789a9e59381e695b0e9878f3a41 = _ENV
  ide789a9e59381e695b0e9878f3a41 = 1
  for TempVar = 1, 18 do
    if ide789a9e59381e695b0e9878f3a58 > ide789a9e59381e695b0e9878f3a5831 and ide789a9e59381e695b0e9878f3a58 < ide789a9e59381e695b0e9878f3a5832 and ide789a9e59381e695b0e9878f3a59 > ide789a9e59381e695b0e9878f3a5931 and ide789a9e59381e695b0e9878f3a59 < ide789a9e59381e695b0e9878f3a5932 then
      LuaAuxLib.SetRowsNumber(0)
      LuaAuxLib.TracePrint("_5120:", LuaAuxLib.SetDict(0, "Attachment:WUPIN.txt", 1))
      LuaAuxLib.TracePrint("_5121:", LuaAuxLib.UseDict(0))
      local ide789a9e59381e695b0e9878f3ae695b058 = _ENV
      ide789a9e59381e695b0e9878f3ae695b058 = ide789a9e59381e695b0e9878f3a5831
      local ide789a9e59381e695b0e9878f3ae695b059 = _ENV
      ide789a9e59381e695b0e9878f3ae695b059 = ide789a9e59381e695b0e9878f3a5932 - 10
      local ide789a9e59381e695b0e9878f3ae58d81e4bd8d, ide789a9e59381e695b0e9878f3ae4b8aae4bd8d = _UPVALUE1_, LuaAuxLib.UseDict(0)
      ide789a9e59381e695b0e9878f3ae58d81e4bd8d = LuaAuxLib.Ocr(ide789a9e59381e695b0e9878f3ae695b058 + 21, ide789a9e59381e695b0e9878f3ae695b059 - 11, ide789a9e59381e695b0e9878f3ae695b058, ide789a9e59381e695b0e9878f3ae695b059, "9E9EB6-101010|A8A9C2-101010|C5C5E4-101010|B8B8D4-101010|8F90A5-101010|D5D5F6-101010", 0.9)
      ide789a9e59381e695b0e9878f3ae4b8aae4bd8d = LuaAuxLib.Ocr(ide789a9e59381e695b0e9878f3ae695b058 + 21, ide789a9e59381e695b0e9878f3ae695b059 + 11, ide789a9e59381e695b0e9878f3ae695b058, ide789a9e59381e695b0e9878f3ae695b059, "9E9EB6-101010|A8A9C2-101010|C5C5E4-101010|B8B8D4-101010|8F90A5-101010|D5D5F6-101010", 0.9)
      _ENV[ide789a9e59381e695b0e9878f3ae58d81e4bd8d .. ide789a9e59381e695b0e9878f3ae4b8aae4bd8d] = ide789a9e59381e695b0e9878f3a58
      LuaAuxLib.TracePrint("_5128:", ide695b0e68dae, ide789a9e59381e695b0e9878f3ae695b058 + 21, ide789a9e59381e695b0e9878f3ae695b059 + 11, ide789a9e59381e695b0e9878f3ae695b058, ide789a9e59381e695b0e9878f3ae695b059)
    end
    ide789a9e59381e695b0e9878f3a5831 = ide789a9e59381e695b0e9878f3a5831 + 84
    ide789a9e59381e695b0e9878f3a5832 = ide789a9e59381e695b0e9878f3a5832 + 84
    ide789a9e59381e695b0e9878f3a41 = ide789a9e59381e695b0e9878f3a41 + 1
    if 3 < ide789a9e59381e695b0e9878f3a41 then
      ide789a9e59381e695b0e9878f3a41 = 1
      ide789a9e59381e695b0e9878f3a5831 = 129
      ide789a9e59381e695b0e9878f3a5832 = 207
      ide789a9e59381e695b0e9878f3a5931 = ide789a9e59381e695b0e9878f3a5931 + 87
      ide789a9e59381e695b0e9878f3a5932 = ide789a9e59381e695b0e9878f3a5932 + 87
    end
  end
end] = _zmm
_ENV[function()
  local ide8b5b0e8b7afe696b9e5bc8f3a58 = _ENV
  ide8b5b0e8b7afe696b9e5bc8f3a58 = 307
  local ide8b5b0e8b7afe696b9e5bc8f3a59 = _ENV
  ide8b5b0e8b7afe696b9e5bc8f3a59 = 636
  local ide8b5b0e8b7afe696b9e5bc8f3a5a = _ENV
  ide8b5b0e8b7afe696b9e5bc8f3a5a = 0
  for ide8b5b0e8b7afe696b9e5bc8f3a49 = 0, LuaAuxLib.TableSize(ide7a7bbe58aa8e695b0e7bb84) - 1 do
    _ENV[Thread.GetShareVar("开始答题")] = ide8b5b0e8b7afe696b9e5bc8f3a58
    if ide5bc80e5a78be7ad94e9a298 == true then
      ide7ad94e9a298()
    end
    if ide7a7bbe58aa8e695b0e7bb84[ide8b5b0e8b7afe696b9e5bc8f3a49 + 1] == "0" then
      ide8b5b0e8b7afe696b9e5bc8f3a58 = ide8b5b0e8b7afe696b9e5bc8f3a58 - 50
      ide8b5b0e8b7afe696b9e5bc8f3a59 = ide8b5b0e8b7afe696b9e5bc8f3a59 - 90
      ide8b5b0e8b7afe696b9e5bc8f3a5a = ide8b5b0e8b7afe696b9e5bc8f3a5a + 1
    elseif ide7a7bbe58aa8e695b0e7bb84[ide8b5b0e8b7afe696b9e5bc8f3a49 + 1] == "3" then
      ide8b5b0e8b7afe696b9e5bc8f3a5a = ide8b5b0e8b7afe696b9e5bc8f3a5a + 1
      ide8b5b0e8b7afe696b9e5bc8f3a58 = ide8b5b0e8b7afe696b9e5bc8f3a58 + 50
      ide8b5b0e8b7afe696b9e5bc8f3a59 = ide8b5b0e8b7afe696b9e5bc8f3a59 - 90
    elseif ide7a7bbe58aa8e695b0e7bb84[ide8b5b0e8b7afe696b9e5bc8f3a49 + 1] == "1" then
      ide8b5b0e8b7afe696b9e5bc8f3a58 = ide8b5b0e8b7afe696b9e5bc8f3a58 - 50
      ide8b5b0e8b7afe696b9e5bc8f3a59 = ide8b5b0e8b7afe696b9e5bc8f3a59 + 90
      ide8b5b0e8b7afe696b9e5bc8f3a5a = ide8b5b0e8b7afe696b9e5bc8f3a5a + 1
    elseif ide7a7bbe58aa8e695b0e7bb84[ide8b5b0e8b7afe696b9e5bc8f3a49 + 1] == "2" then
      ide8b5b0e8b7afe696b9e5bc8f3a58 = ide8b5b0e8b7afe696b9e5bc8f3a58 + 50
      ide8b5b0e8b7afe696b9e5bc8f3a59 = ide8b5b0e8b7afe696b9e5bc8f3a59 + 90
      ide8b5b0e8b7afe696b9e5bc8f3a5a = ide8b5b0e8b7afe696b9e5bc8f3a5a + 1
    end
    if 2 < ide8b5b0e8b7afe696b9e5bc8f3a5a then
      LuaAuxLib.Tap(ide8b5b0e8b7afe696b9e5bc8f3a58, ide8b5b0e8b7afe696b9e5bc8f3a59, 0)
      LuaAuxLib.Sleep(LuaAuxLib.ReadConfig("移动间隔输入框", _ENV, 1, nil) * 6)
      ide8b5b0e8b7afe696b9e5bc8f3a58 = 307
      ide8b5b0e8b7afe696b9e5bc8f3a59 = 636
      ide8b5b0e8b7afe696b9e5bc8f3a5a = 0
    end
    LuaAuxLib.KeepReleaseScreenSnapshot(nil)
    if ide7a7bbe58aa8e695b0e7bb84[ide8b5b0e8b7afe696b9e5bc8f3a49 - 1 + 1] == "怪" then
      LuaAuxLib.TracePrint("_5175:", "中途打怪------------------------------------------")
      _ENV[0] = ide8b5b0e8b7afe696b9e5bc8f3a58
      ide68898e69697e4b8ad()
      ide68898e69697e7bb9fe8aea1()
      LuaAuxLib.Sleep(555)
    end
  end
  if 0 < ide8b5b0e8b7afe696b9e5bc8f3a5a then
    LuaAuxLib.Tap(ide8b5b0e8b7afe696b9e5bc8f3a58, ide8b5b0e8b7afe696b9e5bc8f3a59, 0)
    LuaAuxLib.Sleep(LuaAuxLib.ReadConfig("移动间隔输入框", _ENV, 1, nil) * 2)
  end
  if 1 < ide8b5b0e8b7afe696b9e5bc8f3a5a then
    LuaAuxLib.Sleep(LuaAuxLib.ReadConfig("移动间隔输入框", _ENV, 1, nil) * 2)
  end
end] = _zmm
_ENV[function()
  if ide5a49ae782b9e689be(10, 1179, 101, 1269, "131540-090909", "24|-29|131540-090909,-11|-24|131540-090909,38|8|131540-090909") == true then
    LuaAuxLib.Tap(57, 1223, 0)
    LuaAuxLib.Sleep(333)
  end
end] = _zmm
_ENV[function(ide68da2e8a3853ae7acace587a0e5a597)
  local ide68da2e8a3853a58, ide68da2e8a3853a59 = _UPVALUE1_, nil
  LuaAuxLib.TracePrint("_5201:", "需要换装" .. ide68da2e8a3853ae7acace587a0e5a597)
  if ide68da2e8a3853ae7acace587a0e5a597 == 1 then
    ide68da2e8a3853a58 = 182
    ide68da2e8a3853a59 = 277
  end
  if ide68da2e8a3853ae7acace587a0e5a597 == 2 then
    ide68da2e8a3853a58 = 182
    ide68da2e8a3853a59 = 366
  end
  Thread.Stop(ide7aa97e58fa3e6a380e6b58b)
  ide68993e5bc80e8838ce58c85()
  LuaAuxLib.Tap(ide68da2e8a3853a58, ide68da2e8a3853a59, 0)
  LuaAuxLib.Sleep(111)
  LuaAuxLib.Tap(ide68da2e8a3853a58, ide68da2e8a3853a59, 0)
  LuaAuxLib.Sleep(1111)
  LuaAuxLib.Tap(260, 752, 0)
  LuaAuxLib.Sleep(111)
  LuaAuxLib.Tap(260, 752, 0)
  LuaAuxLib.Sleep(2222)
  LuaAuxLib.TracePrint("_5223:", ide68da2e8a3853a58, ide68da2e8a3853a59)
  ide585b3e997ade8838ce58c85()
  LuaAuxLib.Sleep(1111)
  _ENV[Thread.Start(ide6a380e6b58be7aa97e58fa3)] = ide68da2e8a3853ae7acace587a0e5a597
  ide5b08fe59cb0e59bbe()
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide5a49ae782b9e689be(105, 185, 624, 233, "B3E3F2-050505", "181|-14|B3E3F2-050505,343|-16|B3E3F2-050505") == true or ide5a49ae782b9e689be(105, 185, 624, 233, "B3E3F2-050505", "154|1|B3E3F2-050505,337|-5|B3E3F2-050505") == true then
    LuaAuxLib.TracePrint("_5235:", "找到三个日常任务" .. id494e5458, id494e5459)
    local ide4bbbbe58aa1e58685e5aeb93a575757 = _ENV
    ide4bbbbe58aa1e58685e5aeb93a575757 = zm.OcrBaiDu(id494e5458 - 40, id494e5459 + 50, id494e5458 + 340, id494e5459 + 370)
    LuaAuxLib.TracePrint("_5237:", ide4bbbbe58aa1e58685e5aeb93a575757)
    _ENV[LuaAuxLib.StringSplit(ide4bbbbe58aa1e58685e5aeb93a575757, "日常")] = ReturnValueVar
    LuaAuxLib.TracePrint("_5239:", ide4bbbbe58aa1e7a78de7b1bb[1])
    LuaAuxLib.TracePrint("_5240:", ide4bbbbe58aa1e7a78de7b1bb[2])
    LuaAuxLib.TracePrint("_5241:", ide4bbbbe58aa1e7a78de7b1bb[3])
    LuaAuxLib.TracePrint("_5242:", ide4bbbbe58aa1e7a78de7b1bb[4])
  else
    LuaAuxLib.TracePrint("_5244:", "当前页面没有三书,拉到三书")
    if ide5a49ae782b9e689be(118, 643, 576, 712, "418EC7-080808", "11|9|7C3B57-080880,26|-8|60744A-080880,9|3|1EA8ED-080880") == true then
      LuaAuxLib.TracePrint("_5246:", id494e5458, id494e5459)
      if id494e5458 < 204 then
        ide58892e58aa8(id494e5458, id494e5459, id494e5458 + 150, id494e5459, 222)
        ide58892e58aa8(id494e5458 + 150, id494e5459, id494e5458 + 150 + 1, id494e5459 + 1, 222)
        ide4bbbbe58aa1e58685e5aeb9()
      elseif id494e5458 > 204 then
        ide58892e58aa8(id494e5458, id494e5459, 160, 670, 222)
        ide58892e58aa8(160, 670, 159, 670, 222)
        ide4bbbbe58aa1e58685e5aeb9()
      end
    end
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  for ide8af86e588abe59bbee5b1823a49 = 1, 3 do
    for ide8af86e588abe59bbee5b1823a54 = 5, 0, -1 do
      _ENV[ide680aae789a9e59bbe[ide8af86e588abe59bbee5b1823a54 + 1]] = ReturnValueVar
      for ide8af86e588abe59bbee5b1823a47 = 0, LuaAuxLib.TableSize(ide680aae789a9e59bbee5b182) - 1 do
        if 0 < LuaAuxLib.UTF8_InStrRev(ide4bbbbe58aa1e7a78de7b1bb[ide8af86e588abe59bbee5b1823a49 + 1], ide680aae789a9e59bbee5b182[ide8af86e588abe59bbee5b1823a47 + 1], -1, _ENV) then
          LuaAuxLib.TracePrint("_5267:", ide8af86e588abe59bbee5b1823a49, ide8af86e588abe59bbee5b1823a54, ide8af86e588abe59bbee5b1823a47)
          ide7bb93e69e9ce59bbe[ide8af86e588abe59bbee5b1823a49 + 1] = ide8af86e588abe59bbee5b1823a54
          ide7bb93e69e9ce5b182[ide8af86e588abe59bbee5b1823a49 + 1] = ide8af86e588abe59bbee5b1823a47
          ide7bb93e69e9ce680aa[ide8af86e588abe59bbee5b1823a49 + 1] = ide680aae789a9e59bbee5b182[ide8af86e588abe59bbee5b1823a47 + 1]
          LuaAuxLib.TracePrint("_5271:", ide7bb93e69e9ce59bbe[ide8af86e588abe59bbee5b1823a49 + 1], ide7bb93e69e9ce5b182[ide8af86e588abe59bbee5b1823a49 + 1], ide680aae789a9e59bbee5b182[ide8af86e588abe59bbee5b1823a47 + 1])
        end
      end
    end
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ReturnValueVar, ide7bb93e69e9ce59bbee5b1823a41, ide7bb93e69e9ce59bbee5b1823a42, ide7bb93e69e9ce59bbee5b1823a43 = _UPVALUE3_, nil, nil, nil
  if ide7bb93e69e9ce59bbe[2] ~= ide7bb93e69e9ce59bbe[3] and ide7bb93e69e9ce59bbe[2] ~= ide7bb93e69e9ce59bbe[4] then
    LuaAuxLib.TracePrint("_5280:", "三图不一样,找最低层")
    _ENV[1] = ReturnValueVar
    if ide7bb93e69e9ce5b182[2] <= ide7bb93e69e9ce5b182[3] and ide7bb93e69e9ce5b182[2] <= ide7bb93e69e9ce5b182[4] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[2]] = ReturnValueVar
      ide69d80e680aae5b182[1] = ide5bc80e5a78be5b182[ide98089e68ba9e5b182 + 1]
      ide69d80e680aae5b182[2] = 55
      ide69d80e680aae5b182[3] = 55
    end
    if ide7bb93e69e9ce5b182[3] <= ide7bb93e69e9ce5b182[2] and ide7bb93e69e9ce5b182[3] <= ide7bb93e69e9ce5b182[4] then
      _ENV[ide7bb93e69e9ce59bbe[3]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[3]] = ReturnValueVar
      ide69d80e680aae5b182[1] = ide5bc80e5a78be5b182[ide98089e68ba9e5b182 + 1]
      ide69d80e680aae5b182[2] = 55
      ide69d80e680aae5b182[3] = 55
    end
    if ide7bb93e69e9ce5b182[4] <= ide7bb93e69e9ce5b182[3] and ide7bb93e69e9ce5b182[4] <= ide7bb93e69e9ce5b182[2] then
      _ENV[ide7bb93e69e9ce59bbe[4]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[4]] = ReturnValueVar
      ide69d80e680aae5b182[1] = ide5bc80e5a78be5b182[ide98089e68ba9e5b182 + 1]
      ide69d80e680aae5b182[2] = 55
      ide69d80e680aae5b182[3] = 55
    end
    if ide98089e68ba9e5b182 ~= ide7bb93e69e9ce5b182[2] then
    end
    if nil == ide7bb93e69e9ce5b182[3] then
      if ide7bb93e69e9ce59bbe[2] < ide7bb93e69e9ce59bbe[3] then
        _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      else
        _ENV[ide7bb93e69e9ce59bbe[3]] = ReturnValueVar
      end
    end
    if ide98089e68ba9e5b182 ~= ide7bb93e69e9ce5b182[2] then
    end
    if nil == ide7bb93e69e9ce5b182[4] then
      if ide7bb93e69e9ce59bbe[2] < ide7bb93e69e9ce59bbe[4] then
        _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      else
        _ENV[ide7bb93e69e9ce59bbe[4]] = ReturnValueVar
      end
    end
    if ide98089e68ba9e5b182 ~= ide7bb93e69e9ce5b182[4] then
    end
    if nil == ide7bb93e69e9ce5b182[3] then
      if ide7bb93e69e9ce59bbe[4] < ide7bb93e69e9ce59bbe[3] then
        _ENV[ide7bb93e69e9ce59bbe[4]] = ReturnValueVar
      else
        _ENV[ide7bb93e69e9ce59bbe[3]] = ReturnValueVar
      end
    end
  end
  if ide7bb93e69e9ce59bbe[2] == ide7bb93e69e9ce59bbe[3] and ide7bb93e69e9ce59bbe[2] == ide7bb93e69e9ce59bbe[4] then
    _ENV[3] = ReturnValueVar
    ide7bb93e69e9ce59bbee5b1823a41 = ide7bb93e69e9ce5b182[2]
    ide7bb93e69e9ce59bbee5b1823a42 = ide7bb93e69e9ce5b182[3]
    ide7bb93e69e9ce59bbee5b1823a43 = ide7bb93e69e9ce5b182[4]
    ide69d80e680aae5b182[1] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a41 + 1]
    ide69d80e680aae5b182[2] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a42 + 1]
    ide69d80e680aae5b182[3] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a43 + 1]
    if ide7bb93e69e9ce5b182[2] >= ide7bb93e69e9ce5b182[3] and ide7bb93e69e9ce5b182[2] >= ide7bb93e69e9ce5b182[4] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[2]] = ReturnValueVar
    end
    if ide7bb93e69e9ce5b182[3] >= ide7bb93e69e9ce5b182[2] and ide7bb93e69e9ce5b182[3] >= ide7bb93e69e9ce5b182[4] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[3]] = ReturnValueVar
    end
    if ide7bb93e69e9ce5b182[4] >= ide7bb93e69e9ce5b182[3] and ide7bb93e69e9ce5b182[4] >= ide7bb93e69e9ce5b182[2] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[4]] = ReturnValueVar
    end
  end
  if ide7bb93e69e9ce59bbe[2] == ide7bb93e69e9ce59bbe[3] and ide7bb93e69e9ce59bbe[2] ~= ide7bb93e69e9ce59bbe[4] then
    _ENV[2] = ReturnValueVar
    ide7bb93e69e9ce59bbee5b1823a41 = ide7bb93e69e9ce5b182[2]
    ide7bb93e69e9ce59bbee5b1823a42 = ide7bb93e69e9ce5b182[3]
    ide69d80e680aae5b182[1] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a41 + 1]
    ide69d80e680aae5b182[2] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a42 + 1]
    ide69d80e680aae5b182[3] = 55
    if ide7bb93e69e9ce5b182[2] >= ide7bb93e69e9ce5b182[3] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[2]] = ReturnValueVar
    end
    if ide7bb93e69e9ce5b182[3] >= ide7bb93e69e9ce5b182[2] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[3]] = ReturnValueVar
    end
  end
  if ide7bb93e69e9ce59bbe[2] == ide7bb93e69e9ce59bbe[4] and ide7bb93e69e9ce59bbe[2] ~= ide7bb93e69e9ce59bbe[3] then
    _ENV[2] = ReturnValueVar
    ide7bb93e69e9ce59bbee5b1823a41 = ide7bb93e69e9ce5b182[2]
    ide7bb93e69e9ce59bbee5b1823a43 = ide7bb93e69e9ce5b182[4]
    ide69d80e680aae5b182[1] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a41 + 1]
    ide69d80e680aae5b182[2] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a43 + 1]
    ide69d80e680aae5b182[3] = 55
    if ide7bb93e69e9ce5b182[2] >= ide7bb93e69e9ce5b182[4] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[2]] = ReturnValueVar
    end
    if ide7bb93e69e9ce5b182[4] >= ide7bb93e69e9ce5b182[2] then
      _ENV[ide7bb93e69e9ce59bbe[2]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[4]] = ReturnValueVar
    end
  end
  if ide7bb93e69e9ce59bbe[2] ~= ide7bb93e69e9ce59bbe[3] and ide7bb93e69e9ce59bbe[3] == ide7bb93e69e9ce59bbe[4] then
    _ENV[2] = ReturnValueVar
    ide7bb93e69e9ce59bbee5b1823a42 = ide7bb93e69e9ce5b182[3]
    ide7bb93e69e9ce59bbee5b1823a43 = ide7bb93e69e9ce5b182[4]
    ide69d80e680aae5b182[1] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a42 + 1]
    ide69d80e680aae5b182[2] = ide5bc80e5a78be5b182[ide7bb93e69e9ce59bbee5b1823a43 + 1]
    ide69d80e680aae5b182[3] = 55
    if ide7bb93e69e9ce5b182[4] >= ide7bb93e69e9ce5b182[3] then
      _ENV[ide7bb93e69e9ce59bbe[4]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[4]] = ReturnValueVar
    end
    if ide7bb93e69e9ce5b182[3] >= ide7bb93e69e9ce5b182[4] then
      _ENV[ide7bb93e69e9ce59bbe[4]] = ReturnValueVar
      _ENV[ide7bb93e69e9ce5b182[3]] = ReturnValueVar
    end
  end
  Thread.SetShareVar("清怪层", ide69d80e680aae5b182)
  LuaAuxLib.TracePrint("_5396:", (((((("最后选图" .. ide98089e68ba9e59bbe) .. "最后选层") .. ide98089e68ba9e5b182) .. "需要完成的任务数") .. ide5ae8ce68890e695b0) .. "杀怪层") .. ide69d80e680aae5b182[1], ide69d80e680aae5b182[2], ide69d80e680aae5b182[3])
  if ide98089e68ba9e59bbe == 0 then
    _ENV[16] = ReturnValueVar
  elseif ide98089e68ba9e59bbe == 1 then
    _ENV[17] = ReturnValueVar
  elseif ide98089e68ba9e59bbe == 2 then
    _ENV[18] = ReturnValueVar
  elseif ide98089e68ba9e59bbe == 3 then
    _ENV[19] = ReturnValueVar
  elseif ide98089e68ba9e59bbe == 4 then
    _ENV[20] = ReturnValueVar
  elseif ide98089e68ba9e59bbe == 5 then
    _ENV[24] = ReturnValueVar
  end
  Thread.SetShareVar("回城层数", ide680aae789a9e5b182[ide98089e68ba9e5b182 + 1])
  LuaAuxLib.TracePrint("_5411:", "选择层" .. ide680aae789a9e5b182[ide98089e68ba9e5b182 + 1])
  LuaAuxLib.TracePrint("_5412:", "入口" .. ide585a5e58fa3)
  return ReturnValueVar
end] = _zmm
_ENV[function()
  local ReturnValueVar = _ENV
  if ide5a49ae782b9e689be(39, 632, 600, 805, "0D6397-080808", "0|-16|428DC6-080808,-7|-35|3180BB-080808,-10|-21|682A40-080808") == true then
    ide4bbbbe58aa1e58685e5aeb9()
  else
    ide5beaee4bfa1e58f91e98081("任务可能做完了,脚本暂停", "任务可能做完了,脚本暂停")
    while true do
      LuaAuxLib.ShowMessage(tostring("书已经刷完了"), _UPVALUE2_, 600, 805)
      LuaAuxLib.Sleep(5555)
    end
  end
  ide8af86e588abe59bbee5b182()
  ide7bb93e69e9ce59bbee5b182()
  ide5beaee4bfa1e58f91e98081("当前任务", (((((ide7bb93e69e9ce680aa[2] .. ide7bb93e69e9ce680aa[3]) .. ide7bb93e69e9ce680aa[4]) .. "进图") .. ide98089e68ba9e59bbe + 1) .. "---") .. ide680aae789a9e5b182[ide98089e68ba9e5b182 + 1])
  _ENV[Thread.GetShareVar("任务次数")] = ReturnValueVar
  _ENV[ide4bbbbe58aa1e6aca1e695b0 + 1] = ReturnValueVar
  Thread.SetShareVar("任务次数", ide4bbbbe58aa1e6aca1e695b0)
  return ReturnValueVar
end] = _zmm
_ENV[function()
  LuaAuxLib.Tap(73, 962, 0)
  LuaAuxLib.Sleep(1111)
  local ide782b9e98791e69d90e696993ae69d90e69699e98089e68ba9 = _ENV
  ide782b9e98791e69d90e696993ae69d90e69699e98089e68ba9 = ide99984e9ad94e69d90e69699[LuaAuxLib.ReadConfig("下拉框附魔材料", _ENV, 1, nil) + 1]
  local ide782b9e98791e69d90e696993ae4b88be68b89e6aca1e695b0 = _ENV
  ide782b9e98791e69d90e696993ae4b88be68b89e6aca1e695b0 = 0
  while true do
    if ide5a49ae782b9e689be(134, 712, 560, 1227, ide782b9e98791e69d90e696993ae69d90e69699e98089e68ba9[1], ide782b9e98791e69d90e696993ae69d90e69699e98089e68ba9[2]) == true then
      _ENV[Thread.GetShareVar("材料")] = ide782b9e98791e69d90e696993ae69d90e69699e98089e68ba9
      _ENV[ide69d90e69699 + 1] = ide782b9e98791e69d90e696993ae69d90e69699e98089e68ba9
      Thread.SetShareVar("材料", ide69d90e69699)
      LuaAuxLib.TracePrint("_5447:", "点金材料" .. id494e5458, id494e5459)
      LuaAuxLib.Tap(id494e5458, id494e5459, 0)
      LuaAuxLib.Sleep(55)
      LuaAuxLib.Tap(id494e5458, id494e5459, 0)
      LuaAuxLib.Sleep(55)
      LuaAuxLib.Tap(id494e5458, id494e5459, 0)
      LuaAuxLib.Sleep(555)
      LuaAuxLib.Tap(81, 217, 0)
      LuaAuxLib.Sleep(555)
      LuaAuxLib.Tap(302, 640, 0)
      LuaAuxLib.Sleep(111)
      LuaAuxLib.Tap(302, 640, 0)
      LuaAuxLib.Sleep(2222)
      ide5b08fe59cb0e59bbe()
    else
      LuaAuxLib.TracePrint("_5462:", "没材料")
      LuaAuxLib.ShowMessage(tostring("没材料"), _UPVALUE2_, 0, 1227)
      if ide782b9e98791e69d90e696993ae4b88be68b89e6aca1e695b0 < 2 then
        ide782b9e98791e69d90e696993ae4b88be68b89e6aca1e695b0 = ide782b9e98791e69d90e696993ae4b88be68b89e6aca1e695b0 + 1
        ide58892e58aa8(200, 857, 500, 847, 333)
        LuaAuxLib.Tap(250, 1012, 555)
        LuaAuxLib.Sleep(1111)
      else
        ide58892e58aa8(500, 847, 200, 857, 333)
        LuaAuxLib.Sleep(1111)
        break
      end
    end
  end
end] = _zmm
_ENV[function(ide5beaee4bfa1e58f91e980813ae6a087e9a298, ide5beaee4bfa1e58f91e980813ae58685e5aeb9)
  local ReturnValueVar, ide5beaee4bfa1e58f91e980813ae58f91e98081e78ab6e68081, ide5beaee4bfa1e58f91e980813ae8bf9ee68ea5 = _UPVALUE2_, nil, nil
  ide5beaee4bfa1e58f91e980813ae8bf9ee68ea5 = ((((("https://sc.ftqq.com/" .. LuaAuxLib.ReadConfig("CDK", _ENV, 1, nil)) .. ".send") .. "?text=") .. ide5beaee4bfa1e58f91e980813ae6a087e9a298) .. "&desp=") .. ide5beaee4bfa1e58f91e980813ae58685e5aeb9
  ide5beaee4bfa1e58f91e980813ae58f91e98081e78ab6e68081 = LuaAuxLib.URL_OperationGet(ide5beaee4bfa1e58f91e980813ae8bf9ee68ea5, _ENV)
  if LuaAuxLib.VBS_InStr(ide5beaee4bfa1e58f91e980813ae58f91e98081e78ab6e68081, "success", 1, _ENV) ~= 0 then
    LuaAuxLib.TracePrint("_5486:", "微信发送成功")
    LuaAuxLib.ShowMessage(tostring("提醒成功"), _UPVALUE2_, 1, _ENV)
  else
    LuaAuxLib.TracePrint("_5489:", ide5beaee4bfa1e58f91e980813ae8bf9ee68ea5)
    LuaAuxLib.TracePrint("_5490:", LuaAuxLib.ReadConfig("CDK", _ENV, 1, nil), id43444b)
    LuaAuxLib.TracePrint("_5491:", ide5beaee4bfa1e58f91e980813ae58f91e98081e78ab6e68081)
    LuaAuxLib.TracePrint("_5492:", "微信发送不成功")
    LuaAuxLib.URL_OperationGet(((("https://sc.ftqq.com/" .. LuaAuxLib.ReadConfig("CDK", _ENV, 1, nil)) .. ".send") .. "?text=提醒不成功& desp=") .. ide5beaee4bfa1e58f91e980813ae8bf9ee68ea5, _ENV)
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  _ENV[Thread.GetShareVar("自定义提醒")] = Thread.GetShareVar("自定义提醒")
  if ide887aae5ae9ae4b989e68f90e98692 == 0 and LuaAuxLib.VBS_Round(LuaAuxLib.GetTickCount() / 1000 / 60) > LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("自定时间", _ENV, 1, nil)) then
    ide5beaee4bfa1e58f91e98081("自定义提醒" .. LuaAuxLib.VBS_Round(LuaAuxLib.GetTickCount() / 1000 / 60), (LuaAuxLib.ReadConfig("自定内容", _ENV, 1, nil) .. "--------") .. LuaAuxLib.ReadConfig("自定时间", _ENV, 1, nil))
    Thread.SetShareVar("自定义提醒", 1)
  end
end] = _zmm
_ENV[function()
  if LuaAuxLib.CmpColorEx("680|464|48B1D4-111111,679|729|48B1D4-111111,134|559|74ABBB-111111", 1) == 1 then
    LuaAuxLib.Tap(254, 366, 0)
    LuaAuxLib.Sleep(1111)
  end
end] = _zmm
_ENV[function()
  local ReturnValueVar, ide6a380e6b58be58f98e8baab3a4253 = _UPVALUE1_, nil
  ide6a380e6b58be58f98e8baab3a4253 = {
    "变身图标",
    637,
    249,
    675,
    418,
    "B2DAD9-111111",
    "-2|1|B2DAD9-111111,-9|2|B1DAD8-111111,-18|0|B3DBDA-111111,-16|-3|A7D0CF-111111,-19|5|B2DAD9-080808",
    "变身图标",
    637,
    249,
    675,
    418,
    "B2DAD9-111111",
    "-2|1|B2DAD9-111111,-9|2|B1DAD8-111111,-18|0|B3DBDA-111111,-16|-3|A7D0CF-111111,-19|5|B2DAD9-080808",
    "变身图标",
    637,
    249,
    675,
    418,
    "596D6D-111111",
    "-2|-2|586C6C-111111,-7|-4|576B6A-111111,-9|-2|596D6D-111111,-12|-6|596D6D-111111,-17|-5|596D6D-080808,-17|0|596D6D-080808"
  }
  local ide6a380e6b58be58f98e8baab3a41 = _ENV
  ide6a380e6b58be58f98e8baab3a41 = id46.ide5a49ae782b9e695b0e7bb84(ide6a380e6b58be58f98e8baab3a4253)
  if ide6a380e6b58be58f98e8baab3a41[1] == "变身图标" then
    ReturnValueVar = nil
    ide6a380e6b58be58f98e8baab3a4253 = nil
  else
    ReturnValueVar = nil
  end
  return ReturnValueVar
end] = _zmm
_ENV[function()
  LuaAuxLib.Sleep(3333)
  LuaAuxLib.ShowMessage(tostring((("当前分辨率" .. LuaAuxLib.GetScreenInfo(0)) .. ",") .. LuaAuxLib.GetScreenInfo(1)), _UPVALUE2_, LuaAuxLib.GetScreenInfo(1), 1)
  LuaAuxLib.SetScreenScale(0, 720, 1280, 1)
  if LuaAuxLib.GetScreenInfo(0) * 16 ~= LuaAuxLib.GetScreenInfo(1) * 9 then
    while true do
      LuaAuxLib.Sleep(1111)
      LuaAuxLib.ShowMessage(tostring(((("不支持当前分辨率" .. LuaAuxLib.GetScreenInfo(0)) .. ",") .. LuaAuxLib.GetScreenInfo(1)) .. "\n请使用模拟器(分辨率调整为<手机版720-1280>)\n云手机"), _UPVALUE2_, "\n请使用模拟器(分辨率调整为<手机版720-1280>)\n云手机", 1)
      break
    end
  end
  LuaAuxLib.TracePrint("_14:", LuaAuxLib.GetTickCount() / 1000 / 60, LuaAuxLib.ReadConfig("定时关闭", _ENV, 1, nil) + 0)
  _ENV[LuaAuxLib.ReadConfig("定时关闭", _ENV, 1, nil) + 0] = LuaAuxLib.ReadConfig("定时关闭", _ENV, 1, nil) + 0
  Thread.SetShareVar("检测任务", nil)
  _ENV[3], _ENV[{}] = {}, {}
  _ENV[{}] = {}
  _ENV[{}] = {}
  _ENV[{}] = {}
  _ENV[LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil)] = LuaAuxLib.ReadConfig("入口选择", _ENV, 1, nil)
  _ENV[LuaAuxLib.NewArray("异鼠", "洞穴水蛭", "业火", "火蝠", "泥浆怪", "火焰蛛", "流放恶魔", "迷失冒险者", "水龙", "怨灵", "火妖", "尸犬", "赤牙", "惑心魔", "玛丽安", "巨魔")] = LuaAuxLib.NewArray("异鼠", "洞穴水蛭", "业火", "火蝠", "泥浆怪", "火焰蛛", "流放恶魔", "迷失冒险者", "水龙", "怨灵", "火妖", "尸犬", "赤牙", "惑心魔", "玛丽安", "巨魔")
  _ENV[LuaAuxLib.NewArray("小石怪", "木妖", "速龙", "巨石傀儡", "堡垒", "渡鸦", "荆棘龙", "蝇王飞虱", "甲龙", "土人", "防御机械", "石龙", "迅捷斥牙", "安息之吻", "魔人古列", "毁灭者")] = LuaAuxLib.NewArray("小石怪", "木妖", "速龙", "巨石傀儡", "堡垒", "渡鸦", "荆棘龙", "蝇王飞虱", "甲龙", "土人", "防御机械", "石龙", "迅捷斥牙", "安息之吻", "魔人古列", "毁灭者")
  _ENV[LuaAuxLib.NewArray("臭臭花", "刺骨猎人", "曼陀罗草", "巨型水仙", "多头蛇", "恶毒蘑菇", "刺骨祭司", "刺骨战士", "水妖", "捕蝇草", "坑道虫", "树妖", "深棘", "恐爪", "重锤山克", "寄生体")] = LuaAuxLib.NewArray("臭臭花", "刺骨猎人", "曼陀罗草", "巨型水仙", "多头蛇", "恶毒蘑菇", "刺骨祭司", "刺骨战士", "水妖", "捕蝇草", "坑道虫", "树妖", "深棘", "恐爪", "重锤山克", "寄生体")
  _ENV[LuaAuxLib.NewArray("火山龟", "安沃斥候", "火舌", "烈焰守护者", "安沃苦工", "训练机器人", "恐惧兽", "征服者", "黑暗教徒", "安沃督军", "黑灵", "安沃妖术师", "霹雳", "剃刀", "唤魔者阿西克", "修格斯")] = LuaAuxLib.NewArray("火山龟", "安沃斥候", "火舌", "烈焰守护者", "安沃苦工", "训练机器人", "恐惧兽", "征服者", "黑暗教徒", "安沃督军", "黑灵", "安沃妖术师", "霹雳", "剃刀", "唤魔者阿西克", "修格斯")
  _ENV[LuaAuxLib.NewArray("圣兽", "噬魂者", "护灵者", "灼热的灵魂", "守护者", "僧侣之灵", "战士之灵", "圣灵", "神官", "狂徒之灵", "巫师之灵", "恐惧阴影", "梅丽莎", "扎克队长", "大祭司博甘斯", "盖亚")] = LuaAuxLib.NewArray("圣兽", "噬魂者", "护灵者", "灼热的灵魂", "守护者", "僧侣之灵", "战士之灵", "圣灵", "神官", "狂徒之灵", "巫师之灵", "恐惧阴影", "梅丽莎", "扎克队长", "大祭司博甘斯", "盖亚")
  _ENV[LuaAuxLib.NewArray("酸浆虱子", "掘墓者", "守夜人", "比冥骑士", "疯癫小丑", "血肉魔", "墓园树", "瓶中灵", "苦难使女", "鬼面蝎", "不朽傀儡", "御前学者", "弄臣杰克", "圣女大德兰", "首席学者安拓恩")] = LuaAuxLib.NewArray("酸浆虱子", "掘墓者", "守夜人", "比冥骑士", "疯癫小丑", "血肉魔", "墓园树", "瓶中灵", "苦难使女", "鬼面蝎", "不朽傀儡", "御前学者", "弄臣杰克", "圣女大德兰", "首席学者安拓恩")
  _ENV[LuaAuxLib.NewArray(6, 9, 13, 16, 19, 23, 26, 29, 35, 36, 37, 38, 39, 40)] = LuaAuxLib.NewArray(6, 9, 13, 16, 19, 23, 26, 29, 35, 36, 37, 38, 39, 40)
  _ENV[LuaAuxLib.NewArray(1, 1, 1, 1, 4, 7, 10, 14, 17, 20, 24, 27, 27, 27)] = LuaAuxLib.NewArray(1, 1, 1, 1, 4, 7, 10, 14, 17, 20, 24, 27, 27, 27)
  _ENV[LuaAuxLib.NewArray(ide59bbee4b880, ide59bbee4ba8c, ide59bbee4b889, ide59bbee59b9b, ide59bbee4ba94, ide59bbee585ad)] = LuaAuxLib.NewArray(ide59bbee4b880, ide59bbee4ba8c, ide59bbee4b889, ide59bbee59b9b, ide59bbee4ba94, ide59bbee585ad)
  _ENV[LuaAuxLib.NewArray(999, 999, 999)] = LuaAuxLib.NewArray(999, 999, 999)
  Thread.SetShareVar("清怪层", ide69d80e680aae5b182)
  _ENV[{}] = {}
  ide99984e9ad94e69d90e69699[1] = LuaAuxLib.NewArray("4077A4-080808", "6|-2|46474D-080808,-9|1|29426C-080808,-11|-14|29426C-080808,8|15|345583-080808,33|16|69A0EE-080808")
  ide99984e9ad94e69d90e69699[2] = LuaAuxLib.NewArray("908183-080808", "-6|3|675557-080808,-15|8|998B8D-080808,-21|18|000000-080808,-2|37|46474D-080808")
  ide99984e9ad94e69d90e69699[3] = LuaAuxLib.NewArray("543A4A-080808", "5|-23|0056D7-080808,-4|-11|2C1D29-080808,21|7|7E5D73-080808,19|30|45464C-080808")
  ide99984e9ad94e69d90e69699[4] = LuaAuxLib.NewArray("15847A-080808", "10|-6|2AB0A4-080808,18|15|15847A-080808,28|22|474F57-080808,-4|24|294F85-080808")
  ide99984e9ad94e69d90e69699[5] = LuaAuxLib.NewArray("D8DFE1-080808", "7|-15|D8DFE1-080808,21|0|3D4B9A-080808,19|8|3D4B9A-080808,22|-12|46474D-080808")
  ide99984e9ad94e69d90e69699[6] = LuaAuxLib.NewArray("242F46-080808", "6|-2|6383A5-080808,15|-6|465F83-080808,-20|19|46474D-080808,16|-23|46474D-080808")
  ide99984e9ad94e69d90e69699[7] = LuaAuxLib.NewArray("ADD0DB-101010", "10|-14|86B4C7-101010,16|8|D1EDF3-101010,-17|3|61899B-101010,-16|23|46474D-101010")
  ide99984e9ad94e69d90e69699[8] = LuaAuxLib.NewArray("2A3448-101010", "5|-6|445572-101010,15|3|4C6382-101010,12|21|2A3448-101010,-5|28|46474D-101010")
  ide99984e9ad94e69d90e69699[9] = LuaAuxLib.NewArray("C5D4DC-101010", "-7|7|8797A5-101010,-24|-20|3DA55B-101010,10|17|474959-101010,-29|9|46474D-101010")
  ide99984e9ad94e69d90e69699[10] = LuaAuxLib.NewArray("2F4864-101010", "6|1|426A90-101010,25|6|21C397-101010,29|1|378426-101010,9|-29|46474D-101010")
  ide99984e9ad94e69d90e69699[11] = LuaAuxLib.NewArray("C7CDD3-101010", "1|16|819B8E-101010,18|15|46474D-101010,-1|22|9FA5B3-101010,17|-11|000000-101010")
  ide99984e9ad94e69d90e69699[12] = LuaAuxLib.NewArray("FFB11C-101010", "-7|7|DD8235-101010,0|-9|F0DE65-101010,3|-17|FEF5DC-101010,25|-6|46474D-101010")
  ide99984e9ad94e69d90e69699[13] = LuaAuxLib.NewArray("445566-101010", "8|1|7799AA-101010,24|-7|7799AA-101010,19|-26|46474D-101010,-20|-24|445566-101010")
  ide99984e9ad94e69d90e69699[14] = LuaAuxLib.NewArray("445566-101010", "-10|9|46474D-101010,-19|-17|445566-101010,-12|-36|99AABB-101010,25|-18|667788-101010")
  ide99984e9ad94e69d90e69699[15] = LuaAuxLib.NewArray("776688-101010", "12|-11|776688-101010,10|-19|221166-101010,4|-48|6666CC-101010,38|-26|6666CC-101010")
  ide99984e9ad94e69d90e69699[16] = LuaAuxLib.NewArray("774422-111111", "0|-13|B7D973-111111,-17|13|46474D-111111,1|-13|AACC66-111111")
  ide99984e9ad94e69d90e69699[17] = LuaAuxLib.NewArray("FFFF22-111111", "-7|-1|664488-111111,-16|-10|667700-111111,17|9|46474D-111111")
  ide99984e9ad94e69d90e69699[18] = LuaAuxLib.NewArray("662266-111111", "-2|11|46474D-111111,-11|14|FF66EE-111111,15|8|AA66AA-111111")
  ide99984e9ad94e69d90e69699[19] = LuaAuxLib.NewArray("331133-111111", "-22|1|46474D-111111,16|-2|883366-111111,14|-17|664444-111111")
  ide99984e9ad94e69d90e69699[20] = LuaAuxLib.NewArray("46474D-111111", "1|-21|995577-111111,16|-21|884477-111111,20|3|551144-111111,30|-1|46474D-111111")
  ide99984e9ad94e69d90e69699[21] = LuaAuxLib.NewArray("46474D-111111", "9|-26|773366-111111,26|-10|773366-111111,25|-28|46474D-111111,-12|-30|223355-111111")
  ide99984e9ad94e69d90e69699[22] = LuaAuxLib.NewArray("995555-111111", "7|-14|000000-111111,18|-23|994455-111111,-19|5|46474D-111111,18|-49|552244-111111")
  ide99984e9ad94e69d90e69699[23] = LuaAuxLib.NewArray("46474D-111111", "28|-1|000000-111111,25|-12|46474D-111111,14|-26|996688-111111,35|9|443344-111111")
  ide99984e9ad94e69d90e69699[24] = LuaAuxLib.NewArray("994499-111111", "15|-5|CC66CC-111111,14|-12|33AA66-111111,-3|-14|46474D-111111,-12|-26|33AA66-111111")
  ide99984e9ad94e69d90e69699[25] = LuaAuxLib.NewArray("46474D-111111", "-23|-14|000000-111111,-1|-14|775566-111111,-1|-45|DD77AA-111111,-8|-46|000000-111111")
  ide99984e9ad94e69d90e69699[26] = LuaAuxLib.NewArray("46474D-111111", "22|-1|443344-111111,5|-20|AA8899-111111,-10|-48|775566-111111,28|-40|000000-111111")
  ide99984e9ad94e69d90e69699[27] = LuaAuxLib.NewArray("46474D-111111", "-25|-12|46474D-111111,-7|-37|111133-111111,13|-21|111133-111111")
  ide99984e9ad94e69d90e69699[28] = LuaAuxLib.NewArray("46474D-111111", "38|-8|EEEECC-111111,37|-20|666655-111111,11|-27|333E66-111111")
  ide99984e9ad94e69d90e69699[29] = LuaAuxLib.NewArray("46474D-111111", "-7|-9|888866-111111,2|-26|666644-111111,3|-50|666644-111111")
  ide99984e9ad94e69d90e69699[30] = LuaAuxLib.NewArray("333388-111111", "-14|-34|222266-111111,20|-22|99CCEE-111111,17|-41|46474D-111111")
  ide99984e9ad94e69d90e69699[31] = LuaAuxLib.NewArray("446699-111111", "-10|-14|46474D-111111,-7|-30|446699-111111,-20|-38|324477-111111")
  ide99984e9ad94e69d90e69699[32] = LuaAuxLib.NewArray("46474D-111111", "-7|-4|6666CC-111111,9|-19|443399-111111,-41|-29|776688-111111")
  ide99984e9ad94e69d90e69699[33] = LuaAuxLib.NewArray("46474D-111111", "-6|-41|99AABB-111111,-11|-27|445566-111111,21|-23|1F1F66-111111")
  ide99984e9ad94e69d90e69699[34] = LuaAuxLib.NewArray("46474D-080808", "-8|-10|55CCFF-080808,21|-18|55CCFF-080808,-20|-25|3377BB-080808")
  ide99984e9ad94e69d90e69699[35] = LuaAuxLib.NewArray("101010-080808", "29|-20|553344-080808,2|-45|FFDD00-080808,-17|-24|111111-080808")
  ide99984e9ad94e69d90e69699[36] = LuaAuxLib.NewArray("001122-080808", "10|-30|335577-080808,-21|-34|446677-080808,-25|0|001122-080808")
  ide99984e9ad94e69d90e69699[37] = LuaAuxLib.NewArray("775555-080808", "4|-11|998888-080808,-12|-31|CCBBBB-080808,15|-46|000000-080808")
  ide99984e9ad94e69d90e69699[38] = LuaAuxLib.NewArray("000000-111111", "10|21|46474D-111111,-3|-18|446677-111111,28|5|000000-111111")
  ide99984e9ad94e69d90e69699[39] = LuaAuxLib.NewArray("000000-111111", "-14|-3|000007-111111,-7|-10|000000-111111,-25|-57|222266-111111")
  ide99984e9ad94e69d90e69699[40] = LuaAuxLib.NewArray("46474D-111111", "24|-5|55DDEE-111111,13|-23|556666-111111,25|-14|3355AA-111111")
  ide99984e9ad94e69d90e69699[41] = LuaAuxLib.NewArray("46474D-111111", "-22|-10|222288-111111,1|-15|7D7DFF-111111,13|-38|4444FF-111111")
  _ENV[{}] = {}
  Thread.SetShareVar("答题次数", 0)
  Thread.SetShareVar("首领激活", 0)
  math.randomseed(os.time())
  Thread.SetShareVar("准备下楼", nil)
  Thread.SetShareVar("全部层数", 0)
  Thread.SetShareVar("战利品次数", 0)
  Thread.SetShareVar("材料", 0)
  Thread.SetShareVar("装备", 0)
  _ENV[nil] = "ide68a80e883bde5898de5bbb6e697b6"
  Thread.SetShareVar("层数", 0)
  _ENV[LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("回城层数", _ENV, 1, nil))] = "ide59b9ee59f8ee5b182e695b0", LuaAuxLib.VBS_Round(LuaAuxLib.ReadConfig("回城层数", _ENV, 1, nil))
  Thread.SetShareVar("回城层数", ide59b9ee59f8ee5b182e695b0)
  Thread.SetShareVar("战斗次数", 0)
  Thread.SetShareVar("死亡数", 0)
  Thread.SetShareVar("回城数", 0)
  Thread.SetShareVar("看小图数", 0)
  _ENV[(ide69687e4bbb6e5a4b9e4ba8c .. ide69687e4bbb6e5908de4ba8c) .. ".txt"] = "ide696b0e69687e4bbb6", (ide69687e4bbb6e5a4b9e4ba8c .. ide69687e4bbb6e5908de4ba8c) .. ".txt"
  _ENV[0] = "ide8a792e889b2e6aca1e695b0"
  _ENV[0] = "ide696b9e59091"
  _ENV[0] = "ide696b0e8b7afe6aca1e695b0"
  _ENV[{}] = "ide5b7b2e689bee59d90e6a08758", {}
  _ENV[{}] = "ide5b7b2e689bee59d90e6a08759", {}
  _ENV[{}] = "ide5be85e689bee8b7af58", {}
  _ENV[{}] = "ide5be85e689bee8b7af59", {}
  _ENV[{}] = "ide8b5b7e782b958", {}
  _ENV[{}] = "ide8b5b7e782b959", {}
  _ENV[{}] = "ide7bb88e782b958", {}
  _ENV[{}] = "ide7bb88e782b959", {}
  _ENV[0] = "ide7bb88e782b9e4bd8de7bdae"
  _ENV[0] = "ide4b88de9809ae4bd8de7bdae"
  _ENV[0] = "ide5b185e4b8ad"
  _ENV[0] = "ide697a0e8b7af"
  _ENV[0] = "ide69d80e5a4a7e680aa"
  Thread.SetShareVar("杀大怪", 0)
  Thread.SetShareVar("转动次数", 0)
  Thread.SetShareVar("分解次数", 0)
  Thread.SetShareVar("交任务", 0)
  Thread.SetShareVar("吃料理", 0)
  _ENV[nil] = "ide884b1e7a6bbe7bb84e9989f"
  Thread.SetShareVar("装备栏", 0)
  Thread.SetShareVar("神秘移动", 0)
  _ENV[0] = "ide9878de7bdaee6aca1e695b0"
  _ENV[0] = "ide680aae7babfe7a88b"
  _ENV[0] = "ide68ba6e8b7afe680aa"
  Thread.SetShareVar("有门无路", 0)
  Thread.SetShareVar("允许拦路数", 0)
  Thread.SetShareVar("灵视", 0)
  Thread.SetShareVar("是否点金", 0)
  Thread.SetShareVar("灵视次数", 0)
  _ENV["/sdcard/LUBIAO/"] = "ide69687e4bbb6e5a4b9", "/sdcard/LUBIAO/"
  _ENV["/sdcard/LUBIAO2/"] = "ide69687e4bbb6e5a4b9e4ba8c", "/sdcard/LUBIAO2/"
  _ENV[0] = "ide69687e4bbb6e5908de4ba8c"
  Thread.SetShareVar("起点X", ide8b5b7e782b958)
  Thread.SetShareVar("起点y", ide8b5b7e782b958)
  _ENV[LuaAuxLib.NewArray(0)] = "ide4b88de9809a58", LuaAuxLib.NewArray(0)
  _ENV[LuaAuxLib.NewArray(0)] = "ide4b88de9809a59", LuaAuxLib.NewArray(0)
  Thread.SetShareVar("不通X", ide4b88de9809a58)
  Thread.SetShareVar("不通Y", ide4b88de9809a59)
  _ENV[0] = "ide5bc80e5a78be68898e69697"
  Thread.SetShareVar("开始战斗", 0)
  Thread.SetShareVar("开始", 0)
  Thread.SetShareVar("自定义提醒", 0)
  Thread.SetShareVar("时间", 1)
  _ENV[LuaAuxLib.ReadConfig("CDK", _ENV, 1, nil)] = "id43444b", LuaAuxLib.ReadConfig("CDK", _ENV, 1, nil)
  Thread.SetShareVar("任务次数", 0)
  Thread.SetShareVar("找过红怪", nil)
  _ENV[{}] = "ide8a792e889b2e8a385e5a487", {}
  _ENV[LuaAuxLib.NewArray(LuaAuxLib.ReadConfig("火攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("火防", _ENV, 1, nil), LuaAuxLib.ReadConfig("水攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("水防", _ENV, 1, nil), LuaAuxLib.ReadConfig("木攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("木防", _ENV, 1, nil), LuaAuxLib.ReadConfig("光攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("光防", _ENV, 1, nil), LuaAuxLib.ReadConfig("暗攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("暗防", _ENV, 1, nil), LuaAuxLib.ReadConfig("等级", _ENV, 1, nil), LuaAuxLib.ReadConfig("成就", _ENV, 1, nil))] = "ide58583e7b4a0", LuaAuxLib.NewArray(LuaAuxLib.ReadConfig("火攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("火防", _ENV, 1, nil), LuaAuxLib.ReadConfig("水攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("水防", _ENV, 1, nil), LuaAuxLib.ReadConfig("木攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("木防", _ENV, 1, nil), LuaAuxLib.ReadConfig("光攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("光防", _ENV, 1, nil), LuaAuxLib.ReadConfig("暗攻", _ENV, 1, nil), LuaAuxLib.ReadConfig("暗防", _ENV, 1, nil), LuaAuxLib.ReadConfig("等级", _ENV, 1, nil), LuaAuxLib.ReadConfig("成就", _ENV, 1, nil))
  if LuaAuxLib.ReadConfig("识别装备", _ENV, 1, nil) == nil then
  end
  LuaAuxLib.Sleep(1111)
  if 0 < LuaAuxLib.ReadConfig("定时开始", _ENV, 1, nil) + 0 then
    _ENV[0] = "ide5ae9ae697b6"
    for TempVar = 1, LuaAuxLib.ReadConfig("定时开始", _ENV, 1, nil) * 12 do
      LuaAuxLib.ShowMessage(tostring(("未到开始挂机时间,已经等" .. ide5ae9ae697b6) .. "秒"), _UPVALUE2_, "秒", (LuaAuxLib.ReadConfig("光攻", _ENV, 1, nil)))
      LuaAuxLib.TracePrint("_209:", ("未到开始挂机时间,已经等" .. ide5ae9ae697b6) .. "秒")
      LuaAuxLib.Sleep(5000)
      _ENV[ide5ae9ae697b6 + 5] = (for index)
    end
  end
  _ENV[Thread.Start(ide6a380e6b58be7aa97e58fa3)] = "ide7aa97e58fa3e6a380e6b58b", Thread.Start(ide6a380e6b58be7aa97e58fa3)
  _ENV[0] = "ide58892e58aa8e6aca1e695b0"
  while true do
    ide5b08fe59cb0e59bbe()
  end
end] = _zmm
