-- 根据 module_f.luac 重建。名称已解码并简化。
-- 数组来自 QuickMacro 运行时，并使用从 1 开始的 Lua 访问方式。

function 地图坐标连接(起点, 终点, 地图连接数据)
  local 查找列表 = LuaAuxLib.NewArray(起点)
  local 路线 = LuaAuxLib.NewArray("0-0")
  local 找过 = LuaAuxLib.NewArray(起点)

  while true do
    for C = 0, LuaAuxLib.TableSize(查找列表) - 1 do
      -- 每条图记录占用三个条目：
      -- [当前节点，边/路径数据，下一个节点]。
      for I = 0, LuaAuxLib.TableSize(地图连接数据) - 1, 3 do
        if 地图连接数据[I + 1] == 查找列表[C + 1] then
          local 未访问 = true
          for G = 0, LuaAuxLib.TableSize(找过) - 1 do
            if 找过[G + 1] == 地图连接数据[I + 3] then
              未访问 = false
              break
            end
          end

          if 未访问 then
            查找列表[LuaAuxLib.TableSize(查找列表) + 1] = 地图连接数据[I + 3]
            找过[LuaAuxLib.TableSize(找过) + 1] = 地图连接数据[I + 3]

            local 边路径 = 地图连接数据[I + 2]
            local 路径文本 = ""
            for D = 0, LuaAuxLib.TableSize(边路径) - 1, 2 do
              路径文本 = 路径文本 .. "-" .. 边路径[D + 1] .. "-" .. 边路径[D + 2]
            end
            路线[LuaAuxLib.TableSize(路线) + 1] = 路线[C + 1] .. 路径文本
          end

          if 地图连接数据[I + 3] == 终点 then
            return 路线[LuaAuxLib.TableSize(路线)]
          end
        end
      end
    end
  end
end
