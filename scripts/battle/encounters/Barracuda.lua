local Barracuda, super = Class(Encounter)

function Barracuda:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Just Beats fill the area."

    -- Battle music ("battle" is rude buster)
    self.music = "battle/Barracuda"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("Barracuda", 5 / 6 * 640, 240)

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    self.no_end_message = true
end

return Barracuda
