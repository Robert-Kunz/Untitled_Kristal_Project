local Teste, super = Class(Encounter)

function Teste:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Something's fishy here\n* Times three"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("Test")

    --- Uncomment this line to add another!
    self:addEnemy("Test")

    self:addEnemy("Test")
end

return Teste