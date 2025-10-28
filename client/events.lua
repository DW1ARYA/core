-- Player load and unload handling
RegisterNetEvent('DWASCore:Client:OnPlayerLoaded', function()
    ShutdownLoadingScreenNui()
    IsLoggedIn = true
    if not DWASConfig.Server.PVP then return end
    SetCanAttackFriendly(cache.ped, true, false)
    NetworkSetFriendlyFireOption(true)
end)

RegisterNetEvent('DWASCore:Client:OnPlayerUnload', function()
    IsLoggedIn = false
end)

RegisterNetEvent('DWASCore:Client:PvpHasToggled', function(pvp_state)
    SetCanAttackFriendly(cache.ped, pvp_state, false)
    NetworkSetFriendlyFireOption(pvp_state)
end)

-- Teleport Commands
RegisterNetEvent('DWASCore:Command:TeleportToPlayer', function(coords)
    SetPedCoordsKeepVehicle(cache.ped, coords.x, coords.y, coords.z)
end)

RegisterNetEvent('DWASCore:Command:TeleportToCoords', function(x, y, z, h)
    SetPedCoordsKeepVehicle(cache.ped, x, y, z)
    SetEntityHeading(cache.ped, h or GetEntityHeading(cache.ped))
end)

RegisterNetEvent('DWASCore:Command:GoToMarker', function()
    local blipMarker <const> = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blipMarker) then
        DWASCore.Functions.Notify(Lang:t("error.no_waypoint"), "error", 5000)
        return 'marker'
    end

    DoScreenFadeOut(650)
    while not IsScreenFadedOut() do Wait(0) end

    local ped, coords <const> = cache.ped, GetBlipInfoIdCoord(blipMarker)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local oldCoords <const> = GetEntityCoords(ped)

    local x, y, groundZ, Z_START = coords.x, coords.y, 850.0, 950.0
    local found = false
    if vehicle > 0 then FreezeEntityPosition(vehicle, true) else FreezeEntityPosition(ped, true) end

    for i = Z_START, 0, -25.0 do
        local z = (i % 2) ~= 0 and Z_START - i or i
        NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
        local curTime = GetGameTimer()
        while IsNetworkLoadingScene() and GetGameTimer() - curTime <= 1000 do Wait(0) end
        NewLoadSceneStop()
        SetPedCoordsKeepVehicle(ped, x, y, z)
        while not HasCollisionLoadedAroundEntity(ped) and GetGameTimer() - curTime <= 1000 do
            RequestCollisionAtCoord(x, y, z)
            Wait(0)
        end
        found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
        if found then
            SetPedCoordsKeepVehicle(ped, x, y, groundZ)
            break
        end
    end

    DoScreenFadeIn(650)
    if vehicle > 0 then FreezeEntityPosition(vehicle, false) else FreezeEntityPosition(ped, false) end

    if not found then
        SetPedCoordsKeepVehicle(ped, oldCoords.x, oldCoords.y, oldCoords.z - 1.0)
        DWASCore.Functions.Notify(Lang:t("error.tp_error"), "error", 5000)
    end

    SetPedCoordsKeepVehicle(ped, x, y, groundZ)
    DWASCore.Functions.Notify(Lang:t("success.teleported_waypoint"), "success", 5000)
end)

-- Vehicle Commands
RegisterNetEvent('DWASCore:Command:SpawnVehicle', function(vehName)
    local hash = joaat(vehName)
    if not IsModelInCdimage(hash) then return end
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end

    if cache.vehicle then DeleteVehicle(cache.vehicle) end

    local coords = GetEntityCoords(cache.ped)
    local vehicle = CreateVehicle(hash, coords.x, coords.y, coords.z, GetEntityHeading(cache.ped), true, false)
    TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
    SetVehicleFuelLevel(vehicle, 100.0)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetModelAsNoLongerNeeded(hash)
    TriggerEvent("vehiclekeys:client:SetOwner", DWASCore.Functions.GetPlate(vehicle))
end)

