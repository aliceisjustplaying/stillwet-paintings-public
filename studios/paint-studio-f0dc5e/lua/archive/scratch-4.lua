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
sky_top = pile{{"Prussian blue", 1}, {"bone black", 0.12}, {"lead white", 1.6}, name="sky_top"}
sky_mid = pile{{"Prussian blue", 0.25}, {"lead white", 3}, {"vermilion", 0.06}, name="sky_mid"}
sky_glow = pile{{"lead white", 4}, {"vermilion", 0.5}, {"chrome yellow", 0.6}, name="sky_glow"}
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.5}, {"vermilion", 0.1}, name="sky_low"}
local function d(x,y) return math.sqrt(((x+50)/700)^2 + ((y-470)/330)^2) end
local function wtop(x,y) return clamp(d(x,y) - 0.9, 0, 1) * 1.6 end
local function wmid(x,y) return math.exp(-((d(x,y)-0.75)/0.25)^2) end
local function wglow(x,y) return math.exp(-((d(x,y)-0.42)/0.18)^2) end
local function wlow(x,y) return clamp(1 - d(x,y)/0.3, 0, 1) * 1.5 end
local sky = rect(0, 0, 1000, 480)
local P = {{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}}
work(sky, {hand="broad", piles=P, coverage=1.3, load=0.4, angle=0.7, length={70,140}})
work(sky, {hand="broad", piles=P, coverage=1.3, load=0.4, angle=-0.7, length={70,140}})
blend(rect(0, 0, 1000, 490):soften(20), {angle=0, clip=false})
blend(rect(0, 0, 1000, 490):soften(20), {angle=0.2, clip=false})

--@ chunk 3
sky_top2 = pile{{"cobalt blue", 1}, {"Prussian blue", 0.15}, {"vermilion", 0.04}, {"lead white", 1.3}, name="sky_top2"}
sky_mid2 = pile{{"lead white", 4}, {"cobalt blue", 0.35}, {"vermilion", 0.18}, name="sky_mid2"}
sky_glow2 = pile{{"lead white", 4}, {"chrome yellow", 0.6}, {"vermilion", 0.3}, name="sky_glow2"}
sky_low2 = pile{{"lead white", 5}, {"chrome yellow", 0.6}, {"vermilion", 0.05}, name="sky_low2"}
mtn_dark = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"red earth", 0.6}, {"bone black", 0.25}, {"lead white", 0.8}, name="mtn_dark"}
snow_lit = pile{{"lead white", 5}, {"vermilion", 0.18}, {"chrome yellow", 0.25}, blot=0.15, name="snow_lit"}
snow_sh = pile{{"lead white", 3}, {"cobalt blue", 0.6}, {"red earth", 0.12}, {"Prussian blue", 0.04}, blot=0.15, name="snow_sh"}
