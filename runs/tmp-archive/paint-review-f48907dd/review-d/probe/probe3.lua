--@ chunk 1
canvas{style="friedrich", aspect=1.4, seed=7}
--@ chunk 2
local ok, e = pcall(mask, function() error({}) end)
print("mask cb table err:", ok, e)
local ok2, e2 = pcall(mask, function() error(function() end) end)
print("mask cb fn err:", ok2, e2)
local ok3, e3 = pcall(mask, function() return {} end)
print("mask cb returns table:", ok3, e3)
