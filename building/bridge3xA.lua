-- bridge5x2xn
--[[ 
builds a bridge with variable length, but fixed design.
(width: 5 blocks of minecraft:stonebrick; height: 1, 2 at the edges; torch: on edges every intervall (of 4))
--]] --- func desc
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
  for i=1, n, 1 do
    df()
  end
end
local function b(n)
  n = n or 2
  for i=1, n, 1 do
    turtle.back()
  end
end
local function u(n)
  n = n or 1
  for i=1, n, 1 do
    dU()
  end
end
local function d(n)
  n = n or 1
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
    
  ------------------------------------------------
  -- main functions
  ------------------------------------------------
  local function buildBridge(a)
      a = a or 8
      if tonumber(a) > 100 then
        a = 100
      end
      for i=1, a, 1 do
          f(1)
          pD("minecraft:stonebrick")
          r(1)
          pD("minecraft:stonebrick")
          r(1)
          pD("minecraft:stonebrick")
          u(1)
          pD("minecraft:stonebrick")
          if (i % 4) == 1 then
            u(1)
            pD("minecraft:torch")
          end
          l(3)
          if (i % 4) == 1 then
            d(2)
          else
            d(1)    
          end
          pD("minecraft:stonebrick")
          l(1)
          pD("minecraft:stonebrick")
          u(1)
          pD("minecraft:stonebrick")
          if (i % 4) == 1 then
            u(1)
            pD("minecraft:torch")
          end
          r(2)
          if (i % 4) == 1 then
            d(2)
          else
            d(1)
          end
  
          -- if out of placing blocks abort
          if 
          searchBlock("minecraft:stonebrick") == false or
          searchBlock("minecraft:torch") == false then
            turtle.turnLeft()
            turtle.turnLeft()
            f(2)
            turtle.turnLeft()
            turtle.turnLeft()
            print("Job aborted.")
            return  
          end
      end
      print("Job finished.", a, "length")
      print("Fuel:", turtle.getFuelLevel())
  end
  ------------------------------------------------
  -- performed action
  ------------------------------------------------
  print("How long shall the bridge be constructed?")
  local input = read()
  buildBridge(input)
  
  
  ------------------------------------------------