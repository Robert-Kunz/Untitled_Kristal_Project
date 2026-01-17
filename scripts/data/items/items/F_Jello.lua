local item, super = Class(HealItem, "F_Jello")

function item:init()
    super.init(self)

    -- Display name
    self.name = "F_Jell-0"
    -- Name displayed when used in battle (optional)
    self.use_name = "Foolix Jell-0"

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "shaky..."
    -- Shop description
    self.shop = "ooooo"
    -- Menu description
    self.description = "A Jell-O like Form.\nIt resembles an old fooling friend..."

    -- Amount healed (HealItem variable)
    self.heal_amount = 100
    self.heal_amount_other = 30

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        HW = "I-I'm gonna be sick...",
        SD = "Isn't this a...?"
    }
end

function item:onWorldUse(target)
    Kristal.Console:log("yes this is even running")
    if target == Game:getPartyMember("HW") then
        Game.world:hurtParty("HW", self.heal_amount_other)
        target.health = MathUtils.clamp(target.health, 1, 50)
        return
    else
        return super.onWorldUse(self, target)
    end
end

function item:onBattleUse(user, target)
    if target.actor.name == "Honeywisp" then
        if self.heal_amount_other >= target.chara.health then
            target:hurt(target.chara.health - 1)
        else
            target:hurt(self.heal_amount_other)
        end
        target:inflictStatus("numb", 2)
    else
        target:heal(self.heal_amount)
    end
    return true
end

return item
