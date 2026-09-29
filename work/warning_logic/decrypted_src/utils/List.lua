--[[
    双向链表
]]--

Avalon = Avalon or {}

local List = class("AvalonList")
Avalon.List = List

-- private:
local DEBUG = false

-- public:
-- 构造函数
function List:ctor()
    -- 链表头位置
    self._head = 0
    -- 链表尾位置
    self._tail = 0
    -- 链表元素数量
    self._size = 0
    -- 链表容量
    self._capacity = 0

    -- 元素列表
    self._items = {}
    -- 元素下一个的位置
    self._next = {}
    -- 元素上一个的位置
    self._prev = {}
end

-- 销毁
function List:destroy(clean_callback)
    self:clear(clean_callback)

    self._items = nil
    self._next = nil
    self._prev = nil
end

-- 清理
function List:clear(clean_callback)
    local size = self._size
    if (size > 0) then
        local items = self._items
        local prev = self._prev
        local next = self._next

        for i = 1, size do
            local item =  items[i]
            if (item) then
                if (clean_callback) then
                    clean_callback(item)
                end

                items[i] = nil
            end
            next[i] = nil
            prev[i] = nil
        end

        self._head = 0
        self._tail = 0
        self._size = 0
        self._capacity = 0
    end

    if (DEBUG) then
        print("Avalon List clear:")
        self:print()
    end
end

-- 添加元素到链表头
function List:push_front(item)
    assert(item, "[ERROR] Avalon List push_front: item is nil.")

    local size = self._size
    local capacity = self._capacity
    if (size == 0) then
        size = 1
        capacity = 1

        self._next[1] = 0
        self._prev[1] = 0

        self._head = 1
        self._tail = 1
    else
        size = size + 1
        capacity = capacity + 1

        self._next[capacity] = self._head
        self._prev[capacity] = 0
        self._prev[self._head] = capacity

        self._head = capacity
    end
    self._size = size
    self._capacity = capacity
    self._items[capacity] = item

    if (DEBUG) then
        print("Avalon List push_front:")
        self:print()
    end
end

-- 添加元素到俩表尾
function List:push_back(item)
    assert(item, "[ERROR] Avalon List push_back: item is nil.")

    local size = self._size
    local capacity = self._capacity
    if (size == 0) then
        size = 1
        capacity = 1

        self._next[1] = 0
        self._prev[1] = 0

        self._head = 1
        self._tail = 1
    else
        size = size + 1
        capacity = capacity + 1

        self._next[self._tail] = capacity
        self._next[capacity] = 0
        self._prev[capacity] = self._tail

        self._tail = capacity
    end
    self._size = size
    self._capacity = capacity
    self._items[capacity] = item

    if (DEBUG) then
        print("Avalon List push_back:")
        self:print()
    end
end

-- 插入元素
function List:insert_front(newItem, listItem)
    assert(newItem and listItem, "[ERROR] Avalon List insert: item or listItem is nil.")

    local size = self._size
    if (size == 0) then
       assert(false, "[ERROR] Avalon List insert_front: list size is 0.")
    else
        local found = false

        local items = self._items
        local next = self._next
        local prev = self._prev

        local capacity = self._capacity
        for current = 1, capacity do
            local item = items[current]
            if (item == listItem) then
                size = size + 1
                capacity = capacity + 1
                
                local prevIndex = prev[current]
                if (prevIndex > 0) then
                    next[prevIndex] = capacity
                else
                    self._head = capacity
                end
                next[capacity] = current
                prev[capacity] = prevIndex
                prev[current] = capacity

                found = true
                break
            end
        end

        if (found) then
            self._size = size
            self._capacity = capacity
            self._items[capacity] = newItem
        else
            print("[WARNING] Avalon List insert_front: no position found.")
        end
    end

    if (DEBUG) then
        print("Avalon List insert_front:")
        self:print()
    end
end

-- 插入元素
function List:insert_back(newItem, listItem)
    assert(newItem and listItem, "[ERROR] Avalon List insert: item or listItem is nil.")

    local size = self._size
    if (size == 0) then
       assert(false, "[ERROR] Avalon List insert_front: list size is 0.")
    else
        local found = false

        local items = self._items
        local next = self._next
        local prev = self._prev

        local capacity = self._capacity
        for current = 1, capacity do
            local item = items[current]
            if (item == listItem) then
                size = size + 1
                capacity = capacity + 1
                
                local nextIndex = next[current]
                if (nextIndex > 0) then
                    prev[nextIndex] = capacity
                else
                    self._tail = capacity
                end
                next[capacity] = nextIndex
                prev[capacity] = current
                next[current] = capacity

                found = true
                break
            end
        end

        if (found) then
            self._size = size
            self._capacity = capacity
            self._items[capacity] = newItem
        else
            print("[WARNING] Avalon List insert_front: no position found.")
        end
    end

    if (DEBUG) then
        print("Avalon List insert_back:")
        self:print()
    end
end

