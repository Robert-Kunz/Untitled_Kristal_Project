local character, super = Class(PartyMember, "SD")

function character:init()
    super.init(self)
    -- Display name
    self.name = "SD"

    -- Actor (handles overworld/battle sprites)
    self:setActor("SD")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Human\nCreates Potions to\nhelp Teammates"

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 2
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = { 1, 0, 0 }

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "SD-action"

    -- Spells
    self:addSpell("Brewing")
    self:addSpell("Deletion")
    self:addSpell("helth")

    -- Current health (saved to the save file)
    self.health = 240

    -- Base stats (saved to the save file)
    self.stats = {
        health = 240,
        attack = 6,
        defense = 2,
        magic = 5,
    }

    -- Max stats from level-ups
    self.max_stats = {
        health = 420
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/vine"

    -- Equipment (saved to the save file)
    self:setWeapon("basic_vine")
    self:setArmor(1, "amber_card")
    --self:setArmor(2, "amber_card")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/sword"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = { 0.5, 0.5, 0.5 }
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = { 0.5, 0.5, 0.5 }
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = { 0.4, 0.4, 0.4 }
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = { 0.45, 0.45, 0.45 }
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = { 1, 0, 0 }

    -- Head icon in the equip / power menu
    self.menu_icon = "party/SD/head"
    -- Path to head icons used in battle
    self.head_icons = "party/SD/icon"
    -- Name sprite
    self.name_sprite = nil

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    function character:getGameOverMessage(main)
        return {
            "Seriously?[wait:5]\nugh...",
            "[wait:5]get moving,\nAsshole!",
            "And get better\nat this damn\ngame."
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

--function character:canEquip(item, slot_type, slot_index)
--   if item then
--      return super.canEquip(self, item, slot_type, slot_index)
--   else
--     local item
--      if slot_type == "weapon" then
--         item = self:getWeapon()
--      elseif slot_type == "armor" then
--          item = self:getArmor(slot_index)
--     else
--          return true
--       end
--       return false
--   end
--end

return character
