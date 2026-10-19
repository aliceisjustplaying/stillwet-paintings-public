-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}, name="s2"}
work(rect(0,0,1000,667), {hand="broad", pile=s2, coverage=2.2, fill=true, angle=0.03})
wait(2*24*60)
print(drying(300,300))

--@ chunk 3
glow_o = pile{{"cadmium yellow",1},{"orange vermilion",0.7},{"lead white",0.8}, thinner=0.5, name="glow_o"}
glow_y = pile{{"lead white",2},{"cadmium yellow",1},{"lemon chrome",0.4}, name="glow_y"}
core = pile{{"lead white",3},{"lemon chrome",0.3}, blot=0.25, name="core"}
function flash_trial(cx, cy, variant)
  local b = brush{kind="filbert", width=10, stiffness=0.5}
  -- outer glow: radial strokes, thinned orange
  b:load(glow_o, 0.6)
  for i = 1, 26 do
    local a = (i/26)*2*math.pi + rand(-0.1,0.1)
    local r1, r2 = rand(8,18), rand(50,80)
    if i % 5 == 0 then b:load(glow_o, 0.5) end
    b:gesture({{cx+math.cos(a)*r1, cy+math.sin(a)*r1, 0.6},{cx+math.cos(a)*(r1+r2)*0.5, cy+math.sin(a)*(r1+r2)*0.5, 0.35},{cx+math.cos(a)*r2, cy+math.sin(a)*r2, 0.0}})
  end
  -- mid glow: yellow, shorter, more opaque
  local b2 = brush{kind="round", width=7, point=0.6}
  b2:load(glow_y, 0.8)
  for i = 1, 18 do
    local a = (i/18)*2*math.pi + rand(-0.15,0.15)
    local len = rand(18,38)
    if variant == 2 then len = len * (1 + 0.8*math.max(0, math.cos(a))) end
    if i % 4 == 0 then b2:load(glow_y, 0.7) end
    b2:gesture({{cx+math.cos(a)*4, cy+math.sin(a)*4, 0.9},{cx+math.cos(a)*len, cy+math.sin(a)*len, 0.0}})
  end
  -- core: thick white
  local b3 = brush{kind="filbert", width=9, lay=6, stiffness=0.7}
  b3:load(core, 1.0)
  b3:touch(cx, cy, {pressure=0.8, drag={6,0}})
  b3:touch(cx+5, cy+1, {pressure=0.7, drag={4,0}})
end
flash_trial(250, 250, 1)
flash_trial(700, 250, 2)

--@ chunk 4
smoke_hot = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.6}, name="smoke_hot"}
smoke_warm = pile{{"lead white",2.5},{"yellow ochre",0.8},{"orange vermilion",0.15},{"bone black",0.05}, name="smoke_warm"}
smoke_cool = pile{{"lead white",2},{"bone black",0.25},{"Prussian blue",0.15},{"yellow ochre",0.2}, name="smoke_cool"}
flame_w = pile{{"lead white",3},{"lemon chrome",0.6}, name="flame_w"}
flame_o = pile{{"cadmium yellow",1},{"orange vermilion",0.5},{"lead white",0.3}, name="flame_o"}
function smoke_blob(cx, cy, seed)
  local m = ellipse(cx+20, cy-5, 45, 30) + ellipse(cx+60, cy-25, 40, 34) + ellipse(cx+35, cy-45, 30, 26) + ellipse(cx+85, cy+5, 30, 24)
  m = m:roughen(10, 30, seed):soften(6)
  local function d(x,y) return math.sqrt((x-cx-10)^2+(y-cy)^2) end
  work(m, {hand="body", tool="filbert 8", piles={{smoke_hot, function(x,y) return clamp(1-d(x,y)/45,0,1)*2 end},
    {smoke_warm, function(x,y) return clamp(1-math.abs(d(x,y)-55)/35,0,1) end},
    {smoke_cool, function(x,y) return clamp((d(x,y)-55)/40,0,1)*1.5 end}},
    coverage=2, fill=true, length={10,25}, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, curve={0.4,0.2}, edge="soft"})
  return m
