local DashSoul, super = Class(Soul, "DashSoul")

function DashSoul:init(x, y)
    super.init(self, x, y)

    self.color = { 1, 0.5, 0.5 }

    self.speed = 4

    self.dash_0 = { 252 / 255, 166 / 255, 0 }

    -- Do not modify these variables

    self.dash_color = {
        self.dash_0
    }

    self.max_dash = 1

    self.dash = self.max_dash

    self.based_time = 30

    self.null_timer = self.based_time

    self.null_time = 0

    self.timer = self.null_time

    self.dash_speed = 20

    self.trails = {}

    self.act_timer = 0
end

function DashSoul:onWaveStart()
    self.dash = self.max_dash

    self.null_timer = self.based_time

    self.timer = self.null_time
end

function DashSoul:update()
    super.update(self)

    if not self:isMoving() or Kristal.getLibConfig("dash_soul", "rest_dash") == false then
        if self.null_timer > self.based_time - 7 and self.null_timer ~= self.based_time then
            self:setColor(self:changeColor({ 1, 1, 1 }))
        end
        if self.null_timer == self.based_time then
            self.dash = self.max_dash

            self.null_timer = self.based_time
        end
        if self.null_timer < self.based_time then
            self.null_timer = self.null_timer + 1
        end
    end

    if self.dash_active and self.act_timer <= 9 then
        if (self.act_timer % 3 == 0) then
            self.trail = Sprite("player/heart_blur", (0 - (self.act_timer / 3) * 20) * self.moving_x - 10,
                (0 - (self.act_timer / 3) * 20) * self.moving_y - 11)
            self.trail.layer = 400
            self:addChild(self.trail)
            table.insert(self.trails, self.trail)
            self:move(self.moving_x, self.moving_y, self.dash_speed)
        end
    end

    if self.dash_active then
        self.act_timer = self.act_timer + 1
    end

    if self.null_timer < self.based_time - 10 or self.null_timer == self.based_time then
        if self.dash > #self.dash_color - 1 then
            self:setColor(self:changeColor(self.dash_color[#self.dash_color]))
        else
            self:setColor(self:changeColor(self.dash_color[self.dash + 1]))
        end
    end

    for v, k in pairs(self.trails, self.trail) do
        if self.dash > #self.dash_color - 1 then
            self.trails[v]:setColor(self:changeColor(self.dash_color[#self.dash_color]))
        else
            self.trails[v]:setColor(self:changeColor(self.dash_color[self.dash + 1]))
        end
        self.trails[v]:fadeToSpeed(0, 0.1, function() table.remove(self.trails, #self.trails) end)
    end

    if self.act_timer > 40 then
        self.dash_active = false
        self.act_timer = 0
    end

    if self.timer < self.null_time then
        self.timer = self.timer + (1 * DTMULT)
    end
end

function DashSoul:changeColor(new_rgb)
    --Gradient made thanks to AlexGamingSW
    local old_r, old_g, old_b = self:getDrawColor()
    local r = Utils.lerp(old_r, new_rgb[1], 0.3)
    --print (r)
    local g = Utils.lerp(old_g, new_rgb[2], 0.3)
    --print (g)
    local b = Utils.lerp(old_b, new_rgb[3], 0.3)
    --print (b)
    return r, g, b
end

function DashSoul:doMovement()
    local speed = self.speed

    -- Do speed calculations here if required.

    if self.allow_focus then
        if Input.down("cancel") then speed = speed / 2 end -- Focus mode.
    end

    local move_x, move_y = 0, 0

    -- Keyboard input:
    if self.act_timer <= 1 or Kristal.getLibConfig("dash_soul", "dash_move") == true or self.act_timer > 9 then
        if Input.down("left") then move_x = move_x - 1 end
        if Input.down("right") then move_x = move_x + 1 end
        if Input.down("up") then move_y = move_y - 1 end
        if Input.down("down") then move_y = move_y + 1 end
    end

    if self.act_timer <= 1 or Kristal.getLibConfig("dash_soul", "dash_move") == true then
        self.moving_x = move_x
        self.moving_y = move_y
    end

    if move_x ~= 0 or move_y ~= 0 then
        if not self:move(move_x, move_y, speed * DTMULT) then
            if not self.dash_active or Kristal.getLibConfig("dash_soul", "dash_move") == true then
                self.moving_x = 0
                self.moving_y = 0
            end
        end
    end

    if self.timer == self.null_time then
        if Input.pressed("confirm") and self:isMoving() and self.act_timer <= 0 then
            self.dash_active = true
            self.timer = 0
            self.null_timer = 0
            self.act_timer = 0
            Game:setInvulnFrames(10)
        end
    end
end

function DashSoul:draw()
    local r, g, b, a = self:getDrawColor()
    local heart_texture = Assets.getTexture(self.sprite.texture_path)
    local heart_w, heart_h = heart_texture:getDimensions()

    super.draw(self)
    self.color = { r, g, b }
end

return DashSoul
