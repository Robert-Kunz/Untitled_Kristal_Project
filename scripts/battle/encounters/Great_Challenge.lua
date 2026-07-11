local Challenge, super = Class(Encounter)

function Challenge:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The air fills with a looming sense of dread"

    -- Battle music
    self.music = "battle/Barracuda"
    -- Enables the purple grid battle background
    self.background = false

    -- Add the dummy enemy to the encounter
    self:addEnemy("Fifty")
    self:addEnemy("Barracuda", 5 / 6 * 640, 300)
    self:addEnemy("Test")

    -- removes the end message
    self.no_end_message = false

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    local presence = Kristal.getPresence()
    presence.state = "LET THE CHALLENGE BEGIN!"
    Kristal.setPresence(presence)
end

function Challenge:onReturnToWorld()
    local presence = Kristal.getPresence()
    presence.state = "Testing Stuff"
    Kristal.setPresence(presence)
    Game:setFlag("afterimage", false)
end

function Challenge:getNextWaves()
    for _, attack in pairs(super.getNextWaves(self)) do
        if attack == "Barracuda/Final_Attack" then
            return { "Barracuda/Final_Attack" }
        end
    end
    return super.getNextWaves(self)
end

return Challenge
