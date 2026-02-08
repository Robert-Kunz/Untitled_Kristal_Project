local item, super = Class(Item, "basic_vine")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Vine"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/vine"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    -- apperantly senescence is the process leaves go through while going from green to orange
    self.description = "A Vine undergoing senescence. Despite this\nit's still pretty sturdy. Whip-like."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 3,
    }

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = { SD = true }

    -- Character reactions
    self.reactions = {
        SD = "Better than nothing?",
        Honeywisp = "Why are you handing me a vine..."
    }
end

function item:getAttackSprite(battler, enemy, points)
    return "effects/attack/slap_SD"
end

function item:onUnequip(character, replacement)
    return super.onUnequip(self, character, replacement)
end

return item
