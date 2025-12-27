local spell, super = Class(Spell, "Spicy_Nectar")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "S. Nectar"
    -- Name displayed when cast (optional)
    self.cast_name = "her Egg"

    -- Battle description
    self.effect = "Spicy\nPiss"
    -- Menu description
    self.description = "Buffs 1 Party Member's Attack temporarily\n in exchange for dealing damage to them."

    -- TP cost
    self.cost = 25

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = { "Buffs" }
end

function spell:getCastMessage(user, target)
    return ("* " + user.chara:getName() + " tossed her Egg!\n* Though she left to get another one...")
end

function spell:onCast(user, target)
    target:inflictStatus("atkboost", 5, 6)
    target:hurt(60)
    user:hurt(math.huge)
end

return spell
