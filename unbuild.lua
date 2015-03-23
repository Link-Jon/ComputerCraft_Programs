--UNbuild with turtles

--TODO:
    --
local tArgs = { ... }
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

function getArg(num)
    a = tArgs[num]
    if a == nil then --its nothing
        print("Arugments error")
        print("Use unbuild with no arguments if you don't know what you're doing")
        error()
    elseif tonumber(a) ~= nil then --its a number
        return tonumber(a)
    elseif string.lower(tostring(a)) == "true" then --its boolean true
        return true
    elseif string.lower(tostring(a)) == "false" then --its boolean false
        return false
    else --must be string
        return string.lower(tostring(a))
    end
end

function slot()
    function slotsHaveSpace()
        for n=2,16 do
            if turtle.getItemSpace(n) > 0 then
                return true
            end
        end
        turtle.select(1)
        return false
    end
    
    if not slotsHaveSpace() then
        print("Empty inventory to continue.")
        while not slotsHaveSpace() do
            sleep(1)
        end
    end
end

function inputNum()
    a = io.read()
    a = tonumber(a)
    if a == nil or a <=0 then
        print("Number error")
        error()
    else
        return a
    end
end

function inputStr()
    a = io.read()
    a = tostring(a)
    if a == nil then
        print("String error")
        error()
    else
        return string.lower(a)
    end
end

function myForward()
	refuel()
	if not turtle.forward() then
		myDig()
		myForward()
	end
end

function myBack()
	refuel()
	if not turtle.back() then
		print("Obstruction")
		sleep(1)
		myBack()
	end
end

function myUp()
	refuel()
	if not turtle.up() then
		myDigUp()
		myUp()
	end
end

function myDown()
	refuel()
	if not turtle.down() then
		myDigDown()
		myDown()
	end
end

function myDig()
	while turtle.detect() do
		if turtle.dig() then
			--collect()
			sleep(0.5)
		else
			return false
		end
	end
	return true
end

function myDigUp()
	while turtle.detectUp() do
		if turtle.digUp() then
			--collect()
			sleep(0.5)
		else
			return false
		end
	end
	return true
end

function myDigDown()
	while turtle.detectDown() do
		if turtle.digDown() then
			--collect()
			sleep(0.5)
		else
			return false
		end
	end
	return true
end

function line(L)
    print("Unbuilding "..L.." long line")
    for i=1,L-1 do
        slot()
        turtle.digDown()
        myForward()
    end
    turtle.digDown()
    print("Line done.")
end

function lineUp(H,goDown)
    print("Unbuilding "..H.." high line")
    for i=1,H-1 do
        myUp()
        slot()
        turtle.digDown()
    end
    
    if goDown then
        lineDown(H)
    end
    print("Line done.")
end

function lineDown(H)
    print("Unbuilding "..H.." high line")
    for i=1,H-1 do
		turtle.digDown()
        myDown()
        slot()
    end

    print("Line done.")
end

function stairs(H)
    print("Unbuilding "..H.." long stairs")
    for i=1,H-1 do
        slot()
        turtle.digDown()
        myUp()
        myForward()
    end
    slot()
    turtle.digDown()
    print("Stairs done.")
end

function stairsDown(H)
    print("Unbuilding "..H.." long stairs down")
    for i=1,H-1 do
        slot()
        turtle.digDown()
        myForward()
        myDown()
    end
    slot()
    turtle.digDown()
    print("Stairs done.")
end

function wallA(L,H)
    print("Unbuilding "..L.." long, "..H.." high wall using method A")
    for i=1, math.floor((L)/2) do --math.floor((L-1)/2)
        lineUp(H, false)
		myForward()
		lineDown(H)
		if i == math.floor((L)/2) then --on last one
			if L%2 == 1 then
				myForward()
			end
		else
			myForward()
		end
    end
	if L%2 == 1 then
		lineUp(H, true)
	end
    print("Wall done.")
end

function wallB(L,H)
    print("Unbuilding "..L.." long, "..H.." high wall using method B")
    myUp()
    for i=1,H-1 do
        line(L)
        myUp()
        turtle.turnRight()
        turtle.turnRight()
    end
    line(L)
    print("Wall done.")
end

