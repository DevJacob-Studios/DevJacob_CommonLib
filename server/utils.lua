if not DevJacobLib then DevJacobLib = {} end
DevJacobLib.Utils = {}

-- Server side version of the "GetGamePool" client side native
function DevJacobLib.Utils.GetGamePool(poolName)
    local poolNatives = {
        CPed = GetAllPeds,
        CObject = GetAllObjects,
        CVehicle = GetAllVehicles,
    }

    local fn = poolNatives[poolName]
    return fn and fn()
end

-- Server side version of the "GetPlayers" client side native
function DevJacobLib.Utils.GetActivePlayers()
    local playerNum = GetNumPlayerIndices()
    local players = table.create(playerNum, 0)

    for i = 1, playerNum do
        players[i] = tonumber(GetPlayerFromIndex(i - 1))
    end

    return players
end