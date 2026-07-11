local Fifty, super = Class(Recruit)

function Fifty:init()
    super.init(self)

    self.name = "Honeywisp"

    self.recruit_amount = 1

    self.description = "A timid Honeywisp,\ndon't traumatise her please..."
    self.chapter = "PikRP"
    self.attack = 2
    self.level = 0
    self.defense = 0
    self.element = "Spectral"
    self.like = "Nectar, Winged"
    self.dislike = "The Voices"

    self.box_gradient_type = "bright"

    self.box_gradient_color = { 1, 168 / 255, 72 / 255, 1 }

    self.box_sprite = { "party/Honeywisp/dark/battle/idle", 0, 0, 0.08 }

    self.recruited = true
end

return Fifty
