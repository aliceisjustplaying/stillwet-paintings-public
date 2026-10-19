--@ chunk 1
local n = 0; print(load(function() n = n + 1; if n == 1 then return {} end end))
