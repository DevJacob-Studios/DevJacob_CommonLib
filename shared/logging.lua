if not DevJacobLib then DevJacobLib = {} end
DevJacobLib.Logger = {}
DevJacobLib.Logger._CurrentResource = GetCurrentResourceName()

function DevJacobLib.Logger.Debug(message, ...)
    print(("[%s] DEBUG: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
end

function DevJacobLib.Logger.DebugIf(condition, message, ...)
    if condition == true then
        print(("[%s] DEBUG: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
    end
end

function DevJacobLib.Logger.Info(message, ...)
    print(("[%s] INFO: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
end

function DevJacobLib.Logger.InfoIf(condition, message, ...)
    if condition == true then
        print(("[%s] INFO: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
    end
end

function DevJacobLib.Logger.Warn(message, ...)
    print(("[%s] WARN: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
end

function DevJacobLib.Logger.WarnIf(condition, message, ...)
    if condition == true then
        print(("[%s] WARN: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
    end
end

function DevJacobLib.Logger.Error(message, ...)
    print(("[%s] ERROR: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
end

function DevJacobLib.Logger.ErrorIf(condition, message, ...)
    if condition == true then
        print(("[%s] ERROR: %s"):format(DevJacobLib.Logger._CurrentResource or "unknown", message, ...))
    end
end