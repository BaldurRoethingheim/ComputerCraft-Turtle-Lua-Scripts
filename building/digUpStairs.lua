print("length?")
local len = io.read()
for i=1, len do
  turtle.digUp()
  turtle.dig()
  turtle.forward()
  turtle.digUp()
  turtle.up()
end
