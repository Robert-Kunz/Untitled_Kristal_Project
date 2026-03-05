--- HOOK EXPLANATION:
--- This hook is just for aesthetics to have stacked boxes peek over the ones in front. Also relies on a method only on latest Kristal (as of writing this) so this just won't really do anything on older Kristal versions.

---@class ActionBox : Object
---@field box_scale number
---@field partial_head_sprite PartialSprite
local ActionBox, super = HookSystem.hookScript(ActionBox)

function ActionBox:init(x, y, index, battler)
    self.box_scale = EverParty:getActionBoxScale((index <= EverParty:getRowCheckSize()) and 0 or (math.floor((index-1)/EverParty:getRowCheckSize())))
    super.init(self, x, y, index, battler)
    if not (EverParty:isWideStyle()) then
        self.partial_head_sprite = PartialSprite(battler.chara:getHeadIcons().."/"..battler:getHeadIcon(), 0, 0)
        if not self.partial_head_sprite:getTexture() then
            self.partial_head_sprite:setSprite(battler.chara:getHeadIcons().."/head")
        end
        self.head_sprite:addChild(self.partial_head_sprite)
        self.partial_head_sprite:setColor(0.5, 0.5, 0.5, 1.0)
        return
    end
    self:adjustButtonsForScale()
    self.hp_sprite.x = self.hp_sprite.x * ((self.box_scale ~= 0) and self.box_scale or 1)
    if (self.box_scale > 0 and self.box_scale < 1) then
        self.hp_sprite.visible = false
    end
    self.head_sprite.x = self.head_sprite.x * ((self.box_scale ~= 0) and self.box_scale or 1)
    if (self.name_sprite) then
        self.name_sprite.x = self.name_sprite.x * ((self.box_scale ~= 0) and self.box_scale or 1) + 4
    end
    self.targeted_x = self.x
    self.has_set_x = false
    self.show_progress = 0
    self.original_x = x
    self.original_layer = self.layer
end

function ActionBox:setHeadIcon(icon)
    super.setHeadIcon(self, icon)

    if not self.partial_head_sprite then return end
    local full_icon = self.battler.chara:getHeadIcons().."/"..icon
    if self.partial_head_sprite:hasSprite(full_icon) then
        self.partial_head_sprite:setSprite(full_icon)
    else
        self.partial_head_sprite:setSprite(self.battler.chara:getHeadIcons().."/head")
    end
end

function ActionBox:resetHeadIcon()
    super.resetHeadIcon(self)
    if not self.partial_head_sprite then return end
    local full_icon = self.battler.chara:getHeadIcons().."/"..self.battler:getHeadIcon()
    if self.partial_head_sprite:hasSprite(full_icon) then
        self.partial_head_sprite:setSprite(full_icon)
    else
        self.partial_head_sprite:setSprite(self.battler.chara:getHeadIcons().."/head")
    end
end

