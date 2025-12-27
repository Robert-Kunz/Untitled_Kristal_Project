local mititeless, super = Class(StatusCondition)

function mititeless:init()
    super.init(self)

    self.name = "Mitite- Gone"

    self.desc = ("While this Status is on a character, that character can't use the Mitite Toss(M. toss) spell's effects. The Tp still get used and the User still dies regardless")

    self.default_turns = 2

    self.icon = "ui/status/dedmitite"
end

return mititeless
