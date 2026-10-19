--@ chunk 1
print(string.format("%s", setmetatable({}, {__tostring = function() return {} end})))
