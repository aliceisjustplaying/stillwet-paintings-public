jDeep = pile{{"lead white",1.5},{"raw umber",1},{"bone black",0.35},{"green earth",0.6},{"yellow ochre",0.3}}
local jb = jugBody + spout
jVal = mask(function(x,y) return jf:value(x,y) end)
local sh = jb * jVal:map(function(v) return v < 0.42 and 1 or 0 end)
sh = sh:soften(4)
work(sh, {hand="body", tool="filbert 8", pile=jDeep, coverage=2.5, angle=function(x,y) return jf:across(x,y) end, length={20,45}, edge="firm", fill=true})
