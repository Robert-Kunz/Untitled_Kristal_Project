local Challenge, super = Class(Encounter)

function Challenge:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* 'Of course... of course on my birthday...'"

    -- Battle music
    self.music = "battle/Barracuda"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("Test")
    self:addEnemy("Fifty_Birthday")
    self:addEnemy("Test")

    -- removes the end message
    self.no_end_message = false

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    local presence = Kristal.getPresence()
    presence.state = "Birthday Bash"
    Kristal.setPresence(presence)
end

function Challenge:onReturnToWorld()
    local presence = Kristal.getPresence()
    presence.state = "Testing Stuff"
    Kristal.setPresence(presence)
end

return Challenge
