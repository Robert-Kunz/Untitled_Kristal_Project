local actor, super = Class(Actor, "gaster")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "gaster"

    -- Width and height for this actor, used to determine its center
    self.width = 40
    self.height = 88

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = { 2, 44, 40, 40 }

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 1, 1 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/missingno"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = ""

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

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

function actor:onTextSound()
    --if self.voice_timer == 0 then
    --    local rand = Utils.random(0, 8, 1) + 1

    --     local pitchrandom = (0.86 + Utils.random(0.35))
    --     local soundindex = "voice/missingno/glitch_" .. rand

    --    Assets.stopAndPlaySound(soundindex, 0.7, pitchrandom)

    --    self.voice_timer = 3
    --end
    -- plays a random sound with a random pitch and speed(i think) from the catalogue of sounds
    -- as the "voice"
    if self.voice_timer == 0 then
        local rand = Utils.random(0, 1, 1) + 1
        Kristal.Console:log(rand)
        local file_stuff = "voice/gaster/gaster_" .. rand
        Kristal.Console:log(file_stuff)
        local snd = Utils.pick({ file_stuff })
        local pitch = 0.80 + Utils.random(0.2)
        Assets.playSound(snd, 1, 1)
        self.voice_timer = 0
    end
    --self.voice_timer = self.voice_timer - 0.5
    return true
end

return actor
