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
mtn_dark = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"red earth", 0.6}, {"bone black", 0.3}, {"lead white", 0.6}, name="mtn_dark"}
water_deep = pile{{"cobalt blue", 1}, {"Prussian blue", 0.4}, {"raw umber", 0.15}, {"lead white", 0.6}, name="water_deep"}
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
refl_dark = mix{{mtn_dark, 0.65}, {water_deep, 0.2}, {sky_mid, 0.15}, name="refl_dark"}
work(rect(0, 0, 1000, 749), {hand="body", pile=refl_dark, coverage=2.2, load=0.6, clip=true, angle=math.pi/2, length={20,50}})
blend(everywhere(), {angle=math.pi/2, length={10, 25}})
ripple = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, thinner=0.4, name="ripple"}
ripple2 = mix{{sky_mid, 0.7}, {refl_dark, 0.3}, name="ripple2"}
local rg = brush{kind="rigger", width=2.5, point=1}
-- A: thinned sky_mid, rigger, light pressure
for i = 1, 4 do
  rg:reload(ripple, 0.5)
  rg:stroke({{60, 80 + i*40}, {200, 80 + i*40 + 0.5}, {340, 80 + i*40}}, {pressure={0.15 + i*0.08, 0.05}, ramps={0.3, 0.5}})
end
-- B: ripple2 (darker), rigger
for i = 1, 4 do
  rg:reload(ripple2, 0.5)
  rg:stroke({{400, 80 + i*40}, {540, 80 + i*40 + 0.5}, {680, 80 + i*40}}, {pressure={0.15 + i*0.08, 0.05}, ramps={0.3, 0.5}})
end
-- C: flat brush on edge, ripple2, very light
local fl = brush{kind="flat", width=10}
for i = 1, 4 do
  fl:reload(ripple2, 0.3)
  fl:stroke({{60, 320 + i*40}, {200, 320 + i*40}, {340, 320 + i*40}}, {pressure={0.08 + i*0.04, 0.05}, orient="along", ramps={0.3, 0.5}})
end

--@ chunk 3
function wind_line(br, p, x0, y0, len, seed)
  math.randomseed(seed)
  local x = x0
  local xe = x0 + len
  while x < xe do
    local seg = rand(12, 45)
    local x1 = math.min(xe, x + seg)
    local yy = y0 + rand(-0.6, 0.6)
    br:reload(p, rand(0.3, 0.5))
    local xm = (x + x1) / 2
    br:stroke({{x, yy + rand(-0.3, 0.3)}, {xm, yy + rand(-0.5, 0.5)}, {x1, yy + rand(-0.3, 0.3)}}, {pressure={rand(0.1, 0.2), 0.03}, ramps={0.35, 0.5}})
    x = x1 + rand(2, 14)
  end
end
local rg = brush{kind="rigger", width=2.5, point=1}
wind_line(rg, ripple2, 420, 380, 160, 1)
wind_line(rg, ripple2, 520, 420, 90, 2)
wind_line(rg, ripple2, 400, 470, 220, 3)
wind_line(rg, ripple, 450, 520, 140, 4)
wind_line(rg, ripple, 600, 560, 60, 5)
