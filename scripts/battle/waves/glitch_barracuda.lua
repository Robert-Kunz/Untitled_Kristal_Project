local mixed_grow, super = Class(Wave)

function mixed_grow:init()
    super.init(self)
    self.time = 8
end

function mixed_grow:onStart()
    self:setArenaSize(300, 200)
    for _, v in ipairs(self:getAttackers()) do
        if v.id == "MISSINGNO" then
            -- Every second...
            self.timer:every(0.5, function()
                local x, y = v:getRelativePos(v.width / 2, v.height / 2)
                local bullet = self:spawnBullet("Ball", x, y)
                -- Make this bullet double the size of a regular bullet (Default scaling is 2x)
                bullet.physics.speed = 6
                bullet.rotation = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
                bullet.physics.match_rotation = true
            end)
        end
    end

    self.timer:every(0.5, function()
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

function mixed_grow:update()
    -- Code here gets called every frame

    super.update(self)
end

return mixed_grow
