local Bomb, super = Class(Bullet)

function Bomb:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/Bomb")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = 10
    self.destroy_on_hit = false
    self.physics.friction = 0.15
    self.timer = self:addChild(Timer())
    --checks every 2 seconds if the bomb has basically stopped, if yes, spawns 8 bullets and then deletes itself
    self.timer:every(2, function()
        if math.abs(self.physics.speed) < 0.1 then
            self.wave:spawnBullet("CorruptedBullet", x - 5, self.y, math.rad(0), 10)
            self.wave:spawnBullet("CorruptedBullet", x - 3, self.y, math.rad(45), 10)
            self.wave:spawnBullet("CorruptedBullet", x, self.y, math.rad(90), 10)
            self.wave:spawnBullet("CorruptedBullet", x + 3, self.y, math.rad(135), 10)
            self.wave:spawnBullet("CorruptedBullet", x + 5, self.y, math.rad(180), 10)
            self.wave:spawnBullet("CorruptedBullet", x + 3, self.y, math.rad(225), 10)
            self.wave:spawnBullet("CorruptedBullet", x, self.y, math.rad(270), 10)
            self.wave:spawnBullet("CorruptedBullet", x - 3, self.y, math.rad(315), 10)
            Assets.playSound("bomb")
            self:remove()
        end
    end)
end

function Bomb:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Bomb
