wSil = pile{{"lead white",3},{"green earth",1.3},{"pale smalt",0.6},{"yellow ochre",0.5},{"raw umber",0.1}, medium=0.08}
wSil2 = pile{{"lead white",5},{"green earth",0.9},{"pale smalt",0.5},{"yellow ochre",0.7},{"chrome yellow",0.08}, medium=0.08}
rodP = pile{{"lead white",2},{"green earth",1.4},{"yellow ochre",0.6},{"raw umber",0.4},{"pale smalt",0.3}, medium=0.08}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local hy = y - 32*s
  local m = CROWN2[i]
  local wid = math.max(1.0, 2.4*s)
  -- silver-grey clusters on the upper and left, in clumps
  local up = m * mask(function(xx,yy) local d = (yy - (hy - 45*s))/(40*s) - (xx - x)/(90*s); return 1 - smoothstep(0.1, 0.9, d) end)
  stipple(up, {pile=wSil, width=wid, coverage=function(xx,yy) return 2.0*up:at(xx,yy) end, pressure={0.5,0.85}, cluster={0.75, 6*s+2}, feather=0.6, dips={8,0.7,0.4}})
  local top = m * mask(function(xx,yy) local dx, dy = (xx - x + 14*s)/(26*s), (yy - hy + 48*s)/(22*s); return 1 - smoothstep(0.2, 1.0, math.sqrt(dx*dx+dy*dy)) end)
  stipple(top, {pile=wSil2, width=wid*0.85, coverage=function(xx,yy) return 1.4*top:at(xx,yy) end, pressure={0.45,0.8}, cluster={0.8, 4*s+2}, feather=0.7, dips={6,0.6,0.4}})
  -- rods standing out of the crown edge
  local rb = brush{kind="rigger", width=math.max(0.5, 0.9*s), point=1}
  rb:load(rodP, 0.5)
  local n = math.floor(10 + 14*s)
  for k=1,n do
    local a = -math.pi/2 + rand(-1.5, 1.5)
    local r0 = rand(12, 22)*s
    local sx, sy = x + math.cos(a)*r0, hy - 22*s + math.sin(a)*r0*0.9
    local len = rand(10, 22)*s
    local a2 = a*0.8 - math.pi/2*0.2
    rb:stroke({{sx,sy},{sx+math.cos(a2)*len*0.5 + rand(-1,1)*s, sy+math.sin(a2)*len*0.5},{sx+math.cos(a2)*len, sy+math.sin(a2)*len - 2*s}}, {pressure={0.45,0.0}})
    if rb:fullness() < 0.25 then rb:reload(rodP, 0.5) end
  end
end
print(wait(0))
