local display = false
local lastToggleTime = 0.1
local toggleCooldown = 1000 -- 1 second cooldown
local speedThreshold = 15 -- Speed buffer to prevent flickering

CreateThread(function()
    while true do
        local sleep = 200
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if IsPedInVehicle(ped, veh, false) then
            sleep = 150
            local playerLocation = GetEntityCoords(ped)
            local streetHash = GetStreetNameAtCoord(playerLocation.x, playerLocation.y, playerLocation.z)
            street = GetStreetNameFromHashKey(streetHash)
            local speedLimit = Config.Speedlimit[street]
            local speed = GetEntitySpeed(veh) * 3.6 -- Convert to km/h

            local currentTime = GetGameTimer()
            if currentTime - lastToggleTime > toggleCooldown then
                if not display and speed > speedLimit + speedThreshold then
                    display = true
                    lastToggleTime = currentTime
                elseif display and speed < speedLimit - speedThreshold then
                    display = false
                    lastToggleTime = currentTime
                end
            end

            SendNUIMessage({
                type = "ui",
                display = display,
                speedLimit = speedLimit
            })
        else
            sleep = 1000
            if display then
                display = false
                SendNUIMessage({
                    type = "ui",
                    display = false,
                    speedLimit = 0
                })
            end
        end
        Wait(sleep)
    end
end)