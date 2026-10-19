--@ chunk 1
print(tostring(setmetatable({}, {__tostring = function() return 1 end})))
