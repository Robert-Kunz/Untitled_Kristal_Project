local snakesegment, super = Class(Bullet)

function snakesegment:init(x, y, following, index)
    -- Last argument = sprite path
    super.init(self, x, y, 'bullets/snakesegment')

    self.following = following
    self.index = index
    self.remove_offscreen = false
    self.destroy_on_hit = false
end

function snakesegment:update()
    local dist = math.max(self.following.path:getTotalLength() - self.index * 18 + 8, 0)
    local point = self.following.path:getPositionAtLength(dist)
    if point then
        self:setPosition(point.x, point.y)

        local point_2 = self.following.path:getPositionAtLength(dist + 1)
        self.rotation = Utils.angle(point.x, point.y, point_2.x, point_2.y)
    end

    super.update(self)
end

return snakesegment
