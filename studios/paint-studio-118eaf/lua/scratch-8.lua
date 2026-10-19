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
tx_lt = pile{{"lead white", 1}, {"raw umber", 0.5}, {"rose madder", 0.2}, {"Naples yellow", 0.35}, {"orange chrome", 0.1}, name="tx_lt"}
tx_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.5}, {"bone black", 0.25}, {"rose madder", 0.15}, name="tx_dk"}
tx_dk2 = pile{{"raw umber", 1}, {"ultramarine blue", 0.6}, {"bone black", 0.5}, {"burnt sienna", 0.3}, name="tx_dk2"}
local A = land * rect(0, 0, 500, 714)
work(A * above({{0,640},{1000,640}}), {hand="hatch", tool={kind="flat", width=5, stiffness=0.6}, pile=tx_lt, angle=0, angle_jitter=0.05, length={10, 40},
  scale_at=function(x,y) return 0.35 + 1.4*smoothstep(476, 714, y) end, coverage=0.35, load=0.4, clip=A, seed=2})
work(A, {hand="hatch", tool={kind="flat", width=5, stiffness=0.6}, pile=tx_dk, angle=0, angle_jitter=0.05, length={10, 40},
  scale_at=function(x,y) return 0.35 + 1.4*smoothstep(476, 714, y) end, coverage=0.45, load=0.5, clip=A, seed=3})
local B = land * rect(500, 0, 500, 714)
stipple(B, {pile=tx_dk2, width=4, coverage=function(x,y) return 0.25 + 0.4*smoothstep(520, 714, y) end, cluster={0.8, 30}, drag={4, 0}, feather=1, seed=4})
stipple(B, {pile=tx_lt, width=3, coverage=function(x,y) return 0.25*(1 - smoothstep(560, 700, y)) end, cluster={0.7, 20}, drag={5, 0}, feather=1, seed=5})

--@ chunk 3
sage_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.4}, {"green earth", 0.5}, name="sage_dk"}
sage_lt = pile{{"green earth", 0.6}, {"Naples yellow", 0.5}, {"lead white", 0.4}, {"raw umber", 0.3}, {"orange chrome", 0.1}, name="sage_lt"}
function sage(x, y, s, seed)
  local m = (ellipse(x, y - 3*s, 12*s, 7*s) + ellipse(x - 7*s, y - 1*s, 7*s, 5*s) + ellipse(x + 8*s, y - 1*s, 8*s, 5*s)):roughen(2.5*s, 5*s, seed, 0.5)
  stipple(m, {pile=sage_dk, width=2.2*s, coverage=2.2, cluster={0.5, 4*s}, pressure={0.4, 0.8}, feather=1, seed=seed})
  local top = m * ellipse(x + 3*s, y - 8*s, 10*s, 5*s)
  stipple(top, {pile=sage_lt, width=1.6*s, coverage=0.8, cluster={0.6, 3*s}, pressure={0.3, 0.6}, feather=1, seed=seed+1})
  -- twigs at the base
  local tb = brush{kind="round", width=1.2*s, point=0.9}
  tb:reload(sage_dk, 0.6)
  for i = 1, 4 do local a = rand(-2.6, -0.5) tb:gesture({{x + rand(-6,6)*s, y + 2*s, 0.6}, {x + rand(-8,8)*s + math.cos(a)*6*s, y + math.sin(a)*8*s, 0.1}}) end
end
sage(560, 640, 1.6, 1)
sage(650, 600, 1.2, 2)
sage(720, 560, 0.9, 3)
sage(800, 520, 0.6, 4)
sage(870, 500, 0.4, 5)
-- a rise: soft darker band below a lit crest
gl_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.6}, {"bone black", 0.25}, {"rose madder", 0.15}, medium=0.8, name="gl_dk"}
local rise = poly({{500,585},{620,575},{760,580},{1000,590},{1000,625},{500,620}}, true):soften(10)
work(rise, {hand="glaze", pile=gl_dk, coverage=1.5, fill=true, clip=true, angle=0, seed=6})
blend(rise:grow(4), {angle=0})
