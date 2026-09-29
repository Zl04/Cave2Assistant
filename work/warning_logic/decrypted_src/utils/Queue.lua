--[[
    队列
]]--

Avalon = Avalon or {}

local Queue = class("AvalonQueue")
Avalon.Queue = Queue

local DEBUG = false

function Queue:ctor()
    self._first = 0
    self._end = 0
    self._elements = {}
end

function Queue:destroy()
    self._elements = nil
end

function Queue:push(element)
    local endIndex = self._end
    if (endIndex == 0) then
        self._first = 1
        endIndex = 1
    else
        endIndex = endIndex + 1
    end
    self._elements[endIndex] = element
    self._end = endIndex

    if (DEBUG) then
        print(string.format("Queue: push one element, first:%d end:%d element count:%d(%d).", self._first, self._end, self:size(), #self._elements))
        self:print()
    end
end

function Queue:front()
    local elements = self._elements;
    if (self._first <= self._end) then
        local element = elements[self._first];
        elements[self._first] = nil

        self._first = self._first + 1
        if (self._first > self._end) then
            self:reset()
        end

        if (DEBUG) then
            print(string.format("Queue: pop one element, first:%d end:%d element count:%d(%d).", self._first, self._end, self:size(), #self._elements))
            self:print()
        end

        return element
    else
        if (DEBUG) then
            print(string.format("[ERROR] Queue: pop one element, first:%d end:%d element count:%d(%d).", self._first, self._end, self:size(), #self._elements))
        end

        return nil
    end
end

function Queue:peek()
    local elements = self._elements;
    if (self._first <= self._end) then
        local element = elements[self._first];

        if (DEBUG) then
            print(string.format("Queue: peek one element, first:%d end:%d element count:%d(%d).", self._first, self._end, self:size(), #self._elements))
            self:print()
        end

        return element
    else
        if (DEBUG) then
            print(string.format("[ERROR] Queue: peek one element, first:%d end:%d element count:%d(%d).", self._first, self._end, self:size(), #self._elements))
        end

        return nil
    end
end

function Queue:reset()
    local elements = self._elements

    local firstIndex = self._first
    local endIndex = self._end
    for i = firstIndex, endIndex do
        elements[i] = nil
    end
    self._first = 0
    self._end = 0

    if (DEBUG) then
        print(string.format("Queue: reset, first:%d end:%d element count:%d(%d).", self._first, self._end, self:size(), #self._elements))
    end
end

function Queue:size()
    return self._end - self._first + 1
end

function Queue:empty()
    if (self._end == 0) then
        return true
    else
        return (self._end - self._first + 1) == 0
    end
end

function Queue:print()
    print("------------------------")
    print("Queue elements:")

    local elements = self._elements
    local firstIndex = self._first
    local endIndex = self._end
    for i = 1, endIndex do
        print(string.format("Queue element: index %d, element %s.", i, elements[i]))
    end

    print("------------------------")
end
