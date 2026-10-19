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
gunMetal = pile{{"bone black", 1}, {"ultramarine blue", 0.2}, {"raw umber", 0.3}}
local dk = rect(20, 20, 960, 400)
work(dk, {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=dk, angle=0})
print(wait(14 * 24 * 60))
for i = 0, 2 do
  local x = 60 + i * 320
  local barrel = ribbon({{x, 200}, {x + 70, 196}}, {5, 4.5})
  work(barrel, {hand="detail", tool={kind="round", width=2.2}, pile=gunMetal, coverage=4, fill=true, clip=barrel, angle=0, length={6, 20}})
end
flashCore = pile{{"lead white", 4}, {"lemon chrome", 1}, name="core"}
flashY = pile{{"lead white", 2}, {"cadmium yellow", 1.5}, {"lemon chrome", 0.5}, name="flashY"}
flashO = pile{{"cadmium yellow", 1}, {"orange chrome", 1.2}, {"lead white", 0.6}, name="flashO"}
flashR = pile{{"orange chrome", 1}, {"vermilion", 0.8}, {"cadmium red", 0.3}, name="flashR"}
glowP = pile{{"orange chrome", 1}, {"cadmium yellow", 0.6}, {"burnt sienna", 0.3}, medium=0.6, name="glowP"}

--@ chunk 3
function flash(mx, my, opts)
  opts = opts or {}
  local sc = opts.scale or 1
  -- glow on the wall
  local g = mask(function(x, y)
    local d = math.sqrt(((x - mx - 18 * sc) * 0.9)^2 + (y - my)^2)
    return 1 - smoothstep(10 * sc, 60 * sc, d)
  end)
  stipple(g, {pile=glowP, width=8, coverage=function(x, y)
    local d = math.sqrt(((x - mx - 18 * sc) * 0.9)^2 + (y - my)^2)
    return 2.2 * (1 - smoothstep(8 * sc, 62 * sc, d))
  end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
  blend(g:grow(6):blur(8), {angle=0.3})
  -- red-orange outer jets
  local r = brush{kind="round", width=6 * sc, point=0.8, lay=3}
  local jets = opts.jets or {{-0.75, 26}, {-0.38, 38}, {0.0, 48}, {0.36, 36}, {0.8, 24}, {-1.3, 14}, {1.25, 15}}
  for _, j in ipairs(jets) do
    local a, L = j[1], j[2] * sc
    r:reload(flashR, 0.7)
    r:gesture({{mx + 2, my, 0.9}, {mx + math.cos(a) * L * 0.45, my + math.sin(a) * L * 0.45, 0.8}, {mx + math.cos(a) * L, my + math.sin(a) * L, 0.0}})
  end
  -- orange body
  local o = brush{kind="round", width=8 * sc, point=0.7, lay=4}
  for _, j in ipairs({{-0.3, 30}, {0.0, 38}, {0.28, 28}}) do
    local a, L = j[1], j[2] * sc
    o:reload(flashO, 0.8)
    o:gesture({{mx + 1, my, 1.0}, {mx + math.cos(a) * L * 0.4, my + math.sin(a) * L * 0.4, 0.9}, {mx + math.cos(a) * L, my + math.sin(a) * L, 0.0}})
  end
  -- yellow
  local y = brush{kind="round", width=7 * sc, point=0.7, lay=5}
  y:reload(flashY, 0.9)
  y:gesture({{mx, my, 1.0}, {mx + 12 * sc, my - 0.5, 0.9}, {mx + 24 * sc, my - 1, 0.0}})
  y:reload(flashY, 0.9)
  y:gesture({{mx, my, 0.9}, {mx + 9 * sc, my - 6 * sc, 0.6}, {mx + 16 * sc, my - 10 * sc, 0.0}})
  y:reload(flashY, 0.9)
  y:gesture({{mx, my, 0.9}, {mx + 9 * sc, my + 6 * sc, 0.6}, {mx + 15 * sc, my + 9 * sc, 0.0}})
  -- white-hot core
  local c = brush{kind="round", width=7 * sc, point=0.3, lay=7}
  c:reload(flashCore, 1.0)
  c:touch(mx + 4 * sc, my, {pressure=0.9})
  c:reload(flashCore, 0.8)
  c:gesture({{mx + 2, my, 0.9}, {mx + 10 * sc, my, 0.6}, {mx + 16 * sc, my, 0.0}})
end
flash(131, 196)
flash(451, 196, {scale=0.8, jets={{-0.5, 30}, {0.0, 52}, {0.5, 30}, {-1.0, 18}, {1.0, 18}}})

--@ chunk 4
glow2 = pile{{"orange chrome", 1}, {"vermilion", 0.4}, {"lead white", 0.6}, {"Naples yellow", 0.5}, thinner=0.5, name="glow2"}
function burst(mx, my, sc, seed)
  local nz = noise{seed=seed, octaves=3, period=14 * sc, kind="fbm"}
  local function shp(x, y, k)
    local dx, dy = x - mx, y - my
    if dx < -4 * sc then return 0 end
    local a = math.atan(dy, dx)
    local r = math.sqrt(dx * dx + dy * dy)
    -- teardrop: long forward, short sideways, flame fingers via angular noise
    local reach = sc * (52 * math.max(0, math.cos(a)) ^ 1.5 + 14) * (0.75 + 0.5 * nz:at01(mx + math.cos(a) * 30, my + math.sin(a) * 30))
    return (r < reach * k) and 1 or 0
  end
  local outer = mask(function(x, y) return shp(x, y, 1.0) end)
  local mid = mask(function(x, y) return shp(x, y, 0.62) end)
  local core = mask(function(x, y) return shp(x, y, 0.32) end)
  -- glow around
  local g = mask(function(x, y) local d = math.sqrt(((x - mx - 20 * sc) * 0.8)^2 + (y - my)^2) return 1 - smoothstep(20 * sc, 75 * sc, d) end)
  stipple(g, {pile=glow2, width=7, coverage=function(x, y) local d = math.sqrt(((x - mx - 20 * sc) * 0.8)^2 + (y - my)^2) return 1.6 * (1 - smoothstep(15 * sc, 78 * sc, d)) end, feather=1, pressure={0.2, 0.45}, dips={40, 0.35, 0}})
  blend(g:grow(4):blur(6), {angle=0.4})
  stipple(outer, {pile=flashR, width=5, coverage=3, pressure={0.4, 0.7}, dips={20, 0.7, 0}})
  stipple(mid, {pile=flashO, width=5, coverage=3, pressure={0.5, 0.8}, dips={20, 0.8, 0}})
  stipple(core, {tool={kind="stippler", width=5, lay=5}, pile=flashY, coverage=3, pressure={0.6, 0.9}, dips={20, 0.9, 0}})
  local c = brush{kind="round", width=6 * sc, point=0.3, lay=7}
  c:reload(flashCore, 1.0)
  c:gesture({{mx + 2, my, 1.0}, {mx + 8 * sc, my, 0.8}, {mx + 15 * sc, my, 0.0}})
  c:reload(flashCore, 0.8)
  c:touch(mx + 5 * sc, my, {pressure=0.8})
end
burst(771, 196, 1.0, 3)
