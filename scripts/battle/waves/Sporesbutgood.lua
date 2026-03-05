local SporesButGood, super = Class(Wave)

local inaccuracy = 50
-- -- THIS IS NOT WRITTEN BY ME, THIS WAS TAKEN FROM Somerandomguy, a friend of mine (with permission)
function SporesButGood:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 10
    self.arena_width = 200
    self.arena_height = 200
end

function SporesButGood:onStart()
    self:setArenaSize(200, 200)
    -- Every 0.05 seconds...
    self.timer:every(1 / 15, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()


        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do
            -- Get the x and y position
            local x = math.random(SCREEN_WIDTH / 2 + SCREEN_WIDTH / 6, SCREEN_WIDTH - SCREEN_WIDTH / 8)
            local y = math.random(-100, SCREEN_HEIGHT + 100)

            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x, y, Game.battle.soul.x + math.random(-inaccuracy, inaccuracy),
                Game.battle.soul.y + math.random(-inaccuracy, inaccuracy))

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self:spawnBullet("smallerbullet", x, y, angle, 3)
        end
    end)
end

function SporesButGood:update()
    -- Code here gets called every frame

    super.update(self)
end

return SporesButGood
