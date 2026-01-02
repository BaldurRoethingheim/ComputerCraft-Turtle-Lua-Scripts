print("length?")
local input = io.read()
local a = input
for i=1,a do
  turtle.dig()
  turtle.digUp()
  turtle.forward()
  turtle.digUp()
  turtle.digDown()
  turtle.down()
  
end
