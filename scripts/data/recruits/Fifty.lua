local Fifty, super = Class(Recruit)

function Fifty:init()
    super.init(self)

    self.name = "Fifty"

    self.recruit_amount = 1

    self.description = "An annoying Mushroom.\nNot to be confused with a Toad."
    self.chapter = "RPG"
    self.level = "?"
    self.attack = "no"
    self.defense = "no"
    self.element = "Mushroom, Magic"
    self.like = "Organic"
    self.dislike = "Nature"

    self.box_gradient_type = "dark"

    self.box_gradient_color = { 1, 168 / 255, 72 / 255, 1 }

    self.box_sprite = { "party/Fifty/battle/idle", 10, 0, 0.15 }

    self.recruited = 0
end

return Fifty
