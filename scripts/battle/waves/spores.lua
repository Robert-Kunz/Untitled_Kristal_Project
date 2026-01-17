local spores, super = Class(Wave)
function spores:init()
    super.init(self)
    self.time = 10
end


function spores:onStart()
    -- Every 0.33 seconds...
    self:setArenaSize(300, 150)
    self.timer:every(1/2, function()
        -- Our X position is offscreen, to the right
        local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
        -- Get a random Y position between the top and the bottom of the arena
        local y = 0

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("spores", x, y, math.rad(90), 5)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end)
    
end

function spores:update()
    -- Code here gets called every frame

    super.update(self)
end

return spores