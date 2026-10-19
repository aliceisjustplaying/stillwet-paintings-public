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
sky_top = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 0.8}, name="sky_top"}
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.65}, {"vermilion", 0.06}, name="sky_low"}
water_deep = pile{{"cobalt blue", 1}, {"Prussian blue", 0.4}, {"raw umber", 0.15}, {"lead white", 0.6}, name="water_deep"}
mtn_dark = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"red earth", 0.6}, {"bone black", 0.3}, {"lead white", 0.6}, name="mtn_dark"}
land_dark = pile{{"raw umber", 1}, {"Prussian blue", 0.25}, {"bone black", 0.3}, {"red earth", 0.25}, {"lead white", 0.15}, name="land_dark"}
local A = mix{{mtn_dark, 0.8}, {water_deep, 0.2}, name="A"}
local B = mix{{mtn_dark, 0.65}, {water_deep, 0.15}, {sky_mid, 0.2}, name="B"}
local C = mix{{sky_low, 0.85}, {land_dark, 0.15}, name="C"}
local D = mix{{sky_low, 0.8}, {land_dark, 0.08}, {sky_mid, 0.12}, name="D"}
local E = mix{{sky_low, 0.9}, {land_dark, 0.1}, name="E"}
local ps = {A, B, C, D, E}
for i, p in ipairs(ps) do
  work(rect(30 + (i-1)*190, 50, 170, 150), {hand="body", pile=p, coverage=2.2, load=0.6, clip=true})
end

--@ chunk 3
-- nothing; probes follow
