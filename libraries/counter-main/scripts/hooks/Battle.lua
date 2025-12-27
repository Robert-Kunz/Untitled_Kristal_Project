---@class Battle : Battle
local Battle, super = Class(Battle)

function Battle:init()
    super.init(self)
    ---@type Counter
    self.turn_counter = Counter()
end

function Battle:nextTurn()
    self.turn_counter:tick()
    return super.nextTurn(self)
end

function Battle:afterTurns(turns, callback)
    return self.turn_counter:after(turns, callback)
end

return Battle