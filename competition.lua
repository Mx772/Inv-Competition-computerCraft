bridge = peripheral.find("rsBridge")
mon = peripheral.wrap("top")
-- modem = peripheral.wrap("back")
if bridge == nil then error("rsBridge not found") end


itemGoals = {
    [1] = {"Steak","minecraft:cooked_beef",100000},
    [2] = {"Oak Logs","minecraft:oak_log",100000},
    [3] = {"Wool","minecraft:white_wool",100000},
    [4] = {"Ender Pearl","minecraft:ender_pearl",100000},
    [5] = {"Cobble Stone","minecraft:cobblestone",100000},
    [6] = {"Glass","minecraft:glass",100000},
    [7] = {"Sand","minecraft:sand",100000},
    [8] = {"Nether Star","minecraft:nether_star",100000},
    [9] = {"Sharpness X","minecraft:cobblestone",10000},
    [10] = {"Antimatter","mekanism:pellet_antimatter",5000},
    [11] = {"RS Infinity Booster","rsinfinitybooster:infinity_card",5000},
    [12] = {"Elytra","minecraft:elytra",5000}
}

function mainInv(displayName, dataName, goal, i)
    -- displayName incase it ends up being used inside here for some reason.
    item = bridge.getItem({name=dataName})
    CenterT(displayName, i, colors.black, colors.lightGray, "left")
    if item == nil then
        CenterT("0/" .. goal, i, colors.black, colors.red,"right")
    else
        qty = tostring(item.amount)
        if item.amount >= goal then
            CenterT(qty .. "/" .. goal, i, colors.black, colors.green,"right")
        else
            CenterT(qty .. "/" .. goal, i, colors.black, colors.red,"right")
        end
    end
end

function clearMon()
    mon.clear()
    mon.setCursorPos(1,1)
end

function checkInv()
    row = 1
    clearMon()
    for i = 1, #itemGoals, 1 do
        displayName = itemGoals[i][1]
        dataName = itemGoals[i][2]
        goal = itemGoals[i][3]
        mainInv(displayName, dataName, goal, i)
    end
end

  -- Snippet from BetterMonitors
function CenterT(text, line, txtback , txtcolor, pos)
    monX,monY = mon.getSize()
    mon.setBackgroundColor(txtback)
    mon.setTextColor(txtcolor)
    length = string.len(text)
    dif = math.floor(monX-length)
    x = math.floor(dif/2)
    if pos == "head" then
      mon.setCursorPos(x+1, line)
      mon.write(text)
    elseif pos == "left" then
      mon.setCursorPos(2,line)
      mon.write(text)
    elseif pos == "right" then
      mon.setCursorPos(monX-length, line)
      mon.write(text)
    end
end

while true do
    checkInv()
    -- Putting a sleep here so it's not constantly running
    sleep(10)
end

