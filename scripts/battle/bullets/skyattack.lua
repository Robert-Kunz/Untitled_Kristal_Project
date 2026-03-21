local skyattack, super = Class(Bullet)

function skyattack:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/coolersmallbullet")

    self.damage = math.huge
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.timer = self:addChild(Timer())
end

function skyattack:update()
    self.physics.speed = self.physics.speed * 1.05
    super.update(self)
end

function skyattack:onCollide(soul)
    super.onCollide(self, soul)
    self.timer:after(0, Game.battle:endWaves())
end

return skyattack
