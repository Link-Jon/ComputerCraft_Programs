local tArgs = { ... }

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
  turtle.dig()
  turtle.digUp()
  fuel()
  turtle.up()
  height = height+1
end
turtle.turnRight()
turtle.dig()
fuel()
turtle.forward()
turtle.turnLeft()
while height > 1 do
  turtle.dig()
  turtle.digDown()
  fuel()
  turtle.down()
  height = height - 1
end
turtle.dig()  
fuel()
turtle.back()
turtle.turnLeft()
fuel()
turtle.forward()
turtle.turnRight()

if tostring(tArgs[1])=="chest" then
  turtle.turnLeft()
  for i=1,16 do
    turtle.select(i)
    if turtle.getItemCount(i) > 0 then
      turtle.drop()
    end
  end
  turtle.turnRight()
end