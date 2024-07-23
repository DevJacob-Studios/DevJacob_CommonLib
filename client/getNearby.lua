if not DevJacobLib then DevJacobLib = {} end

function DevJacobLib.GetNearbyVehicles(coords, maxDistance, includePlayerVehicle)
	local vehicles = GetGamePool("CVehicle")
	local nearby = {}
	local count = 0
	maxDistance = maxDistance or 2.0
    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	for i = 1, #vehicles do
		local vehicle = vehicles[i]

		if not currentVehicle or vehicle ~= currentVehicle or includePlayerVehicle then
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
	end

	return nearby
end