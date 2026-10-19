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
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
water_deep = pile{{"cobalt blue", 1}, {"Prussian blue", 0.4}, {"raw umber", 0.15}, {"lead white", 0.6}, name="water_deep"}
mist_cool = pile{{"lead white", 4}, {"cobalt blue", 0.4}, {"vermilion", 0.12}, {"chrome yellow", 0.04}, blot=0.2, name="mist_cool"}
local A = mix{{sky_mid, 0.6}, {water_deep, 0.4}, name="A"}
local B = mix{{sky_mid, 0.5}, {water_deep, 0.5}, name="B"}
local C = mix{{sky_mid, 0.55}, {water_deep, 0.35}, {mist_cool, 0.1}, name="C"}
local D = mix{{sky_mid, 0.45}, {water_deep, 0.45}, {mist_cool, 0.1}, name="D"}
for i, p in ipairs({A, B, C, D}) do
  work(rect(30 + (i-1)*240, 50, 200, 150), {hand="body", pile=p, coverage=2.2, load=0.6, clip=true})
end

--@ chunk 3
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.65}, {"vermilion", 0.06}, name="sky_low"}
land_dark = pile{{"raw umber", 1}, {"Prussian blue", 0.25}, {"bone black", 0.3}, {"red earth", 0.25}, {"lead white", 0.15}, name="land_dark"}
local sm = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid2"}
local E = mix{{sm, 0.5}, {water_deep, 0.38}, {sky_low, 0.12}, name="E"}
local F = mix{{sm, 0.5}, {water_deep, 0.38}, {land_dark, 0.04}, {sky_low, 0.08}, name="F"}
local G = mix{{sm, 0.55}, {water_deep, 0.3}, {land_dark, 0.05}, {sky_low, 0.1}, name="G"}
for i, p in ipairs({E, F, G}) do
  work(rect(30 + (i-1)*240, 300, 200, 150), {hand="body", pile=p, coverage=2.2, load=0.6, clip=true})
end
