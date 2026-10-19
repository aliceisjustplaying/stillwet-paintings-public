--@ chunk 1
local ok, e = pcall(string.format, "%d", "x"); print(e)
