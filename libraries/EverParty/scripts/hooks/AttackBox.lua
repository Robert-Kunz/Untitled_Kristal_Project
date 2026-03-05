--- HOOK EXPLANATION:
--- This is solely for fixing attackbox positioning with more than 3 party members.

local AttackBox, super = HookSystem.hookScript(AttackBox)

function AttackBox:init(...)
    super.init(self, ...)
    if #Game.battle.party > 3 then
        self.y = 40 + (38 / math.ceil(#Game.battle.party / 3) * (self.index - 1))
        self.bolt.height = self.bolt.height / math.ceil(#Game.battle.party / 3)
    end
end

--- very unfortunately, I have to overwrite this function to change the size of the AttackBox rectangle. If Kristal makes it more accessible this hook is going byebye tho.
function AttackBox:draw()
    if (#Game.battle.party <= 3) then
        super.draw(self)
        return
    end
    local target_color = { self.battler.chara:getAttackBarColor() }
    local box_color = { self.battler.chara:getAttackBoxColor() }

    if self.flash > 0 then
        box_color = ColorUtils.mergeColor(box_color, { 1, 1, 1 }, self.flash)
    end

    love.graphics.setLineWidth(2)
    love.graphics.setLineStyle("rough")

    local ch1_offset = Game:getConfig("oldUIPositions")

    Draw.setColor(box_color)
    love.graphics.rectangle("line", 80, ch1_offset and 0 or 1, (15 * 8) + 3, (ch1_offset and 37 or 36) / math.ceil(#Game.battle.party / 3))

    Draw.setColor(target_color)
    love.graphics.rectangle("line", 83, 1, 8, 36 / math.ceil(#Game.battle.party / 3))
    Draw.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 84, 2, 6, 34 / math.ceil(#Game.battle.party / 3))

    love.graphics.setLineWidth(1)

    super.super.draw(self)
end

return AttackBox