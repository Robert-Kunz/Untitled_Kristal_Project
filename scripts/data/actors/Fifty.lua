local actor, super = Class(Actor, "Fifty")

function actor:init(style)
    super.init(self)

    -- Display name (optional)
    self.name = "Fifty"

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
    self.default = "walk"
    -- Sound to play when this actor speaks (optional)
    self.voice = "susie"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/Fifty"
    self.portrait_offset = { -25, -5 }
    -- Offset position for this actor's portrait (optional)

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    self.animations = {
        ["slide"]                = { "slide", 4 / 30, true },
        -- Battle animations
        ["battle/idle"]          = { "battle/idle", 0.15, true },

        ["battle/attack"]        = { "battle/attack", 1 / 20, false },
        ["battle/act"]           = { "battle/act", 1 / 15, false },
        ["battle/spell"]         = { "battle/spell", 0.1, false },
        ["battle/brewing"]       = { "battle/brewing", 0.2, false },
        ["battle/deletion"]      = { "battle/deletion", 0.1, false },
        ["battle/item"]          = { "battle/item", 1 / 12, false, next = "battle/item_end" },
        ["battle/spare"]         = { "battle/act", 1 / 15, false, next = "battle/idle" },
        ["battle/dodge"]         = { "battle/dodge", 1 / 15, true, next = "battle/idle", duration = 0.5 },

        ["battle/attack_ready"]  = { "battle/attackready", 0.2, true },
        ["battle/act_ready"]     = { "battle/actready", 0.2, true },
        ["battle/spell_ready"]   = { "battle/spellready", 0.2, true },
        ["battle/brewing_ready"] = { "battle/brewingready", 0.2, true },
        ["battle/item_ready"]    = { "battle/itemready", 0.2, true },
        ["battle/defend_ready"]  = { "battle/defend", 1 / 15, false },

        ["battle/act_end"]       = { "battle/actend", 1 / 15, false, next = "battle/idle" },
        ["battle/item_end"]      = { "battle/itemend", 1 / 15, false, next = "battle/idle" },

        ["battle/hurt"]          = { "battle/hurt", 1 / 15, false, temp = true, duration = 0.5 },
        ["battle/defeat"]        = { "battle/defeat", 1 / 15, false },
        ["battle/swooned"]       = { "battle/swooned", 0.2, true },

        ["battle/transition"]    = { "battle/intro_transition", 0.2, true },
        ["battle/intro"]         = { "battle/intro", 1 / 30, false },
        ["battle/victory"]       = { "battle/victory", 1 / 10, false },
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["walk/left"] = { 0, 0 },
        ["walk/right"] = { 0, 0 },
        ["walk/up"] = { 0, 0 },
        ["walk/down"] = { 0, 0 },
        -- Battle offsets
        ["battle/idle"] = { 0, 0 },
        ["battle/dodge"] = { -30, 0 },

        ["battle/attack"] = { -8, -6 },
        ["battle/attackready"] = { -8, -6 },
        ["battle/act"] = { -6, -6 },
        ["battle/actend"] = { -6, -6 },
        ["battle/actready"] = { -6, -6 },
        ["battle/item"] = { -6, -6 },
        ["battle/itemend"] = { -6, -6 },
        ["battle/itemready"] = { -6, -6 },
        ["battle/spell"] = { -6, -6 },
        ["battle/brewing"] = { -6, -6 },
        ["battle/deletion"] = { -6, -6 },
        ["battle/spellready"] = { -6, -6 },
        ["battle/defend"] = { -5, -1 },

        ["battle/defeat"] = { -8, -5 },
        ["battle/swooned"] = { -8, -5 },
        ["battle/hurt"] = { -5, -1 },

        ["battle/intro"] = { -8, -9 },
        ["battle/victory"] = { -3, 0 },
    }
end

return actor
