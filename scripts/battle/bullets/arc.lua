local arc, super = Class(Bullet)

function arc:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/fish")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = math.pi*3/2 
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = 18
    self.physics.gravity = 0.9
    self.h_speed = Utils.random(6, 14)
end

function arc:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.x = self.x - DTMULT*self.h_speed
    --if self.y >= Game.battle.arena.top then
        --self.physics.direction = 4
        --self.y = Game.battle.arena.top - 1
    --elseif self.y <= Game.battle.arena.bottom then
        --self.physics.direction = 2
        --self.y = Game.battle.arena.bottom + 1
    --end
    super.update(self)
end

return arc