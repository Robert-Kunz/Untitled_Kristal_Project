local item, super = Class(HealItem, "Cake")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Cake"
    -- Name displayed when used in battle (optional)
    self.use_name = "Cake"

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "It's a\nLIE"
    -- Shop description
    self.shop = "Yum"
    -- Menu description
    self.description = "The cake is a lie.\nA few candles are lit..."

    -- Amount healed (HealItem variable)
    self.heal_amount = math.huge
    self.heal_amount_other = 40

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = "Lit Candle"
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        HW = "I-I don't...",
        SD = "mm... Love these cakes..."
    }
end

function item:getHealAmount(id)
    if id == "SD" then
        return self.heal_amount
    else
        return self.heal_amount_other
    end
end

function item:onBattleUse(user, target)
    if target.id == "SD" then
        target:heal(self.heal_amount)
    else
        target:heal(self.heal_amount_other)
    end
    target:inflictStatus("atkboost", 5, 3)
    Game.inventory:tryGiveItem("Lit Candle")
    Game.inventory:tryGiveItem("Lit Candle")
    Game.inventory:tryGiveItem("Lit Candle")
    return true
end

return item
