local item, super = Class(Item, "jsab_egg")

function item:init()
    super.init(self)

    -- Display name
    self.name = "JEAB"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/egg"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A cyan glowing Egg shaped structure.\nProtects from the corrupted."

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

    self.bonus_name = "DEFEND Corrupted"
    self.bonus_icon = "ui/menu/icon/armor"
    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        health = 20,
        defense = 2,
        magic = 1
    }

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        Honeywisp = true
    }

    -- Character reactions
    self.reactions = {
        SD = "Egg, but glowing",
        Honeywisp = "...Is this even an Egg?"
    }
end

function item:getAttackSprite(battler, enemy, points)
    return "effects/attack/slap_SD"
end

function item:onBattleDamage(amount, swoon, all)

end

return item