-- 删除元素
function List:remove(item)
    assert(item, "[ERROR] Avalon List remove: item is nil.")

    local found = false

    local size = self._size
    if (size > 0) then
        local current = self._head
        local prev = self._prev
        local next = self._next
        local items = self._items
        repeat
            if (item == items[current]) then
                if (size == 1) then
                    prev[current] = nil
                    next[current] = nil

                    self._head = 0
                    self._tail = 0
                else
                    local prevIndex = prev[current]
                    local nextIndex = next[current]

                    if (prevIndex == 0) then
                        prev[nextIndex] = 0

                        self._head = nextIndex
                    elseif (nextIndex == 0) then
                        next[prevIndex] = 0

                        self._tail = prevIndex
                    else
                        next[prevIndex] = nextIndex
                        prev[nextIndex] = prevIndex
                    end
                end

                found = true
                break
            end

            current = next[current]
        until (current == 0)

        if (found) then
            if (clean) then
                item:destroy()
            end

            self._size = size - 1
            self._items[current] = nil
        else
            print("[WARNING] Avalon List remove: no item found.")
        end
    end
    if (self._size == 0) then
        self._capacity = 0
    end

    if (DEBUG) then
        print("Avalon List remove:")
        self:print()
    end

    return found
end

-- 遍历
function List:traverse(target, callback, isFromTail)
    isFromTail = isFromTail or false

    local size = self._size
    if (size > 0) then
        local items = self._items

        if (not isFromTail) then
            local next = self._next
            local current = self._head
            repeat
                local item = items[current]
                callback(target, item)

                current = next[current]
            until (current == 0)
        else
            local prev = self._prev
            local current = self._tail
            repeat
                local item = items[current]
                callback(target, item)

                current = prev[current]
            until (current == 0)
        end
    end
end

-- 查询第一个满足条件的元素
function List:find(callback, isFromTail)
    isFromTail = isFromTail or false

    local size = self._size
    if (size > 0) then
        local items = self._items

        if (not isFromTail) then
            local next = self._next
            local current = self._head
            repeat
                local item = items[current]
                if (callback(item)) then
                    return item
                end

                current = next[current]
            until (current == 0)
        else
            local prev = self._prev
            local current = self._tail
            repeat
                local item = items[current]
                if (callback(target, item)) then
                    return item
                end

                current = prev[current]
            until (current == 0)
        end
    end
    return nil
end

-- 获取第一个元素
function List:head()
    return self._items[self._head]
end

-- 删除第一个元素
function List:pop_front()
    local item = nil

    local size = self._size
    if (size > 0) then
        item = self._items[self._head]

        local current = self._head
        local nextIndex = self._next[current]

        self._prev[current] = nil
        self._next[current] = nil
        self._prev[nextIndex] = 0

        self._head = nextIndex
        self._size = size - 1
        self._items[current] = nil
    else
        print("[WARNING] Avalon List pop_front: size is 0.")
    end
    if (self._size == 0) then
        self._capacity = 0
    end

    if (DEBUG) then
        print("Avalon List pop_front:")
        self:print()
    end

    return item
end

-- 获取最后一个元素
function List:tail()
    return self._items[self._tail]
end

-- 删除从某个节点开始的所有节点
function List:remove_from(begin_item, end_item, clean_callback)
    assert(begin_item, "[ERROR] Avalon List remove: begin item is nil.")

    local size = self._size
    if (size > 0) then
        local current = self._head
        local prev = self._prev
        local next = self._next
        local items = self._items

        local startIndex = 0
        local endIndex = 0

        local started = false
        local ended = false
        repeat
            local nextIndex = next[current]
            local item = items[current]

            if (started) then
                prev[current] = nil
                next[current] = nil

                size = size - 1
                items[current] = nil

                if (clean_callback) then
                    clean_callback(item)
                end
            end

            if (not started) then
                if (item == begin_item) then
                    started = true
                    startIndex = current
                end
            end
            if (not ended) then
                if (item == end_item) then
                    ended = true
                    endIndex = nextIndex

                    break
                end
            end

            current = nextIndex
        until (current == 0)

        if (startIndex > 0) then
            next[startIndex] = endIndex

            self._size = size
        else
            print("[WARNING] Avalon List remove: no begin item found.")
        end
        if (endIndex > 0) then
            prev[endIndex] = startIndex
        else
            self._tail = startIndex
        end
    else
        print("[WARNING] Avalon List remove: size is 0.")
    end
    if (self._size == 0) then
        self._capacity = 0
    end

    if (DEBUG) then
        print("Avalon List remove_from:")
        self:print()
    end
end

-- 获取元素个数
function List:size()
    return self._size
end

-- 打印
function List:print()
    local size = self._size
    local capacity = self._capacity
    print("------------------------------")
    print(string.format("List size:%d capacity:%d.", size, capacity))
    if (size > 0) then
        print(string.format("List head:%d tail:%d.", self._head, self._tail));
        local current = self._head
        repeat
            local prev = self._prev[current]
            local next = self._next[current]
            print(string.format("List current:%d prev:%d next:%d item:%s.", current, prev, next, self._items[current]))

            current = self._next[current]
        until (current == 0)
    end
    print("------------------------------\n")
end