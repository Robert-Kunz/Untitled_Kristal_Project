local Tire, super = Class(Item, "The Tire-inator")
function Tire:init()
    super.init(self)
    self.enableStatBuffCountdown = false
    self.statBuffCountdown = 0
    -- Display name
    self.name = "Tire"
    -- Name displayed when used in battle (optional)
    self.use_name = "Tire-Inator! You see perry the platypus..."

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "I'm-a Tire!"
    -- Shop description
    self.shop = "Tire, NOW"
    -- Menu description
    self.description = "what do you mean this is for testing only?"
    -- Light world check text
    self.check = "You see a paper cutout of a ray gun"

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

function Tire:onBattleUse(user, target)
    target:setTired(true)
    return true
end

return Tire
