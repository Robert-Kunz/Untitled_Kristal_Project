---@class ActionBoxDisplay : Object
local ActionBoxDisplay, super = HookSystem.hookScript(ActionBoxDisplay)


function ActionBoxDisplay:draw()
    if (EverParty:getRowCheckSize() <= 3) then
        super.draw(self)
        return
    end
    if Game.battle.current_selecting == self.actbox.index then
        Draw.setColor(self.actbox.battler.chara:getColor())
    else
        Draw.setColor(PALETTE["action_strip"], 1)
    end

    local box_size = self.actbox.box_scale
    -- if (not EverParty:isWideStyle()) then
    --     box_size = (Game.battle.current_selecting ~= self.actbox.index) and 1 or 1
    -- end
    if (box_size == 0) then
        box_size = 1
    end
    --love.graphics.print(box_size, 0, -100)
    if (box_size == 1) and (EverParty:isWideStyle()) then
        super.draw(self)
        return
    end

    local linestart = (EverParty:isWideStyle() and (self.actbox.index % EverParty:getRowCheckSize()) > 0 and EverParty:getRowCheckSize() > 3 and Game.battle.current_selecting ~= self.actbox.index) and 2 or 0
    love.graphics.setLineWidth(2)
    love.graphics.line(linestart  , Game:getConfig("oldUIPositions") and 2 or 1, 213 * box_size, Game:getConfig("oldUIPositions") and 2 or 1)

    love.graphics.setLineWidth(2)
    if Game.battle.current_selecting == self.actbox.index then
        love.graphics.line(1  , 2, 1,   36)
        love.graphics.line(212 * box_size, 2, 212 * box_size, 36)
    elseif not EverParty:isWideStyle() then
        love.graphics.line(1  , 2, 1,   36)
        love.graphics.line(212 * box_size, 2, 212 * box_size, 36)
    end

    Draw.setColor(PALETTE["action_fill"])
    love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, 208 * box_size, Game:getConfig("oldUIPositions") and 34 or 35)

    if (not EverParty:isWideStyle()) and Game.battle.current_selecting ~= self.actbox.index then
        self:drawAdditional()
        super.super.draw(self)
        return
    end

    Draw.setColor(PALETTE["action_health_bg"])
    love.graphics.rectangle("fill", 128 * box_size, 22 - self.actbox.data_offset, 76 * box_size, 9)

    local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 76

    if health > 0 then
        Draw.setColor(self.actbox.battler.chara:getColor())
        love.graphics.rectangle("fill", 128 * box_size, 22 - self.actbox.data_offset, math.ceil(health) * box_size, 9)
    end


    local color = PALETTE["action_health_text"]
    if health <= 0 then
        color = PALETTE["action_health_text_down"]
    elseif (self.actbox.battler.chara:getHealth() <= (self.actbox.battler.chara:getStat("health") / 4)) then
        color = PALETTE["action_health_text_low"]
    else
        color = PALETTE["action_health_text"]
    end


    local health_offset = 0
    health_offset = (#tostring(self.actbox.battler.chara:getHealth()) - 1) * 8

    Draw.setColor(color)
    love.graphics.setFont(self.font)
    love.graphics.print(self.actbox.battler.chara:getHealth(), 152 * box_size - health_offset, 9 - self.actbox.data_offset)
    Draw.setColor(PALETTE["action_health_text"])
    love.graphics.print("/", 161 * box_size, 9 - self.actbox.data_offset)
    local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
    Draw.setColor(color)
    love.graphics.print(self.actbox.battler.chara:getStat("health"), (205 * box_size) - string_width, 9 - self.actbox.data_offset)

    self:drawAdditional()

    super.super.draw(self)
end

--Note:
--This method is meant to be hooked!! Specifically for custom actionbox info.
function ActionBoxDisplay:drawAdditional()
end

return ActionBoxDisplay