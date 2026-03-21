local snake, super = Class(Wave)
function snake:init(
)
    super.init(self)
    self.time = 10
    self.arena_width = 100
    self.arena_height = 50
end

function snake:onStart(dir, segments, target)
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
end

function snake:update()
    -- Code here gets called every frame

    super.update(self)
end

return snake
