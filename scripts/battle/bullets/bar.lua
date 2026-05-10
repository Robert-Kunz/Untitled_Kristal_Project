local Bar, super = Class(Bullet)

function Bar:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/bar")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false
    self.rotation = dir
    self.height = 100
    self.width = 20
    self:setHitbox(0, 0, 10, 90)
end

function Bar:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Bar
