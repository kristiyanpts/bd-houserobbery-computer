local currentResourceName = GetCurrentResourceName()

function debugPrint(...)
    if not HouseRobbery.Main.Debug then return end
    local args <const> = { ... }

    local appendStr = ''
    for _, v in ipairs(args) do
        appendStr = appendStr .. ' ' .. tostring(v)
    end
    local msgTemplate = '^3[%s]^0%s'
    local finalMsg = msgTemplate:format(currentResourceName, appendStr)
    print(finalMsg)
end

function HouserobberyAlert()
    exports["sp-dispatch"]:HouseRobbery()
end

function LootProgressbar()
    local finished = nil
    if HouseRobbery.Main.ProgressBar == "qb" then
        Framework.Functions.Progressbar('looting_drawer', language.client.robbing_drawer, 5000, false,
            false, { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                finished = true
            end, function()
                finished = false
            end)
    elseif HouseRobbery.Main.ProgressBar == "ox" then
        if lib.progressBar({
                duration = 5000,
                label = language.client.robbing_drawer,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    mouse = true,
                    combat = true,
                    sprint = true,
                }
            }) then
            finished = true
        else
            finished = false
        end
    end

    while finished == nil do
        Wait(1)
    end

    return finished
end

if HouseRobbery.Main.Framework == "qb" then
    RegisterNetEvent('police:SetCopCount')
    AddEventHandler('police:SetCopCount', function(Amount)
        CurrentCops = Amount
    end)
end

function AddTarget(id, pos, options)
    if HouseRobbery.Main.Target == "qb" then
        local sizex = 1
        local sizey = 1

        for k, v in pairs(options) do
            if v.serverEvent then
                v.event = v.serverEvent
                v.type = "server"
            else
                v.type = "client"
            end

            if v.onSelect then
                v.action = v.onSelect
            end
        end

        exports["qb-target"]:AddBoxZone(id, pos, sizex, sizey, {
            name = id,
            heading = 90.0,
            minZ = pos.z - 5,
            maxZ = pos.z + 5
        }, {
            options = options,
            distance = 2,
        })

        return id
    end
    if HouseRobbery.Main.Target == "ox" then
        return exports["ox_target"]:addBoxZone({ -- -1183.28, -884.06, 13.75
            coords = vec3(pos.x, pos.y, pos.z),
            size = vec3(1, 1, 1),
            rotation = 45,
            debug = false,
            options = options
        })
    end
end

function RemoveTarget(sendid)
    if HouseRobbery.Main.Target == "qb" then
        exports["qb-target"]:RemoveZone(sendid)
    end
    if HouseRobbery.Main.Target == "ox" then
        exports["ox_target"]:removeZone(sendid)
    end
    return true
end

function DrawerMinigame()
    return exports['sp-minigame']:SkillBar({ 5000, 6000 }, 5,
        math.random(3, 5))
end

function PanelMinigame()
    return exports['sp-minigame']:SkillCheck(50, 3000, { 'w', 'a', 's', 'w', 'y',
        'z', 'j' }, 2, 30, 3) --SkillCheck(speed(milliseconds), time(milliseconds), keys(string or table), rounds(number), bars(number), safebars(number))
end
