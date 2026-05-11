local spell, super = Class(Spell, "Vanish")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Vanish"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Spoopy"
    -- Menu description
    self.description = "Vanishes from the Battlefield causing all\nattacks that would hit to miss for a turn"

    -- TP cost
    self.cost = 70

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "none"

    -- Tags that apply to this spell
    self.tags = { "heal" }
end

function spell:getCastMessage(user, target)
    return ("* " .. user.chara:getName() .. " vanished!")
end

function spell:onCast(user, target)
    user:inflictStatus("vanished", 1)
end

return spell
