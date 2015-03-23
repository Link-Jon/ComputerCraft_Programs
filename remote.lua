write('Host ID: ')
sender = read()
--ask for host id

shell.run('clear') --clear the screen
rednet.open("right") --open the wifi port
x=1
while x == 1 do --start loop
    action, senderID, text = os.pullEvent() --wait for input
    if action == "rednet_message" then --if its a wireless message do
        if text == 'forward' then -- if the up button is pressed
            turtle.forward() -- go forward
        end
        if text == 'backward' then --you know...
            turtle.back()
        end
        if text == 'left' then
            turtle.turnLeft()
        end
        if text == 'right' then
            turtle.turnRight()
        end
        if text == 'up' then
            if turtle.detectUp() then
                turtle.digUp()
            else
            turtle.up()
            end
        end
        if text == 'down' then
            if turtle.detectDown() then
                turtle.digDown()
            else
                turtle.down()
            end
        end
        if text == 'dig' then -- if the space button is pressed on dig mode
            turtle.dig() -- dig forward
        end
        if text == 'place' then -- if the space button is pressed on place mode
            turtle.place() --place the selected block in front
        end
        if text == 'rs' then -- if the ctrl button is pressed
            redstone.setOutput('front', true) -- set redstone in front to true
        end
    end
    if action=="key" and senderID == sender then -- check sender id
        x=0
    end
end