function box(L,W,H,makeRoof)
    print("Unbuilding "..L.." x "..W.." x "..H.." box")
    function getDown()
        for x=1,H-1 do
            myDown()
        end
    end
	
	for i=1,L do
        wallA(W, H)
        if i%2 == 1 then
            turtle.turnRight()
            myForward()
            turtle.turnRight()
			
			--getDown()
        elseif i%2 == 0 then
            turtle.turnLeft()
            myForward()
            turtle.turnLeft()
			
			--getDown()
        end
    end
	
    --wallA(W,H)
    --getDown()
    --
    --wallA(L-1,H)
    --getDown()
    --
    --wallA(W-1,H)
    --getDown()
    --
    --wallA(L-2,H)
    --myForward()
    --turtle.turnRight()
    
	
    print("Box done.")
end

function platform(L,W)
    print("Unbiulding "..L.." x "..W.." platform")
    for i=1,L-1 do
        line(W)
        if i%2 == 1 then
            turtle.turnRight()
            myForward()
            turtle.turnRight()
        elseif i%2 == 0 then
            turtle.turnLeft()
            myForward()
            turtle.turnLeft()
        end
    end
    line(W)
end

term.clear()
term.setCursorPos(1,1)

--local options = {"line", "wallA", "wallB", "box", "platform", "stairs", "stairsdown", "lineup"}

if #tArgs == 0 then
    doText = true
else
    doText = false
end

if doText then
    print("Shape unmaker")
    print("Warning: This program is mostly untested")
    print("Fuel in slot 1")
    print("Materials will be in slots 2-16")
    print("-----------------------")
    print("What Shape?")
    print("Options:")
    print("line, wallA, wallB, box, platform, stairs, stairsDown, lineUp")
    
    choice = inputStr()
    
    term.clear()
    term.setCursorPos(1,1)
else
    choice = getArg(1)
end

if choice == "line" then
    if doText then
        print("Place turtle facing build direction.")
        print("------------------------------------")
        print("Length?")
        l = inputNum()
    else
        l = getArg(2)
    end
    line(l)

elseif choice == "stairs" then
    if doText then
        print("Place turtle facing build direction.")
        print("Stair starts with block below turtle.")
        print("------------------------------------")
        print("Length/height?")
        h = inputNum()
    else
        h = getArg(2)
    end
    stairs(h)  
    
elseif choice == "stairsdown" then
    if doText then
        print("Place turtle facing build direction.")
        print("Stair starts with block below turtle.")
        print("------------------------------------")
        print("Length/height?")
        h = inputNum()
    else
        h = getArg(2)
    end
    stairsDown(h)  
    
elseif choice == "walla" then
    if doText then
        print("Method A - build line by line")
        print("Place turtle facing build direction.")
        print("------------------------------------")
        print("Length?")
        l = inputNum()
        print("Height?")
        h = inputNum()
    else
        l = getArg(2)
        h = getArg(3)
    end
    wallA(l,h)
    
elseif choice == "wallb" then
    if doText then
        print("Method B - start from bottom layer and go up")
        print("Place turtle facing build direction.")
        print("------------------------------------")
        print("Length?")
        l = inputNum()
        print("Height?")
        h = inputNum()
    else
        l = getArg(2)
        h = getArg(3)
    end
    wallB(l,h)
    
elseif choice == "box" then
    if doText then
        print("Place turtle in lower left corner.")
        print("----------------------------------")
        print("Length? (Sides parallel to front of turtle)")
        l=inputNum()
        print("Depth? (Sides perpendicular to front of turtle)")
        w=inputNum()
        print("Height?")
        h = inputNum()
        
    else
        l = getArg(2)
        w = getArg(3)
        h = getArg(4)
        --r = getArg(5)
    end
    
    box(l,w,h)

elseif choice == "platform" then
    if doText then
        print("Place turtle in bottom left corner.")
        print("-----------------------------------")
        print("Length? (Sides parallel to front of turtle)")
        l=inputNum()
        print("Width? (Sides perpendicular to front of turtle)")
        w=inputNum()
    else
        l = getArg(2)
        w = getArg(3)
    end
    
    platform(l,w)
    
elseif choice == "lineup" then
    if doText then
        print("Height?")
        h=inputNum()
        print("Go down after? y/n")
        d = inputStr()
        if d == "y" or r == "yes" then
            d = true
        elseif r == "n" or r == "no" then
            d = false
        else
            print("Boolean error, will go down")
            d = false
        end
    else
        h = getArg(2)
        d = getArg(3)
    end
    
    lineUp(h,d)
    
else
    if doText then
        print("Not an option")
    else
        print("Arguments error")
        print("Use build with no arguments if you don't know what you're doing")
    end
    error()
end

