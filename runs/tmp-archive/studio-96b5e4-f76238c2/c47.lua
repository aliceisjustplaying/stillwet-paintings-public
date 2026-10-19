t_mid2 = pile{{"raw umber",1},{"smalt",0.6},{"green earth",0.6},{"lead white",0.55},{"bone black",0.12},{"red earth",0.05}, medium=0.08}
work(treesR, {hand="detail", pile=t_mid2, angle=function(x,y) return -1.2+0.5*math.sin(x/9+y/7) end, coverage=2.6, length={4,10}, tool={kind="round", width=2.6, point=0.3}, fill=true, clip=true, dips={6,0.8,0.3}})
local cr = {{830,405,45,22},{880,400,40,20},{790,420,40,18},{920,420,40,18}}
local top, lrim = nil, nil
for _,e in ipairs(cr) do
  local cx,cy,rx,ry = e[1],e[2],e[3],e[4]
  local t = ellipse(cx+0.05*rx, cy-0.45*ry, 0.75*rx, 0.5*ry)
  local l = ellipse(cx,cy,rx,ry) - ellipse(cx+0.2*rx, cy+0.1*ry, rx, ry)
  top = top and (top+t) or t; lrim = lrim and (lrim+l) or l
end
local tr_top = pile{{"raw umber",1},{"smalt",0.6},{"green earth",0.5},{"lead white",1.0}, medium=0.08}
local tr_rim = pile{{"yellow ochre",1},{"red earth",0.3},{"lead white",0.7},{"smalt",0.2}, medium=0.08}
stipple(top:roughen(3,8,121) * treesR, {pile=tr_top, width=2.2, coverage=0.8, pressure={0.3,0.5}, cluster=0.5, feather=0.4})
stipple(lrim:roughen(2,6,122) * (treesR - treesR:shrink(6)), {pile=tr_rim, width=1.8, coverage=0.7, pressure={0.3,0.5}, cluster=0.4, feather=0.4})
