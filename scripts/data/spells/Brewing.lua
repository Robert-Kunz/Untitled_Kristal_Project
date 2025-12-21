local spell, super = Class(Spell, "Brewing")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Brewing"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Jesse we \nneed to cook"
    -- Menu description
    self.description = "Creates a health \nand strength potion."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "none"

    -- Tags that apply to this spell
    self.tags = {"Item"}
end
function spell:getCastMessage(user, target)
    if Game.inventory:hasItem("Bottle") then
        Game.inventory:removeItem("Bottle")
        if Game.inventory:hasItem("Bottle") then
            Game.inventory:tryGiveItem("Bottle")
            return ("* " + user.chara:getName() + " brewed up a Healing P.\n* And a Strength Potion!")
        else
            Game.inventory:tryGiveItem("Bottle")
            return ("* " + user.chara:getName() + " brewed up a Healing P.,\n[wait:8]* But had no empty Bottle for the Strength Potion!")
        end
    else
        return ("* " + user.chara:getName() + " tried to brew up two Potions...\n[wait:8]* But had no empty Bottles for them!")
    end
end

function spell:onCast()
    if Game.inventory:hasItem("Bottle") then
        Game.inventory:removeItem("Bottle")
        Game.inventory:tryGiveItem("Potion")
    end
    if Game.inventory:hasItem("Bottle") then
        Game.inventory:removeItem("Bottle")
        Game.inventory:tryGiveItem("Strength_Potion")   
    end
end

return spell