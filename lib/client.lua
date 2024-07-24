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

function DevJacobLib.DrawText3DThisFrame(drawOptions)
    -- Validate the draw options
    if drawOptions.coords == nil then error("Missing options field \"coords\", it must be a valid vector3 object!", 2) end
    local coords = drawOptions.coords

    if drawOptions.text == nil or drawOptions.text == "" then error("Missing options field \"text\", it must be a valid string!", 2) end
    local text = drawOptions.text
    
    local colour = drawOptions.colour or { r = 255, g = 255, b = 255, a = 215 }
    local scale = drawOptions.scale or 0.35
    local drawBackground = drawOptions.drawBackground or true
    local outline = drawOptions.outline or false
    local font = drawOptions.font or 4

    -- Get the location on the screen to draw to
    local _, screenX, screenY = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)

    -- Set the scale and font
    SetTextScale(scale, scale)
    SetTextFont(font)

    -- Set the text decor
    if outline == true then
        SetTextOutline()
    end

    SetTextColour(colour.r, colour.g, colour.b, colour.a)
    BeginTextCommandDisplayText("STRING")
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(screenX, screenY)

    if drawBackground == true then
        DrawRect(screenX, screenY + 0.0125, string.len(text) / 300, 0.03, 41, 11, 41, 68)
    end
end

function DevJacobLib.DrawText2DThisFrame(drawOptions)
    -- Validate the draw options
    if drawOptions.coords == nil then error("Missing options field \"coords\", it must be a valid vector3 or vector2 object!", 2) end
    local coords = drawOptions.coords

    if drawOptions.text == nil or drawOptions.text == "" then error("Missing options field \"text\", it must be a valid string!", 2) end
    local text = drawOptions.text
    
    local colour = drawOptions.colour or { r = 255, g = 255, b = 255, a = 215 }
    local scale = drawOptions.scale or 0.35
    local outline = drawOptions.outline or false
    local font = drawOptions.font or 4
    local alignment = drawOptions.alignment or 1

    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour.r, colour.g, colour.b, colour.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    if outline == true then SetTextOutline() end

    if alignment == 0 or alignment == 2 then
        SetTextJustification(alignment)

        if alignment == 2 then
            SetTextWrap(0, coords.x)
        end
    end 

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(coords.x, coords.y)
end

function DevJacobLib.DrawHelpTextThisFrame(text) 
    BeginTextCommandDisplayHelp("CELL_EMAIL_BCON")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, false, -1)
end

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