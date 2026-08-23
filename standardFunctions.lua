------------------------------------------------
-- standard functions 
------------------------------------------------
local function df()         -- digForward
  while (turtle.detect()) do
    turtle.dig();
  end    
  turtle.forward();
end
local function dU()         -- digUp
  while (turtle.detectUp()) do
      turtle.digUp();
  end
  turtle.up();
end
local function dD()         -- digDown
  while (turtle.detectDown()) do
    turtle.digDown();
  end
  turtle.down();
end
local function f(n)         -- go forward N with digging if block in they way
  n = n or 2
  for i=1, n, 1 do
    df();
  end
end
local function b(n)         -- go back N
  n = n or 2
  for i=1, n, 1 do
    turtle.back();
  end
end
local function u(n)         -- go up N with digging if block in they way
  n = n or 1
  for i=1, n, 1 do
    dU();
  end
end
local function d(n)         -- go down N with digging if block in they way
  n = n or 1
  for i=1, n, 1 do
    dD();
  end
end
local function r(n)         -- right sideways N
  n = n or 2;
  turtle.turnRight();
  f(n);
  turtle.turnLeft();
end
local function l(n)         -- left sideways N
  n = n or 2;
  turtle.turnLeft();
  f(n);
  turtle.turnRight();    
end
local function refuelN(refuel_to_minimum_level)
  -- vound check and set them to the extrems
  if refuel_to_minimum_level < 1 then
    refuel_to_minimum_level = 1;
  elseif refuel_to_minimum_level > 20000 then
    refuel_to_minimum_level = 20000;
  end

  -- stepswise refuel to the refuel_to_minimum_level
  for i = 1, 16, 1 do
    if turtle.getFuelLevel() <= refuel_to_minimum_level then
      turtle.refuel(1);
    else
      return  
    end  
  end    
end
local function pf(BlockName)  -- placeForward
  BlockName = BlockName or "minecraft:stonebrick";
  if turtle.detect() == false and searchBlock(BlockName) == true then
    turtle.place();
  end
end
local function pU(BlockName)  -- placeUp
  BlockName = BlockName or "minecraft:stonebrick";
  if turtle.detectUp() == false and searchBlock(BlockName) == true then
    turtle.placeUp();
  end    
end
local function pD(BlockName)  -- placeDown
  BlockName = BlockName or "minecraft:stonebrick";
  if turtle.detectDown() == false and searchBlock(BlockName) == true then
    turtle.placeDown();
  end    
end
local function swD(Blockname)   -- swapDown
  Blockname = Blockname or "chisel:concrete";
  
  local success, data = turtle.inspectDown();
  
  if searchBlock(BlockName) == true then
    turtle.digDown();
    turtle.placeDown();        
  end
end

function searchBlock(blockname)
  blockname = blockname or "chisel:concrete";
  --
  local d = turtle.getItemDetail();
  if d and d.name == blockname then
    print("slot", turtle.getSelectedSlot(), ":", d.name);
    return true; -- found it & remains at this slot
  end
  --
  for i=1, 16, 1 do
    turtle.select(i);
    local data = turtle.getItemDetail();
    if data then
      if data.name == blockname then
        print("slot", i, ":", data.name);
        return true; -- found it & remains at this slot    
      end 
    end
    if i == 16 then
      turtle.select(1);
      print(blockname ," was not found");
      return false;
    end
  end
end
