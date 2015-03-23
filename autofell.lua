local height = 1
--slots:
--1: fuel
--2-14: log
--15: saplings
--16: bonemeal
function fuel()
  if turtle.getFuelLevel() == 0 then
    turtle.select(1)
    turtle.refuel(1)
    print("Refuled, new fuel level is " .. turtle.getFuelLevel())
  end
end

function bonemeal()
  turtle.select(16)
  a=turtle.getItemCount(16)
  turtle.place()
  if turtle.getItemCount(16) < a then
    bonemeal()
  end
end

function tree()
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
  turtle.select(15)
  turtle.suck()
  turtle.place()
  turtle.back()
  turtle.suck()
  turtle.place()
  turtle.turnLeft()
  turtle.suck()
  fuel()
  turtle.forward()
  turtle.suck()
  turtle.turnRight()
  turtle.suck()
  fuel()
  turtle.forward()
  turtle.suck()
  turtle.place()
  turtle.back()
  turtle.suck()
  turtle.place()
  
  --chest
  turtle.turnLeft()
  for i=2,14 do
    turtle.select(i)
    if turtle.getItemCount(i) > 0 then
      turtle.drop()
    end
  end
  turtle.turnRight()
  
  --bonemeal
  print("Waiting for the leaves to decay...")
  sleep(333)
  bonemeal()
  tree()
end
tree()