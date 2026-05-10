local actor, super = Class(Actor, "soul")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "soul"

    -- Width and height for this actor, used to determine its center
    self.width = 40
    self.height = 88

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 1, 1 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = nil
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = ""

    -- Sound to play when this actor speaks (optional)
    self.voice = "floweytalk2"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/SOUL"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = { -15, -5 }

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
    self.voice_timer = 0
end

return actor
