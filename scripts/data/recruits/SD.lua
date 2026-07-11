local Fifty, super = Class(Recruit)

function Fifty:init()
    super.init(self)

    self.name = "Sushi-dieb"

    self.recruit_amount = 1

    self.description = "The main Vessel.\nTends to break the 4th wall."
    self.chapter = "RPG"
    self.attack = 15
    self.level = 0
    self.defense = 2
    self.element = "Creation, Deletion"
    self.like = "Nature, Solitude(kinda)"
    self.dislike = "Fifty, A shit ton more"

    self.box_gradient_type = "bright"

    self.box_gradient_color = { 1, 168 / 255, 72 / 255, 1 }

    self.box_sprite = { "party/SD/dark/battle/idle", 0, 0, 0.2 }

    self.recruited = true
end

return Fifty
