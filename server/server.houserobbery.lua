local Jobs = {}

language = lib.loadJson('languages.' .. HouseRobbery.Main.Language)

-- Functions
function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function EndJobHouse(groupId, success)
    if exports["bd-computer"]:DoesGroupExist(groupId) == false then return end

    local members = exports["bd-computer"]:GetGroupMembers(groupId)

    for i = 1, #members do
        TriggerClientEvent("bd-heists:client:houserobbery:finish-job", members[i])
        TriggerClientEvent("sp-laptop:client:hide-job-stage", members[i])
    end

    exports["bd-computer"]:RemoveBlipForGroup(groupId, "house-location")

    if success == true then
        exports["bd-computer"]:FinishContract(groupId)
    end

    exports["bd-computer"]:DestroyGroup(groupId)
    Jobs[groupId] = nil
end

RegisterNetEvent("bd-computer:server:hq:contracts:expired-contract", function(contractData)
    local groupId = contractData.id

    if Jobs[groupId] == nil then return end

    EndJobHouse(groupId, false)
end)

function GetHouse(houseId)
    return deepcopy(HouseRobbery.Locations[houseId]), houseId
end

-- Callbacks
lib.callback.register('bd-heists:server:houserobbery:get-job-data', function(source, groupId)
    if Jobs[groupId] == nil then return false end

    return Jobs[groupId]
end)

-- Events
RegisterNetEvent("bd-heists:server:houserobbery:remove-item", function(groupId, item, amount)
    if Jobs[groupId] == nil then return false end

    RemoveItem(source, item, amount)
end)

RegisterNetEvent("bd-heists:server:houserobbery:change-state", function(groupId, isDone, locationName, locationId, state)
    if Jobs[groupId] == nil or exports["bd-computer"]:DoesGroupExist(groupId) == false then return end

    if locationId then
        if isDone then
            Jobs[groupId][locationName][locationId].IsDone = state
        else
            Jobs[groupId][locationName][locationId].IsBusy = state
        end
    else
        if isDone then
            Jobs[groupId][locationName].IsDone = state
        else
            Jobs[groupId][locationName].IsBusy = state
        end
    end
end)

RegisterNetEvent("bd-heists:server:houserobbery:start-job", function(source, params)
    local PlayerId = source
    local group = exports["bd-computer"]:FindGroupByMember(PlayerId)
    if group == 0 then
        Notify(PlayerId, language.server.not_in_group, "error", 3000)
    else
        local leader = exports["bd-computer"]:GetGroupLeader(group)
        local members = exports["bd-computer"]:GetGroupMembers(group)
        if PlayerId == leader then
            local canStartJob = lib.callback.await('bd-heists:client:houserobbery:can-start-job', PlayerId)

            if canStartJob == true and Jobs[group] == nil then
                local House, HouseId = GetHouse(params.house)

                if House == nil then
                    EndJobHouse(group, false)
                    Notify(PlayerId, language.server.no_house_available, "error", 3000)
                    return
                end

                Jobs[group] = { Misc = nil, OutsidePanel = nil, Lockers = nil, Fails = 0, HouseId = 0 }

                Jobs[group]['Misc'] = House.Misc
                Jobs[group]['OutsidePanel'] = House.OutsidePanel
                Jobs[group]['Lockers'] = House.Lockers
                Jobs[group]['Fails'] = 0
                Jobs[group]['HouseId'] = HouseId

                exports["bd-computer"]:NotifyGroup(group,
                    language.server.head_to_location,
                    7500)

                for i = 1, #members do
                    TriggerClientEvent('bd-heists:client:houserobbery:add-interactions', members[i], Jobs[group],
                        group)
                    TriggerClientEvent("sp-laptop:client:show-job-stage", members[i], {
                        job = language.server.job_title,
                        title = language.server.job_location,
                        hasStatus = false,
                    })
                end

                local blip = {
                    coords = Jobs[group]['OutsidePanel']['Coords'],
                    color = 1,
                    alpha = 255,
                    sprite = 40,
                    scale = 1.65,
                    label = "Targeted House",
                    route = true,
                    routeColor = 1,
                }

                exports["bd-computer"]:CreateBlipForGroup(group, "house-location", blip)
            else
                exports["bd-computer"]:ResetContractProgress(group)
                EndJobHouse(group, false)
                exports["bd-computer"]:SendComputerNotification(PlayerId,
                    language.server.not_enough_cops, "error")
            end
        else
            exports["bd-computer"]:ResetContractProgress(group)
            EndJobHouse(group, false)
            exports["bd-computer"]:SendComputerNotification(PlayerId,
                language.server.not_leader, "error")
        end
    end
end)

