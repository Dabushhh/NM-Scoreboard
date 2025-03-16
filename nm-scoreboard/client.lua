local NMCore = exports['nm-core']:GetCoreObject()

local function updateScoreboard()
    local players = GetActivePlayers()
    local playerData = {}
    local jobCounts = { police = 0, ems = 0, tuner = 0 }

    for _, playerId in ipairs(players) do
        local player = NMCore.Functions.GetPlayerData()
        if player and player.charinfo then
        table.insert(playerData, {
                name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname,
                id = GetPlayerServerId(playerId),
                job = player.job.label
            })

            if player.job.name == 'police' then
                jobCounts.police = jobCounts.police + 1
            elseif player.job.name == 'ambulance' then
                jobCounts.ems = jobCounts.ems + 1
            elseif player.job.name == 'tuner' then
                jobCounts.tuner = jobCounts.tuner + 1
            end
        end
    end

    SendNUIMessage({
        action = "updateScoreboard",
        players = playerData,
        totalPlayers = #players,
        jobs = jobCounts
    })
end

RegisterCommand('toggleScoreboard', function()
    SendNUIMessage({ action = "toggleScoreboard" })
end, false)

RegisterKeyMapping('toggleScoreboard', 'Toggle Scoreboard', 'keyboard', 'PAGEUP')

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) 
        updateScoreboard()
    end
end)