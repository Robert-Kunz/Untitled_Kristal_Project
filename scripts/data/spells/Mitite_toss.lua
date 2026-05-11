local spell, super = Class(Spell, "Mitite_toss")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "M. toss"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "ugly\ncreature"
    -- Menu description
    self.description = "Tosses a Mitite at the enemy\nDeals little damage, though distracts them."

    -- TP cost
    self.cost = 60

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = { "" }
end

function spell:getCastMessage(user, target)
    if user:hasStatus("mititeless") then
        return { ("* " .. user.chara:getName() .. " tossed an Empty egg..."),
            "* She left to get another one.\n* [color:yellow](don't use Mitite Toss with the mititeless status!)[color:reset]" }
    else
        return ("* " .. user.chara:getName() .. " tossed her Egg!\n* Though she left to get another one...")
    end
end

function spell:onCast(user, target)
    if user:hasStatus("mititeless") then
        for _, v in ipairs(Game.battle:getActiveEnemies()) do
            v:hurt(20)
        end
        user:hurt(math.huge)
    else
        for _, v in ipairs(Game.battle:getActiveEnemies()) do
            v:hurt(20)
            v:inflictStatus("atknerf", 3, 5)
            v:inflictStatus("defnerf", 3, 2)
        end
        user:inflictStatus("mititeless", 3)
        user:hurt(math.huge)
    end
end

return spell
