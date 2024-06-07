--------------------------------------
------Created By Whit3Xlightning------
--https://github.com/Whit3XLightning--
--------------------------------------

local isAutoDVActive = false

RegisterCommand(Config.commandName, function(source, args, rawCommand, user)
    if isAutoDVActive then
        TriggerClientEvent('chatMessage', source, "^*^1 An automatic mass vehicle deletion is already in progress.")
        return
    end

    isAutoDVActive = true
    TriggerClientEvent('chatMessage', -1, "^*^1 Manual MASS DV, PLEASE GET INTO YOUR VEHICLES! (^3 30 SECONDS ^1)")
    Wait(15000)
    
    if not isAutoDVActive then return end
    TriggerClientEvent('chatMessage', -1, "^*^1 A MASS DV IS INCOMING, GET INTO YOUR VEHICLES! (^3 15 SECONDS ^1)")
    Wait(15000) 

    if not isAutoDVActive then return end
    TriggerClientEvent('chatMessage', -1, "^*^5 Manual MASS DV COMPLETE!")
    Wait(1)
    TriggerClientEvent("wld:delallveh", -1)
    isAutoDVActive = false
end, Config.restricCommand)

RegisterCommand(Config.cancelCommandName, function(source, args, rawCommand, user)
    if isAutoDVActive then
        isAutoDVActive = false
        TriggerClientEvent('chatMessage', -1, "^9 SYSTEM: ^*^1 Mass DV has been cancelled.")
    else
        TriggerClientEvent('chatMessage', source, "^1SYSTEM: ^*^1 There is no automatic mass vehicle deletion in progress.")
    end
end, Config.restricCommand)

local delay = 1000 * 60 * 30 -- just edit this to your needed delay (30 minutes in this example)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(delay)
        if not isAutoDVActive then
            isAutoDVActive = true
            TriggerClientEvent('chatMessage', -1, "^*^1 MASS DV, PLEASE GET INTO YOUR VEHICLES! (^3 30 SECONDS ^1)")
            Wait(15000)
            
            if not isAutoDVActive then goto continue end
            TriggerClientEvent('chatMessage', -1, "^*^1 MASS DV, PLEASE GET INTO YOUR VEHICLES! (^3 15 SECONDS ^1)")
            Wait(15000) 
            
            if not isAutoDVActive then goto continue end
            TriggerClientEvent('chatMessage', -1, "^*^5 MASS DV COMPLETE!")
            Wait(1)
            TriggerClientEvent("wld:delallvehauto", -1)
            isAutoDVActive = false
        end
        ::continue::
    end
end)
