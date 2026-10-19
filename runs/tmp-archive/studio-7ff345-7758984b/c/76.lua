print(type(oakDead), type(oakSegs2), oakSegs2 and #oakSegs2)
local s = oakSegs2 and oakSegs2[1]
if type(s)=="table" then for k,v in pairs(s) do print(k, type(v)=="table" and #v or v) end end
print(drying(240,200), drying(300,150), drying(230,100))
