local Encounter, super = HookSystem.hookScript(Encounter)

function Encounter:createSoul(x, y, color)
    if Game:getFlag("DashSoul", false) then
        return DashSoul(x, y, color)
    else
        return Soul(x, y, color)
    end
end

return Encounter
