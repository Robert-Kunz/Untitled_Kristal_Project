local spores, super = Class(Bullet)

function spores:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/spore")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false
end

function spores:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return spores
