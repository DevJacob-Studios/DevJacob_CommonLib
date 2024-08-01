DevJacobLib = {
	_CurrentResource = GetCurrentResourceName()
}

--------------------
-- Shared | Start --
--------------------
DevJacobLib.Logger = {
	Debug = function(message, ...)
		print(("[%s] DEBUG: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
	end,
	
	DebugIf = function(condition, message, ...)
		if condition == true then
			print(("[%s] DEBUG: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
		end
	end,
	
	Info = function(message, ...)
		print(("[%s] INFO: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
	end,
	
	InfoIf = function(condition, message, ...)
		if condition == true then
			print(("[%s] INFO: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
		end
	end,
	
	Warn = function(message, ...)
		print(("[%s] WARN: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
	end,
	
	WarnIf = function(condition, message, ...)
		if condition == true then
			print(("[%s] WARN: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
		end
	end,
	
	Error = function(message, ...)
		print(("[%s] ERROR: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
	end,
	
	ErrorIf = function(condition, message, ...)
		if condition == true then
			print(("[%s] ERROR: %s"):format(DevJacobLib._CurrentResource or "unknown", message, ...))
		end
	end,
}

DevJacobLib.Table = {
	ArrayContainsValue = function(table, value)
		for i = 1, #table do
			if table[i] == value then
				return true
			end
		end
	
		return false
	end,

	ContainsValue = function(table, value)
		for _, v in pairs(table) do
			if v == value then
				return true
			end
		end

		return false
	end,

	ContainsKey = function(table, key)
		return table[key] ~= nil
	end,
}

DevJacobLib.Math = {
	Round = function(num, numDecimalPlaces)
		return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
	end,

	IsNaN = function(value)
		return value ~= value
	end,

	Lerp = function(a, b, t)
		return a + (b - a) * t
	end,
}

function DevJacobLib.Ternary(condition, trueValue, falseValue)
    if condition then
        return trueValue
    else
        return falseValue
    end
end
--------------------
-- Shared | End --
--------------------

-- Server side version of the "GetGamePool" client side native
function DevJacobLib.GetGamePool(poolName)
	local poolNatives = {
		CPed = GetAllPeds,
		CObject = GetAllObjects,
		CVehicle = GetAllVehicles,
	}

	local fn = poolNatives[poolName]
	return fn and fn()
end

-- Server side version of the "GetPlayers" client side native
function DevJacobLib.GetActivePlayers()
	local playerNum = GetNumPlayerIndices()
	local players = table.create(playerNum, 0)

	for i = 1, playerNum do
		players[i] = tonumber(GetPlayerFromIndex(i - 1))
	end

	return players
end

function DevJacobLib.GetNearbyObjects(coords, maxDistance)
	local objects = DevJacob.GetGamePool("CObject")
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
	local peds = DevJacob.GetGamePool("CPed")
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
	local players = DevJacob.GetActivePlayers()
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
	local vehicles = DevJacob.GetGamePool('CVehicle')
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