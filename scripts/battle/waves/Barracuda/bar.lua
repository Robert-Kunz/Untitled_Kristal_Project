local grow, super = Class(Wave)

function grow:onStart()
    local arena = Game.battle.arena
    for _, v in ipairs(self:getAttackers()) do
        if v.id == "Barracuda" then
            -- Every 0.33 seconds...
            self.timer:after(2, function()
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
                -- Make this bullet double the size of a regular bullet (Default scaling is 2x)
            end)
        end
    end
end

function grow:update()
    -- Code here gets called every frame

    super.update(self)
end

return grow
