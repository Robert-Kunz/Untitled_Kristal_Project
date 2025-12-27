---@class Counter
local Counter = Class()

function Counter:init(start_value)
    self.value = start_value or 0
    self.timer = Timer()
end

function Counter:tick()
    self.value = self.value + 1
    local old_dt, old_dtmult = DT, DTMULT
    DT, DTMULT=1, 30
    self.timer:update()
    DT, DTMULT = old_dt, old_dtmult
end

function Counter:after(ticks, callback)
    return self.timer:after(ticks,callback)
end

function Counter:clear() return self.timer:clear() end
function Counter:every(delay, func, count) return self.timer:every(delay, func, count) end
function Counter:script(func) return self.timer:script(func) end
function Counter:everyInstant(delay, func, count) return self.timer:everyInstant(delay, func, count) end
function Counter:cancel(handle) return self.timer:cancel(handle) end


return Counter