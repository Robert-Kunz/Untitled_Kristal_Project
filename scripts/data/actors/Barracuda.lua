local actor, super = Class(Actor, "Barracuda")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Barracuda"

    -- Width and height for this actor, used to determine its center
    self.width = 100
    self.height = 100

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 0, 0 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/Barracuda"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/Barracuda"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = { "idle", 0.03, true },
        ["awakening"] = { "awakening", 0.1, false, next = "awakened" },
        ["awakened"] = { "awakened", 0.03, true },
        ["deletion_block"] = { "deletion_block", 0.1, false },
        ["deletion_delete"] = { "deletion_delete", 0.1, false }
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = { 0, 0 },
        ["awakening"] = { 0, 0 },
        ["awakened"] = { 0, 0 },
        ["deletion_block"] = { 0, 0 },
        ["deletion_delete"] = { 0, 0 }
    }
end

function actor:onSpriteUpdate(sprite)
    if Game:getFlag("Convinced", false) == true or Game:getFlag("low", false) == true then
        local character = sprite.parent
        -- local battler = sprite.parent:includes(Battler) and sprite.parent or nil
        -- local character = sprite.parent:includes(Character) and sprite.parent or nil

        sprite.img_timer = (sprite.img_timer or 0) + DTMULT
        sprite.y = math.sin(Kristal.getTime() * 3 + 1) * 10
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
