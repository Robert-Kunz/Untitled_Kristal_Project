--- HOOK EXPLANATION:
--- This ensures that party battlers actually have unique positions beyond the third index. This WILL be broken by overwrites to getPartyPosition, but since that's always custom logic you can just copy this
--- yourself (or position them manually, which is what you'd usually be doing with an overwrite of this function anyways).

---@class Encounter : Class
local Encounter, super = HookSystem.hookScript(Encounter)

function Encounter:getPartyPosition(index)
    local x, y = super.getPartyPosition(self, ((index - 1) % 3) + 1)
    local cramped = EverParty:getConfig("ui_style") == "BATTLECARD"
    local column_size = cramped and #Game.party or 3
    local battler = Game.battle.party[index]
    local ox, oy = battler.chara:getBattleOffset()
    --scuffed code duplication but i refuse to overwrite anything if i can help it
    if #Game.battle.party >= 3 then
        local modifier = cramped and (index-1) or ((index - 1) % 3)
        x = 80 + (cramped and (-5 * index) or 0)
        y = (cramped and -20 or 50) + ((80 * modifier) / (cramped and math.max(1, #Game.battle.party/4) or 1))
        x = x + (battler.actor:getWidth() / 2 + ox) * 2
        y = y + (battler.actor:getHeight() + oy) * 2
    end
    if (EverParty:getRowCheckSize() == 2) and not cramped then
        x = 80
        y = (80 * (((index - 1) % 2) + 1))
        column_size = 2

        x = x + (battler.actor:getWidth() / 2 + ox) * 2
        y = y + (battler.actor:getHeight() + oy) * 2
    end
    if (index <= column_size) then return x, y end
    local offset_count = math.ceil((index / column_size)) - 1
    --Kristal.Console:log(offset_count)
    x = x + (60 * offset_count)
    y = y - (20 * ((offset_count % 2)))
    return x, y
end

---@return string context The context of the battle. Defaults to GENERIC.
function Encounter:getChatContext()
    return "GENERIC"
end

return Encounter