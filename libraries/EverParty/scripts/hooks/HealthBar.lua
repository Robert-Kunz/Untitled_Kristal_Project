---HOOK EXPLANATION
---This hook is to allow for the overworld health bar to have a larger party. It's a little scuffed.

---@class HealthBar : Object
local HealthBar, super = HookSystem.hookScript(HealthBar)

function HealthBar:init()
    super.init(self)
    self.current_row = EverParty.overworld_row
    for i, box in ipairs(self.action_boxes) do
        
        local x_pos = ((i-1) % 3) * 213
        local row = math.floor((i-1) / 3)
        local row_size = MathUtils.clamp(#Game.party - (row * 3), 1, 3)

        if row_size == 2 then
            if Game:getConfig("oldUIPositions") then
                if ((i-1) % 3) + 1 == 1 then
                    x_pos = 105
                else
                    x_pos = 325
                end
            else
                if ((i-1) % 3) + 1 == 1 then
                    x_pos = 108
                else
                    x_pos = 322
                end
            end
        elseif row_size == 1 then
            x_pos = 213
        end

        box:setPosition(x_pos, box.y) -- -35 * row)
        box.visible = (EverParty.overworld_row == row)
        

    end
end

--todo: animate swap
function HealthBar:updateRow()
    if (self.current_row ~= EverParty.overworld_row) then
        for i, box in ipairs(self.action_boxes) do
            local row = math.floor((i-1) / 3)
            box.visible = (EverParty.overworld_row == row)
        end
    end
    self.current_row = EverParty.overworld_row
end

function HealthBar:draw()
    super.draw(self)
    local overworld_rows = math.ceil(#Game.party / 3)
    if (overworld_rows < 2) then
        return
    end
    local has_left = self.current_row >= 1
    local has_right = self.current_row < overworld_rows-1
    Draw.setColor(1,1,1,0.5)
    if (has_left) then
        Draw.setColor(1,1,1,1)
    end
    Draw.draw(Assets.getTexture("ui/page_arrow_left"), 10, 40)
    Draw.setColor(1,1,1,0.5)
    if (has_right) then
        Draw.setColor(1,1,1,1)
    end
    Draw.draw(Assets.getTexture("ui/page_arrow_right"), SCREEN_WIDTH - 16 - 10, 40)
end

return HealthBar