local skyattack, super = Class(Wave)

function skyattack:init()
    super.init(self)
    self.time = 100000
    self.arena_width = 20
    self.arena_height = 20
end

function skyattack:onStart()
    -- Every 0.33 seconds...
    local fx = ColorMaskFX({ 1, 0, 0 })
    --Game.stage:addFX(fx)
    for _, v in ipairs(self:getAttackers()) do
        if v.id == "MISSINGNO" then
            -- Every second...
            self.timer:every(0.5, function()
                local x, y = v:getRelativePos(v.width / 2, v.height / 2)
                local bullet = self:spawnBullet("skyattack", x, y)
                bullet.physics.speed = 2
                bullet.rotation = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
                bullet.physics.match_rotation = true
                bullet.remove_offscreen = false
            end)
        end
    end

    -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)

    -- Dont remove the bullet offscreen, because we spawn it offscreen
end

function skyattack:update()
    -- Code here gets called every frame

    super.update(self)
end

return skyattack
