CreateThread(function()
    if HouseRobbery.Main.Framework ~= 'esx' then return end

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

    -- * Gets the identifier of a player's character.
    function GetPlayerIdentifier(source)
        local xPlayer = Framework.GetPlayerFromId(source)
        return xPlayer?.identifier
    end

    -- * Gets the bank balance of a player.
    function GetBankBalance(source)
        local xPlayer = Framework.GetPlayerFromId(source)
        if not xPlayer then
            return 0
        end

        return xPlayer.getAccount("bank")?.money or 0
    end

    -- * Adds money to a player's bank account.
    function AddMoney(source, amount)
        local xPlayer = Framework.GetPlayerFromId(source)
        if not xPlayer or amount < 0 then
            return false
        end

        xPlayer.addAccountMoney("bank", amount)
        return true
    end

    -- * Removes money from a player's bank account.
    function RemoveMoney(source, amount)
        local xPlayer = Framework.GetPlayerFromId(source)
        if not xPlayer or amount < 0 or GetBankBalance(source) < amount then
            return false
        end

        xPlayer.removeAccountMoney("bank", amount)

        return true
    end

    function AddItem(source, item, amount, metadata)
        return true
    end

    function RemoveItem(source, item, amount)
        return true
    end

    function HasItem(source, item)
        return true
    end

    -- * Sends a notification to a player.
    function Notify(source, message, type, time)
        TriggerClientEvent("esx:showNotification", source, message, type, time)
    end
end)
