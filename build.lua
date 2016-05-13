os.loadAPI("JoshAPI")
--build with turtles

--TODO:
    --
local tArgs = { ... }

function getArg(num)
    a = tArgs[num]
    if a == nil then --its nothing
        print("Arugments error")
        print("Use build with no arguments if you don't know what you're doing")
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
    function trySlot()
        for n=2,16 do
            if turtle.getItemCount(n) > 0 then
                turtle.select(n)
                return true
            end
        end
        turtle.select(1)
        return false
    end
    
    if not trySlot() then
        print("Add more blocks to continue.")
        while not trySlot() do
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

function line(L)
    --print("Building "..L.." long line")
    for i=1,L-1 do
        slot()
        turtle.placeDown()
        JoshAPI.forward()
    end
    turtle.placeDown()
    --print("Line done.")
end

function lineFromBelow(L)
    --print("Building "..L.." long line")
    for i=1,L-1 do
        slot()
        turtle.placeUp()
        JoshAPI.forward()
    end
    turtle.placeUp()
    --print("Line done.")
end

function lineUp(H,goDown)
    --print("Building "..H.." high line")
    for i=1,H do
        JoshAPI.up()
        slot()
        turtle.placeDown()
    end
    
    if goDown then
        JoshAPI.forward()
        for i=1,H do
            JoshAPI.down()
        end
    end
    --print("Line done.")
end

function stairs(H)
    --print("Building "..H.." long stairs")
    for i=1,H-1 do
        slot()
        turtle.placeDown()
        JoshAPI.up()
        JoshAPI.forward()
    end
    slot()
    turtle.placeDown()
    --print("Stairs done.")
end

function stairsDown(H)
    --print("Building "..H.." long stairs down")
    for i=1,H-1 do
        slot()
        turtle.placeDown()
        JoshAPI.forward()
        JoshAPI.down()
    end
    slot()
    turtle.placeDown()
    --print("Stairs done.")
end

function wallA(L,H)
    --print("Building "..L.." long, "..H.." high wall using method A")
    for i=1,L-1 do
        lineUp(H, true)        
    end
    lineUp(H, false)
    --print("Wall done.")
end

function wallB(L,H)
    --print("Building "..L.." long, "..H.." high wall using method B")
    JoshAPI.up()
    for i=1,H-1 do
        line(L)
        JoshAPI.up()
        turtle.turnRight()
        turtle.turnRight()
    end
    line(L)
    --print("Wall done.")
end

function box(L,W,H,makeRoof)
    --print("Building "..L.." x "..W.." x "..H.." box")
    function getDown()
        turtle.turnRight()
        JoshAPI.forward()
        for x=1,H do
            JoshAPI.down()
        end
    end
    wallA(L,H)
    getDown()
    
    wallA(W-1,H)
    getDown()
    
    wallA(L-1,H)
    getDown()
    
    wallA(W-2,H)
    JoshAPI.forward()
    turtle.turnRight()
    
    if makeRoof then
        platform(L,W)
    end
    --print("Box done.")
end

function platform(L,W)
    --print("Building "..L.." x "..W.." platform")
    for i=1,W-1 do
        line(L)
        if i%2 == 1 then
            turtle.turnRight()
            JoshAPI.forward()
            turtle.turnRight()
        elseif i%2 == 0 then
            turtle.turnLeft()
            JoshAPI.forward()
            turtle.turnLeft()
        end
    end
    line(L)
end

JoshAPI.cleanTerm()

--local options = {"line", "wallA", "wallB", "box", "platform", "stairs", "stairsdown", "lineup"}

if #tArgs == 0 then
    doText = true
else
    doText = false
end

if doText then
    print("Shape maker")
    print("Fuel in slot 1")
    print("Materials in slots 2-16")
    print("-----------------------")
    print("What Shape?")
    print("Options:")
    print("line, wallA, wallB, box, platform, stairs, stairsDown, lineUp, linefrombelow")
    
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

elseif choice == "linefrombelow" then
	if doText then
        print("Place turtle facing build direction.")
        print("------------------------------------")
        print("Length?")
        l = inputNum()
    else
        l = getArg(2)
    end
    lineFromBelow(l) 


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
        print("Width? (Sides perpendicular to front of turtle)")
        w=inputNum()
        print("Height?")
        h = inputNum()
        print("Roof? y/n")
        r = inputStr()
        if r == "y" or r == "yes" then
            r = true
        elseif r == "n" or r == "no" then
            r = false
        else
            print("Boolean error, no roof for you!")
            r = false
        end
    else
        l = getArg(2)
        w = getArg(3)
        h = getArg(4)
        r = getArg(5)
    end
    
    box(l,w,h,r)

elseif choice == "platform" then
    if doText then
        print("Place turtle in bottom left corner.")
        print("-----------------------------------")
        print("Length? (Sides perpendicular to front of turtle)")
        l=inputNum()
        print("Width? (Sides parallel to front of turtle)")
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

