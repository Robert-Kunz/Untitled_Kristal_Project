local spell, super = Class(Spell, "Nectar")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Nectar"
    -- Name displayed when cast (optional)
    self.cast_name = "her Egg"

    -- Battle description
    self.effect = "PISS!"
    -- Menu description
    self.description = "Heals 1 party member using\nan egg that the user carries around."

    -- TP cost
    self.cost = 40

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = { "heal" }
end

function spell:getCastMessage(user, target)
    return ("* " + user.chara:getName() + " tossed her Egg!\n* Though she left to get another one...")
end

function spell:onCast(user, target)
    if not target.is_down then
        local base_heal = user.chara:getStat("magic") + (target.chara:getStat("health") / 3)
        local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara)
        target:heal(heal_amount)
    elseif target.is_down then
        local heal_amount = math.abs(target.chara:getHealth()) + (target.chara:getStat("health") / 3)
        target:heal(heal_amount)
    end
    user:hurt(math.huge)
end

return spell
