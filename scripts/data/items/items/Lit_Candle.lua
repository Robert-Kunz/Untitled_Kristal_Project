local item, super = Class(Item, "Lit Candle")
function item:init()
    super.init(self)
    self.enableStatBuffCountdown = false
    self.statBuffCountdown = 0
    -- Display name
    self.name = "L.C."
    -- Name displayed when used in battle (optional)
    self.use_name = "Lit Candle!"

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "I'M\nBURNIN"
    -- Shop description
    self.shop = "Burn..."
    -- Menu description
    self.description = "Gives off a nice glow...\nApplies burning to one enemy"
    -- Light world check text
    self.check = nil

    -- Default shop price (sell price is halved)
    self.price = 500
    -- Whether the item can be sold
    self.can_sell = false

    self.result_item = nil

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "battle"
end

function item:onBattleUse(user, target)
    target:inflictStatus("burn", 3)
    return
end

return item
