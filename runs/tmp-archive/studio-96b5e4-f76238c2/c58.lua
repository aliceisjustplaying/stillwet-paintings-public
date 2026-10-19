local cr = {{830,405,45,22},{880,400,40,20},{790,420,40,18},{920,420,40,18},{860,425,90,16}}
local top, lrim, und = nil, nil, nil
for _,e in ipairs(cr) do
  local cx,cy,rx,ry = e[1],e[2],e[3],e[4]
  local t = ellipse(cx+0.05*rx, cy-0.45*ry, 0.75*rx, 0.5*ry) * ellipse(cx,cy,rx,ry)
  local l = ellipse(cx,cy,rx,ry) - ellipse(cx+0.18*rx, cy+0.1*ry, rx, ry)
  local u = ellipse(cx, cy+0.5*ry, 0.85*rx, 0.45*ry) * ellipse(cx,cy,rx,ry)
  top = top and (top+t) or t; lrim = lrim and (lrim+l) or l; und = und and (und+u) or u
end
local tr_top = pile{{"raw umber",1},{"smalt",0.6},{"green earth",0.5},{"lead white",1.1}, medium=0.08}
local tr_rim = pile{{"yellow ochre",1},{"red earth",0.3},{"lead white",0.8},{"smalt",0.15}, medium=0.08}
local tr_und = pile{{"raw umber",1},{"smalt",0.5},{"bone black",0.25},{"green earth",0.4},{"lead white",0.2}, medium=0.08}
stipple(und:roughen(3,8,131) * treesR, {pile=tr_und, width=2.2, coverage=0.9, pressure={0.35,0.55}, cluster=0.5, feather=0.4, drag=1})
stipple(top:roughen(3,8,132) * treesR, {pile=tr_top, width=2, coverage=0.7, pressure={0.3,0.5}, cluster=0.6, feather=0.5, drag=1})
stipple(lrim:roughen(2,6,133) * (treesR - treesR:shrink(6)), {pile=tr_rim, width=1.7, coverage=0.7, pressure={0.3,0.5}, cluster=0.4, feather=0.5})
-- a few small sky holes and trunk gaps
local hole = pile{{"lead white",6},{"chrome yellow",0.4},{"vermilion",0.08},{"yellow ochre",0.1}, medium=0.1}
local r = brush{kind="round", width=1.6, point=0.3}
for _,p in ipairs({{812,432},{846,436},{893,434},{935,436},{870,408},{905,413}}) do r:reload(hole, 0.6); r:touch(p[1], p[2], {pressure=rand(0.4,0.6)}) end
