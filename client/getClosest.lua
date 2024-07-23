if not DevJacobLib then DevJacobLib = {} end

function DevJacobLib.GetClosestVehicle(coords, maxDistance, includePlayerVehicle)
	local vehicles = GetGamePool("CVehicle")
	local closestVehicle, closestCoords
	local origMax = maxDistance
	maxDistance = maxDistance or 2.0
    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	for i = 1, #vehicles do
		local vehicle = vehicles[i]

		if not currentVehicle or vehicle ~= currentVehicle or includePlayerVehicle then
			local vehicleCoords = GetEntityCoords(vehicle)
			local distance = #(coords - vehicleCoords)

			if distance < maxDistance then
				maxDistance = distance
				closestVehicle = vehicle
				closestCoords = vehicleCoords
			end
		end
	end

	return closestVehicle, closestCoords
end