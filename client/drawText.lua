if not DevJacobLib then DevJacobLib = {} end

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