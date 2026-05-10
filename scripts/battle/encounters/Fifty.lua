local Fifty, super = Class(Encounter)

function Fifty:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Spores begin to fill the area"

    -- Battle music
    self.music = "battle/The_Path_of_Justice"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    if Game:getFlag("Birthday", false) then
        self:addEnemy("Test")
        self:addEnemy("Fifty")
        self:addEnemy("Test")
    else
        self:addEnemy("Fifty")
    end
    -- removes the end message
    self.no_end_message = false

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    if Game:getFlag("Birthday", false) then
        local presence = Kristal.getPresence()
        presence.state = "Birthday Bash, baby!"
        Kristal.setPresence(presence)
    else
        local presence = Kristal.getPresence()
        presence.state = "Filthy Parody"
        Kristal.setPresence(presence)
    end
end

function Fifty:onReturnToWorld()
    local presence = Kristal.getPresence()
    presence.state = "Testing Stuff"
    Kristal.setPresence(presence)
end

return Fifty
