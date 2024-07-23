DevJacobLib = {}

exports("getLibObject", function(currentResource)
    currentResource = currentResource or GetCurrentResourceName()

    local newLibObject = DevJacobLib
    newLibObject.Logger._CurrentResource = currentResource

	return newLibObject
end)