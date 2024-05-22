CreateThread(function()
    if HouseRobbery.Main.Framework ~= "esx" then return end

    debugPrint("HouseRobbery:ESX:Loading Framework")

    OnPlayerLoadedEvent = "esx:playerLoaded"
    OnPlayerUnloadedEvent = "esx:onPlayerLogout"
    OnJobUpdateEvent = "esx:setJob"

    PlayerData = {}

    export, Framework = pcall(function()
        return exports.es_extended:getSharedObject()
    end)

    if not export then
        while not Framework do
            TriggerEvent("esx:getSharedObject", function(obj)
                Framework = obj
            end)

            Wait(500)
        end
    end

    CreateThread(function()
        while Framework.GetPlayerData().job == nil do
            Wait(100)
        end

        PlayerData = Framework.GetPlayerData()
    end)

    RegisterNetEvent(OnPlayerLoadedEvent, function(xPlayer)
        PlayerData = xPlayer
    end)

    RegisterNetEvent(OnPlayerUnloadedEvent, function()
        PlayerData.identifier = nil
    end)

    while not Framework.PlayerLoaded do
        Wait(500)
    end

    RegisterNetEvent("esx:setJob", function(job)
        PlayerData.job = job
    end)

    function Notify(message, type, time)
        TriggerEvent("esx:showNotification", message, type, time)
    end

    function HasItem(item)
        if GetResourceState('ox_inventory') == 'started' then
            return exports.ox_inventory:Search('count', item) > 0
        end

        -- This is a custom function that checks if the player has an item in their inventory client sided.
        -- If you are not using ox_inventory you have to make this work depending on your inventory system.
        return true
    end

    debugPrint("HouseRobbery:ESX:Framework loaded")
end)
