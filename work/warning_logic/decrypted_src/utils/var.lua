

-- In other words, it will return true if the variable is an empty string, false, array(), NULL, "0", 0, and an unset variable
function isempty(value)
	return value == nil  or value == "" or   (type(value) == "table" and table.nums(value) <= 0)
end

function istrue(value)
	return not isempty(value)
end

function istable(value)
	return type(value) == "table"
end

function isfunction(value)
	return type(value) == "function"
end

function isnumber(value)
	return type(value) == "number"
end

function isstring(value)
	return type(value) == "string"
end

function isbool(value)
	return type(value) == "boolean"
end

function isuserdata(value)
	return type(value) == "userdata"
end

function isset(value)
	return type(value) ~= nil
end

function format(...)
	return string.format(...)
end

function checkvalue(value, msg)
	if not msg then msg = "value is nil" end
	if not value then
		error(msg)
	end
end
--检测objName
function checkObjName(clsName)
  if not clsName or string.len(clsName) <2 then return clsName end
  return string.lcfirst(clsName)
end
function string.ucfirst(input)
    return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

function string.lcfirst(input)
    return string.lower(string.sub(input, 1, 1)) .. string.sub(input, 2)
end
-- Function string.gfind was renamed string.gmatch. (Option LUA_COMPAT_GFIND) 
function getglobal(f)
    local v = mvc
    -- for w in string.gfind(f, "[%w_]") do
    for w in string.gmatch(f, "[%w_]+") do
        v = v[w]
    end
    return v
end

function setglobal(f, v)
    local t = mvc
    -- for w, d in string.gfind(f, "([%w_]+)(.?)") do
    for w, d in string.gmatch(f, "([%w_]+)(.?)") do
        if d == "." then -- not last field
            t[w] = t[w] or {}   -- create table if absent
            t = t[w]            -- get the table
        else                    -- last field
            t[w] = v            -- do the assignment
        end
    end
end
