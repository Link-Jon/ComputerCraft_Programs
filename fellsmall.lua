local height = 1

function fuel()
  if turtle.getFuelLevel() == 0 then
    turtle.refuel(1)
  end
end

turtle.dig()
fuel()
turtle.forward()
while turtle.detectUp() do
  turtle.digUp()
  fuel()
  turtle.up()
  height = height+1
end

while height > 1 do
  turtle.digDown()
  fuel()
  turtle.down()
  height = height - 1
end 
