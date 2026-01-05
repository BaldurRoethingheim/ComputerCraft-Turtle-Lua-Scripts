-- standard functions 
------------------------------------------------
local function df()
  while (turtle.detect()) do
    turtle.dig()
  end    
  turtle.forward()
end
local function dU()
  while (turtle.detectUp()) do
    turtle.digUp()
  end
  turtle.up()
end
local function dD()
  while (turtle.detectDown()) do
    turtle.digDown()
  end
  turtle.down()
end
local function f(n)
  n = n or 2
  if n <= 0 then
    return;
  end
  for i=1, n, 1 do
    df()
  end
end
local function b(n)
  n = n or 2
  if n <= 0 then
    return;
  end
  for i=1, n, 1 do
    turtle.back()
  end
end
local function u(n)
  n = n or 1
  if n <= 0 then
    return;
  end
  for i=1, n, 1 do
      dU()
  end
end
local function d(n)
  n = n or 1
  if n <= 0 then
    return;
  end
  for i=1, n, 1 do
      dD()
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
local function refuel500()
  for i = 1, 16, 1 do
    if turtle.getFuelLevel() <= 500 then
      turtle.refuel(1)
    else
      return  
    end  
  end    
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
  
------------------------------------------------
-- main functions
------------------------------------------------

-- place stair below onto solid block for upside down placement

local function buildStairsDown(a, b)
    a = a or 8                  -- standard cycles
    b = b or 5                  -- standard cycles -- must be uneven, preferable 5
    if tonumber(a) > 100 then
      a = 100                   -- maximum cycles
    end
    
    for i=1, a, 1 do
      -- program -- build structure
      
      -- go to starting point
      l((b-1)/2)

      -- staircase rows
      for i_2=1, b do
        d(2)
        pD("minecraft:stonebrick")
        u(1)
        pD("minecraft:stonebrick")
        u(1)
        turtle.turnLeft();turtle.turnLeft();
        if (b >= 5 and (i_2 == 1 or i_2 == b)) then
          pD("minecraft:stonebrick")
        else
          pD("minecraft:stone_brick_stairs")
        end
        turtle.turnLeft();turtle.turnLeft();
  
        if(i_2 < b) then
          r(1)    
        end
      end
      
      -- back to the middle
      l((b-1)/2)
      -- next line
      f(1)
      d(1)

      
      -- if out of placing blocks abort
      if 
      searchBlock("minecraft:stonebrick") == false or
      searchBlock("minecraft:stone_brick_stairs") == false then
        turtle.turnLeft()
        turtle.turnLeft()
        f(0)
        turtle.turnLeft()
        turtle.turnLeft()
        print("Job aborted.")
        return  
      end
    end
    print("Job finished.", a, " length")
    print("Fuel:", turtle.getFuelLevel())
end
------------------------------------------------
-- performed action
------------------------------------------------
print("How long shall the stair case be constructed?")
local length = io.read()
length = tonumber(length)
print("How wide shall the stair case be constructed?")
local width = io.read()
width = tonumber(width)

buildStairsDown(length, width)


------------------------------------------------
