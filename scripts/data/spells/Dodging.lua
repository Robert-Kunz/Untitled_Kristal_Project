local spell, super = Class(Spell, "Dodging")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Dodge"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Sans\nUndertale"
    -- Menu description
    self.description = "User prepares to Dodge attacks that hit\n(1 in 2 chance to trigger)"

    -- TP cost
    self.cost = 90

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = { "heal" }
    self.bheal = 0
end

function spell:onCast(user, target)
    user:inflictStatus("dodge", 3)
end

function spell:getCastMessage(user, target)
    return "* " + user + " prepared to dodge oncoming attacks!"
end

return spell
