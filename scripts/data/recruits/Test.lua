local Sushi, super = Class(Recruit)

function Sushi:init()
    super.init(self)

    self.name = "Sushi"

    self.recruit_amount = 3

    self.description = "A Piece of sushi...\n\nor is it?"
    self.chapter = "???"
    self.level = 4
    self.attack = 7
    self.defense = 2
    self.element = "FISH:WATER"
    self.like = "Fish"
    self.dislike = "Cats"

    self.box_gradient_type = "bright"

    self.box_gradient_color = { 1, 168 / 255, 72 / 255, 1 }

    self.box_sprite = { "enemies/Test/idle", 0, 0, 1 / 3 }

    self.recruited = 0
end

return Sushi
