local top = {{556,394},{572,383},{590,373},{618,362},{640,350},{648,334},{660,318},{680,311},{700,317},{712,303},{730,287},{750,273},{770,266},{790,268},{804,282},{822,290},{842,297},{860,305},{874,318},{898,329},{924,332},{946,340},{966,346},{986,352},{1004,360}}
local n = noise{seed=17, octaves=3, period=25}
local pts = {}
for i,p in ipairs(top) do pts[#pts+1] = {p[1], p[2]-1} end
for i=#top,1,-1 do
  local p = top[i]
  pts[#pts+1] = {p[1]+3, p[2] + 13 + 8*n(p[1],p[2])}
end
litTopM = poly(pts, true):roughen(2.5, 14, 3)
cl2 = pile{{"lead white",14},{"yellow ochre",0.3},{"vermilion",0.05}}
work(litTopM, {hand="body", tool="filbert 4", pile=cl2, angle=function(x,y) return cloudF:across(x,y) end, coverage=2.2, fill=true, pressure={0.45,0.75}, edge={found=0.7, soft=0.3}, seed=111})
-- inner billow rims
local rims = {
 {{690,338},{705,328},{722,322},{742,322},{756,330}},
 {{770,312},{785,302},{800,300},{812,308}},
 {{800,338},{815,328},{835,326},{852,334},{862,345}},
 {{880,350},{900,342},{922,343},{940,352}},
 {{612,378},{628,370},{648,368},{664,374}},
 {{940,366},{958,358},{978,360},{996,368}},
}
for j,r in ipairs(rims) do
  local rp = {}
  for i,p in ipairs(r) do rp[#rp+1] = {p[1], p[2]+3} end
  local m = ribbon(rp, 6):roughen(2, 10, 20+j)
  work(m, {hand="body", tool="filbert 3", pile=cl2, angle=0.1, coverage=1.8, pressure={0.4,0.6}, edge={found=0.6, soft=0.4}, seed=120+j})
end
