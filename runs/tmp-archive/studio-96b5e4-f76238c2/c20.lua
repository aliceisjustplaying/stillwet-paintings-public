clumps = {{185,285,30,24},{160,305,34,27},{212,308,36,30},{175,335,50,35},{218,345,44,35},{148,362,44,35},{195,375,60,38},{168,400,58,24},{228,398,38,24},
 {300,322,34,28},{332,345,40,32},{278,352,36,30},{312,375,55,38},{348,388,40,30},{288,402,52,24},{330,410,40,18},
 {75,352,30,28},{52,385,44,35},{102,378,34,32},{75,405,50,22},{30,410,26,20},
 {396,388,24,22},{412,410,27,20},{384,414,24,15}}
t_base = pile{{"raw umber",1},{"bone black",0.3},{"green earth",1.1},{"smalt",0.25},{"lead white",0.15}, medium=0.08}
t_under = pile{{"raw umber",1},{"bone black",0.6},{"green earth",0.5}, medium=0.08}
t_top = pile{{"raw umber",1},{"green earth",1},{"lead white",0.55},{"smalt",0.35},{"yellow ochre",0.2}, medium=0.08}
local cm = crowns * above(function(x) return 446 end)
work(cm, {hand="body", pile=t_base, angle=function(x,y) return -1.0+0.5*math.sin(x/17+y/13) end, coverage=2.4, length={6,18}, tool="filbert 5", fill=true, clip=true, dips={4,0.8,0.3}})
-- undersides and tops per clump
local und, top = nil, nil
for _,e in ipairs(clumps) do
  local cx,cy,rx,ry = e[1],e[2],e[3],e[4]
  local u = ellipse(cx-0.05*rx, cy+0.45*ry, 0.8*rx, 0.5*ry) * ellipse(cx,cy,rx,ry)
  local t = ellipse(cx+0.1*rx, cy-0.4*ry, 0.7*rx, 0.5*ry) * ellipse(cx,cy,rx,ry)
  und = und and (und + u) or u
  top = top and (top + t) or t
end
clump_und = (und:roughen(4, 10, 61)) * cm
clump_top = (top:roughen(4, 10, 62) - clump_und) * cm
stipple(clump_und, {pile=t_under, width=4, coverage=1.3, pressure={0.4,0.7}, cluster=0.4, feather=0.3})
stipple(clump_top, {pile=t_top, width=3.5, coverage=0.9, pressure={0.3,0.6}, cluster=0.5, feather=0.4})
