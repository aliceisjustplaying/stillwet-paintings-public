WL = {{35,580,1.0},{112,563,0.8},{178,550,0.64},{231,539,0.52},{274,531,0.43},{309,524,0.35},{338,519,0.29},{361,515,0.24},{380,512,0.2},{396,510,0.17}}
-- ditch: a dark bank line and water glint in front of the willows
local dpts, wpts = {}, {}
for x = -10, 420, 10 do
  local y = 583 - 0.176*(x+10)  -- rough line through bases
  y = 583 - (583-509)*((x+10)/430)^0.8
  dpts[#dpts+1] = {x, y+4}
  wpts[#wpts+1] = {x, y+6}
end
local ditchW = {}
for i,p in ipairs(dpts) do ditchW[i] = lerp(7, 1.2, (i-1)/(#dpts-1)) end
DITCH = ribbon(dpts, ditchW)
local bankD = pile{{"raw umber",1},{"green earth",1.2},{"Prussian blue",0.25},{"yellow ochre",0.6},{"lead white",0.3}, medium=0.1}
work(DITCH, {hand="detail", pile=bankD, angle=-0.17, length={8,20}, coverage=2, clip=true, fill=true})
local ww = {}
for i,p in ipairs(wpts) do ww[i] = lerp(2.4, 0.5, (i-1)/(#wpts-1)) end
DWATER = ribbon(wpts, ww) * mask(function(x,y) return (math.sin(x/9)+math.sin(x/23)) > -0.6 and 1 or 0 end)
local glint = pile{{"lead white",6},{"pale smalt",1.2},{"smalt",0.2}, medium=0.1}
work(DWATER, {hand="detail", pile=glint, angle=-0.17, length={6,16}, coverage=1.5, clip=true})
-- trunks
trunkD = pile{{"raw umber",1.2},{"bone black",0.3},{"lead white",0.6},{"yellow ochre",0.3}, medium=0.08}
trunkL = pile{{"lead white",2},{"raw umber",0.8},{"yellow ochre",0.5},{"pale smalt",0.3}, medium=0.08}
TRUNKS = nil
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local pts = {{x-4.5*s, y+1}, {x-6*s, y+2*s}, {x-4.8*s, y-8*s}, {x-4.2*s, y-22*s}, {x-7*s, y-30*s}, {x-3*s, y-34*s}, {x+2*s, y-33*s}, {x+7.5*s, y-31*s}, {x+4.6*s, y-22*s}, {x+4.6*s, y-8*s}, {x+6.5*s, y+2*s}, {x+4.5*s, y+1}}
  local t = poly(pts, true)
  TRUNKS = TRUNKS and (TRUNKS + t) or t
  work(t, {hand="detail", pile=trunkD, tool={kind="round", width=math.max(0.8, 2*s), point=0.4}, angle=math.pi/2, length={3,10}, coverage=2.5, clip=true, fill=true, edge="found"})
  local lit = t * mask(function(xx,yy) return xx < x - 1.2*s and 1 or 0 end)
  work(lit, {hand="detail", pile=trunkL, tool={kind="round", width=math.max(0.7, 1.4*s), point=0.4}, angle=math.pi/2, length={2,7}, coverage=1.4, clip=true})
end
print(wait(0))
