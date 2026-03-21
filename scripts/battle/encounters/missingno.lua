local MISSINGNO, super = Class(Encounter)

function MISSINGNO:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text =
    "* You feel as though your storage fills up..."

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

function MISSINGNO:onBattleStart()
    super.onBattleStart(self)
    while Game.inventory:getFreeSpace("storage") > 0 do
        if not (Game.inventory:getItem("items", 6) == nil) then
            Game.inventory:addItemTo("storage", "F_Jello")
        else
            Game.inventory:addItemTo("storage", "The Tire-inator")
        end
    end
end

function MISSINGNO:onReturnToWorld()
end

return MISSINGNO
