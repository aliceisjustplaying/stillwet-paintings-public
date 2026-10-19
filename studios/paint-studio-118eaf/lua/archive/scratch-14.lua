-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
ld_hz2 = pile{{"lead white", 1}, {"raw umber", 0.6}, {"rose madder", 0.3}, {"ultramarine blue", 0.25}, {"orange chrome", 0.12}, {"Naples yellow", 0.25}}
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}}
land = below({{0,478},{1000,474}})
work(land, {hand="body", tool={kind="flat", width=12, stiffness=0.6},
  piles={{ld_hz2, function(x,y) return 1 - smoothstep(482, 530, y) end},
         {ld_mid2, function(x,y) local t = smoothstep(482, 530, y) return t * (1 - smoothstep(570, 650, y)) end},
         {ld_near2, function(x,y) return smoothstep(570, 650, y) end}},
  angle=0, length={25, 80}, scale_at=function(x,y) return 0.4 + 1.0*smoothstep(476, 714, y) end,
  coverage=1.7, fill=true, clip=land, seed=1})
wait(10*24*60)
sh_glaze = pile{{"ultramarine blue", 1}, {"raw umber", 0.8}, {"bone black", 0.25}, {"rose madder", 0.25}, medium=0.75, name="sh_glaze"}
-- shadow A: soft band, glaze + fill + blend
local A = poly({{300,540},{316,540},{250,714},{170,714}}, true):soften(4)
work(A, {hand="glaze", pile=sh_glaze, coverage=2, fill=true, clip=A:grow(3), angle=-1.2, seed=2})
blend(A:grow(4), {angle=-1.2})
-- shadow B: same with body hand, filbert (more controlled)
local B = poly({{600,540},{616,540},{700,714},{620,714}}, true):soften(4)
work(B, {hand="body", tool={kind="filbert", width=10, stiffness=0.35}, pile=sh_glaze, coverage=2, fill=true, clip=B:grow(3), angle=1.15, seed=3})
blend(B:grow(4), {angle=1.15})

--@ chunk 3
sh_glaze2 = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"bone black", 0.2}, {"rose madder", 0.1}, medium=0.85, name="sh_glaze2"}
local A = poly({{400,540},{412,540},{360,714},{290,714}}, true):soften(10)
work(A, {hand="body", tool={kind="filbert", width=12, stiffness=0.35}, pile=sh_glaze2, coverage=1.5, fill=true, angle=-1.28, edge="soft", seed=4})
blend(A:grow(8), {angle=-1.28})
sh_glaze3 = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"bone black", 0.2}, {"rose madder", 0.1}, medium=0.75, name="sh_glaze3"}
local B = poly({{480,540},{492,540},{460,714},{390,714}}, true):soften(10)
work(B, {hand="glaze", pile=sh_glaze3, coverage=1.5, fill=true, angle=-1.38, edge="soft", seed=5})
blend(B:grow(8), {angle=-1.38})

--@ chunk 4
local k = knife{width=14}
k:scrape({{400,545},{385,600},{360,660},{335,714}}, {pressure=1})
k:scrape({{392,560},{372,620},{348,680},{322,714}}, {pressure=1})
k:scrape({{408,560},{396,620},{370,690},{350,714}}, {pressure=1})
local r = rag{width=14}
r:dip(0.9)
r:wipe({{482,545},{470,600},{455,660},{440,714}}, {pressure=0.8})
r:refold() r:dip(0.9)
r:wipe({{470,560},{455,620},{440,680},{420,714}}, {pressure=0.8})
r:refold() r:dip(0.9)
r:wipe({{488,560},{478,620},{465,690},{452,714}}, {pressure=0.8})

--@ chunk 5
local r = rag{width=20}
for pass = 1, 4 do
  r:refold() r:dip(1.0)
  r:wipe({{480,545},{468,600},{453,660},{438,714}}, {pressure=1.0})
  r:refold() r:dip(1.0)
  r:wipe({{476,560},{462,620},{447,680},{430,714}}, {pressure=1.0})
end
