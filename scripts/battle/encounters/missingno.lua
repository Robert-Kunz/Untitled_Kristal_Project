local MISSINGNO, super = Class(Encounter)

function MISSINGNO:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text =
    "* 01001101 01001001 01010011 01010011 01001001 01001110 01000111 01001110 01001111 00100000 01100001 01110000 01110000 01110010 01101111 01100001 01100011 01101000 01100101 01110011"

    -- Battle music
    self.music = "overworld/ZZAZZ_Music"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("MISSINGNO", 3 / 4 * 640, 240)
    Kristal.Console:log(SCREEN_WIDTH)
    Kristal.Console:log(SCREEN_HEIGHT)
    -- removes the end message
    self.no_end_message = false

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function MISSINGNO:onReturnToWorld()
end

return MISSINGNO
