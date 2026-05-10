local Basic, super = Class(Wave)

function Basic:init()
    super.init(self)
    self.siner = 0
    -- The duration of our wave, in seconds. (Defaults to `5`)
    self.time = 10
end

function Basic:onStart()
    -- Get the Arena Object
    local arena = Game.battle.arena
    -- Store starting arena position
    self.arena_start_x = arena.x
    self.arena_start_y = arena.y
    -- Every 0.33 seconds...
    self.timer:every(1 / 3, function()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH + 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("smallbullet", x, y, math.rad(180), 8)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end)
    self.timer:after(4, function()
        Assets.playSound("alert", 1, 1)
        local warning_sprite = self:spawnSprite("bullets/alertarenahazard", arena.x,
            arena.y - arena.height / 2 + arena.height / 16)

        local warning_sprite2 = self:spawnSprite("bullets/alertarenahazard", arena.x,
            arena.y + arena.height / 2 - arena.height / 16)
        self.timer:after(1, function()
            warning_sprite:remove()
            warning_sprite2:remove()
        end)
    end)
    self.timer:after(5, function()
        -- Spawn spikes on top of arena
        self:spawnBulletTo(Game.battle.arena, "arenahazard", arena.width / 2, 0, math.rad(0))

        -- Spawn spikes on bottom of arena (rotated 180 degrees)
        self:spawnBulletTo(Game.battle.arena, "arenahazard", arena.width / 2, arena.height, math.rad(180))
    end)
end

function Basic:update()
    -- Code here gets called every frame
    self.timer:after(5, function()
        -- Increment timer for arena movement
        self.siner = self.siner + DT

        -- Calculate the arena Y offset
        local offset = math.sin(self.siner * 1.5) * 60

        -- Move the arena
        Game.battle.arena:setPosition(self.arena_start_x, self.arena_start_y + offset)
    end)
    super.update(self)
end

return Basic
