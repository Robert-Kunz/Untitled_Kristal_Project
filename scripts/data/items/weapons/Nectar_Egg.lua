local item, super = Class(Item, "Nectar_Egg")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Egg"

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
    self.description = "A Nectar egg straight from the Pikmin Universe.\nIt's not very sturdy..."

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
        health = 0,
        attack = 0
    }

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        Honeywisp = true
    }

    -- Character reactions
    self.reactions = {
        SD = "Egg",
        Honeywisp = "Reminds me of home..."
    }
end

function item:getAttackSprite(battler, enemy, points)
    return "effects/attack/slap_SD"
end

return item
