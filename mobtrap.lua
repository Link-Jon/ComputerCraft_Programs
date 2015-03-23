slot = 2
turtle.select(2)
 
local function setSlot(s)
  slot = s
  turtle.select(s)
end
 
local function checkFuel()
  curSlot = slot
  if turtle.getFuelLevel() < 10 then
    setSlot(1)
    turtle.refuel()
    setSlot(curSlot)
  end
end
 
local function digMove()
  checkFuel()
  if turtle.forward() then
    return true
  end
  for i=1,100 do
    if turtle.dig() then
      if turtle.forward() then
        return true
      end
    end
  end
  for i=1,100 do
    if turtle.forward() then
      return true
    end
    read()
  end  
 
  return false
end
 
local function digMoveUp()
  turtle.digUp()
  checkFuel()
  return turtle.up()
end
 
local function digMoveDown()
  turtle.digDown()
  checkFuel()
  return turtle.down()
end
 
local function selectStack()
  if turtle.getItemCount(slot) > 0 then
    return
  end
  for s = 2,16 do
    if turtle.getItemCount(s) > 0 then
      if s ~= slot then
        setSlot(s)
      end
      return
    end
  end
end
 
local function place()
  selectStack()
  turtle.place()
end
 
local function placeUp()
  selectStack()
  turtle.placeUp()
end
 
local function placeDown()
  selectStack()
  turtle.placeDown()
end
 
function vcoords(x, y, z, w, h, d)
  local fy = h+1-y
  local parity = 0
  if d%2==1 and y%2==0 then
    parity = 1
  end
  local fz = z
  if y%2==0 then
    fz = d+1-z
  end
  local fx = x
  if z%2==parity then
    fx = w+1-x
  end
 
  return fx,fy,fz
end
 
 
local function buildBox(w, h, d, buildFunc)
  for y=1,h do
    local skipX = 1
    if y ~= 1 then
      turtle.turnRight()
      turtle.turnRight()
      digMoveDown()
    end
    for z=1,d do
      if z ~= 1 then
        local parity = 0
        if d%2 == 0 and y%2==0 then
          parity = 1
        end
        if z%2 == parity then
          turtle.turnRight()
          digMove()
          turtle.turnRight()
        else
          turtle.turnLeft()
          digMove()
          turtle.turnLeft()
        end
      end
      for x=skipX,w do
        if x ~= skipX then
          digMove()
        end
        turtle.digDown()
       
        local fx, fy, fz
        fx,fy,fz = vcoords(x,y,z,w,h,d)
        if buildFunc(fx, fy, fz) then
          placeUp()
        end
       
        local skip = true
        if z<d then
          skipX = 0
          for tx=x+1,w do
            local tfx,tfy,tfz
            tfx,tfy,tfz=vcoords(tx,y,z,w,h,d)
            if buildFunc(tfx,tfy,tfz) then
              skip = false
              break
            end
            tfx,tfy,tfz=vcoords(tx,y,z+1,w,h,d)
            if buildFunc(tfx,tfy,tfz) then
              skip = false
              break
            end
          end
          if skip then
            skipX = w+1-x
            break
          end
        end
      end
    end
  end
end
 
local function column(x, y, z)
  if x==2 and z==2 then
    return true
  else
    return false
  end
end
 
local function mobTrap(w, h, d)
  return function(x, y, z)
    if y >= h-1 then
      if x == 1 or x == w or z == 1 or z == d then
        return true
      else
        return false
      end
    end
    d1 = (x-1) + (z-1)
    d2 = (w-x) + (z-1)
    d3 = (x-1) + (d-z)
    d4 = (w-x) + (d-z)
    minD = math.min(math.min(d1, d2), math.min(d3, d4))
    level = math.floor(minD / 7)
    if h-2-y == level then
      return true
    elseif (x==1 or z==1 or x==w or z==d) and (h-2-y < level) then
      return true
    else
      return false
    end
  end
end
 
buildBox(70, 25, 70, mobTrap(70, 25, 70))