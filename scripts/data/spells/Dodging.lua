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
    self.target = "none"

    -- Tags that apply to this spell
    self.tags = {}
    self.bheal = 0
end

function spell:onCast(user, target)
    user:inflictStatus("dodge", 3)
end

function spell:getCastMessage(user, target)
    if math.random(1, 10) == 1 then
        return { "* today we got one of the easiest deltarune fangames.\n* It's just a guy in a grey suit.",
            "* I mean it's so easy even a Baby could beat this one-",
            "* Wait what do you mean this isn't a Sans variation and also not an enemy." }
    else
        return "* " .. user.chara:getName() .. " prepares to dodge oncoming attacks!"
    end
end

return spell
