local Challenge, super = Class(Encounter)

function Challenge:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The air fills with a looming sense of dread"

    -- Battle music
    self.music = "Barracuda"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("Fifty")
    self:addEnemy("Barracuda")
    self:addEnemy("Test")

    -- removes the end message
    self.no_end_message = false

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function Challenge:onReturnToWorld()
    Game.world:startCutscene("Fifty", "Leave")
    end

return Challenge