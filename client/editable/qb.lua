CreateThread(function()
    if HouseRobbery.Main.Framework ~= 'qb' then return end

    debugPrint("HouseRobbery:QB:Loading Framework")

    Framework = exports['qb-core']:GetCoreObject()

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobInfo)
        PlayerData.job = jobInfo
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        QBPlayerData = Framework.Functions.GetPlayerData()

        PlayerData = {
            identifier = QBPlayerData.citizenid,
            job = QBPlayerData.job
        }
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData.identifier = nil
        PlayerData.job = nil
    end)

    while not LocalPlayer.state.isLoggedIn do
        Wait(500)
    end

    debugPrint("HouseRobbery:QB:Framework loaded")

    local QBPlayerData = Framework.Functions.GetPlayerData()

    PlayerData = {
        identifier = QBPlayerData.citizenid,
        job = QBPlayerData.job,
        money = QBPlayerData.money
    }

    function Notify(message, type, time)
        TriggerEvent("QBCore:Notify", message, type, time)
    end

    function HasItem(item)
        if GetResourceState('ox_inventory') == 'started' then
            return exports.ox_inventory:Search('count', item) > 0
        end

        return Framework.Functions.HasItem(item)
    end
end)
