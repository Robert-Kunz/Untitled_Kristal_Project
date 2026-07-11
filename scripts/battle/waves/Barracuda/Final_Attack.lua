local grow, super = Class(Wave)

function grow:init()
    super.init(self)
    self.time = 30
    self.arena_width = SCREEN_WIDTH
    self.arena_height = SCREEN_HEIGHT
end

function grow:onStart(dir, segments, target)
    local x = SCREEN_WIDTH / 2
    local y = -50
    local cuda = self:spawnBullet("Cuda", x, y, math.rad(90))
    cuda.layer = 1000
    self.timer:after(2, function()
        self.timer:everyInstant(1, function()
            if cuda then
                local x, y = cuda:getPosition()
                segments = 9
                dir = dir or 180
                target = { x = math.random(-10, 650), y = math.random(-10, 490) }
                self.worm = {}
                local head = self:spawnBullet("snake", x, y, dir, 1, "tip", target, nil)
                head.layer = 999
                local lastsegment = head
                table.insert(self.worm, 1, head)
                local lastindex = 1
                for i = 1, segments do
                    local segment = self:spawnBullet("snake", x, y, dir, 1, "segment", target, lastsegment)
                    segment.layer = 999
                    lastsegment = segment
                    table.insert(self.worm, i + 1, segment)
                    lastindex = i + 1
                end

                self.timer:after(1, function() head.should_turn = true end)
            end
        end, 4)
    end)
    self.timer:every(2, function()
        if cuda then
            local x, y = cuda:getPosition()
            self:spawnBullet("CorruptedBullet", x - 5, y, math.rad(0), 10)
            self:spawnBullet("CorruptedBullet", x - 2, y, math.rad(22), 10)
            self:spawnBullet("CorruptedBullet", x - 3, y, math.rad(45), 10)
            self:spawnBullet("CorruptedBullet", x - 4, y, math.rad(78), 10)
            self:spawnBullet("CorruptedBullet", x, y, math.rad(90), 10)
            self:spawnBullet("CorruptedBullet", x + 2, y, math.rad(112), 10)
            self:spawnBullet("CorruptedBullet", x + 3, y, math.rad(135), 10)
            self:spawnBullet("CorruptedBullet", x + 4, y, math.rad(158), 10)
            self:spawnBullet("CorruptedBullet", x + 5, y, math.rad(180), 10)
            self:spawnBullet("CorruptedBullet", x - 2, y, math.rad(202), 10)
            self:spawnBullet("CorruptedBullet", x - 3, y, math.rad(225), 10)
            self:spawnBullet("CorruptedBullet", x - 4, y, math.rad(242), 10)
            self:spawnBullet("CorruptedBullet", x, y, math.rad(270), 10)
            self:spawnBullet("CorruptedBullet", x - 2, y, math.rad(298), 10)
            self:spawnBullet("CorruptedBullet", x - 3, y, math.rad(315), 10)
            self:spawnBullet("CorruptedBullet", x - 4, y, math.rad(332), 10)
        end
    end, 9)
    self.timer:everyInstant(3, function()
        if cuda then
            self.timer:after(2, function() Assets.playSound("alert", 1, 1) end)
            self.timer:after(3, function()
                local x, y = cuda:getPosition()
                local bar1 = self:spawnBullet("bar", x, y + 100, math.rad(90), 3)
                local bar2 = self:spawnBullet("bar", x - 60, y - 20, math.rad(205), 3)
                local bar3 = self:spawnBullet("bar", x + 60, y, math.rad(335), 3)
                self.timer:every(1 / 15, function()
                    -- Cancel timer if the bullet is removed
                    if bar1:isRemoved() then
                        return false
                    end

                    -- Spawn a new afterimage with 0.4 starting alpha
                    local after_image = AfterImage(bar1.sprite, 0.4)
                    bar1:addChild(after_image)
                    -- Cancel timer if the bullet is removed
                    if bar2:isRemoved() then
                        return false
                    end

                    -- Spawn a new afterimage with 0.4 starting alpha
                    local after_image = AfterImage(bar2.sprite, 0.4)
                    bar2:addChild(after_image)
                    -- Cancel timer if the bullet is removed
                    if bar3:isRemoved() then
                        return false
                    end

                    -- Spawn a new afterimage with 0.4 starting alpha
                    local after_image = AfterImage(bar3.sprite, 0.4)
                    bar3:addChild(after_image)
                end)
            end)
        end
    end, 6)

    self.timer:after(15, function()
        self.timer:everyInstant(0.1, function()
            if cuda then
                local x, y = cuda:getPosition()
                segments = 12
                dir = dir or 180
                target = { x = math.random(-10, 650), y = math.random(-10, 490) }
                self.worm = {}
                local head = self:spawnBullet("snake", x, y, dir, 1, "tip", target, nil)
                head.layer = 999
                local lastsegment = head
                table.insert(self.worm, 1, head)
                local lastindex = 1
                for i = 1, segments do
                    local segment = self:spawnBullet("snake", x, y, dir, 1, "segment", target, lastsegment)
                    segment.layer = 999
                    lastsegment = segment
                    table.insert(self.worm, i + 1, segment)
                    lastindex = i + 1
                end

                self.timer:after(1, function() head.should_turn = true end)
            end
        end, 4)
    end)
    self.timer:after(20, function()
        local x, y = cuda:getPosition()
        local boom = self:spawnBullet("explode_cuda", x, y, math.rad(90))
        cuda:remove()
        self.timer:after(1, function() Assets.playSound("bomb") end)
    end)
    self.timer:after(22, function()
        self.timer:every(0.1, function()
            -- Our X position is offscreen, to the right
            local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
            -- Get a random Y position between the top and the bottom of the arena
            local y = 0

            -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            local bullet = self:spawnBullet("triangles", x, y, math.rad(90), 5)

            -- Dont remove the bullet offscreen, because we spawn it offscreen
            bullet.remove_offscreen = false
        end)
    end)
end

function grow:update()
    -- Code here gets called every frame
    super.update(self)
end

function grow:beforeEnd()
    --Game.battle:startCutscene("Barracuda", "power")
    return false
end

function grow:onEnd(death)
    --Game.battle:startCutscene("Barracuda", "power")
    return false
end

return grow
