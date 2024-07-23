if not DevJacobLib then DevJacobLib = {} end
DevJacobLib.Table = {}

function DevJacobLib.Table.ArrayContainsValue(table, value)
    for i = 1, #table do
        if table[i] == value then
            return true
        end
    end

    return false
end

function DevJacobLib.Table.ContainsValue(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end

    return false
end

function DevJacobLib.Table.ContainsKey(table, key)
    return table[key] ~= nil
end