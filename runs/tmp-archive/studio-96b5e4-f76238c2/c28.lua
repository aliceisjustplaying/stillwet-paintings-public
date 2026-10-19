t_rim = pile{{"yellow ochre",1},{"red earth",0.25},{"lead white",0.5},{"green earth",0.4},{"raw umber",0.2}, medium=0.1}
local cres = nil
for _,e in ipairs(clumps) do
  local cx,cy,rx,ry = e[1],e[2],e[3],e[4]
  local c = ellipse(cx,cy,rx,ry) - ellipse(cx-0.22*rx, cy+0.12*ry, rx, ry)
  cres = cres and (cres + c) or c
end
local cm = crowns * above(function(x) return 446 end)
rimR = cres:roughen(2, 6, 91) * (cm - cm:shrink(9))
stipple(clump_und, {pile=t_under, width=3, coverage=0.8, pressure={0.35,0.6}, cluster=0.6, feather=0.4, drag=1.5})
stipple(clump_top, {pile=t_top, width=2.6, coverage=0.7, pressure={0.3,0.55}, cluster=0.6, feather=0.5, drag=1.5})
stipple(rimR, {pile=t_rim, width=2.2, coverage=0.8, pressure={0.3,0.55}, cluster=0.5, feather=0.5, drag=1.2})
