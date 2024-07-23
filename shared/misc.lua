if not DevJacobLib then DevJacobLib = {} end

function DevJacobLib.Ternary(condition, trueValue, falseValue)
    if condition then
        return trueValue
    else
        return falseValue
    end
end