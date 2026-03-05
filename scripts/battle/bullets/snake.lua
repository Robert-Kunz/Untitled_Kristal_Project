---@class snaketip : Bullet
local snaketip, super = Class(Bullet)

---@alias BodyPart
---| "head"
---| "body"
---| "tail"

---@param x number
---@param y number
---@param dir number
---@param speed number
---@param bodypart BodyPart
---@param target Soul|Object
---@param parent snaketip
function snaketip:init(x, y, dir, speed, bodypart, target, parent)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/snake" .. bodypart)

    if parent then
        speed = parent.physics.speed
        dir = MathUtils.angle(self.x, self.y, parent.x, parent.y)
        parent.child_part = self
    else
        speed = speed or 0
        dir = dir or 0
    end

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.match_rotation = true
    self.rotation = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.target_speed = speed

    self.owner_part = parent
    self.child_part = nil

    self.target = target

    self.should_turn = false

    self.remove_offscreen = false
    self.destroy_on_hit = false
    --self.damage = self.damage * 2
end

function snaketip:update()
    super.update(self)
    if self.owner_part then
        local p = self.owner_part
        local desired = 15

        local dx, dy = self.x - p.x, self.y - p.y
        local d = math.sqrt(dx * dx + dy * dy)
        if d > 0.0001 then
            local tx = p.x + (dx / d) * desired
            local ty = p.y + (dy / d) * desired

            local stiffness = 0.65
            self.x = self.x + (tx - self.x) * stiffness
            self.y = self.y + (ty - self.y) * stiffness

            self.rotation = MathUtils.angle(self.x, self.y, p.x, p.y)
        end

        self.physics.speed = 0
        return
    end

    local angle_diff = MathUtils.angleDiff(self.rotation, MathUtils.angle(self.x, self.y, self.target.x, self.target.y))
    local gradient = math.abs(angle_diff) / math.pi
    self.target_speed = 10 * math.max(1 - gradient, 0.1)
    self.physics.speed = MathUtils.approach(self.physics.speed, self.target_speed, DTMULT / 6)
    if (self.should_turn) then
        self.rotation = MathUtils.approachAngle(self.rotation,
            MathUtils.angle(self.x, self.y, self.target.x, self.target.y), DTMULT / 16)
    end
end

function snaketip:draw()
    super.draw(self)
end

return snaketip
