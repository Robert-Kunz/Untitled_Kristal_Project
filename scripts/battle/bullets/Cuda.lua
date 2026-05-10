local Bomb, super = Class(Bullet)

function Bomb:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/cuda")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = 7
    self.destroy_on_hit = false
    self.physics.friction = 0.15
    self.timer = self:addChild(Timer())
    self.collider = PolygonCollider(self, { { 49, 6 }, { 88, 86 }, { 15, 86 }, { 49, 6 } })
    --checks every 2 seconds if the bomb has basically stopped, if yes, spawns 8 bullets and then deletes itself
end

function Bomb:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Bomb
