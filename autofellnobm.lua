term.clear()
term.setCursorPos(1,1)
turtle.select(1)
print("Auto Felling Program")
print("Fuel in slot 1")
print("Saplings in slot 16")

local trees=0
local height = 1
--slots:
--1: fuel
--2-15: log
--16: saplings
function fuel()
    if turtle.getFuelLevel() == 0 then
        turtle.select(1)
        turtle.refuel(1)
        print("Refuled, new fuel level is " .. turtle.getFuelLevel())
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
    turtle.select(16)
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
    for i=2,15 do
        turtle.select(i)
        if turtle.getItemCount(i) > 0 then
            turtle.drop()
        end
    end
    turtle.turnRight()
    trees=trees+1
    print("Harvested "..trees.." trees")
    
    --wait for tree
    fuel()
    turtle.digUp()
    turtle.up()
    print("Waiting for next tree to grow")
    while not turtle.detect() do
        sleep(30)
    end
    fuel()
    turtle.down()
    
    tree()
end
tree()