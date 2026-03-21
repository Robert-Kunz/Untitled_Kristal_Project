local fish, super = Class(Bullet)

function fish:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/fish")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false
end

function fish:update()
    -- For more complicated bullet behaviours, code here gets called every update
    super.update(self)
end

return fish
