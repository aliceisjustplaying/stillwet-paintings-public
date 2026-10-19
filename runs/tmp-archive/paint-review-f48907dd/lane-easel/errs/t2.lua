--@ chunk 1
print(setmetatable({}, {__tostring = function() return {} end}))
