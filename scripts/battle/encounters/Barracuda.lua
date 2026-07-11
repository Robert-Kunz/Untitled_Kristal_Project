local Barracuda, super = Class(Encounter)

function Barracuda:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Just Beats fill the area."

    -- Battle music ("battle" is rude buster)
    self.music = "battle/Barracuda"
    -- Enables the purple grid battle background
    self.background = false

    -- Add the dummy enemy to the encounter
    self:addEnemy("Barracuda", 5 / 6 * 640, 240)

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    self.no_end_message = true
    local presence = Kristal.getPresence()
    presence.state = "Snakes, Why did it have to be snakes?"
    Kristal.setPresence(presence)
end

function Barracuda:onReturnToWorld()
    local presence = Kristal.getPresence()
    presence.state = "Testing Stuff"
    Kristal.setPresence(presence)
    Game:setFlag("afterimage", false)
end

return Barracuda
