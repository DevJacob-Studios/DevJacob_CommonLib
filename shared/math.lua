if not DevJacobLib then DevJacobLib = {} end
DevJacobLib.Math = {}

function DevJacobLib.Math.Round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function DevJacobLib.Math.IsNaN(value)
    return value ~= value
end