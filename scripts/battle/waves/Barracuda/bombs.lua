local Bombs, super = Class(Wave)

function Bombs:init()
    super.init(self)
    self.time = 10
    self.arena_width = 300
    self.arena_height = 150
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
    if Game:getFlag("DashSoul", false) then
        self.timer:after(4, function() Assets.playSound("alert", 1, 1) end)
        self.timer:after(5, function()
            local arena = Game.battle.arena
            for _, v in ipairs(self:getAttackers()) do
                if v.id == "Barracuda" then
                    local x, y = v:getRelativePos(v.width - 50, arena.height / 2)
                    local bullet = self:spawnBullet("bar", x, y, math.rad(180), 3)
                    self.timer:every(1 / 15, function()
                        -- Cancel timer if the bullet is removed
                        if bullet:isRemoved() then
                            return false
                        end

                        -- Spawn a new afterimage with 0.4 starting alpha
                        local after_image = AfterImage(bullet.sprite, 0.4)
                        bullet:addChild(after_image)
                    end)
                end
            end
        end)
    end
end

function Bombs:update()
    -- Code here gets called every frame

    super.update(self)
end

return Bombs
