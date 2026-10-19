--@ chunk 1
print(type(load), type(string.dump))
local ok, f = pcall(load, string.dump(function() return 1 end))
print("binary load:", ok and (f and "accepted" or "refused (nil)") or ("error: " .. tostring(f)))
print("tostring(table):", tostring({}))
print("%p:", pcall(string.format, "%p", {}))
