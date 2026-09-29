-- ObserverVariable.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:变量监听事件 

ObserverVariable = ObserverVariable or {}

ObserverVariable.bindersList = {}

--注册监听
function ObserverVariable:addListener(variable,obj,callFun)
    for i = 1,#self.bindersList do
        if self.bindersList[i] == variable then
            local handler = {}
            handler.obj = obj;
            handler.callFun = callFun
            self.bindersList[i]:addListener(handler)
            return;
        end
    end
end

--移除监听(需要在虚构函数中调用)
function ObserverVariable:removeListenr(variable,obj,callFun)
    if variable == nil or obj == nil or callFun == nil then
        return
    end

    for i = 1,#self.bindersList do
        if self.bindersList[i] == variable then
            local handler = {}
            handler.obj = obj;
            handler.callFun = callFun
            self.bindersList[i]:removeListenr(handler)
            return;
        end
    end
end

--具体观察者
ConcreteObserver = class("ConcreteObserver")

function ConcreteObserver:ctor(var)
    self.data = var
    self.oldData = var;
    self.handlerList = {}

    table.insert(ObserverVariable.bindersList,self)
end


--设置变量
function ConcreteObserver:set(var)
    if type(var) ~= type(self.data) then
        printError("ConcreteObserver:set ==> type different ==>"..type(var).."==>"..type(self.data))
    end
    self.data = var;
    self:Notify()
    self.oldData = var;
end

--获取变量
function ConcreteObserver:get()
    return self.data;
end

--添加监听事件
function ConcreteObserver:addListener(handler)
    for i = 1,#self.handlerList do
        if self.handlerList[i].obj == handler.obj then
            self.handlerList[i].callFun = handler.callFun
            return;
        end
    end

    table.insert(self.handlerList,handler)
end

--移除监听事件
function ConcreteObserver:removeListenr(handler)
    for i = #self.handlerList,1,-1 do
        if self.handlerList[i].obj == handler.obj then
            table.remove(self.handlerList,i)
        end
    end
end

--执行
function ConcreteObserver:Notify()
    for i = 1,#self.handlerList do
        if self.handlerList[i].obj and self.handlerList[i].callFun then
            self.handlerList[i].callFun(self.handlerList[i].obj,self.data,self.oldData);
        else
            printError("ConcreteObserver:Notify ==> obj is nil or callFun is nil");
        end
    end
end


