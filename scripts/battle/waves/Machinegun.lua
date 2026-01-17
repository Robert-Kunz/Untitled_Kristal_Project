local MachineGun, super = Class(Wave)

local inaccuracy = 15
local shot_number = 0

function MachineGun:init()
    super.init(self)

    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 10
end

function MachineGun:onStart()
    self:setArenaSize(200, 220)
    -- Every 0.25 seconds...
    self.timer:every(1 / 32, function()
        shot_number = shot_number + 1
        if shot_number == 32 then
            shot_number = 0
        end

        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()
        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do
            for i = 0, 0 do
                -- Get the x and y position
                local x, y = attacker:getRelativePos(attacker.width / 2, attacker.height / 2 + math.random(-2, 2))
                y = y - i * 75
                print(y)
                -- Get the angle between the bullet position and the soul's position
                local angle = Utils.angle(x, y, Game.battle.soul.x + math.random(-inaccuracy, inaccuracy),
                    Game.battle.soul.y + math.random(-inaccuracy, inaccuracy))

                if shot_number < 24 then
                    -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
                    self:spawnBullet("smallerbullet", x, y, angle, 12)
                end
            end
        end
    end)
end

function MachineGun:update()
    -- Code here gets called every frame

    super.update(self)
end

return MachineGun
