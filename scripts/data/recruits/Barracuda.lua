local Barracuda, super = Class(Recruit)

function Barracuda:init()
    super.init(self)

    self.name = "Barracuda"

    self.recruit_amount = 1

    self.description = "One of the four bosses,\nreluctant to friendship."
    self.chapter = "JSAB"
    self.level = 10
    self.attack = 10
    self.defense = 3
    self.element = "Corruption:Snake"
    self.like = "Corruption, Snakes"
    self.dislike = "Uncorrupted"

    self.box_gradient_type = "dark"

    self.box_gradient_color = { 1, 168 / 255, 72 / 255, 1 }

    self.box_sprite = { "bullets/cuda", 0, 0, 1 / 3 }

    self.recruited = 0
end

return Barracuda
