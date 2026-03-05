local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/coolersmallbullet")

    self.damage = math.huge
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

function SmallBullet:onDamage(soul)
    Assets.playSound("deathnoise")
    return super.onDamage(self, soul)
end

function SmallBullet:shouldSwoon(damage, target, soul)
    super.shouldSwoon(self, damage, target, soul)
    return true
end

return SmallBullet