end
local m = smoke_blob(250, 520, 7)
blend(m:grow(8), {angle=0.3})

--@ chunk 5
smoke_veil = pile{{"lead white",2},{"bone black",0.15},{"Prussian blue",0.1},{"yellow ochre",0.25}, thinner=0.6, name="smoke_veil"}
smoke_wveil = pile{{"lead white",2},{"Naples yellow",0.8},{"cadmium yellow",0.4}, thinner=0.5, name="smoke_wveil"}
local cx, cy = 650, 520
local m = ellipse(cx+30, cy-5, 55, 32) + ellipse(cx+70, cy-28, 45, 36) + ellipse(cx+40, cy-50, 35, 28) + ellipse(cx+100, cy+2, 35, 26)
m = m:roughen(12, 35, 3):soften(10)
local function d(x,y) return math.sqrt((x-cx-10)^2+(y-cy)^2) end
for pass = 1, 3 do
  work(m, {hand="scumble", piles={{smoke_wveil, function(x,y) return clamp(1-d(x,y)/50,0,1)*2 end},{smoke_veil, function(x,y) return clamp(d(x,y)/50,0.05,1) end}},
    coverage=0.9, edge="lost", angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, seed=pass*11})
end
-- flame
local bf = brush{kind="round", width=9, point=0.8, lay=3}
bf:load(flame_o, 0.9)
for i, a in ipairs({-0.35,-0.15,0.0,0.12,0.3,-0.6,0.55}) do
  local L = ({55,70,80,72,58,30,32})[i]
  bf:gesture({{cx, cy, 0.9},{cx+math.cos(a)*L*0.5, cy+math.sin(a)*L*0.5+rand(-4,4), 0.7},{cx+math.cos(a)*L, cy+math.sin(a)*L, 0.0}}, {wobble=3})
  if i % 3 == 0 then bf:load(flame_o, 0.8) end
end
local bw = brush{kind="round", width=8, point=0.7, lay=4}
bw:load(flame_w, 1.0)
for i, a in ipairs({-0.15,0.0,0.12,-0.3,0.25}) do
  local L = ({40,52,45,22,24})[i]
  bw:gesture({{cx-2, cy, 1.0},{cx+math.cos(a)*L*0.5, cy+math.sin(a)*L*0.5, 0.8},{cx+math.cos(a)*L, cy+math.sin(a)*L, 0.0}})
end

--@ chunk 6
local cx, cy = 180, 520
local region = ellipse(cx+90, cy-20, 170, 110):soften(20)
work(region, {hand="broad", pile=s2, coverage=2, fill=true, angle=0.03})
-- warm glow into wet sky, around the flash
glow_w = pile{{"lead white",2},{"yellow ochre",0.6},{"orange vermilion",0.25},{"Naples yellow",0.5}, name="glow_w"}
local function d(x,y) return math.sqrt(((x-cx-25)/1.3)^2+(y-cy)^2) end
local sm = (ellipse(cx+40, cy-5, 60, 34) + ellipse(cx+85, cy-30, 48, 38) + ellipse(cx+50, cy-55, 36, 30) + ellipse(cx+115, cy+2, 36, 26)):roughen(12, 35, 5):soften(8)
work(sm, {hand="body", tool="filbert 10", piles={{smoke_hot, function(x,y) return clamp(1-d(x,y)/40,0,1)*2.5 end},
   {glow_w, function(x,y) return clamp(1-math.abs(d(x,y)-50)/30,0,1) end},
   {smoke_cool, function(x,y) return clamp((d(x,y)-55)/35,0,1)*1.5 end}},
   coverage=1.6, fill=true, length={12,30}, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, curve={0.5,0.2}, pressure={0.3,0.6}})
blend(sm:grow(14), {angle=0.4})
blend(sm:grow(10):rim(14, 6), {angle=-0.6})
