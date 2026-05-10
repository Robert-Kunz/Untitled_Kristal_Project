local Bombs, super = Class(Wave)

function Bombs:init()
    super.init(self)
    self.time = 10
    self.arena_width = 300
    self.arena_height = 300
end

function Bombs:onStart(dir, segments, target)
    -- Every 0.33 seconds...
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
    self.timer:everyInstant(1, function()
        for _, v in ipairs(self:getAttackers()) do
            if v.id == "Barracuda" or v.id == "MISSINGNO" then
                local x, y = v:getRelativePos(v.width / 2, v.height / 2)
                -- Every 0.33 seconds...
                segments = 6
                dir = dir or 180
                target = { x = math.random(-10, 650), y = math.random(-10, 490) }
                self.worm = {}
                local head = self:spawnBullet("snake", x, y, dir, 1, "tip", target, nil)
                local lastsegment = head
                table.insert(self.worm, 1, head)
                local lastindex = 1
                for i = 1, segments do
                    local segment = self:spawnBullet("snake", x, y, dir, 1, "segment", target, lastsegment)
                    lastsegment = segment
                    table.insert(self.worm, i + 1, segment)
                    lastindex = i + 1
                end

                self.timer:after(1, function() head.should_turn = true end)
            end
        end
    end, 4)
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
                    local x, y = v:getRelativePos(v.width - 50, arena.height / 4)
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
                    local x, y = v:getRelativePos(v.width - 50, arena.height / 8)
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
