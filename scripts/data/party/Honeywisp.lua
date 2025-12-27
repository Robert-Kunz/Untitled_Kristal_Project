local character, super = Class(PartyMember, "HW")

function character:init()
    super.init(self)
    -- Display name
    self.name = "HW"

    -- Actor (handles overworld/battle sprites)
    self:setActor("Honeywisp")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Honeywisp\nUses Eggs to\nsupport and heal."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 2
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = { 0, 1, 1 }

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "HW-action"

    -- Spells
    self:addSpell("Nectar")
    self:addSpell("Spicy_Nectar")
    self:addSpell("Vanish")
    self:addSpell("Mitite_toss")
    self:addSpell("Eggcify")
    -- Current health (saved to the save file)
    self.health = 50

    -- Base stats (saved to the save file)
    self.stats = {
        health = 50,
        attack = 2,
        defense = 0,
        magic = 10,
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 50
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/sword"

    -- Equipment (saved to the save file)
    self:setWeapon("red_scarf")
    self:setArmor(1, "amber_card")
    --self:setArmor(2, "amber_card")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/sword"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = { 1, 0, 0.7 }
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = { 1, 0, 0.7 }
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = { 1, 0, 0.7 }
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = { 0.9, 0, 0.6 }
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = { 1, 0, 0.7 }

    -- Head icon in the equip / power menu
    self.menu_icon = "party/Honeywisp/head"
    -- Path to head icons used in battle
    self.head_icons = "party/Honeywisp/icon"
    -- Name sprite
    self.name_sprite = nil

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/cut"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    function character:getGameOverMessage(main)
        return {
            "I-I'm sorry...",
            "I d-didn't \nmean to...",
            "P-please don't \ndie..."
        }
    end

    -- Battle position offset (optional)
    self.battle_offset = { 2, 1 }
    -- Head icon position offset (optional)
    self.head_icon_offset = { -5, -1 }
    -- Menu icon position offset (optional)
    self.menu_icon_offset = { 0, 0 }

    -- Message shown on gameover (optional)
    self.gameover_message = true
end

function character:autoHealAmount()
    return math.huge
end

return character
