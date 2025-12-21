local item, super = Class(Item, "Strength_Potion")
function item:init()
    super.init(self)
    self.enableStatBuffCountdown = false
    self.statBuffCountdown = 0
    -- Display name
    self.name = "Strength P."
    -- Name displayed when used in battle (optional)
    self.use_name = "Strength Potion! Attack increased by 5 for the next 3 turns"

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "attack \ngo \nbrrr"
    -- Shop description
    self.shop = "Steroids"
    -- Menu description
    self.description = "Increases the strength of an ally for a few turns when used, only usable in battle"
    -- Light world check text
    self.check = "You see a water bottle filled with junk, this should not be possible to see"

    -- Default shop price (sell price is halved)
    self.price = 500
    -- Whether the item can be sold
    self.can_sell = true

    self.result_item = "Bottle"

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "battle"
end

-- Thanks Hyperboid and accousticjamm and Somerandomguy for helping lol
function item:onBattleUse(user, target)
    target:inflictStatus("atkboost", 5, 3)
    return true
end

return item