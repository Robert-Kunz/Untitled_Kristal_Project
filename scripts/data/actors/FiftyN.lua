local actor, super = Class(Actor, "FiftyN")

function actor:init(style)
    super.init(self)

    local susie_style = style or Game:getConfig("susieStyle")

    -- Display name (optional)
    self.name = "FiftyN"

    -- Width and height for this actor, used to determine its center
    self.width = 25
    self.height = 43

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)

    -- A table that defines where the Soul should be placed on this actor if they are a player.
    -- First value is x, second value is y.
    self.soul_offset = { 12.5, 24 }

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 0, 1 }

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/Fifty"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"
    -- Sound to play when this actor speaks (optional)
    self.voice = "susie"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/Fifty"
    self.portrait_offset = { 0, -5 }
    -- Offset position for this actor's portrait (optional)

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = { "idle", 0.25, true },
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = { 0, 0 },
    }
end

return actor
