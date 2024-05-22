local CurrentCops = 0
local zoneIds = {}

language = lib.loadJson('languages.' .. HouseRobbery.Main.Language)

-- Functions
function CanPlayerInteractHouseRobbery(groupId, locationName, locationId)
    local jobData = lib.callback.await('bd-heists:server:houserobbery:get-job-data', false, groupId)

    if jobData == false then return false end

    if locationId then
        return not jobData[locationName][locationId].IsBusy and not jobData[locationName][locationId].IsDone
    else
        return not jobData[locationName].IsBusy and not jobData[locationName].IsDone
    end

    return false
end

-- Callbacks
lib.callback.register('bd-heists:client:houserobbery:can-start-job', function()
    if HouseRobbery.Main.Framework == 'qb' then
        return CurrentCops >= HouseRobbery.Misc.CopsRequired
    elseif HouseRobbery.Main.Framework == 'esx' then
        local cops = lib.callback.await('bd-houserobbery:server:get-active-police-officers', false)
        return cops >= HouseRobbery.Misc.CopsRequired
    else
        return true
    end
end)

RegisterNetEvent('bd-heists:client:houserobbery:add-interactions', function(Job, GroupId)
    local zone = AddTarget("houserobbery-outsidepanel", Job.OutsidePanel.Coords, {
        {
            serverEvent = "bd-heists:server:houserobbery:change-state",
            label = language.client.hack_panel,
            icon = "fa-solid fa-bolt",
            distance = 1.5,
            canInteract = function()
                return CanPlayerInteractHouseRobbery(GroupId, "OutsidePanel")
            end,
            onSelect = function()
                if CanPlayerInteractHouseRobbery(GroupId, "OutsidePanel") then
                    if HasItem(HouseRobbery.RequiredItems["OutsidePanel"]["Item"]) then
                        TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId, false,
                            "OutsidePanel", nil, true)

                        SetEntityCoords(PlayerPedId(), Job.OutsidePanel.AnimationCoords.x,
                            Job.OutsidePanel.AnimationCoords.y, Job.OutsidePanel.AnimationCoords.z - 1)
                        SetEntityHeading(PlayerPedId(), Job.OutsidePanel.AnimationCoords.w)

                        lib.requestAnimDict("anim_heist@hs3f@ig1_hack_keypad@arcade@male@")

                        Wait(500)

                        local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
                        local rx, ry, rz = table.unpack(GetEntityRotation(PlayerPedId()))
                        local fx, fy = px + GetEntityForwardX(PlayerPedId()),
                            py + GetEntityForwardY(PlayerPedId()) * 1
                        local _, z = GetGroundZFor_3dCoord(px, py + 0.2, pz, 0)

                        local scene = NetworkCreateSynchronisedScene(fx, fy, pz + 0.36, rx, ry, rz, 2, true,
                            false, -1, 0, 1.0)

                        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene,
                            "anim_heist@hs3f@ig1_hack_keypad@arcade@male@", "action_var_01", 1.5, -4.0, 1, 16,
                            1148846080, 0)

                        object1 = CreateObject(GetHashKey("ch_prop_ch_usb_drive01x"), px + 0.3, py, z, true, true,
                            true)
                        NetworkAddEntityToSynchronisedScene(object1, scene,
                            "anim_heist@hs3f@ig1_hack_keypad@arcade@male@",
                            "action_var_01_ch_prop_ch_usb_drive01x", 1.0, 1.0, 1)
                        object2 = CreateObject(GetHashKey("prop_phone_ing"), px + 0.6, py, z, true, true, true)
                        NetworkAddEntityToSynchronisedScene(object2, scene,
                            "anim_heist@hs3f@ig1_hack_keypad@arcade@male@", "action_var_01_prop_phone_ing", 1.0,
                            1.0, 1)

                        NetworkStartSynchronisedScene(scene)

                        Wait(5400)

                        local success = PanelMinigame()
                        if success then
                            TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId, false,
                                "OutsidePanel", nil, false)
                            TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId, true,
                                "OutsidePanel", nil, true)

                            TriggerServerEvent("bd-heists:server:houserobbery:second-stage", GroupId)

                            if HouseRobbery.RequiredItems["OutsidePanel"]["RemoveItem"] then
                                TriggerServerEvent("bd-heists:server:houserobbery:remove-item", GroupId,
                                    HouseRobbery.RequiredItems["OutsidePanel"]["Item"],
                                    HouseRobbery.RequiredItems["OutsidePanel"]["Amount"])
                            end

                            if HouseRobbery.Misc.EnableCopsDispatch == true then
                                HouserobberyAlert()
                            end

                            TriggerEvent("bd-heists:server:houserobbery:hacked-house")

                            TaskPlayAnim(PlayerPedId(), "anim_heist@hs3f@ig1_hack_keypad@arcade@male@",
                                "success_react_exit_var_02", 8.0, 8.0, -1, 0, 0, 0, 0, 0)
                        else
                            TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId, false,
                                "OutsidePanel", nil, false)

                            TaskPlayAnim(PlayerPedId(), "anim_heist@hs3f@ig1_hack_keypad@arcade@male@",
                                "fail_react", 8.0, 8.0, -1, 0, 0, 0, 0, 0)

                            TriggerServerEvent("bd-heists:server:houserobbery:add-fail", GroupId)
                        end

                        Wait(3566)

                        TaskPlayAnim(PlayerPedId(), "anim_heist@hs3f@ig1_hack_keypad@arcade@male@", "exit", 8.0,
                            8.0, -1, 0, 0, 0, 0, 0)

                        Wait(3433)

                        NetworkStopSynchronisedScene(scene)
                        DeleteEntity(object1)
                        DeleteEntity(object2)

                        ClearPedTasks(PlayerPedId())
                    else
                        Notify(language.client.no_item, "error", 3000)
                    end
                else
                    Notify(language.client.panel_busy, "error", 3000)
                end
            end
        }
    })

    zoneIds[#zoneIds + 1] = zone
end)

