-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
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
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 1}}, texture=0.25, um=70}, {apply="brush", pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25}}, linen={16, 14}, seed=1873, size=700}

--@ chunk 2
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}}
wallMid = pile{{"raw umber", 1}, {"burnt sienna", 1}, {"yellow ochre", 1}}
sky = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}}
floorLit = pile{{"lead white", 3}, {"yellow ochre", 2}, {"Naples yellow", 1}, {"burnt sienna", 0.2}}
gunMetal = pile{{"bone black", 1}, {"ultramarine blue", 0.2}, {"raw umber", 0.3}}
local all = rect(0, 0, 1000, 750)
work(all, {hand="broad", pile=wallDk, coverage=2, fill=true, clip=all, angle=0})
work(rect(590, 210, 200, 350), {hand="body", tool="filbert 10", pile=sky, coverage=2.5, fill=true, clip=rect(590, 210, 200, 350), angle=1.57})
local sp = poly({{590, 560}, {790, 560}, {660, 690}, {297, 690}})
work(sp, {hand="body", tool="filbert 9", pile=floorLit, coverage=2.5, fill=true, clip=sp, angle=-0.5})
local z = rect(660, 300, 50, 255)
work(z, {hand="detail", tool={kind="round", width=4}, pile=wallDk, coverage=3, fill=true, clip=z, angle=1.57})
local barrel = ribbon({{478, 401}, {529, 385}}, {5.2, 4.6})
work(barrel, {hand="detail", tool={kind="round", width=2.2}, pile=gunMetal, coverage=4, fill=true, clip=barrel, angle=-0.3, length={6, 20}})
print(wait(16 * 24 * 60))
print(drying(300, 300), drying(650, 300), drying(500, 650))

--@ chunk 3
smokeLit = pile{{"lead white", 3}, {"Naples yellow", 0.8}, {"yellow ochre", 0.6}, medium=0.85, name="smokeLit"}
smokeDim = pile{{"lead white", 2}, {"yellow ochre", 1}, {"raw umber", 0.5}, {"burnt sienna", 0.3}, medium=0.85, name="smokeDim"}
-- shaft triangle: (590,210)-(590,560)-(297,690) plus door/spill hull
local function inShaft(x, y)
  -- left boundary line from (590,210) to (297,690)
  local xl = 590 - (y - 210) * (293 / 480)
  local s1 = smoothstep(xl - 6, xl + 18, x)
  local s2 = 1 - smoothstep(588, 600, x)  -- left of the door (the door itself is excluded)
  local s3 = smoothstep(205, 230, y) * (1 - smoothstep(560 + (590 - x) * 0.44 - 6, 560 + (590 - x) * 0.44 + 8, y))
  return s1 * s2 * s3
end
local function nearDoor(x, y) return 0.35 + 0.65 * (1 - smoothstep(0, 260, 590 - x)) end
local nz = noise{seed=17, octaves=4, period=60, kind="billow", warp={90, 30}, stretch={-0.9, 2.0}}
local function dens(x, y) return inShaft(x, y) * nearDoor(x, y) * (0.25 + 0.95 * nz:at01(x, y)) end
local area = mask(function(x, y) return dens(x, y) > 0.04 and 1 or 0 end)
stipple(area, {pile=smokeLit, width=10, coverage=function(x, y) return 2.2 * dens(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(area:grow(10):blur(10), {angle=-1.0})
blend(area:grow(6):blur(8), {angle=0.5})

--@ chunk 4
smokeLit2 = pile{{"lead white", 2}, {"yellow ochre", 1.5}, {"Naples yellow", 1}, {"raw sienna", 0.4}, medium=0.85, name="smokeLit2"}
smokeLit3 = pile{{"lead white", 2}, {"yellow ochre", 1.2}, {"Naples yellow", 1}, {"orange chrome", 0.25}, medium=0.8, name="smokeLit3"}
local nz = noise{seed=19, octaves=4, period=60, kind="billow", warp={90, 30}, stretch={-0.9, 2.0}}
local function denA(x, y)
  local c = 1 - smoothstep(30, 80, math.abs(x - 880))
  return c * smoothstep(40, 80, y) * (1 - smoothstep(300, 340, y)) * (0.25 + 0.95 * nz:at01(x, y))
end
local function denB(x, y)
  local c = 1 - smoothstep(30, 80, math.abs(x - 880))
  return c * smoothstep(400, 440, y) * (1 - smoothstep(660, 700, y)) * (0.25 + 0.95 * nz:at01(x, y))
end
local aA = mask(function(x, y) return denA(x, y) > 0.04 and 1 or 0 end)
local aB = mask(function(x, y) return denB(x, y) > 0.04 and 1 or 0 end)
stipple(aA, {pile=smokeLit2, width=10, coverage=function(x, y) return 2.2 * denA(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(aA:grow(10):blur(10), {angle=-1.0})
stipple(aB, {pile=smokeLit3, width=10, coverage=function(x, y) return 2.2 * denB(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(aB:grow(10):blur(10), {angle=-1.0})

--@ chunk 5
local ps = {
  pile{{"Naples yellow", 2}, {"yellow ochre", 1}, {"lead white", 0.5}, medium=0.8},
  pile{{"Naples yellow", 1}, {"cadmium yellow", 0.3}, {"lead white", 1}, medium=0.8},
  pile{{"lead white", 1}, {"yellow ochre", 1}, {"raw sienna", 1}, medium=0.7},
  pile{{"yellow ochre", 2}, {"burnt sienna", 0.6}, {"lead white", 0.7}, medium=0.8},
}
local nz = noise{seed=23, octaves=3, period=40, kind="billow"}
for i, p in ipairs(ps) do
  local cx = 80 + (i - 1) * 120
  local function den(x, y)
    local d = math.sqrt((x - cx)^2 + (y - 120)^2)
    return (1 - smoothstep(20, 50, d)) * (0.5 + 0.5 * nz:at01(x, y))
  end
  local a = mask(function(x, y) return den(x, y) > 0.04 and 1 or 0 end)
  stipple(a, {pile=p, width=10, coverage=function(x, y) return 2.4 * den(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
  blend(a:grow(8):blur(8), {angle=-1.0})
  blend(a:grow(6):blur(6), {angle=0.6})
end
