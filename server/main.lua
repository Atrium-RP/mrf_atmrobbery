local QBCore = exports[Config.Core]:GetCoreObject()
local currentRobber = nil
RegisterServerEvent("mrf_atmrobbery:server:getReward")
AddEventHandler("mrf_atmrobbery:server:getReward", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local Chance = math.random(1, 10)--Config.RewardChance
    local Amount = 1

    local info = {
        worth = math.random(1290, 1400)--Config.Cash
    }

    if Config.Markedbills then
        if Chance == Amount then
            Player.Functions.AddItem(Config.RewardItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RewardItem], 'add', 1)
            Player.Functions.AddItem(Config.MoneyItem, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.MoneyItem], "add")
            TriggerClientEvent("QBCore:Notify", src, "Vous avez obtenu " .. info.worth .. ' $', "success")
        else
            Player.Functions.AddItem(Config.MoneyItem, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.MoneyItem], "add")
            TriggerClientEvent("QBCore:Notify", src, "Vous avez obtenu " .. info.worth .. ' $', "success")
        end
    else
        if Chance == Amount then
            Player.Functions.AddItem(Config.RewardItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RewardItem], 'add', 1)
            Player.Functions.AddMoney('cash', info.worth, 'ATM Cash')
            TriggerClientEvent("QBCore:Notify", src, "Vous avez obtenu " .. info.worth .. ' $', "success")
        else
            Player.Functions.AddMoney('cash', info.worth, 'ATM Cash')
            TriggerClientEvent("QBCore:Notify", src, "Vous avez obtenu " .. info.worth .. ' $', "success")
        end
    end
end)

RegisterServerEvent("mrf_atmrobbery:server:spawnRope")
AddEventHandler("mrf_atmrobbery:server:spawnRope", function()
    TriggerClientEvent("mrf_atmrobbery:client:spawnRope", -1)
end)

RegisterServerEvent("mrf_atmrobbery:server:attachVehicle")
AddEventHandler("mrf_atmrobbery:server:attachVehicle", function(NetworkVehicle, NetworkPlayerPed)
    TriggerClientEvent("mrf_atmrobbery:client:attachVehicle", -1, NetworkVehicle, NetworkPlayerPed)
end)

RegisterServerEvent("mrf_atmrobbery:server:attachATM")
AddEventHandler("mrf_atmrobbery:server:attachATM", function(ATMObjectProp, ObjectCoordsx, ObjectCoordsy, ObjectCoordsz, NetworkVehicle, NetObjectConsole)
    TriggerClientEvent("mrf_atmrobbery:client:attachATM", -1, ATMObjectProp, ObjectCoordsx, ObjectCoordsy, ObjectCoordsz, NetworkVehicle, NetObjectConsole)
end)

RegisterServerEvent("mrf_atmrobbery:server:spawnATM")
AddEventHandler("mrf_atmrobbery:server:spawnATM", function(NetObjectConsole)
    TriggerClientEvent("mrf_atmrobbery:client:spawnATM", -1, NetObjectConsole)
end)

RegisterServerEvent("mrf_atmrobbery:server:deleteATM")
AddEventHandler("mrf_atmrobbery:server:deleteATM", function(NetConsoleProp)
    TriggerClientEvent("mrf_atmrobbery:client:deleteATM", -1, NetConsoleProp)
end)

RegisterServerEvent("mrf_atmrobbery:server:deleteRopeProp")
AddEventHandler("mrf_atmrobbery:server:deleteRopeProp", function(Rope)
    TriggerClientEvent("mrf_atmrobbery:client:deleteRopeProp", -1, Rope)
    currentRobber = nil
end)

QBCore.Functions.CreateUseableItem(Config.RequiredItem, function(source, item)
    local src = source
    if currentRobber ~= nil then TriggerClientEvent("QBCore:Notify", src, "Les ATMs ont été vérrouillés, veuillez essayer à nouveau!", "error", 7000) return end
    currentRobber = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent("mrf_atmrobbery:client:ropeUsed", src)
end)

RegisterServerEvent("mrf_atmrobbery:server:RemoveItem")
AddEventHandler("mrf_atmrobbery:server:RemoveItem", function(Rope)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(Config.RequiredItem, 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RequiredItem], "remove")
	end
end)

RegisterServerEvent("mrf_atmrobbery:server:addRopeItem")
AddEventHandler("mrf_atmrobbery:server:addRopeItem", function(Rope)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.AddItem(Config.RequiredItem, 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RequiredItem], "add")
	end
end)