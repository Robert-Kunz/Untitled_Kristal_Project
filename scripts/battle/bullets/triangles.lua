local triangles, super = Class(Bullet)

function triangles:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/triangle")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.sprite.graphics.spin = 0.3
    self.sprite:setOrigin(0.5)
    self.destroy_on_hit = false
    self.collider = PolygonCollider(self, { { -4, -5 }, { 4, -5 }, { 4, 4 }, { -4, 4 } })
end

function triangles:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return triangles
