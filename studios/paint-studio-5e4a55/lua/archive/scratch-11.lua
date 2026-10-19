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
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lenticel"}
brushdark = pile{{"raw umber",2},{"red earth",1.5},{"Prussian blue",0.3},{"yellow ochre",0.4}, name="brushdark"}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
rim_warm = pile{{"yellow ochre",2},{"red earth",1},{"lead white",1.5},{"chrome yellow",0.25},{"vermilion",0.15}, name="rim_warm"}
mosslit = pile{{"yellow ochre",2},{"green earth",1.5},{"lead white",1},{"chrome yellow",0.4},{"raw umber",0.3}, name="mosslit"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
rockgray = mix{{rock, 0.5}, {haze, 0.5}, name="rockgray"}
work(rect(0,0,1000,500), {hand="body", tool="filbert 10", coverage=3, fill=true, length={20,50}, angle=1.45, piles={{rock,1},{brushdark,0.5},{lent,0.3}}})
-- (a) knife, very light pressure, along slanted planes
local k = knife{width=30}
local planes = {{{40,120},{120,100}}, {{130,105},{200,130}}, {{60,200},{140,190}}, {{150,190},{230,215}}, {{50,300},{130,290}}, {{140,280},{220,300}}, {{70,400},{190,385}}}
for i, p in ipairs(planes) do
  k:load(i % 2 == 0 and mosslit or rockgray, 0.35)
  k:lay(p, {pressure={0.05, 0.1}})
end
-- (b) dry brush flat 12, load .12, pressure .15
local fb = brush{kind="flat", width=14, stiffness=0.8}
for i, p in ipairs(planes) do
  fb:reload(i % 2 == 0 and mosslit or rockgray, 0.12)
  fb:stroke({{p[1][1] + 330, p[1][2]}, {p[2][1] + 330, p[2][2]}}, {pressure=0.15, orient="across"})
  fb:stroke({{p[1][1] + 333, p[1][2] + 8}, {p[2][1] + 330, p[2][2] + 8}}, {pressure=0.12, orient="across"})
end
-- (c) dry brush after waiting to set? not now. (c) scumble hand with small mask
for i, p in ipairs(planes) do
  local m = ribbon({{p[1][1] + 660, p[1][2]}, {p[2][1] + 660, p[2][2]}}, 14)
  work(m, {hand="scumble", pile=(i % 2 == 0) and mosslit or rockgray, coverage=0.6})
end

--@ chunk 3
work(rect(0,520,1000,400), {hand="body", tool="filbert 10", coverage=3, fill=true, length={20,50}, angle=1.45, piles={{rock,1},{brushdark,0.5},{lent,0.3}}})
-- rock cluster: list of rocks with top-edge polylines
local rocks = {
  {{60,640},{120,620},{170,628},{200,650}}, {{210,660},{260,646},{300,655}}, {{90,720},{150,705},{230,712},{270,735}},
  {{300,700},{340,690},{380,702}}, {{40,800},{110,785},{180,790}}, {{200,795},{260,780},{330,792},{370,815}},
}
local k = knife{width=22}
local ks = knife{width=12}
for i, top in ipairs(rocks) do
  -- top planes: short pulls along each segment, slightly below the edge
  for j = 1, #top - 1 do
    local a, b = top[j], top[j+1]
    k:load((j % 2 == 1) and mosslit or rim_warm, 0.4)
    k:lay({{a[1], a[2] + 3}, {b[1], b[2] + 3}}, {pressure={0.06, 0.12}})
    -- shadowed side plane under it: grayer, pulled down
    ks:load(rockgray, 0.3)
    local mx = (a[1] + b[1]) / 2
    ks:lay({{mx, (a[2] + b[2])/2 + 10}, {mx + rand(-4, 4), (a[2] + b[2])/2 + 40}}, {pressure={0.08, 0.15}})
  end
end

--@ chunk 4
local rocks = {
  {{560,640},{620,620},{670,628},{700,650}}, {{710,660},{760,646},{800,655}}, {{590,720},{650,705},{730,712},{770,735}},
  {{800,700},{840,690},{880,702}}, {{540,800},{610,785},{680,790}}, {{700,795},{760,780},{830,792},{870,815}},
}
for i, top in ipairs(rocks) do
  for j = 1, #top - 1 do
    local a, b = top[j], top[j+1]
    local dx, dy = b[1] - a[1], b[2] - a[2]
    local len = math.sqrt(dx*dx + dy*dy)
    local ang = math.atan(dy, dx)
    local k = knife{width=len * 0.9}
    local mx, my = (a[1] + b[1]) / 2, (a[2] + b[2]) / 2
    k:load((j % 2 == 1) and mosslit or rim_warm, 0.35)
    k:lay({{mx, my + 1}, {mx + rand(-2,2), my + rand(5, 10)}}, {pressure={0.1, 0.2}, angle=ang})
    -- side plane: blade vertical-ish, pulled sideways a little
    local ks = knife{width=rand(18, 34)}
    ks:load(rockgray, 0.3)
    local sx = (j == 1) and a[1] + 4 or b[1] - 4
    ks:lay({{sx, my + 22}, {sx + ((j == 1) and 6 or -6), my + 24}}, {pressure={0.15, 0.2}, angle=math.pi/2 + rand(-0.2, 0.2)})
  end
end
