CreateThread(function()
    if HouseRobbery.Main.Framework ~= 'qb' then return end

    Framework = exports['qb-core']:GetCoreObject()

    -- * Gets the citizen ID of a player's character.
    function GetPlayerIdentifier(source)
        return Framework.Functions.GetPlayer(source)?.PlayerData?.citizenid
    end

    -- * Gets the source of a player from their citizen ID.
    function GetPlayerSourceFromIdentifier(identifier)
        local player = Framework.Functions.GetPlayerByCitizenId(identifier)

        return player?.PlayerData?.source
    end

    -- * Gets the citizen ID of a player's character.
    function GetPlayerName(source)
        local Player = Framework.Functions.GetPlayer(source)
        return Player?.PlayerData?.charinfo?.firstname .. " " .. Player?.PlayerData?.charinfo?.lastname
    end

    -- * Gets the bank balance of a player.
    function GetBankBalance(source)
        return Framework.Functions.GetPlayer(source)?.Functions.GetMoney("bank") or 0
    end

    -- * Adds money to a player's bank account.
    function AddMoney(source, amount)
        local Player = Framework.Functions.GetPlayer(source)
        if not Player or amount < 0 then
            return false
        end

        Player.Functions.AddMoney("bank", amount, "bd-cokerun")
        return true
    end

    -- * Removes money from a player's bank account.
    function RemoveMoney(source, amount)
        if amount < 0 or GetBankBalance(source) < amount then
            return false
        end

        Framework.Functions.GetPlayer(source)?.Functions.RemoveMoney("bank", amount, "bd-computer")
        return true
    end

    function AddItem(source, item, amount, metadata)
        local Player = Framework.Functions.GetPlayer(source)
        if not Player or amount < 0 then
            return false
        end

        if Player.Functions.AddItem(item, amount, nil, metadata) then
            return true
        else
            return false
        end
    end

    function RemoveItem(source, item, amount)
        local Player = Framework.Functions.GetPlayer(source)
        if not Player or amount < 0 then
            return false
        end

        if Player.Functions.RemoveItem(item, amount) then
            return true
        else
            return false
        end
    end

    function HasItem(source, item)
        local Player = Framework.Functions.GetPlayer(source)
        if not Player then
            return false
        end

        return Player.Functions.GetItemByName(item)
    end

    -- * Sends a notification to a player.
    function Notify(source, message, type, time)
        TriggerClientEvent("QBCore:Notify", source, message, type, time)
    end
end)
