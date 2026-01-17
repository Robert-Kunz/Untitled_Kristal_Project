local Bombs, super = Class(Wave)

function Bombs:init()
    super.init(self)
    self.time = 10
end

function Bombs:onStart()
    -- Every 0.33 seconds...
    self:setArenaSize(300, 150)
    self.timer:every(1, function()
        -- Our X position is offscreen, to the right
        local x = Utils.random(0, SCREEN_WIDTH)
        -- Get a random Y position between the top and the bottom of the arena
        local y = SCREEN_HEIGHT

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("Bomb", x, y, math.rad(270))

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end)
end

function Bombs:update()
    -- Code here gets called every frame

    super.update(self)
end

return Bombs
