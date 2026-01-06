-- treeFarm1x8
local function df()
  if turtle.detect() then
    turtle.dig()  
  end
  turtle.suck()
  turtle.forward()
end

local function dU()
  if turtle.detectUp() then
    turtle.digUp()  
  end
  turtle.up()
end

local function dD()
  if turtle.detectDown() then
    turtle.digDown()
  end
  turtle.down()
end

local function f(n)
  n = n or 2
  for i=1, n, 1 do
    df()
    turtle.suck()
  end
end

local function b(n)
    n = n or 2
    for i=1, n, 1 do
      turtle.back()
    end
end

local function r(n)
    n = n or 2
    turtle.turnRight()
    f(n)
    turtle.turnLeft()
end

local function l(n)
    n = n or 2
    turtle.turnLeft()
    f(n)
    turtle.turnRight()    
end


local function pf(BlockName)
  BlockName = BlockName or "minecraft:stonebrick"
  if turtle.detect() == false and searchBlock(BlockName) == true then
      turtle.place()    
  end
end

local function pU(BlockName)
  BlockName = BlockName or "minecraft:stonebrick"
  if turtle.detectUp() == false and searchBlock(BlockName) == true then
      turtle.placeUp()    
  end    
end

local function pD(BlockName)
  BlockName = BlockName or "minecraft:stonebrick"
  if turtle.detectDown() == false and searchBlock(BlockName) == true then
      turtle.placeDown()        
  end    
end

function searchBlock(blockname)
  blockname = blockname or "minecraft:stonebrick"
  --
  local d = turtle.getItemDetail()
  if d and d.name == blockname then
    print("slot", turtle.getSelectedSlot(), ":", d.name)
    return true -- found it & remainS at this slot
  end
  --
  for i=1, 16, 1 do
      turtle.select(i)
      local data = turtle.getItemDetail()
      if data then
          if data.name == blockname then
              print("slot", i, ":", data.name)
              return true -- found it & remainS at this slot    
          end 
      end
      if i == 16 then
          turtle.select(1)
          print(blockname ,"was not found")
          return false
      end
  end
end

function searchBlockCount(blockname)
  blockname = blockname or "minecraft:stonebrick"
  local blocknameCount = 0
  for i=1, 16, 1 do
    turtle.select(i)
    local data = turtle.getItemDetail()
    if data then
      if data.name == blockname then
        print("slot", i, ":", data.name, turtle.getItemCount(i))
        blocknameCount = blocknameCount + turtle.getItemCount(i)
      end
    end
    if i == 16 and blocknameCount == 0 then
      turtle.select(1)
      print(blockname ,"was not found")
      return blocknameCount
    end
  end
  print(blocknameCount, blockname,"counted")
  return blocknameCount
end

local function refuel500()
  while (turtle.getFuelLevel() < 500) do
    if (searchBlock("minecraft:log") == false) then
      turtle.select(1);
      return false;
    end
    
    turtle.refuel(1)
  end
  print("refueled to above 500")
  print("fuel:", turtle.getFuelLevel())
  turtle.select(1);
  return true;
end


------------------------------
-- tree
local function tree()
  df()
  local success, data = turtle.inspect()
  if success then
    if data.name == "minecraft:log" then
      df()
      for i=1, 10, 1 do
        dU()
      end
      for i=1, 10, 1 do
        dD()
      end
      turtle.back()
      pf("minecraft:sapling")
      turtle.select(1)
      turtle.back()
      refuel500()
    else
      pf("minecraft:sapling")
      turtle.select(1)
      b(1)
      return  
    end
  else
    pf("minecraft:sapling")
    turtle.select(1)
    b(1)
    return
  end
  
end

------------------------------
-- tree farm

local cycle = 0;

local function Job()
  cycle = cycle + 1;
  print("cycle:", cycle);
  
  local a = 11
  f(2)
  turtle.turnLeft()
  tree()
  for i=1, a, 1 do
    turtle.suck();     
    r(2)
    tree()
  end
  turtle.turnLeft()
  turtle.turnLeft()
  tree()
  for i=1, a, 1 do
      r(2)
      tree()
      
  end
  turtle.turnLeft()
  b(2)
  turtle.turnLeft()
  turtle.turnLeft()
  
  while searchBlockCount("minecraft:log") > (8*64 + 4) do
    searchBlock("minecraft:log")
    turtle.drop(4)
    print("dropped 4 items")  
  end
  
  turtle.select(1)
  turtle.turnLeft()
  turtle.turnLeft()
  
  if turtle.detectUp() == true and refuel500() then
    Job();
  end

end

Job();

print("Fuel level is: ", turtle.getFuelLevel())
