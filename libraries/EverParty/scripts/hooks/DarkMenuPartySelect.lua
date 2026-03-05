---HOOK EXPLANATION
---This is for the 'roulette' head selection in the party menu

---@class DarkMenuPartySelect : Object
local DarkMenuPartySelect, super = HookSystem.hookScript(DarkMenuPartySelect)

function DarkMenuPartySelect:init(x, y)
    self.current_row = 0
    self.previous_row = 0
    self.previous_selected = 1
    self.spinning = 0
    super.init(self, x, y)
end


function DarkMenuPartySelect:updateSelectedParty()
    super.updateSelectedParty(self)
    local old_row = math.floor((self.previous_selected-1) / 3)
    local new_row = math.floor((self.selected_party-1) / 3)
    if (old_row ~= new_row) and (new_row ~= self.current_row) then
        --Kristal.Console:log("old " .. old_row .. " new " .. new_row)

        self.spinning = 8
        self.previous_row = self.current_row
        self.current_row = new_row
        self.just_wrapped = math.abs(new_row - old_row) > 1

        Assets.stopAndPlaySound("wing")

        EverParty.overworld_row = self.current_row
        if (Game.world and Game.world.healthbar) then
            Game.world.healthbar:updateRow()
        end
    end
    self.previous_selected = self.selected_party
end

function DarkMenuPartySelect:update()
    self.spinning = MathUtils.approach(self.spinning, 0, DTMULT)
    if self.focused then
        local old_selected = self.selected_party
        if Input.pressed("down") then
            self.selected_party = math.max(self.selected_party - 3, -1)
        elseif Input.pressed("up") then
            self.selected_party = math.min(self.selected_party + 3, #Game.party + 1)
        end
        self:updateSelectedParty()
        if old_selected ~= self.selected_party then
            Assets.stopAndPlaySound("ui_move")
            if self.on_select then
                self.on_select(self.selected_party, old_selected)
            end
        end
    end
    super.update(self)
end

function DarkMenuPartySelect:draw()
    if (#Game.party < 3) then super.draw(self)
    else
        local current_ease = Utils.ease(0, 1, (8 - self.spinning) / 8, "out-cubic")
        local overshoot_ease = Utils.ease(0, 1, current_ease, "in-back")
        for i,party in ipairs(Game.party) do
            local my_row = math.floor((i-1) / 3)
            if my_row == self.current_row then
                if self.selected_party ~= i then
                    Draw.setColor(1, 1, 1, 0.4)
                else
                    Draw.setColor(1, 1, 1, 1)
                end
                local ox, oy = party:getMenuIconOffset()
                local y_offset = ((self.just_wrapped and ((self.current_row == 0) and 1 or -1) or (self.current_row - self.previous_row)) > 0 and -25 or 25) * (1 - overshoot_ease) --((self.spinning / 8))
                Draw.draw(Assets.getTexture(party:getMenuIcon()), ((i-1)%3)*50 + (ox*2), (oy*2) + y_offset, 0, 2 * current_ease, 2 * current_ease)
                --debug
                --love.graphics.print(my_row, ((i-1)%3)*50 + (ox*2), (oy*2) + y_offset)
            elseif math.abs(my_row - self.current_row) <= 1 then
                Draw.setColor(1, 1, 1, 0.25)
                local ox, oy = party:getMenuIconOffset()
                local y_offset = ((my_row - self.current_row) > 0 and -25 or 35) * (current_ease)
                local scale_offset = 0
                if (self:wasRowVisible(my_row) and (MathUtils.sign(my_row - self.current_row) == MathUtils.sign(my_row - self.previous_row) or my_row == self.previous_row)) then
                    --local overshoot_ease = Utils.ease(0, 1, ((-math.abs(6-self.spinning) / 8) + 1), "out-cubic")
                    y_offset = y_offset + ((my_row - self.current_row) > 0 and -25 or 25) * (1- overshoot_ease) --((-math.abs(6-self.spinning) / 8) + 1)
                    scale_offset =  1 * (1- current_ease) --(self.spinning/8)
                else 
                    --y_offset = 0 -- y_offset * ((my_row - self.current_row) > self.current_row and -25 or 25) * (1- current_ease) --((self.spinning / 8))
                    scale_offset = -1 *  (1- current_ease) --(self.spinning / 8)
                end
                Draw.draw(Assets.getTexture(party:getMenuIcon()), ((i-1)%3)*50 + (ox*2), (oy*2) + y_offset, 0, 1 + scale_offset, 1 + scale_offset)
                --love.graphics.print(my_row, ((i-1)%3)*50 + (ox*2), (oy*2) + y_offset)
            end

        end
        --debug
        --love.graphics.print(self.current_row)
        --love.graphics.print(self.previous_row, 0, 10)
        if self.focused then
            local frames = Assets.getFrames("player/heart_harrows")
            Draw.setColor(Game:getSoulColor())
            Draw.draw(frames[(math.floor(self.heart_siner/20)-1)%#frames+1], ((self.selected_party-1)%3)*50 + 10, -18)
        end
    end
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
    Draw.draw(Assets.getTexture("ui/page_arrow_up"), -16, -20)
    Draw.setColor(1,1,1,0.5)
    if (has_right) then
        Draw.setColor(1,1,1,1)
    end
    Draw.draw(Assets.getTexture("ui/page_arrow_down"), -16, 20)
end

---@return boolean
function DarkMenuPartySelect:wasRowVisible(row)
    return math.abs(row - self.previous_row) <= 1
end

return DarkMenuPartySelect