--@ chunk 3
-- N1 leak probes (print outputs only)
local ok, e = pcall(ribbon, "bad")
print("api error object:", type(e), e)
print("fmt api err:", string.format("%s", e))
print("width p:", pcall(string.format, "%10p", {}))
print("format %-5.2s:", string.format("[%-5.2s]", {}))
print("tostring C fn:", tostring(print), tostring(string.format), tostring(tostring))
print("concat err:", pcall(function() return {} .. "" end))
print("compare err:", pcall(function() return {} < {} end))
print("call err:", pcall(function() local t = {} t() end))
print("index err:", pcall(function() local t = setmetatable({}, {__name = "N"}) return #t + nil end))
--@ chunk 4
-- C-stack budget: how deep can pcall-recursion go
local max = 0
local function r(d) if d > max then max = d end pcall(r, d + 1) end
r(1)
print("pcall depth:", max)
local m2 = 0
local mt = {}
mt.__index = function(t, k) m2 = m2 + 1; return setmetatable({}, mt)[k] end
pcall(function() return setmetatable({}, mt).x end)
print("__index depth:", m2)
local m3 = 0
local tm = {}
tm.__tostring = function(t) m3 = m3 + 1; return tostring(setmetatable({}, tm)) end
pcall(tostring, setmetatable({}, tm))
print("__tostring depth:", m3)
--@ chunk 5
-- keys ordering of library functions in pairs
local t = {[print] = 1, [tostring] = 2, [string.format] = 3, [load] = 4, [math.floor] = 5, [ipairs] = 6}
local o = {}
for k, v in pairs(t) do o[#o + 1] = v end
print("fn-key order:", table.concat(o, " "))
local n = 0 for k in pairs(string) do n = n + 1 end
print("string entries:", n)
