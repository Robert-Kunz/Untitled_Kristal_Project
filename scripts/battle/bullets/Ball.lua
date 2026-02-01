local Ball, super = Class(Bullet)

function Ball:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/Ball")
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    --self.graphics.grow = 0.03
    self.destroy_on_hit = false
end

function Ball:update()
    -- For more complicated bullet behaviours, code here gets called every update
    super.update(self)
    self:setScale(self.scale_x + (0.03 * DTMULT), self.scale_y + (0.03 * DTMULT))
end

return Ball
