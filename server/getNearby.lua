if not DevJacobLib then DevJacobLib = {} end

function DevJacobLib.GetNearbyObjects(coords, maxDistance)
	local objects = DevJacob.Utils.GetGamePool("CObject")
	local nearby = {}
	local count = 0
	maxDistance = maxDistance or 2.0

	for i = 1, #objects do
		local object = objects[i]

        local objectCoords = GetEntityCoords(object)
        local distance = #(coords - objectCoords)

        if distance < maxDistance then
            count += 1
            nearby[count] = {
                object = object,
                coords = objectCoords
            }
        end
	end

	return nearby
end

function DevJacobLib.GetNearbyPeds(coords, maxDistance)
    local peds = DevJacob.Utils.GetGamePool("CPed")
    local nearby = {}
    local count = 0
    maxDistance = maxDistance or 2.0

    for i = 1, #peds do
        local ped = peds[i]

        if not IsPedAPlayer(ped) then
            local pedCoords = GetEntityCoords(ped)
            local distance = #(coords - pedCoords)

            if distance < maxDistance then
                count += 1
                nearby[count] = {
                    ped = ped,
                    coords = pedCoords,
                }
            end
        end
    end

    return nearby
end

function DevJacobLib.GetNearbyPlayers(coords, maxDistance)
    local players = DevJacob.Utils.GetActivePlayers()
    local nearby = {}
    local count = 0
    maxDistance = maxDistance or 2.0

    for i = 1, #players do
        local playerId = players[i]
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(coords - playerCoords)

        if distance < maxDistance then
            count += 1
            nearby[count] = {
                id = playerId,
                ped = playerPed,
                coords = playerCoords,
            }
        end
    end

    return nearby
end

function DevJacobLib.GetNearbyVehicles(coords, maxDistance)
	local vehicles = DevJacob.Utils.GetGamePool('CVehicle')
	local nearby = {}
	local count = 0
	maxDistance = maxDistance or 2.0

	for i = 1, #vehicles do
		local vehicle = vehicles[i]
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = #(coords - vehicleCoords)

        if distance < maxDistance then
            count += 1
            nearby[count] = {
                vehicle = vehicle,
                coords = vehicleCoords
            }
        end
	end

	return nearby
end