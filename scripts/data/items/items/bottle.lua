local item, super = Class(Item, "Bottle")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Bottle"
    -- Name displayed when used in battle (optional)
    self.use_name = "Empty Bottle"

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "Empty..."
    -- Shop description
    self.shop = "newly made"
    -- Menu description
    self.description = "An empty Bottle, that has the possibility to be filled with anything. Doesn't do anything alone"

    -- Default shop price (sell price is halved)
    self.price = 50
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
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
        susie = "You expect me to eat this?",
        ralsei = "This is just glass...",
        Fifty = "You still have to fill this, idiot",
        SD = "Ahh... perfect, an empty Bottle.",
        Honeywisp = "...huh?"
    }
end

function item:getBattleMessage(user, target)
    -- doesn't work currently
    return ("* " + user.chara:getName() + " doesn't know what to do with the " + item.getUseName() + "...")
end

return item
