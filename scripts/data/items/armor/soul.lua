local item, super = Class(Item, "PS")

function item:init()
    super.init(self)
    -- Display name

    self.name = "PURE SOUL"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/soul"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description =
    "The [color:red]SOUL[color:reset]'s own kind of 'armor'.\n[color:red]It[color:reset] [color:yellow]clings[color:reset] to this object...?"

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        defense = 2,
        magic = 2,
        health = 20
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = { { 1, 0, 0 }, "Control UP" }
    self.bonus_icon = "ui/menu/icon/soul"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {
        SD = "Guess you do have some benefit...",
        Honeywisp = "*shaking* (T-the voices a-are back...)",
    }
end

function item:onEquip(character, replacement)
    return super.onEquip(self, character, replacement)
end

function item:onUnequip(character, replacement)
    local index = 1 -- the first action box, so probably Kris
    if character:getName() == "HW" then
        Game.world.healthbar:react(character, { { 1, 0, 0 }, ("GET YOUR HANDS OF ME, HONEYWISP") })
    else
        Game.world.healthbar:react(character, { { 1, 0, 0 }, ("GET YOUR HANDS OF ME, " + character:getName()) })
    end
    return false
end

return item
