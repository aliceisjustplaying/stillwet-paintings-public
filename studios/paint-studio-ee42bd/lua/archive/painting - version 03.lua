-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{size=400, aspect=1.2, linen={18, 14}, seed=101,
       ground={{pile={{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 0.5}}, um=40, apply="knife", texture=0.1}}}
print("Tubes: " .. table.concat(tubes(), ", "))

--@ chunk 2
p_sky_top = pile{{"lead white", 12}, {"cobalt blue", 2}, {"ultramarine ash", 1}, {"yellow ochre", 0.2}, medium=0.1}
p_sky_low = pile{{"lead white", 15}, {"Naples yellow", 2}, {"yellow ochre", 1}, {"vermilion", 0.1}, medium=0.1}
p_sea = pile{{"lead white", 4}, {"Prussian blue", 1.5}, {"viridian", 1}, {"raw umber", 1.5}, {"yellow ochre", 0.5}, medium=0.1}
p_land = pile{{"raw sienna", 4}, {"yellow ochre", 4}, {"raw umber", 3}, {"burnt sienna", 1}, {"lead white", 2}, medium=0.05}
p_dark = pile{{"raw umber", 5}, {"bone brown", 3}, {"yellow ochre", 2}, {"green earth", 1}, medium=0.05}

local b_broad = brush{kind="flat", width=55}

-- Upper atmosphere
local m_sky_top = rect(0, 0, 1000, 320)
work(m_sky_top, {pile=p_sky_top, tool=b_broad, hand="broad", angle=0, length=90, coverage=1.2, fill=true})

-- Lower warm atmosphere
local m_sky_low = rect(0, 270, 1000, 460)
work(m_sky_low, {pile=p_sky_low, tool=b_broad, hand="broad", angle=0, length=80, coverage=1.2, fill=true})

-- Soften sky transition
local m_sky_blend = rect(0, 250, 1000, 340)
blend(m_sky_blend, {tool=brush{kind="round", width=60}, pressure=0.45})

-- Distant sea
local m_sea = rect(0, 440, 1000, 520)
local b_sea = brush{kind="flat", width=35}
work(m_sea, {pile=p_sea, tool=b_sea, hand="broad", angle=0, length=65, coverage=1.15, fill=true})

-- Headland slope
local m_land = poly{{1000, 390}, {1000, 834}, {0, 834}, {0, 560}, {300, 530}, {650, 470}, {850, 410}}
local b_land = brush{kind="flat", width=45}
work(m_land, {pile=p_land, tool=b_land, hand="broad", angle=0.15, length=70, coverage=1.2, fill=true})

-- Foreground slope
local m_fg = poly{{0, 680}, {1000, 580}, {1000, 834}, {0, 834}}
work(m_fg, {pile=p_dark, tool=brush{kind="flat", width=50}, hand="broad", angle=-0.1, length=70, coverage=1.0, fill=true})
