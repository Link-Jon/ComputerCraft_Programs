function fuel()
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

turtle.select(1)

print("Starts by digging block below")
print("Enter distance")
distance=io.read()

for i=1, distance do
    while turtle.detectUp() do
        turtle.digUp()
        sleep(0.5)
    end
    turtle.digDown()
    fuel()
    turtle.down()
    while turtle.detect() do
        turtle.dig()
        sleep(0.5)
    end
    fuel()
	if not turtle.detectDown() then
		turtle.placeDown()
	end
    turtle.forward()
end