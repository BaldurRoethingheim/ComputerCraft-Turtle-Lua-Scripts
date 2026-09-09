print("If inventory full, then items drop to floor.")
print("How long?: ");
local length = tonumber(read());
local height = 3

local function Dig()
    if turtle.detect() == true and turtle.dig() == false then
        print("block not breakable.");
        print("Job aborted.");
        exit();
    end
end

local function DigUp()
    if turtle.detectUp() == true and turtle.digUp() == false then
        print("block not breakable.");
        print("Job aborted.");
        exit();
    end
end

local function DigDown()
    if turtle.detectDown() == true and turtle.digDown() == false then
        print("block not breakable.");
        print("Job aborted.");
        exit();
    end
end

local function neededFuel(len)
    if (turtle.getFuelLevel() <= (len * 5)) then
        print("Not enough fuel for job. Please refuel.");
        return false;
    else
        return true;
    end
end

-- add optional chest deposition if chest in inventory at start. go back t ochest to deposit and resume where left off.
local function InventoryFull()
-- TODO
end
local function depositInventory()
-- TODO
end

local function Job()
    -- start digging
    print("Digging tunnel 3x3");
    
    for i_2 = 1, length, 1 do
        for i_1 = 1, height, 1 do
            turtle.turnLeft();
            Dig();
            turtle.turnLeft();turtle.turnLeft();
            Dig();
            turtle.turnLeft();
        
            if i_1 == height then
                for a = 1, (height-1), 1 do
                    turtle.down();    
                end       
            else
                DigUp();
                turtle.up();
            end
    
        end
        if (i_2 == length) then
            print("Job finished, Digger.")
        else
            Dig();
            turtle.forward();
        end
    end
end
    
if (neededFuel(length) == false) then
    exit();
else
   Job(); 
end
