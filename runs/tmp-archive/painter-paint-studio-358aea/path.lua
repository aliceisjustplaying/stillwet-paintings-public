-- path: centre line and half widths, perspective
PC = {{560,712},{548,690},{528,665},{506,640},{486,616},{470,596},{460,578},{455,562},{456,548},{462,537},{472,528},{484,521},{495,516}}
local hw = {}
for i,p in ipairs(PC) do hw[i] = lerp(52, 1.5, ((i-1)/(#PC-1))^0.7) end
local L, R = {}, {}
for i=1,#PC do
  local a = PC[math.max(1,i-1)]; local b = PC[math.min(#PC,i+1)]
  local dx, dy = b[1]-a[1], b[2]-a[2]; local d = math.sqrt(dx*dx+dy*dy)
  local nx, ny = -dy/d, dx/d
  L[#L+1] = {PC[i][1] + nx*hw[i], PC[i][2] + ny*hw[i]}
  R[#R+1] = {PC[i][1] - nx*hw[i], PC[i][2] - ny*hw[i]}
end
local pts = {}
for i=1,#L do pts[#pts+1] = L[i] end
for i=#R,1,-1 do pts[#pts+1] = R[i] end
PATH = poly(pts, true):roughen(1.5, 8, 71)
pathL = pile{{"lead white",3},{"yellow ochre",1.5},{"raw umber",0.4},{"red earth",0.12}, medium=0.1}
pathD = pile{{"lead white",1},{"yellow ochre",1.2},{"raw umber",0.8},{"green earth",0.3}, medium=0.1}
work(PATH, {hand="body", pile=pathD, tool="filbert 6", angle=function(x,y) return -1.0 + (y-520)/190*0.0 end, length={8,20}, coverage=1.6, fill=true, clip=true, edge="firm"})
local lit = PATH * mask(function(x,y) return smoothstep(0.35,0.6, noise{seed=9,period=30}:at01(x,y)) end)
work(lit, {hand="scumble", pile=pathL, tool="filbert 5", coverage=1.4, clip=PATH, load=0.5})
print(wait(0))
