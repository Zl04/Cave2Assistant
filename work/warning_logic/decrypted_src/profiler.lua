--[[ Copyright (c) 2018, Charles Mallah ]]
-- Released with MIT License


---------------------------------------|
--- Configuration
--
---------------------------------------|

local PROFILER_FILENAME                = "profiler.lua" -- Location and name of profiler (to remove itself from reports);
                                                        -- e.g. if this is in a 'tool' folder, rename this as: "tool/profiler.lua"

local EMPTY_TIME                       = "0.0000"       -- Detect empty time, replace with tag below
local emptyToThis                      = "~"

local fileWidth                        = 41
local funcWidth                        = 22
local lineWidth                        = 6
local timeWidth                        = 7
local relaWidth                        = 6
local callWidth                        = 4
local callFuncWidth                    = 7         -- 函数调用平均次数

local reportSaved                      = " > Report saved to"
local formatOutputHeader               = "| %-"..fileWidth.."s: %-"..funcWidth.."s: %-"..lineWidth.."s: %-"..timeWidth.."s: %-"..relaWidth.."s: %-"..callWidth.."s: %-"..callFuncWidth.."s|\n"
local formatOutputTitle                = "%-"..fileWidth.."."..fileWidth.."s: %-"..funcWidth.."."..funcWidth.."s: %-"..lineWidth.."s" -- File / Function / Line count
local formatOutput                     = "| %s: %-"..timeWidth.."s: %-"..relaWidth.."s: %-"..callWidth.."s: %-"..callFuncWidth.."s|\n" -- Time / Relative / Called
local formatTotalTime                  = "TOTAL TIME   = %f s\n"
local formatFunLine                    = "%"..(lineWidth-2).."i"
local formatFunTime                    = "%04.4f"
local formatFunCllNum                  = "%"..callFuncWidth.."i"
local formatFunRelative                = "%03.1f"
local formatFunCount                   = "%"..(callWidth-1).."i"
local formatMemory 	                   = "%s\n"
local format2MB  		                   = "%i" -- "%0.1f"
local formatHeader                     = string.format(formatOutputHeader, "FILE", "FUNCTION", "LINE", "TIME", "%", "#", "funcNum")


---------------------------------------|
--- Locals
--
---------------------------------------|

local getTime                          = os.clock
local string                           = string
local debug                            = debug
local table                            = table

local TABL_REPORT_CACHE                = {}
local TABL_REPORTS                     = {}
local reportCount                      = 0
local startTime                        = 0
local stopTime                         = 0
local callFuncNum                      = 0

local printFun                         = nil
local verbosePrint                     = false

