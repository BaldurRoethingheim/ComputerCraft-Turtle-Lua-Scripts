function searchBlock(blockname)
  blockname = blockname or "minecraft:stonebrick"
  --
  local d = turtle.getItemDetail()
  if d and d.name == blockname then
    print("slot", turtle.getSelectedSlot(), ":", d.name)
    return true -- found it & remains at this slot
  end
  --
  for i=1, 16, 1 do
      turtle.select(i)
      local data = turtle.getItemDetail()
      if data then
          if data.name == blockname then
              print("slot", i, ":", data.name)
              return true -- found it & remains at this slot    
          end 
      end
      if i == 16 then
          turtle.select(1)
          print(blockname ,"was not found")
          return false
      end
  end
end
