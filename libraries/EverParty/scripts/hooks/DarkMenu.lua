---HOOK EXPLANATION
---This hook ensures selections scroll overworld box rows.

---@class DarkMenu : Object
local DarkMenu, super = HookSystem.hookScript(DarkMenu)

function DarkMenu:updateSelectedBoxes()
    if #Game.party < 4 then return end

    local row = EverParty.overworld_row
    local selected_row = math.floor((self.selected_party-1) / 3)
    if (selected_row ~= row) then
        EverParty.overworld_row = selected_row
        if Game.world and Game.world.healthbar then
            Game.world.healthbar:updateRow()
        end
    end
    super.updateSelectedBoxes(self)
end

return DarkMenu