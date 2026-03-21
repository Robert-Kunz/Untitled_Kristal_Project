local Smash, super = Class(Wave)
-- THIS IS NOT WRITTEN BY ME, THIS WAS TAKEN FROM THE DISCORD SERVER (with permission)
function Smash:init()
    super.init(self)

    self.siner = 0
    self.intensity = 0
    self.flash_timer = 0
end

function Smash:onStart()
    self.intensity = 60 -- How far the screen smashes apart
    self.flash_timer = 1

    -- Bullet logic
    self.timer:script(function(wait)
        local arena = Game.battle.arena

        while true do
            for i = 1, 3 do
                local bullet = self:spawnBullet("smallbullet", 0, 0)
                bullet:setScreenPos(260 + 60 * (i - 1), 70)
                bullet.physics.direction = math.rad(90)
                bullet.physics.speed = 5
            end
            wait(0.5)

            for i = 1, 2 do
                local bullet = self:spawnBullet("smallbullet", 0, 0)
                bullet:setScreenPos((260 + 30) + 60 * (i - 1), 280)
                bullet.physics.direction = math.rad(270)
                bullet.physics.speed = 5
            end
            wait(0.5)
        end
    end)
end

function Smash:update()
    super.update(self)

    self.siner = self.siner + DT
    if self.flash_timer > 0 then
        self.flash_timer = self.flash_timer - (DT * 2)
    end
end

function Smash:draw()
    if self.intensity > 1 and not self.already_drawn then
        self.already_drawn = true

        -- Move screen side to side
        local offset = math.sin(self.siner * 1.5) * self.intensity
        local height = SCREEN_HEIGHT / 2 - 70

        love.graphics.clear()

        -- Top Half
        love.graphics.push()
        love.graphics.setScissor(0, 0, SCREEN_WIDTH, height)
        love.graphics.translate(offset, 0)
        Game.stage:draw()
        love.graphics.pop()

        -- Bottom Half
        love.graphics.push()
        love.graphics.setScissor(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)
        love.graphics.translate(-offset, 0)
        Game.stage:draw()
        love.graphics.pop()

        -- GUI
        love.graphics.push()
        love.graphics.setScissor(0, 325, SCREEN_WIDTH, SCREEN_HEIGHT)
        Game.stage:draw()
        love.graphics.pop()

        -- Reset Scissors
        love.graphics.setScissor()

        if self.flash_timer > 0 then
            -- Smash CUT
            local bar_height = 30 * self.flash_timer
            love.graphics.setColor(1, 1, 1, self.flash_timer)
            love.graphics.rectangle("fill", 0, height - (bar_height / 2), SCREEN_WIDTH, bar_height)
            love.graphics.setColor(1, 1, 1, 1)
        end

        self.already_drawn = false
    else
        -- Only draw normally if we arent cutting
        super.draw(self)
    end
end

function Smash:onEnd()
    Game.stage.x = 0
end

return Smash
