local TestingBullet, super = Class(Wave)

function TestingBullet:init()
    super.init(self)
    self.time = 10
end

function TestingBullet:onStart()
    -- Every 0.33 seconds...
    self:setArenaSize(300, 300)
    self.timer:every(1/3, function()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH + 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("Bomb", x, y, math.rad(180), 6)
        local bullet = self:spawnBullet("Ball", x, y, math.rad(180), 4)
        local bullet = self:spawnBullet("CorruptedBullet", x, y, math.rad(180), 10)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end)
end

function TestingBullet:update()
    -- Code here gets called every frame

    super.update(self)
end

return TestingBullet