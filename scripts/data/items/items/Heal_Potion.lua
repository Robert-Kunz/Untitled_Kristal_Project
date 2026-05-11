-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "Potion")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Healing P."
    -- Name displayed when used in battle (optional)
    self.use_name = "Instant Health II Potion"

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "Medicine"
    -- Shop description
    self.shop = "Medicine"
    -- Menu description
    self.description = "A Pinkish liquid.\nSmells like Watermelons. +60HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 60

    -- Default shop price (sell price is halved)
    self.price = 500
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = "Bottle"
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Hey! This has a melony Taste!",
        ralsei = "Healthy!",
        noelle = "This tastes interesting...",
        SD = "Watermelone",
        Honeywisp = "winged..."
    }
end

return item
