local actor, super = Class(Actor, "FiftyN")

function actor:init(style)
    super.init(self)

    local susie_style = style or Game:getConfig("susieStyle")

    -- Display name (optional)
    self.name = "FiftyN"

    -- Width and height for this actor, used to determine its center
    self.width = 30
    self.height = 40

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)

    -- A table that defines where the Soul should be placed on this actor if they are a player.
    -- First value is x, second value is y.
    self.soul_offset = { 12.5, 24 }

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 0, 1 }

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/Fifty"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "battle/idle"
    -- Sound to play when this actor speaks (optional)
    self.voice = "susie"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/Fifty"
    self.portrait_offset = { -25, -5 }
    -- Offset position for this actor's portrait (optional)

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["battle/idle"] = { "battle/idle", 0.15, true },
        ["battle/defeat"] = { "battle/defeat", 0.25, true },
        ["battle/dodge"] = { "battle/dodge", 0.25, false, temp = 0.5 },
        ["battle/intro"] = { "battle/intro", 0.1, false },
        ["battle/transition"] = { "battle/intro_transition", 0.25, false }
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["battle/idle"] = { 0, 0 },
        ["battle/defeat"] = { 0, 0 },
        ["battle/dodge"] = { -30, 0 },
        ["battle/intro"] = { 0, 0 },
        ["battle/intro_transition"] = { 0, 0 }
    }
    self.flip = "left"
    self.turn = true
end

function actor:onWorldUpdate()

end

return actor
