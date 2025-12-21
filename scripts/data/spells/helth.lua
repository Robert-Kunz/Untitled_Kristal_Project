local spell, super = Class(Spell, "helth")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "helth"
    -- Name displayed when cast (optional)
    self.cast_name = "random bs healing"

    -- Battle description
    self.effect = "random bs\ngo!"
    -- Menu description
    self.description = "Heals 1 party member using\nthe best bs reason SD could come up with."

    -- TP cost
    self.cost = 90

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"heal"}
    self.bheal = 0
end

function spell:onCast(user, target)
    if self.cost > 40 then
    self.cost = self.cost - 1
    self.bheal = self.bheal + 3
    end
    local base_heal = user.chara:getStat("magic") + 23 + self.bheal
    local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara)
    target:heal(heal_amount)
end

return spell