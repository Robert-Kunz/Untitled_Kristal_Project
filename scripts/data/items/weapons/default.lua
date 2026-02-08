local item, super = Class(Item, "Default")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Nothing"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/smile_dog"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    -- apperantly senescence is the process leaves go through while going from green to orange
    self.description = "You against the world with just your own Body.\n[Good for a challenge run!]"

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
        health = 10,
        attack = 0,
        defense = 2,
        magic = -3
    }

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = nil

    -- Character reactions
    self.reactions = {
        SD = "Guess i'm going with my Fists",
        Honeywisp = "My egg..."
    }
end

function item:getAttackSprite(battler, enemy, points)
    return "effects/attack/slap_SD"
end

return item
