local Fifty, super = Class(Encounter)

function Fifty:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Spores begin to fill the area"

    -- Battle music
    self.music = "The_Path_of_Justice"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("Fifty")

    -- removes the end message
    self.no_end_message = false

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function Fifty:onReturnToWorld()
    Game.world:startCutscene("Fifty", "Leave")
    end

return Fifty