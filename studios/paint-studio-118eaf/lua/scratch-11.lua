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
dab_lt_far = pile{{"lead white", 1}, {"raw umber", 0.55}, {"rose madder", 0.25}, {"ultramarine blue", 0.18}, {"orange chrome", 0.2}, {"Naples yellow", 0.4}, name="dab_lt_far"}
dab_lt_mid = pile{{"raw umber", 1}, {"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 0.6}, {"burnt sienna", 0.3}, {"Naples yellow", 0.15}, name="dab_lt_mid"}
dab_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.55}, {"bone black", 0.3}, {"rose madder", 0.2}, {"lead white", 0.1}, name="dab_dk"}
local function sc(x,y) return 0.3 + 1.3*smoothstep(476, 714, y) end
local upper = land * above({{0,640},{1000,640}})
work(upper, {hand="hatch", tool={kind="flat", width=6, stiffness=0.6}, angle=0, angle_jitter=0.06, length={8, 30}, scale_at=sc,
  piles={{dab_lt_far, function(x,y) return 1 - smoothstep(490, 560, y) end}, {dab_lt_mid, function(x,y) return smoothstep(490, 560, y) end}},
  coverage=0.4, load=0.35, load_at=function(x,y) return 0.35*(1 - smoothstep(580, 640, y)) + 0.05 end, clip=land, seed=2})
work(land, {hand="hatch", tool={kind="flat", width=6, stiffness=0.6}, pile=dab_dk, angle=0, angle_jitter=0.06, length={8, 30}, scale_at=sc,
  coverage=0.4, load=0.35, clip=land, seed=3})
