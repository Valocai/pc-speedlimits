local display = false

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
            if speedLimit then
                if Config.Settings.kmh then
                    speedLimit = speedLimit * 1.609344
                end
            else
                speedLimit = 0
            end
            local currentTime = GetGameTimer()
            if Config.Settings.keepon == true then
                display = true
                lastToggleTime = currentTime
            elseif Config.Settings.keepon == fasle then
                dispaly = false
                lastToggleTime = currentTime
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