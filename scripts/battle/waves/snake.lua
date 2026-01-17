local snake, super = Class(Wave)

function snake:onStart()
    -- Every 0.33 seconds...
    self.timer:every(1 / 3, function()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH - 40
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)
        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        self:spawnBullet("snaketip", x, y, math.rad(180), 8)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
    end)
end

function snake:update()
    -- Code here gets called every frame

    super.update(self)
end

return snake
