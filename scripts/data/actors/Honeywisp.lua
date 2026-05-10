local actor, super = Class(Actor, "Honeywisp")

function actor:init()
    super.init(self)
    -- Display name (optional)
    self.name = "Honeywisp"

    -- Width and height for this actor, used to determine its center
    self.width = 36
    self.height = 60

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = { 5, 40, 19, 14 }

    -- A table that defines where the Soul should be placed on this actor if they are a player.
    -- First value is x, second value is y.
    self.soul_offset = { 10, 24 }

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 0, 1, 1 }

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/Honeywisp/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "HW"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/HW"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = { -20, -10 }

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        ["slide"]               = { "slide", 4 / 30, true },
        -- Battle animations
        ["battle/idle"]         = { "battle/idle", 0.08, true },

        ["battle/attack"]       = { "battle/attack", 1 / 10, false },
        ["battle/act"]          = { "battle/act", 1 / 15, false },
        ["battle/spell"]        = { "battle/spell", 0.12, false },
        ["battle/item"]         = { "battle/item", 1 / 12, false, next = "battle/item_end" },
        ["battle/spare"]        = { "battle/act", 1 / 15, false, next = "battle/idle" },

        ["battle/attack_ready"] = { "battle/attackready", 0.08, false },
        ["battle/act_ready"]    = { "battle/actready", 0.2, true },
        ["battle/spell_ready"]  = { "battle/spellready", 0.08, false },
        ["battle/item_ready"]   = { "battle/itemready", 0.1, false },
        ["battle/defend_ready"] = { "battle/defend", 1 / 15, false },

        ["battle/act_end"]      = { "battle/actend", 1 / 15, false, next = "battle/idle" },
        ["battle/item_end"]     = { "battle/itemend", 1 / 15, false, next = "battle/idle" },

        ["battle/hurt"]         = { "battle/hurt", 1 / 15, false, temp = true, duration = 0.5 },
        ["battle/defeat"]       = { "battle/defeat", 1 / 15, false },
        ["battle/swooned"]      = { "battle/defeat", 1 / 15, false },
        ["battle/vanish"]       = { "battle/vanish", 1 / 15, false },
        ["battle/reappear"]     = { "battle/reappear", 1 / 12, false },

        ["battle/transition"]   = { "battle/transition_intro", 0.1, true },
        ["battle/intro"]        = { "battle/victory", 0.05, false },
        ["battle/victory"]      = { "battle/victory", 1 / 10, false },
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["walk/left"] = { 0, 0 },
        ["walk/right"] = { 0, 0 },
        ["walk/up"] = { 0, 0 },
        ["walk/down"] = { 0, 0 },
        -- Battle offsets
        ["battle/idle"] = { -5, -1 },

        ["battle/attack"] = { -8, -6 },
        ["battle/attackready"] = { -8, -6 },
        ["battle/act"] = { -6, -6 },
        ["battle/actend"] = { -6, -6 },
        ["battle/actready"] = { -6, -6 },
        ["battle/item"] = { -6, -6 },
        ["battle/itemend"] = { -6, -6 },
        ["battle/itemready"] = { -6, -6 },
        ["battle/spell"] = { -6, -6 },
        ["battle/spellready"] = { -6, -6 },
        ["battle/defend"] = { -5, -1 },
        ["battle/reappear"] = { -6, -6 },

        ["battle/defeat"] = { -8, -5 },
        ["battle/hurt"] = { -5, -1 },

        ["battle/intro"] = { -8, -9 },
        ["battle/victory"] = { -3, 0 },
    }
end

function actor:onSpriteUpdate(sprite)
    if not (Game.battle ~= nil) then
        local character = sprite.parent
        -- local battler = sprite.parent:includes(Battler) and sprite.parent or nil
        -- local character = sprite.parent:includes(Character) and sprite.parent or nil

        sprite.img_timer = (sprite.img_timer or 0) + DTMULT
        sprite.y = math.sin(Kristal.getTime() * 3 + 1) * 5
        -- sprite.y = sprite.y + math.sin(Kristal.getTime() * 3 + 1) * 0.25

        if sprite.img_timer < 7 then return end
        sprite.img_timer = 0


        --if sprite and not (character.is_down or character.sleeping) then
        --    if sprite.visible then
        --        local img = AfterImage(sprite, 0.8, 0.009)
        --        img.alpha = 0.6
        --        img.physics.direction = (character:includes(Character) and character.facing == "left") and 0 or math.rad(180)
        --        img.physics.speed = 1
        --        sprite.parent:addChild(img)
        --        img.debug_select = false


        -- img.physics.direction = ((battler:includes(Character) and battler.facing == "left") or battler:includes(PartyBattler)) and 0 or math.rad(180)
        -- img.physics.direction = (character.facing == "left" or battler:includes(PartyBattler)) and 0 or math.rad(180)
        --    end
        --end
        --sprite.y = sprite.y + math.sin(Kristal.getTime() * 3 + 1) * 10
    end
end

return actor