RegisterNetEvent('DWASCore:Command:DeleteVehicle', function()
    if cache.vehicle then
        SetEntityAsMissionEntity(cache.vehicle, true, true)
        DeleteVehicle(cache.vehicle)
    else
        local pcoords = GetEntityCoords(cache.ped)
        for _, v in pairs(GetGamePool('CVehicle')) do
            if #(pcoords - GetEntityCoords(v)) <= 5.0 then
                SetEntityAsMissionEntity(v, true, true)
                DeleteVehicle(v)
            end
        end
    end
end)

RegisterNetEvent('DWASCore:Client:VehicleInfo', function(info)
    local plate = DWASCore.Functions.GetPlate(info.vehicle)
    local hasKeys = GetResourceState('qb-vehiclekeys') == 'started' and exports['qb-vehiclekeys']:HasKeys() or true

    local data = {
        vehicle = info.vehicle,
        seat = info.seat,
        name = info.modelName,
        plate = plate,
        driver = GetPedInVehicleSeat(info.vehicle, -1),
        inseat = GetPedInVehicleSeat(info.vehicle, info.seat),
        haskeys = hasKeys
    }

    TriggerEvent('DWASCore:Client:'..info.event..'Vehicle', data)
end)

-- Other stuff
RegisterNetEvent('DWASCore:Player:SetPlayerData', function(val)
    if GetInvokingResource() ~= GetCurrentResourceName() then return end
    DWASCore.PlayerData = val
end)

RegisterNetEvent('DWASCore:NotifyV2', function(props)
    DWASCore.Functions.NotifyV2(props)
end)

RegisterNetEvent('DWASCore:Notify', function(text, notifyType, duration)
    DWASCore.Functions.Notify(text, notifyType, duration)
end)

-- Callback Events
RegisterNetEvent('DWASCore:Client:TriggerClientCallback', function(name, ...)
    DWASCore.Functions.TriggerClientCallback(name, function(...)
        TriggerServerEvent('DWASCore:Server:TriggerClientCallback', name, ...)
    end, ...)
end)

RegisterNetEvent('DWASCore:Client:TriggerCallback', function(name, ...)
    if DWASCore.ServerCallbacks[name] then
        DWASCore.ServerCallbacks[name](...)
        DWASCore.ServerCallbacks[name] = nil
    end
end)

-- Me command
local function Draw3DText(coords, str)
    local onScreen, worldX, worldY = World3dToScreen2d(coords.x, coords.y, coords.z)
    local camCoords = GetGameplayCamCoord()
    local scale = 200 / (GetGameplayCamFov() * #(camCoords - coords))
    if onScreen then
        SetTextScale(1.0, 0.5 * scale)
        SetTextFont(4)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextProportional(true)
        SetTextOutline()
        SetTextCentre(true)
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(str)
        EndTextCommandDisplayText(worldX, worldY)
    end
end

AddStateBagChangeHandler('me', nil, function(bagName, _, value)
    if not value then return end
    local playerId = GetPlayerFromStateBagName(bagName)
    if not playerId or not NetworkIsPlayerActive(playerId) then return end

    local isLocalPlayer = playerId == cache.playerId
    local playerPed = isLocalPlayer and cache.ped or GetPlayerPed(playerId)
    if not DoesEntityExist(playerPed) then return end
    if not isLocalPlayer and #(GetEntityCoords(playerPed) - GetEntityCoords(cache.ped)) > 25 then return end

    CreateThread(function()
        local displayTime = 5000 + GetGameTimer()
        while displayTime > GetGameTimer() do
            playerPed = isLocalPlayer and cache.ped or GetPlayerPed(playerId)
            Draw3DText(GetEntityCoords(playerPed), value)
            Wait(0)
        end
    end)
end)

-- Listen to Shared being updated
RegisterNetEvent('DWASCore:Client:OnSharedUpdate', function(tableName, key, value)
    DWASCore.Shared[tableName][key] = value
    TriggerEvent('DWASCore:Client:UpdateObject')
end)

RegisterNetEvent('DWASCore:Client:OnSharedUpdateMultiple', function(tableName, values)
    for key, value in pairs(values) do
        DWASCore.Shared[tableName][key] = value
    end
    TriggerEvent('DWASCore:Client:UpdateObject')
end)

