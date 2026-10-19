--@ chunk 1
local a = utf8.codes("a")
local b = utf8.codes("a", true)
local c = ipairs({})
local t = {[a]="strict", [b]="lax", [c]="ipairs", [{}]="object", x="value"}
local o = {}; for k,v in pairs(t) do o[#o+1] = v end; print(table.concat(o,","))