RegisterNetEvent("bd-heists:server:houserobbery:second-stage", function(groupId)
    if Jobs[groupId] == nil or exports["bd-computer"]:DoesGroupExist(groupId) == false then return end
    local src = source

    local members = exports["bd-computer"]:GetGroupMembers(groupId)

    for i = 1, #members do
        TriggerClientEvent("bd-heists:client:houserobbery:add-interactions-second-stage", members[i], Jobs[groupId],
            groupId)
        TriggerClientEvent("sp-laptop:client:show-job-stage", members[i], {
            job = language.server.job_title,
            title = language.server.job_rob,
            hasStatus = true,
            statusMessage = language.server.job_robbed,
            statusValue = "0/" .. #Jobs[groupId]["Lockers"],
        })
    end
end)

RegisterNetEvent("bd-heists:server:houserobbery:rob-locker", function(groupId, lockerId)
    if Jobs[groupId] == nil or exports["bd-computer"]:DoesGroupExist(groupId) == false then return end

    local randomItem = math.random(1, #Jobs[groupId]["Lockers"][lockerId]["Rewards"])
    local itemAmount = Jobs[groupId]["Lockers"][lockerId]["Rewards"][randomItem]["Amount"]

    AddItem(source,
        Jobs[groupId]["Lockers"][lockerId]["Rewards"][randomItem]["Item"], itemAmount)

    if Jobs[groupId]["Lockers"][lockerId]["Rewards"][randomItem]["Item"] == "sns_accessories" then
        TriggerClientEvent("bd-heists:client:houserobbery:receive-accessories", source)
    end

    local robbedLockers = 0

    for k, v in pairs(Jobs[groupId]["Lockers"]) do
        if v.IsDone then
            robbedLockers = robbedLockers + 1
        end
    end

    local members = exports["bd-computer"]:GetGroupMembers(groupId)

    for i = 1, #members do
        if robbedLockers == #Jobs[groupId]["Lockers"] then
            for k = 1, #members do
                TriggerClientEvent("bd-heists:client:robbed-house", members[k])
            end

            EndJobHouse(groupId, true)

            break
        else
            TriggerClientEvent("sp-laptop:client:show-job-stage", members[i], {
                job = language.server.job_title,
                title = language.server.job_rob,
                hasStatus = true,
                statusMessage = language.server.job_robbed,
                statusValue = robbedLockers .. "/" .. #Jobs[groupId]["Lockers"],
            })
        end
    end
end)

RegisterNetEvent("bd-heists:server:houserobbery:add-fail", function(groupId)
    if Jobs[groupId] == nil or exports["bd-computer"]:DoesGroupExist(groupId) == false then return end

    Jobs[groupId]["Fails"] = Jobs[groupId]["Fails"] + 1

    local members = exports["bd-computer"]:GetGroupMembers(groupId)

    if Jobs[groupId]["Fails"] >= HouseRobbery.Misc.MaxFailsPerHeist then
        EndJobHouse(groupId, true)

        for i = 1, #members do
            Notify(members[i], language.server.failed, "error", 5000)
        end
    else
        for i = 1, #members do
            Notify(members[i],
                string.format(language.server.failed_once, Jobs[groupId]["Fails"], HouseRobbery.Misc.MaxFailsPerHeist),
                "error", 5000)
        end
    end
end)
