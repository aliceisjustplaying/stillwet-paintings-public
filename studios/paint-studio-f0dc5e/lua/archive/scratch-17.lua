-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.3347921225382933, ground={{apply="knife", pile={{"lead white", 6}, {"yellow ochre", 0.05}}, texture=0.25, um=70}, {apply="roller", pile={{"lead white", 1}}, um=35}}, linen={17, 15}, seed=2417, size=610}

--@ chunk 2
lw = pile{{"lead white", 1}, medium=0.45, name="liquid_white"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.65}, {"vermilion", 0.06}, name="sky_low"}
work(everywhere(), {hand="broad", pile=sky_low, coverage=2, load=0.5, angle=0})
land_dark = pile{{"raw umber", 1}, {"Prussian blue", 0.25}, {"bone black", 0.3}, {"red earth", 0.25}, {"lead white", 0.15}, name="land_dark"}
grass_dusk = pile{{"raw umber", 1}, {"yellow ochre", 0.75}, {"cobalt blue", 0.25}, {"red earth", 0.15}, {"lead white", 0.12}, name="grass_dusk"}
grass_rim = pile{{"yellow ochre", 1}, {"lead white", 0.7}, {"vermilion", 0.12}, {"raw umber", 0.15}, blot=0.1, name="grass_rim"}
bank = poly({{0,300},{200,320},{450,360},{500,749},{0,749}}, true)
local function topy(x) return 300 + x * 0.12 end
work(bank, {hand="body", piles={{land_dark, function(x,y) return smoothstep(topy(x)+8, topy(x)+50, y) + 0.12 end}, {grass_dusk, function(x,y) return 1 - smoothstep(topy(x)+8, topy(x)+50, y) end}}, coverage=2.5, load=0.75, clip=true, fill=true, angle=-1.35, length={10,30}})
-- old-style blades (as on the painting) on left half
math.randomseed(1)
local rg = brush{kind="rigger", width=2.2, point=1}
local rg2 = brush{kind="round", width=3, point=0.9}
for i = 1, 200 do
  local x = rand(0, 480)
  local depth = rand(0, 1)^2 * 90
  local y0 = topy(x) + rand(-2, 2) + depth
  local h = rand(9, 30) * (1 + depth/90)
  local b = (rand(0,1) < 0.6) and rg or rg2
  local p = (rand(0,1) < 0.5) and grass_dusk or land_dark
  if i % 2 == 0 then b:load(p, 0.7) end
  b:gesture({{x, y0, 0.7}, {x + rand(-0.35,0.2)*h*0.4, y0 - h*0.5, 0.4}, {x + rand(-0.35,0.2)*h, y0 - h, 0.0}})
end
for i = 1, 50 do
  local x = rand(0, 450)
  local y0 = topy(x) + rand(0, 18)
  local h = rand(9, 24)
  if i % 2 == 0 then rg:wipe(0.7); rg:load(grass_rim, 0.5) end
  local l = rand(-0.45, 0.05)
  rg:gesture({{x, y0, 0.5}, {x + l*h*0.4, y0 - h*0.5, 0.3}, {x + l*h, y0 - h, 0.0}})
end

--@ chunk 3
function topy(x) return 300 + x * 0.12 end
math.randomseed(2)
local rg = brush{kind="rigger", width=2.2, point=1}
local rg2 = brush{kind="round", width=3, point=0.9}
for i = 1, 300 do
  local x = rand(0, 480)
  local depth = rand(0, 1)^2 * 90
  local y0 = topy(x) + rand(-2, 2) + depth
  local h = rand(9, 30) * (1 + depth/90)
  local b = (rand(0,1) < 0.6) and rg or rg2
  local p = (rand(0,1) < 0.5) and grass_dusk or land_dark
  if i % 2 == 0 then b:load(p, 0.7) end
  b:gesture({{x, y0, 0.7}, {x + rand(-0.35,0.2)*h*0.4, y0 - h*0.5, 0.4}, {x + rand(-0.35,0.2)*h, y0 - h, 0.0}})
end
-- Trial A on x 0-230
local A = bank * rect(0, 0, 230, 749) * mask(function(x, y) return smoothstep(topy(x) + 25, topy(x) + 80, y) end)
work(A, {hand="body", pile=land_dark, coverage=1.6, load=0.7, clip=true, angle=-1.45, length={15,40}, seed=3})
function tuft(x, y, h, n, piles, br, lean)
  for i = 1, n do
    local p = piles[math.random(#piles)]
    br:load(p, 0.6)
    local a = -math.pi/2 + (lean or 0) + rand(-0.45, 0.45)
    local hh = h * rand(0.5, 1.1)
    local bend = rand(-0.4, 0.4) + (lean or 0)
    local x1, y1 = x + math.cos(a) * hh * 0.55, y + math.sin(a) * hh * 0.55
    local a2 = a + bend
    local x2, y2 = x1 + math.cos(a2) * hh * 0.5, y1 + math.sin(a2) * hh * 0.5
    br:gesture({{x + rand(-2, 2), y, 0.75}, {x1, y1, 0.45}, {x2, y2, 0.0}})
  end
end
math.randomseed(4)
local rg3 = brush{kind="rigger", width=2.4, point=1}
for i = 1, 26 do
  local x = rand(0, 230)
  local y = topy(x) + rand(0, 1)^1.5 * 140
  tuft(x, y, rand(14, 30) * (1 + (y - topy(x))/200), math.floor(rand(4, 9)), {land_dark, grass_dusk, land_dark}, rg3, rand(-0.3, 0.1))
end
local rr = brush{kind="rigger", width=1.8, point=1}
for i = 1, 22 do
  local x = rand(0, 230)
  local y = topy(x) + rand(-2, 8)
  rr:wipe(0.7); rr:load(grass_rim, 0.5)
  local a = -math.pi/2 + rand(-0.5, 0.3)
  local hh = rand(8, 18)
  rr:gesture({{x, y, 0.4}, {x + math.cos(a)*hh*0.5, y + math.sin(a)*hh*0.5, 0.3}, {x + math.cos(a + rand(-0.3, 0.3))*hh, y + math.sin(a)*hh, 0.0}})
end
