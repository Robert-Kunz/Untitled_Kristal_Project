local grow, super = Class(Wave)

function grow:onStart()
    self:setArenaSize(150, 200)
    for _, v in ipairs(self:getAttackers()) do
        if v.id == "Fifty_Birthday" or v.id == "Fifty" then
            -- Every 0.33 seconds...
            self.timer:every(1 / 2, function()
                local x, y = v:getRelativePos(v.width / 2, v.height / 2)
                local bullet = self:spawnBullet("Ball", x, y)
                -- Make this bullet double the size of a regular bullet (Default scaling is 2x)
                bullet.physics.speed = 6
                bullet.rotation = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
                bullet.physics.match_rotation = true
            end)
        end
    end
end

function grow:update()
    -- Code here gets called every frame

    super.update(self)
end

return grow