function ActionBox:animateBox()
    if (EverParty:isWideStyle()) and (Game.battle.state ~= "INTRO") and (StringUtils.contains(Game.battle.state, "SELECT")) then
        local checker = EverParty:getRowCheckSize()
        local selected_row = math.floor((Game.battle.current_selecting-1) / checker)
        local row = math.floor((self.index-1) / checker)
        local positional_row = row
        --Kristal.Console:log(tostring(selected_row) .. " vs " .. tostring(row) .. " for battler " .. self.battler.chara.name)
        local shouldHalfRaise = EverParty:shouldHalfRaise(checker, selected_row, row, Game.battle.current_selecting, self.index)
        if (EverParty:getConfig("ui_style") == "ROULETTE") then
            --local real_selected_row = math.floor((Game.battle.current_selecting) / checker)
            if (selected_row+1 < row) then
                self.visible = false
                shouldHalfRaise = false
                return
            end
            if (selected_row > row) then
                shouldHalfRaise = false
                if (self.box.y < 40) then
                    self.box.y = self.box.y + 8 * DTMULT
                    return
                else
                    self.visible = false
                    return
                end
            end
            self.visible = true
            local row_offset = (Game:getConfig("oldUIPositions") and 36 or 37)

            local index_in_row = ((self.index-1) % checker) + 1
            Kristal.Console:log(self.original_x)
            
            if (row == selected_row) then
                self.show_progress = MathUtils.approach(self.show_progress, 1, DTMULT/4)
                local eased = Utils.ease(0, 1, Utils.ease(0, 1, self.show_progress, "in-out-cubic"), "out-back")
                if self.y < 0 then self.y = self.y + 16 * DTMULT else self.y = 0 end
                self.scale_x = MathUtils.lerp(self.scale_x, 1, eased)
                self.scale_y = self.scale_x
                self:setLayer(self.original_layer + 10)
                --self.x = MathUtils.lerp(self.x, self.original_x, eased)
            else
                self.show_progress = MathUtils.approach(self.show_progress, 0, DTMULT/4)
                local eased = Utils.ease(0, 1, Utils.ease(0, 1, 1-self.show_progress, "in-out-cubic"), "out-back")
                if self.y > -row_offset then self.y = self.y - 8 * DTMULT else self.y = -row_offset end
                self.scale_x = MathUtils.lerp(self.scale_x, 0.75, eased)
                self.scale_y = self.scale_x
                --self.x = MathUtils.lerp(self.x, 108 + 54 * (index_in_row / EverParty:getRowCheckSize()), eased)
                self:setLayer(self.original_layer - 10)
            end
        end
        if (shouldHalfRaise) then
            if self.box.y > -32 / ((row+1)/1.5) then self.box.y = self.box.y - 2 * DTMULT end
            if self.box.y > -24 / ((row+1)/1.5) then self.box.y = self.box.y - 4 * DTMULT end
            if self.box.y > -16 / ((row+1)/1.5) then self.box.y = self.box.y - 6 * DTMULT end
            if self.box.y > -8 / ((row+1)/1.5) then self.box.y = self.box.y - 8 * DTMULT end
            -- originally '= -64' but that was an oversight by toby
            if self.box.y < -32 / ((row+1)/1.5) then self.box.y = -32 / ((row+1)/1.5) end
        elseif self.box.y < -14 and (Game.battle.current_selecting ~= self.index) then
            self.box.y = self.box.y + 15 * DTMULT
        elseif Game.battle.current_selecting ~= self.index then
            self.box.y = 0
        else
            if (super.animateBox) then super.animateBox(self) end
        end
        for i, btn in ipairs(self.buttons) do
            btn.visible = (row == math.floor((Game.battle.current_selecting-1) / checker)) and not shouldHalfRaise
            if (EverParty:getConfig("ui_style") == "ROULETTE") then
                btn.visible = row == selected_row
            end
        end
    elseif (EverParty:getConfig("ui_style") == "BATTLECARD") and ((Game.battle.state ~= "INTRO")) then
        if (super.animateBox) then super.animateBox(self) end
        self.box_scale = (Game.battle.current_selecting == self.index) and 0 or 0.1
        if (Game.battle.current_selecting == self.index) then
            self.targeted_x = 40 * self.index
        elseif (Game.battle.current_selecting < self.index) then
            self.targeted_x = (213 - 35) + 40 * self.index
        else
            self.targeted_x = 40 * self.index
        end
        self.targeted_x = self.targeted_x - 40 * Game.battle.action_scroll
        if (not self.has_set_x) then
            self.has_set_x = true
            --self.x = self.targeted_x
        end
        local approachMult = 32
        local xdist = math.abs(self.x - self.targeted_x)
        if xdist < 64 then
            approachMult = 16
        elseif xdist < 32 then
            approachMult = 8
        elseif xdist < 24 then
            approachMult = 4
        elseif xdist < 16 then
            approachMult = 1
        elseif xdist < 8 then
            approachMult = 0.25
        end
        if (Game.battle.current_selecting == self.index) then
            approachMult = 64
        end
        if (self.x < self.targeted_x and (Game.battle.current_selecting < self.index)) then
            approachMult = 64
        end
        self.x = MathUtils.approach(self.x, self.targeted_x, DTMULT * approachMult)
        for i, btn in ipairs(self.buttons) do
            btn.visible = (Game.battle.current_selecting == self.index)
        end
        self.hp_sprite.visible = (Game.battle.current_selecting == self.index)
        self.head_sprite.x = (Game.battle.current_selecting == self.index) and (13 + self.head_offset_x) or (5 + self.head_offset_x)
        local hp_percent = (self.battler.chara:getHealth() / self.battler.chara:getStat("health"))
        self.partial_head_sprite:lerpCut(0,hp_percent * self.partial_head_sprite:getScaledHeight(),0,0)
    else
        if (super.animateBox) then super.animateBox(self) end
    end
