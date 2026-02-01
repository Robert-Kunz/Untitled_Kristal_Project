local snaketip, super = Class(Bullet)

function snaketip:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/snaketip")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false
    self.path = GMPath({
        type = GMPath.TYPE_CURVED,
    })
    self.timer = self:addChild(Timer())
    self.timer:every(1 / 30, function()
        if self:isRemoved() then return false end -- Stops the timer if this bullet is removed
        self.path:addPoint(self.x, self.y, 1)
    end)

    self.bullet_followers = {}
    self.remove_offscreen = false
    self.destroy_on_hit = false
    self.sprite:setRotationOrigin(0.5)
    self.sprite.rotation = math.rad(180)
end

function snaketip:onAdd(...)
    super.onAdd(self, ...)
    for i = 1, 6 do
        local bullet = self.wave:spawnBullet("snakesegment", self.x, self.y, self, i)
        table.insert(self.bullet_followers, bullet)
    end
end

return snaketip
