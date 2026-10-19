local rodD = pile{{"raw umber",1},{"green earth",0.6},{"bone black",0.3},{"lead white",0.4}, medium=0.08}
local rodL = pile{{"lead white",1.6},{"raw umber",0.6},{"yellow ochre",0.4},{"green earth",0.3},{"pale smalt",0.2}, medium=0.08}
local knob = pile{{"raw umber",1},{"green earth",0.5},{"bone black",0.2},{"lead white",0.6},{"pale smalt",0.15}, medium=0.08}
local lD = pile{{"green earth",1.6},{"raw umber",0.7},{"Prussian blue",0.3},{"yellow ochre",0.45},{"lead white",0.4}, medium=0.07}
local lM = pile{{"lead white",0.9},{"green earth",1.9},{"yellow ochre",0.75},{"pale smalt",0.45},{"raw umber",0.3},{"Prussian blue",0.06}, medium=0.07}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  -- knobbly head: a few swollen bosses on the trunk top
  local kb = nil
  for k=1,5 do
    local e = ellipse(hx + rand(-0.075,0.075)*H, hy + rand(-0.005,0.02)*H, rand(0.02,0.035)*H, rand(0.015,0.025)*H)
    kb = kb and (kb + e) or e
  end
  kb = kb:roughen(math.max(0.6,H*0.004), math.max(3,H*0.015), 7500+i) - PWCRALL:shrink(1)
  work(kb, {hand="detail", pile=knob, tool={kind="round", width=math.max(0.9,H*0.008), point=0.4}, angle=0, length={2,6}, coverage=2.5, clip=true, fill=true, load=0.8})
  -- rods from the head up into the crown
  local rb = brush{kind="rigger", width=math.max(0.6, H*0.0065), point=1}
  rb:load(rodD, 0.6)
  local n = math.floor(14 + H*0.08)
  for k=1,n do
    local sx = hx + rand(-0.08, 0.08)*H
    local sy = hy + rand(-0.005, 0.015)*H
    local a = -math.pi/2 + (sx - hx)/(0.08*H)*0.55 + randn(0, 0.22)
    local L = H*rand(0.12, 0.22)
    local bend = rand(-0.15, 0.15)
    local pts = {}
    for j=0,4 do
      local f = j/4
      local aa = a + bend*f
      pts[#pts+1] = {sx + math.cos(aa)*L*f, sy + math.sin(aa)*L*f}
    end
    rb:stroke(pts, {pressure={0.65, 0.15}, ramps={0.05,0.5}})
    if rb:fullness() < 0.3 then rb:reload(rodD, 0.6) end
  end
  -- a few lit rods on the left
  rb:reload(rodL, 0.5)
  for k=1,math.floor(4 + H*0.02) do
    local sx = hx + rand(-0.08, -0.01)*H
    local sy = hy + rand(-0.005, 0.01)*H
    local a = -math.pi/2 + (sx - hx)/(0.08*H)*0.55 + randn(0, 0.2)
    local L = H*rand(0.1, 0.18)
    local pts = {}
    for j=0,3 do local f=j/3; pts[#pts+1] = {sx + math.cos(a)*L*f, sy + math.sin(a)*L*f} end
    rb:stroke(pts, {pressure={0.45, 0.1}, ramps={0.05,0.5}})
  end
  -- ragged leafy fringe hanging below the crown edge, over the rods' upper parts
  local fr = (PWCRALL:grow(0.05*H) - PWCRALL:shrink(0.01*H)) * mask(function(x,y) return (y > hy - 0.15*H and y < hy + 0.06*H and math.abs(x - hx) < 0.36*H) and 1 or 0 end)
  fr = fr * PWGAP[i]:grow(1) + fr * PWCRALL
  stipple(fr, {pile=lD, width=math.max(1.2,H*0.016), coverage=function(x,y) return 0.9 end, pressure={0.5,0.85}, cluster={0.85, H*0.03}, feather=0.6, dips={10,0.7,0.4}})
  stipple(fr, {pile=lM, width=math.max(1.1,H*0.013), coverage=0.35, pressure={0.45,0.8}, cluster={0.85, H*0.025}, feather=0.6, dips={8,0.6,0.4}})
end
print(wait(0))
