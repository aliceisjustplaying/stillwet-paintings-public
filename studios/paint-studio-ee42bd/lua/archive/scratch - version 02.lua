-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.2, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 0.5}}, texture=0.1, um=40}}, linen={18, 14}, seed=101, size=400}

--@ chunk 2
for k, v in pairs(_G) do
  if type(v) == "function" or type(v) == "table" then
    print(k, type(v))
  end
end

--@ chunk 3
local b = brush{width=20}
local candidates = {"stroke", "touch", "load", "dip", "wipe", "clean", "wash", "dab", "press", "lift", "draw", "line", "paint"}
for _, name in ipairs(candidates) do
  local ok, res = pcall(function() return b[name] end)
  if ok and res ~= nil then
    print(name, type(res))
  end
end

--@ chunk 4
local p = pile{{"lead white", 1}}
local b = brush{width=20}
local ok, err = pcall(function() b:load(p) end)
print("load(p):", ok, err)
local ok2, err2 = pcall(function() b:load(p, 1.0) end)
print("load(p, 1):", ok2, err2)

--@ chunk 5
local p = pile{{"cobalt blue", 1}}
local b = brush{width=30}
b:load(p, 1.0)
local ok, err = pcall(function() b:stroke({{100, 100}, {300, 200}}) end)
print("stroke polyline:", ok, err)

--@ chunk 6
local p = pile{{"yellow ochre", 1}}
local ok, err = pcall(function()
  work{pile=p, hand="broad", from={100, 300}, to={400, 500}}
end)
print("work 1:", ok, err)

--@ chunk 7
local m = rect(100, 300, 400, 500)
local p = pile{{"yellow ochre", 1}}
local ok, err = pcall(function()
  work(m, {pile=p})
end)
print("work(m, opts):", ok, err)

--@ chunk 8
local ok, err = pcall(function()
  work(rect(0,0,10,10), {unknown_option_xyz=123})
end)
print("err:", err)

--@ chunk 9
-- Piles for the composition
p_sky_top = pile{{"lead white", 12}, {"cobalt blue", 2}, {"ultramarine ash", 1}, {"yellow ochre", 0.2}, medium=0.1}
p_sky_low = pile{{"lead white", 15}, {"Naples yellow", 2}, {"yellow ochre", 1}, {"vermilion", 0.1}, medium=0.1}
p_sea = pile{{"lead white", 4}, {"Prussian blue", 1.5}, {"viridian", 1}, {"raw umber", 1.5}, {"yellow ochre", 0.5}, medium=0.1}
p_land = pile{{"raw sienna", 4}, {"yellow ochre", 4}, {"raw umber", 3}, {"burnt sienna", 1}, {"lead white", 2}, medium=0.05}
p_dark = pile{{"raw umber", 5}, {"bone brown", 3}, {"yellow ochre", 2}, {"green earth", 1}, medium=0.05}

b_broad = brush{kind="flat", width=55}

-- Upper sky
local m_sky_top = rect(0, 0, 1000, 320)
work(m_sky_top, {pile=p_sky_top, tool=b_broad, hand="broad", angle=0, length=90, coverage=1.2, fill=true})

-- Lower sky meeting horizon
local m_sky_low = rect(0, 280, 1000, 460)
work(m_sky_low, {pile=p_sky_low, tool=b_broad, hand="broad", angle=0, length=80, coverage=1.2, fill=true})

-- Distant sea band
local m_sea = rect(0, 440, 1000, 520)
local b_sea = brush{kind="flat", width=35}
work(m_sea, {pile=p_sea, tool=b_sea, hand="broad", angle=0, length=60, coverage=1.1, fill=true})

-- Headland shape
local m_land = poly{{1000, 390}, {1000, 834}, {0, 834}, {0, 560}, {300, 530}, {650, 470}, {850, 410}}
local b_land = brush{kind="flat", width=45}
work(m_land, {pile=p_land, tool=b_land, hand="broad", angle=0.15, length=70, coverage=1.2, fill=true})

--@ chunk 10
-- Blend sky horizon seam
local m_sky_blend = rect(0, 260, 1000, 340)
blend(m_sky_blend, {tool=brush{kind="round", width=60}, pressure=0.5})

-- Foreground slope with darker earth
local m_fg = poly{{0, 680}, {1000, 580}, {1000, 834}, {0, 834}}
work(m_fg, {pile=p_dark, tool=brush{kind="flat", width=50}, hand="broad", angle=-0.1, length=70, coverage=1.0, fill=true})