end

-- function ActionBox:drawActionBox()
--     super.drawActionBox(self)
--     local row = math.floor((self.index-1) / EverParty:getRowCheckSize())
--     local checker = 3
--     local selected_row = math.max(math.ceil(Game.battle.current_selecting / checker), 1)
--     local old_row_check = math.max(math.ceil(self.index / checker), 1) - (selected_row - 1)
--     --local selected_row = math.floor((Game.battle.current_selecting-1) / EverParty:getRowCheckSize())
--     local should_half_raise = EverParty:shouldHalfRaise(EverParty:getRowCheckSize(), selected_row, row, Game.battle.current_selecting, self.index)
--     love.graphics.print(row, 20, -200)
--     love.graphics.print(old_row_check, 40,-200)
--     love.graphics.print(tostring(should_half_raise), 30, -190)
-- end

function ActionBox:update()
    super.update(self)

    if (not self.force_head_sprite) and self.partial_head_sprite then
        local current_head = self.battler.chara:getHeadIcons() .. "/" .. self.battler:getHeadIcon()
        if not self.partial_head_sprite:hasSprite(current_head) then
            current_head = self.battler.chara:getHeadIcons() .. "/head"
        end

        if not self.partial_head_sprite:isSprite(current_head) then
            self.partial_head_sprite:setSprite(current_head)
        end
    end
end

function ActionBox:adjustButtonsForScale()
    if not (EverParty:isWideStyle()) then return end
    if self.box_scale == 0 then return end
    local realstartx = (213 * (self.box_scale) / 2) - ((#self.buttons - 1) * (35 * (self.box_scale+0.1)) / 2) - 1
    for i, btn in ipairs(self.buttons) do
        local realpos_x, realpos_y = math.floor(realstartx + ((i - 1) * (35 * (self.box_scale+0.125)))) + 0.5, 21
        btn:setPosition(realpos_x, realpos_y)
    end
end

function ActionBox:drawActionBox()
    if (#Game.battle.party <= 3) then
        super.drawActionBox(self)
        return
    end
    if (EverParty:isWideStyle() and self.box_scale == 0) then
        super.drawActionBox(self)
        return
    end
    if not (EverParty:isWideStyle()) then
        if Game.battle.current_selecting == self.index then
            if (self.name_sprite) then self.name_sprite.visible = true end
        else
            if (self.name_sprite) then self.name_sprite.visible = false end
        end
        super.drawActionBox(self)
        return
    end

    if Game.battle.current_selecting == self.index then
        Draw.setColor(self.battler.chara:getColor())
        love.graphics.setLineWidth(2)
        love.graphics.line(1  , 2, 1,   37)
        love.graphics.line(Game:getConfig("oldUIPositions") and (211 * self.box_scale) or (212 * self.box_scale), 2, Game:getConfig("oldUIPositions") and (211 * self.box_scale) or (212* self.box_scale), 37)
        love.graphics.line(0  , 6, 212 * self.box_scale, 6 )
    end
    Draw.setColor(1, 1, 1, 1)
end

function ActionBox:drawSelectionMatrix()
    if (#Game.battle.party <= 3) then
        super.drawSelectionMatrix(self)
        return
    end
    if (EverParty:isWideStyle() and self.box_scale == 0) then
        super.drawSelectionMatrix(self)
        return
    end
    if not (EverParty:isWideStyle()) then
        super.drawSelectionMatrix(self)
        return
    end
    -- Draw the background of the selection matrix
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 2, 2, 209*self.box_scale, 35)

    if Game.battle.current_selecting == self.index then
        local r,g,b,a = self.battler.chara:getColor()

        for i = 0, 11 do
            local siner = self.selection_siner + (i * (10 * math.pi))

            love.graphics.setLineWidth(2)
            Draw.setColor(r, g, b, a * math.sin(siner / 60))
            if math.cos(siner / 60) < 0 then
                love.graphics.line(1 - (math.sin(siner / 60) * 30) + 30, 0, 1 - (math.sin(siner / 60) * 30) + 30, 37)
                love.graphics.line((211* self.box_scale) + (math.sin(siner / 60) * 30) - 30, 0, (211* self.box_scale) + (math.sin(siner / 60) * 30) - 30, 37)
            end
        end

        Draw.setColor(1, 1, 1, 1)
    end
end


return ActionBox