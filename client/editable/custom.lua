CreateThread(function()
    if HouseRobbery.Main.Framework ~= "custom" then
        return
    end

    while not NetworkIsSessionStarted() do
        Wait(500)
    end

    PlayerData = {}
    PlayerLicense = nil

    RegisterNetEvent('bd-cokerun:standalone:receive-player-ident')
    AddEventHandler('bd-cokerun:standalone:receive-player-ident', function(license)
        PlayerLicense = license
        debugPrint("Player License set to: " .. PlayerLicense)

        -- Now that PlayerLicense is set, you can use it
        PlayerData.identifier = PlayerLicense
        -- Perform any actions here that depend on PlayerData being set
    end)

    -- Function to request the player's identifier from the server
    local function requestPlayerIdentifier()
        TriggerServerEvent('bd-cokerun:standalone:request-player-ident')
    end

    -- Request the player's identifier
    requestPlayerIdentifier()

    function Notify(message, type, time)
        return true
    end

    function HasItem(item)
        if GetResourceState('ox_inventory') == 'started' then
            return exports.ox_inventory:Search('count', item) > 0
        end

        -- This is a custom function that checks if the player has an item in their inventory client sided.
        -- If you are not using ox_inventory you have to make this work depending on your inventory system.
        return true
    end
end)
