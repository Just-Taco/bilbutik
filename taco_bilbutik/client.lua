RegisterCommand("sellcar", function(source, args)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    local price = args[1]
    print(price,vehicle)
    if vehicle then
        if price then
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent("taco_bilbutik:sellcar", model, plate, price)
        else
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"BilButik", "Du skal skrive en pris!"}
              })
        end
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"BilButik", "Du skal side i et køretøj!"}
          })
    end
end, false)


RegisterNetEvent("taco_bilbutik:sellcar:success")
AddEventHandler("taco_bilbutik:sellcar:success", function(price)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteEntity(vehicle)
    TriggerEvent('chat:addMessage', {
        color = { 0, 255, 0},
        multiline = true,
        args = {"BilButik", "Du solgte din bil for "..price.." ,- DKK"}
      })
end)

RegisterNetEvent("taco_bilbutik:buycarspawn")
AddEventHandler("taco_bilbutik:buycarspawn", function(dataVehicle, plate)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    print(table.unpack(coords))
    RequestModel(dataVehicle.vehicle) -- Request the model
    while not HasModelLoaded(dataVehicle.vehicle) do -- Waits for the model to load
        Wait(0)
    end
    local vehicle = CreateVehicle(dataVehicle.vehicle, coords, GetEntityHeading(ped), true, false)
    SetPedIntoVehicle(ped, vehicle, -1)
    SetVehicleNumberPlateText(vehicle, plate)
    TriggerEvent('chat:addMessage', {
        color = { 0, 255, 0},
        multiline = true,
        args = {"BilButik", "Du købte lige en "..dataVehicle.vehicle}
      })
end)

RegisterNetEvent("taco_bilbutik:sendlist")
AddEventHandler("taco_bilbutik:sendlist", function(vehicles)
    if vehicles then
        for k,v in ipairs(vehicles) do
            TriggerEvent('chat:addMessage', {
                color = { 0, 255, 255},
                multiline = true,
                args = {"BilButik", "\n Bil: "..v.vehicle.." \n Nummerplade: "..v.plate.. " \n Pris: "..v.price.." ,- DKK"}
            })
        end
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"BilButik", "Ingen køretøjer til salg!"}
        })
    end
end)