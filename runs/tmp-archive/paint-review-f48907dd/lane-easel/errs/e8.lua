--@ chunk 1
local function f(n) return f(n + 1) + 1 end f(1)
