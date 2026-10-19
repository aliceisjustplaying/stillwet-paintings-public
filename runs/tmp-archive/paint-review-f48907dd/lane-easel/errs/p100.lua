--@ chunk 1
local t, f = {}, function() end
print(t, f, print, string.format("%s", {}), tostring(setmetatable({}, {__name="N"})))
local ok, e = pcall(error, {}); print(e)
