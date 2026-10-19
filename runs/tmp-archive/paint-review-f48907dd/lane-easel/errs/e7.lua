--@ chunk 1
print(setmetatable({}, {__tostring = function() error("inner") end}))
