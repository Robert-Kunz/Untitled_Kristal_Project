local spell, super = Class(Spell, "Deletion")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Delete"
    -- Name displayed when cast (optional)
    self.cast_name = "Delete"

    -- Battle description
    self.effect = "It's...\nGone..."
    -- Menu description
    self.description = "You wouldn't... \nuse this spell... right?"

    -- TP cost
    self.cost = 0   

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = {"Fatal"}
end

function spell:getCastMessage(user, target)
    if Game.battle:getEnemyBattler("Fifty") then
    return nil
    end
    return ("* "+ user.chara:getName() + " cast Deletion!")
end

function spell:onCast(user, target)
    if Game.battle:getEnemyBattler("Fifty") then
        Game.battle:startActCutscene("Deletion", "Deletion")
    else
    local object = SnowGraveSpell(user)
    object.damage = self:getDamage(user, target)
    Game.battle:addChild(object)
    return false
    end
end

function spell:getDamage(user, target)
    return math.huge
end

return spell