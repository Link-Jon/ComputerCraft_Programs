local args = { ... }

if(#args > 0) then
    if (args[1] == "up") then
        turtle.digUp()
    elseif (args[1] == "down") then
        turtle.digDown()
    end
else
    turtle.dig()
end