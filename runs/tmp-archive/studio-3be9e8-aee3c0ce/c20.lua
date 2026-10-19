local jb = jugBody + spout
jSil = jf:silhouette{}
jEdgeL = (jb - jSil) * rect(0, 150, 362, 480)
jLightEdge = pile{{"lead white",5},{"yellow ochre",0.5},{"raw umber",0.2},{"green earth",0.1}}
work(jEdgeL:grow(3) * jb, {hand="body", tool="filbert 6", pile=jLightEdge, coverage=2.5, angle=function(x,y) return jf:across(x,y) + 0.6 end, length={12,30}, edge="firm", fill=true})
-- terminator band
local band = jb * jSil * jVal:map(function(v) return clamp(1 - math.abs(v - 0.42)/0.07, 0, 1) end)
blend(band:grow(4), {tool={kind="badger", width=12}, angle=function(x,y) return jf:across(x,y) end})