RegisterNetEvent("bd-heists:client:houserobbery:add-interactions-second-stage", function(Job, GroupId)
    for k, v in pairs(Job.Lockers) do
        local zoneId = AddTarget("houserobbery-lockers", v.Coords, {
            {
                serverEvent = "bd-heists:server:houserobbery:change-state",
                label = language.client.rob_drawer,
                icon = "fa-solid fa-fingerprint",
                distance = 1.5,
                canInteract = function()
                    return CanPlayerInteractHouseRobbery(GroupId, "Lockers", k)
                end,
                onSelect = function()
                    if CanPlayerInteractHouseRobbery(GroupId, "Lockers", k) then
                        if HasItem(HouseRobbery.RequiredItems["Lockers"]["Item"]) then
                            TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId, false,
                                "Lockers", k, true)

                            lib.requestAnimDict("veh@break_in@0h@p_m_one@")
                            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 8.0,
                                8.0, -1, 17, 0, 0, 0, 0)

                            local progressBar = LootProgressbar()

                            if progressBar then
                                TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds",
                                    8.0,
                                    8.0, -1, 17, 0, 0, 0, 0)

                                local success = DrawerMinigame()
                                if success then
                                    TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId,
                                        false, "Lockers", k, false)
                                    TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId,
                                        true, "Lockers", k, true)

                                    TriggerServerEvent("bd-heists:server:houserobbery:rob-locker", GroupId, k)

                                    if HouseRobbery.RequiredItems["Lockers"]["RemoveItem"] then
                                        TriggerServerEvent("bd-heists:server:houserobbery:remove-item",
                                            GroupId,
                                            HouseRobbery.RequiredItems["Lockers"]["Item"],
                                            HouseRobbery.RequiredItems["Lockers"]["Amount"])
                                    end
                                else
                                    TriggerServerEvent("bd-heists:server:houserobbery:change-state", GroupId,
                                        false, "Lockers", k, false)

                                    TriggerServerEvent("bd-heists:server:houserobbery:add-fail", GroupId)
                                end

                                ClearPedTasks(PlayerPedId())
                            else
                                TriggerServerEvent("bd-heists:server:storerobbery:change-state", GroupId,
                                    false,
                                    "Lockers", k, true)
                            end
                        else
                            Notify(language.client.no_item, "error", 3000)
                        end
                    else
                        Notify(language.client.drawer_busy, "error", 3000)
                    end
                end
            }
        })

        zoneIds[#zoneIds + 1] = zoneId
    end
end)

RegisterNetEvent("bd-heists:client:houserobbery:finish-job", function()
    for k, v in pairs(zoneIds) do
        RemoveTarget(v)
    end

    zoneIds = {}
end)

local Items = {
    ["bigtv"] = {
        hashKey = GetHashKey("ex_prop_ex_tv_flat_01"),
        bone = 60309,
        x = -0.05,
        y = 0.2,
        z = 0.35,
        rotX = -145.0,
        rotY = 100.0,
        rotZ = 0.0,
    },
    ["computer"] = {
        hashKey = GetHashKey("prop_laptop_01a"),
        bone = 60309,
        x = 0.025,
        y = 0.08,
        z = 0.255,
        rotX = -45.0,
        rotY = 290.0,
        rotZ = 0.0,
    },
    ["microwave"] = {
        hashKey = GetHashKey("prop_micro_01"),
        bone = 60309,
        x = 0.025,
        y = 0.08,
        z = 0.255,
        rotX = -145.0,
        rotY = 290.0,
        rotZ = 0.0,
    },
}

local isDoingItemAnim = false
local HouseObject = nil
local sleep = 200
CreateThread(function()
    while true do
        if isDoingItemAnim == false then
            for k, v in pairs(Items) do
                if HasItem(k) then
                    isDoingItemAnim = k
                    break
                end
            end

            if HouseObject ~= nil then
                DeleteObject(HouseObject)
                HouseObject = nil
                StopAnimTask(ped, "anim@heists@box_carry@", "idle", 1.0)
            end
        else
            local ped = PlayerPedId()
            RequestAnimDict('anim@heists@box_carry@')
            while not HasAnimDictLoaded('anim@heists@box_carry@') do
                Wait(2)
            end

            if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
                TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                sleep = 1
                if HouseObject == nil then
                    HouseObject = CreateObject(Items[isDoingItemAnim].hashKey, 0, 0, 0, true, true, true)
                    AttachEntityToEntity(HouseObject, ped, GetPedBoneIndex(PlayerPedId(), Items[isDoingItemAnim].bone),
                        Items[isDoingItemAnim].x, Items[isDoingItemAnim].y, Items[isDoingItemAnim].z,
                        Items[isDoingItemAnim].rotX, Items[isDoingItemAnim].rotY, Items[isDoingItemAnim].rotZ, true, true,
                        false, true, 1, true)
                end
            end

            DisableControlAction(0, 21, true)

            if not HasItem(isDoingItemAnim) then
                isDoingItemAnim = false

                sleep = 200
            end
        end
        Wait(sleep)
    end
end)
