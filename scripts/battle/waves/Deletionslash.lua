local DeleteSlash, super = Class(Wave)

local x1 = 1
local y1 = 1
local x2 = 2
local y2 = 2
local x3 = 3
local y3 = 3
local x4 = 4
local y4 = 4

function DeleteSlash:onStart()
    self:setArenaSize(70, 70)
    -- Every 0.25 seconds...
    self.timer:every(0.6, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do
            -- Get the attacker's center position
            x1, y1 = attacker:getRelativePos(attacker.width / 2, attacker.height / 2)
            y1 = math.random(y1 - 70, y1 + 70)
            x2, y2 = attacker:getRelativePos(attacker.width / 2 - (SCREEN_WIDTH - SCREEN_WIDTH / 2), attacker.height / 2)
            --y2 = math.random(y2 - 70, y2 + 70)
            y2 = Game.battle.soul.y

            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x1, y1, x2, y2)
            self.timer:after(0.5, function()
                -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
                self:spawnBullet("deletionbullet", x1, y1, angle, 32)
            end)
        end
    end)
    self.timer:after(0.3, function()
        self.timer:every(0.6, function()
            -- Get all enemies that selected this wave as their attack
            local attackers = self:getAttackers()

            -- Loop through all attackers
            for _, attacker in ipairs(attackers) do
                -- Get the attacker's center position
                x3, y3 = attacker:getRelativePos(attacker.width / 2, attacker.height / 2)
                y3 = math.random(y3 - 70, y3 + 70)
                x4, y4 = attacker:getRelativePos(attacker.width / 2 - (SCREEN_WIDTH - SCREEN_WIDTH / 2),
                    attacker.height / 2)
                y4 = math.random(y4 - 70, y4 + 70)

                -- Get the angle between the bullet position and the soul's position
                local angle = Utils.angle(x3, y3, x4, y4)
                self.timer:after(0.5, function()
                    -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
                    self:spawnBullet("deletionbullet", x3, y3, angle, 32)
                end)
            end
        end)
    end)
end

function DeleteSlash:update()
    -- Code here gets called every frame

    super.update(self)
end

function DeleteSlash:draw()
    -- idk
    love.graphics.setColor({ 1, 0, 0, 0.4 }) -- Draw in a translucent red colour
    love.graphics.setLineWidth(4)            -- Draw a 4px width line
    love.graphics.setLineStyle("rough")      -- Draw the line with rough edges
    love.graphics.line(x1, y1, x2, y2)
    love.graphics.line(x3, y3, x4, y4)
end

return DeleteSlash
