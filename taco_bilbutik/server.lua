RegisterCommand("buycar", function(source, args)
    local plate = args[1]
    local dataVehicle = GetVehicle(plate)
    if dataVehicle then
        MySQL.Async.insert('DELETE FROM bilbutik WHERE plate = ?', {
            plate
        }, function(id)
            TriggerClientEvent("taco_bilbutik:buycarspawn", source, dataVehicle, plate)
        end)
    else
        print("findes ikke!")
    end
end, false)

RegisterCommand("carlist", function(source)
    local vehicles = GetAllVehicle()
    TriggerClientEvent("taco_bilbutik:sendlist", source, vehicles)
end, false)

RegisterNetEvent("taco_bilbutik:sellcar")
AddEventHandler("taco_bilbutik:sellcar", function(vehicle, plate, price)
    local source = source
    MySQL.Async.insert('INSERT INTO `bilbutik` (vehicle, plate, price) VALUES (?, ?, ?)', {
        vehicle, plate, price
    }, function(id)
        TriggerClientEvent('taco_bilbutik:sellcar:success', source, price)
    end)
end)

function GetAllVehicle()
    local results = MySQL.Sync.fetchAll('SELECT * FROM `bilbutik`', {})
    if results[1] then
        return results
    end
end


function GetVehicle(plate)
    local response = MySQL.Sync.fetchAll('SELECT * FROM `bilbutik` WHERE `plate` = ?', {
        plate
    })
    if response[1] then
        return response[1]
    end
end