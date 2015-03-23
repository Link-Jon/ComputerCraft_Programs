function refuel()
	local fuelLevel = turtle.getFuelLevel()
	if fuelLevel == "unlimited" or fuelLevel > 0 then
		return
	end
	
	local function tryRefuel()
		for n=1,16 do
			if turtle.getItemCount(n) > 0 then
				turtle.select(n)
				if turtle.refuel(1) then
					turtle.select(1)
					return true
				end
			end
		end
		turtle.select(1)
		return false
	end
	
	if not tryRefuel() then
		print( "Add more fuel to continue." )
		while not tryRefuel() do
			sleep(1)
		end
		print( "Resuming." )
	end
end

function inv()
	local full=true
	for n=1,16 do
		local nCount = turtle.getItemCount(n)
		if nCount == 0 then
			full=false
		end
	end
	if full then
		print("Inventory full")
		print("Empty and press enter")
		io.read()
	end
end

function myDig()
	inv()
	while turtle.detect() do
		turtle.dig()
		sleep(0.5)
	end
end

function myDigUp()
	inv()
	while turtle.detectUp() do
		turtle.digUp()
		sleep(0.5)
	end
end

function myDigDown()
	inv()
	while turtle.detectDown() do
		turtle.digDown()
		sleep(0.5)
	end
end

function myForward()
	refuel()
	if not turtle.forward() then
		print("Obstruction")
		sleep(1)
		myForward()
	end
end

function myUp()
	refuel()
	if not turtle.up() then
		print("Obstruction")
		sleep(1)
		myUp()
	end
end

function SideTun(dist)
    for i = 1, dist do
		myDig()
		myForward()
		myDigUp()
	end
end

term.clear()
term.setCursorPos(1,1)
print("Welcome to dub mining")
print("Put turtle on level 11")
print("How long will the side tunnels be?")
SideLen=io.read()
print("Mining...")

for x = 1,4 do
	--side tunnels
	turtle.turnRight()
	--tunnel right
	SideTun(SideLen)
	turtle.turnRight()
	turtle.turnRight()
	--back to center
	for a = 1,SideLen do
		myForward()
	end
	--tunnel left
	SideTun(SideLen)
	turtle.turnLeft()
	turtle.turnLeft()
	for a = 1,SideLen do
		myForward()
	end
	turtle.turnLeft()
	
	--tunnel down
	if x ~= 4 then
		for j = 1,2 do
			myDig()
			myForward()
			myDigUp()
			myDigDown()
			turtle.down()
		end
	end
end
--return to start
turtle.turnLeft()
turtle.turnLeft()
for x = 1,6 do
	myUp()
	myForward()
end
turtle.turnLeft()
turtle.turnLeft()
print("Done!")