local function functionReport(information)
  local src = information.short_src
  if src == nil then
    src     = "<C>"
  elseif string.sub(src, #src-3, #src) == ".lua" then
    src     = string.sub(src, 1, #src-4)
  end
  
  local name = information.name
  if name == nil then
    name     = "Anon"
  elseif string.sub(name, #name-1, #name) == "_l" then
    name     = string.sub(name, 1, #name-2)
  end
  
  local lineStr = string.format(formatFunLine, information.linedefined or 0)
	local title                          = string.format(formatOutputTitle, 
                                            src, name, lineStr)
                                            
	local funcReport                     = TABL_REPORT_CACHE[title]
	if not funcReport then
    funcReport                         = {
                                            title  = title,
                                            src = src,
                                            name = name,
                                            lineStr = lineStr,
                                            count  = 0,
                                            timer  = 0,
                                          }
		TABL_REPORT_CACHE[title]          = funcReport
    reportCount                       = reportCount + 1
    TABL_REPORTS[reportCount]         = funcReport
	end
  
	return funcReport
end

local onDebugHook = function(hookType)
  local information     = debug.getinfo(2, "nS")
  if hookType == "call" then
    local funcReport    = functionReport(information)
    funcReport.callTime = getTime()
    funcReport.count    = funcReport.count + 1
    if(funcReport.callFuncNum == nil) then 
      funcReport.callFuncNum = 0
    end
    funcReport.startCallNum = callFuncNum
    callFuncNum = callFuncNum + 1
  elseif hookType == "return" then
    local funcReport    = functionReport(information)
    if funcReport.callTime and funcReport.count > 0 then
      funcReport.timer  = funcReport.timer + (getTime() - funcReport.callTime)
    end
    if(funcReport.startCallNum and funcReport.callFuncNum) then
      funcReport.callFuncNum = funcReport.callFuncNum + (callFuncNum - funcReport.startCallNum)
    end 
  end
end

local function charRepetition(n, character)
  local s   = ""
  character = character or " "
  for _ = 1, n do
    s = s..character
  end
  return s
end

local function singleSearchReturn(str, search)
  for _ in string.gmatch(str, search) do
    printThis = false
    do return true end
  end
  return false
end

local divider = charRepetition(#formatHeader-1, "-").."\n"


---------------------------------------|
--- Functions
--
---------------------------------------|

--- Attach a print function to the profiler, to receive a single string parameter
--
function attachPrintFunction(fn, verbose)
  printFun = fn
  if verbose ~= nil then
    verbosePrint = verbose
  end
end

---
-- 
function profilerStart()
  TABL_REPORT_CACHE = {}
	TABL_REPORTS      = {}
  reportCount       = 0
  callFuncNum       = 0
	startTime         = getTime()
	stopTime          = nil
	debug.sethook(onDebugHook, "cr", 0)
end

---
-- 
function profilerStop()
  callFuncNum       = 0
	stopTime          = getTime()
	debug.sethook()
end

--- Writes the profile report to file
-- 
function profilerReport(filename)  
  if stopTime == nil then
    profilerStop()
  end
  
	if reportCount > 0 then
    filename                = filename or "profiler.log"
    filename = cc.FileUtils:getInstance():fullPathForFilename(filename)    
    
    for k, v in pairs(TABL_REPORTS) do 
        -- 先计算单位次数的时间花费
        v.timer = v.timer/v.count * 100
        if(v.callFuncNum) then
          v.callFuncNum = v.callFuncNum/v.count
        end
    end

		table.sort(TABL_REPORTS, function(a, b) return a.timer > b.timer end)		
    local file              = io.open(filename, "w+")
    
    if reportCount > 0 then    
      local divide          = false
      local totalTime       = stopTime - startTime
      local totalTimeOutput = " > "..string.format(formatTotalTime, totalTime)
      
      if(file) then
        file:write(totalTimeOutput)
      end
      if printFun ~= nil then
        printFun(totalTimeOutput)
      end
      
      if(file) then
        file:write("\n"..divider)
        file:write(formatHeader)
      end
      if printFun ~= nil then
        printFun(formatHeader)
      end
      if(file) then
        file:write(divider)
      end
      
      for i = 1, reportCount do
        local funcReport = TABL_REPORTS[i]
        
        if funcReport.count > 0 then
        -- if funcReport.count > 0 and funcReport.timer <= totalTime then
          local printThis = true
          
          if PROFILER_FILENAME ~= "" then
            if singleSearchReturn(funcReport.title, PROFILER_FILENAME) then
              printThis = false
            end
          end
          
          -- Remove line if not needed
          if printThis == true then
            if singleSearchReturn(funcReport.title, "[[C]]") then
              printThis = false
            end
          end
          
          if printThis == true then
            local count         = string.format(formatFunCount, funcReport.count)
            local timer         = string.format(formatFunTime, funcReport.timer)
            local funCllNum     = string.format(formatFunCllNum , funcReport.callFuncNum)
            local relTime 		  = string.format(formatFunRelative, (funcReport.timer / totalTime) * 100)
            if divide == false and timer == EMPTY_TIME then
              if(file) then
                file:write(divider)
              end
              divide            = true
            end
            
            -- Replace
            if timer == EMPTY_TIME then
              timer             = emptyToThis
              relTime           = emptyToThis
            end

            local title = funcReport.title
            -- 根据自己的喜好组装FILE:FUNCTION:LINE
            local src = funcReport.src
            local name = funcReport.name
            local startIndex = string.find(src, "%[")
            local endIndex = string.find(src, "%]")
            if(startIndex and endIndex) then
                src = string.sub(src, startIndex, endIndex)
                if(#src > fileWidth) then 
                  src = string.sub(src, #src - fileWidth, #src)
                end
                title = string.format(formatOutputTitle, 
                                          src, funcReport.name, funcReport.lineStr)
            end
            
            -- Build final line
            local outputLine    = string.format(formatOutput, title, timer, relTime, count, funCllNum)
            if(file) then
              file:write(outputLine)
            end
            
            -- This is a verbose print to the printFun, however maybe make this smaller for on screen debug?
            if printFun ~= nil and verbosePrint == true then
              printFun(outputLine)
            end
            
          end
        end
      end
      if(file) then
        file:write(divider)
      end
    end
    if(file) then
      file:close()
    end
    
    if printFun ~= nil then
      printFun(reportSaved.."'"..filename.."'")
    end
    
	end
  
end
