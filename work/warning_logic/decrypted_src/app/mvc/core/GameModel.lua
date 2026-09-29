--[[--
游戏数据模型类
允许向控制层发送消息
1、请求函数为自动生成,不会覆盖，可以更改
]]
local GameModel = class("GameModel", mvc.Model)

function GameModel:ctor(...)
	GameModel.super.ctor(self, ...)
	if DEVELOPMENT_MODE then
		self._initDataKeys = {}
		local meta = getmetatable(self)
		meta.__newindex = function(tab, key, val) 
			self._initDataKeys[key] = true
			rawset(tab, key, val)
		end

		setmetatable(self, meta)
	end

	self:initData()
	self.bindMap =  {}

	if DEVELOPMENT_MODE then
		local meta = getmetatable(self)
		meta.__newindex = function(tab, key, val) 
			if self._initDataKeys[key] then
				rawset(tab, key, val)
				return
			end
			printError("给model定义函数必须在initData函数中进行声明:", self.__cname, key, val)
			assert(true, "给model定义函数必须在initData函数中进行声明")
		end

		setmetatable(self, meta)
	end
end


function GameModel:initData()
	assert(true, "必须被子类进行继承重写")
end

function GameModel:onRegister()
	GameModel.super.onRegister(self)
end


--获取名字
function GameModel:getName()
   return checkObjName(self.__cname)
end

--无安全检查
function GameModel:get(dataKey)
	return self[dataKey]
end

--设置数据触发绑定
function GameModel:set(dataKey,data)
	self[dataKey] = data
	self:setForce(dataKey, data)
end

--强制触发
function GameModel:setForce(dataKey, data)
	if self.bindMap and self.bindMap[dataKey] then --触发绑定调用
		local bindInfos = self.bindMap[dataKey]
		for obj, func in pairs(bindInfos) do
			func(obj, data)
		end
	end
end

--绑定数据
function GameModel:bind(dataKey,obj, func)
	if not func then 
		printInfo("[%s] bind a nil function",dataKey)
		return 
	end
	if not self.bindMap[dataKey] then
		self.bindMap[dataKey] = {}
	end
	self.bindMap[dataKey][obj] = func
	
	-- func(obj, self[dataKey])
end

--解除数据绑定
function GameModel:unbind(dataKey,obj)
	if self.bindMap and obj then
		if self.bindMap[dataKey] then
			self.bindMap[dataKey][obj] = nil
		end
	end
end

--释放
function GameModel:dispose()
	printInfo("[%s] dispose cache",self.__cname)
	self.bindMap = nil
end

return GameModel








-- function initData(mymetatable , key1)
-- 	local meta = {__key = key1, originalTab = mymetatable}
-- 	setmetatable(meta,{  __newindex = function(mytable, key, value)
-- 			-- if mymetatable[key] then
-- 	        	if type(value) == "table" then
-- 	        		value = initDataR(value, key1 ..".".. key )
-- 	        	end
-- 	        	mymetatable[key]= value

-- 	        	print("callback==>", meta.__key.."."..key)
-- 	        -- else
-- 	        -- 	rawset(mytable,key, value)
-- 	        -- end
-- 	  end,__index=function(mytable,key)
-- 	  -- print("__index", key)
-- 	  	if mymetatable[key] and mymetatable[key].originalTab then
-- 	  		return mymetatable[key].originalTab 
-- 	  	end
--   		return mymetatable[key]
-- 	  end })
-- 	return meta
-- end

-- function initDataR(mymetatable, key1)
-- 	local meta = initData(mymetatable, key1)
-- 	for key, val in pairs(mymetatable) do
-- 		if type(val) == "table" then
-- 			local m = initDataR(val, key1.."."..key)
-- 			mymetatable[key] = m
-- 		end
-- 	end
-- 	return meta
-- end

-- local mytable = {key2="111",val={{1},{2}},1,2,3}
-- local oldmyTable = mytable
-- local tab1 = {aa=1}
-- mytable = initDataR(mytable, "mytable")
-- print("=======")

-- print("mytable.key1 = tab1")
-- mytable.key1 = tab1
-- -- print(mytable.key1)
-- print("mytable.key1.aa=2")
-- mytable.key1.aa = 2
-- -- print(mytable.key1.aa)


-- print("mytable.val[1][3]=3")
-- mytable.val[1][3] = 3
-- -- print(mytable.val[1][3])
-- print("====121121====")
-- for key, v in pairs(oldmyTable.key1) do

-- 	print(key, v)
-- end
