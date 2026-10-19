-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
print(type(zg_pit), type(ld_mid2), type(land_piles), type(zf_L), type(crosses_paint), type(zg_heap2), type(cw_dark))
print(drying(850,595), drying(930,600), drying(760,620))

--@ chunk 3
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}, name="ld_mid2"}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}, name="ld_near2"}
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}, name="cw_dark"}
jeans_dk2 = pile{{"ultramarine blue", 0.5}, {"bone black", 0.5}, {"raw umber", 0.9}, {"burnt sienna", 0.2}, {"rose madder", 0.08}, name="jeans_dk2"}
gm_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"rose madder", 0.15}, {"bone black", 0.15}, {"lead white", 0.15}, name="gm_dk"}
gm_lt = pile{{"lead white", 1}, {"raw umber", 0.6}, {"rose madder", 0.25}, {"Naples yellow", 0.3}, {"ultramarine blue", 0.15}, name="gm_lt"}
heap_dk = mix{{gm_dk, 0.65}, {cw_dark, 0.35}, name="heap_dk"}
cr_dk = pile{{"raw umber", 1}, {"bone black", 0.3}, {"burnt sienna", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 0.08}, name="cr_dk"}
pz = {{ld_mid2, function(x,y) return 1 - smoothstep(600, 650, y) end},
      {ld_near2, function(x,y) return smoothstep(600, 650, y) + 0.3 end}}
function replica(dx)
  local g = rect(700 + dx, 545, 300, 105)
  work(g, {hand="body", tool={kind="flat", width=12, stiffness=0.6}, piles=pz,
    angle=function(x,y) return 0.05*math.sin(x/60 + y/35) end, length={25, 80},
    coverage=1.7, fill=true, clip=g, mix_jitter=0.06, seed=11})
  local pit = poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}})
  local legs = poly({{769+dx,540},{782+dx,540},{776+dx,612},{773+dx,617},{767+dx,617},{765+dx,612}})
             + poly({{828+dx,540},{841+dx,540},{855+dx,600},{853+dx,605},{847+dx,605},{845+dx,600}})
  local L = poly({{763+dx,603},{776+dx,603},{779+dx,612},{781+dx,623.5},{779.5+dx,629},{766+dx,629.6},{750+dx,630.4},{743.5+dx,629.2},{742.5+dx,625.5},{746+dx,620.5},{755+dx,616.5},{761+dx,611}})
  local R = poly({{843+dx,597},{839+dx,603},{833+dx,609},{827+dx,614},{823+dx,617.5},{821+dx,620.5},{821.5+dx,623.5},{825+dx,624.6},{836+dx,624.4},{845+dx,620.5},{854+dx,614},{859.5+dx,608.5},{858.5+dx,600},{855+dx,596}})
  local feet = L + R
  local cross = poly({{901+dx,545},{913+dx,545},{908+dx,592},{906+dx,598},{898+dx,598},{896+dx,592}})
  local heap = poly({{886+dx,620},{890+dx,606},{898+dx,594},{908+dx,585},{918+dx,581},{930+dx,582},{942+dx,587},{954+dx,594},{966+dx,602},{976+dx,610},{984+dx,617},{986+dx,623},{960+dx,626},{920+dx,627},{895+dx,625}}, true):roughen(2, 5, 81) - legs - feet - cross - pit
  work(heap, {hand="detail", tool={kind="round", width=2.5},
    piles={{gm_dk, function(x,y) return 1 - smoothstep(590, 620, y) end}, {heap_dk, function(x,y) return smoothstep(588, 618, y) end}},
    coverage=3.2, clip=heap, angle=0.1, seed=12})
  work(pit - legs - feet - cross, {hand="detail", tool={kind="round", width=2.5}, pile=cw_dark, coverage=3.5, clip=pit - legs - feet - cross, angle=0, seed=13})
  work(cross, {hand="detail", tool={kind="round", width=2.5}, pile=cr_dk, coverage=3.5, clip=cross, angle=1.5, seed=14})
  work(legs - feet, {hand="detail", tool={kind="round", width=2.5}, pile=jeans_dk2, coverage=3.5, clip=legs - feet, angle=1.4, seed=15})
  work(feet, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3, clip=feet, angle=0, seed=16})
end
replica(0)
replica(-300)
wait(16*24*60)
print(drying(800,620), drying(850,595), drying(550,595), drying(930,600), drying(600,600))

--@ chunk 4
pit_wall = mix{{gm_dk, 0.45}, {cw_dark, 0.55}, name="pit_wall"}
function parts(dx)
  local legs = poly({{769+dx,540},{782+dx,540},{776+dx,612},{773+dx,617},{767+dx,617},{765+dx,612}})
             + poly({{828+dx,540},{841+dx,540},{855+dx,600},{853+dx,605},{847+dx,605},{845+dx,600}})
  local L = poly({{763+dx,603},{776+dx,603},{779+dx,612},{781+dx,623.5},{779.5+dx,629},{766+dx,629.6},{750+dx,630.4},{743.5+dx,629.2},{742.5+dx,625.5},{746+dx,620.5},{755+dx,616.5},{761+dx,611}})
  local R = poly({{843+dx,597},{839+dx,603},{833+dx,609},{827+dx,614},{823+dx,617.5},{821+dx,620.5},{821.5+dx,623.5},{825+dx,624.6},{836+dx,624.4},{845+dx,620.5},{854+dx,614},{859.5+dx,608.5},{858.5+dx,600},{855+dx,596}})
  local cross = poly({{901+dx,545},{913+dx,545},{908+dx,592},{906+dx,598},{898+dx,598},{896+dx,592}})
  return legs + L + R + cross
end
-- A: perspective parallelogram (far edge shifted toward the VP), ragged lips
local dx = 0
local P = parts(dx):grow(0.3)
local oldpit = poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}}):grow(1.2)
holeA = poly({{782,589},{795,588},{805,589.8},{811,588.6},{822,588},{840,588.6},{858,587.6},{866,588.8},{872,588.2},{881,588},
              {885,592},{890,598},{894,604},{886,603.6},{878,605},{868,604.2},{862,605.2},{852,604.4},{845,604.2},{836,605},{826,605.2},{818,604.2},{810,604.6},{803,605},{797,604.6},{792,600},{787,594}}):roughen(0.6, 2.5, 91) - P
local excA = oldpit - holeA - P
work(excA, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=excA, seed=101})
work(holeA, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=holeA, angle=0, seed=102})
-- inner face of the right end wall, a step lighter
endwallA = poly({{880.5,589},{885,592},{890,598},{893,604},{880.5,604}}) * holeA
work(endwallA, {hand="detail", tool={kind="round", width=1.6}, pile=pit_wall, coverage=3.5, clip=endwallA, angle=1.5, seed=103})
-- B: same rectangle, ragged lips: bites of ground into the edges and ends
dx = -300
P = parts(dx):grow(0.3)
local bites = (ellipse(797+dx,596,4.5,8.5) + ellipse(900+dx,594,4.5,9) + ellipse(818+dx,588,4,1.6) + ellipse(865+dx,587.6,5,1.8)
             + ellipse(812+dx,604.2,6,1.8) + ellipse(838+dx,603.4,5,1.5) + ellipse(880+dx,602.8,7,1.8)):roughen(0.8, 2.5, 92) - P
work(bites, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=bites, seed=104})
print(holeA:area(), excA:area(), endwallA:area(), bites:area())

--@ chunk 5
clod_md = mix{{gm_dk, 0.5}, {ld_mid2, 0.5}, name="clod_md"}
function clods(dx, nearpts, farpts, seedbase)
  local P = parts(dx):grow(0.3)
  local keep = -P
  local tb = brush{kind="round", width=3.4, stiffness=0.5}
  for i, c in ipairs(nearpts) do
    tb:reload(clod_md, 0.7)
    tb:touch(c[1] + dx, c[2], {pressure=c[3], drag={c[4] or 2, -0.3}, clip=keep})
  end
  local sb = brush{kind="round", width=2.2, stiffness=0.5}
  for i, c in ipairs(farpts) do
    sb:reload(clod_md, 0.7)
    sb:touch(c[1] + dx, c[2], {pressure=c[3], drag={c[4] or 1.5, 0.3}, clip=keep})
  end
end
-- A
clods(0, {{800,604.6,0.6,2},{809,605.4,0.8,3},{822,605.2,0.5,1.5},{831,605.8,0.7,2.5},{866,605.2,0.6,2},{876,605.8,0.8,3},{887,604.6,0.55,1.5}},
         {{790,589.4,0.5},{804,590.2,0.6},{816,589.4,0.45},{833,589.6,0.55},{862,589.2,0.5},{874,589.4,0.6}})
-- B (same lips at the rectangle's position)
clods(-300, {{802,603.6,0.6,2},{811,604.2,0.8,3},{824,603.8,0.5,1.5},{833,604.2,0.7,2.5},{868,603.4,0.6,2},{878,603.8,0.8,3},{889,602.6,0.55,1.5}},
         {{808,589.6,0.5},{820,589.4,0.6},{834,588.8,0.45},{850,588.6,0.55},{866,588.2,0.5},{880,588.2,0.6}})

--@ chunk 6
wait(10*24*60)
print(drying(809,605), drying(831,606), drying(804,590), drying(511,604))
clod_lt = mix{{gm_lt, 0.55}, {ld_mid2, 0.45}, name="clod_lt"}
function cloud_tops(dx, pts)
  local P = parts(dx):grow(0.3)
  local tb = brush{kind="round", width=1.8, point=0.8, stiffness=0.55}
  for i, c in ipairs(pts) do
    tb:reload(clod_lt, 0.6)
    tb:gesture({{c[1]+dx-1.2, c[2]+0.4, 0.2}, {c[1]+dx, c[2], c[3]}, {c[1]+dx+1.4, c[2]+0.3, 0.15}}, {wobble=0.05, clip=-P})
  end
end
cloud_tops(0, {{809,603.6,0.5},{831,604.2,0.45},{876,604.2,0.5},{866,603.8,0.35},{800,603.4,0.35},{804,588.6,0.3},{874,587.8,0.3},{833,588.2,0.25}})
cloud_tops(-300, {{811,602.6,0.5},{833,602.6,0.45},{878,602.2,0.5},{868,602,0.35},{802,602.2,0.35},{820,588,0.3},{880,586.8,0.3},{850,587.2,0.25}})

--@ chunk 7
wait(8*24*60)
print(drying(511,603), drying(533,603), drying(809,604))
local dx = -300
local P = parts(dx):grow(0.3)
-- cover B's old slot and its clods with ground
local oldB = poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}}):grow(3.5) - P
work(oldB, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=oldB, seed=201})
print(oldB:area())

--@ chunk 8
wait(10*24*60)
print(drying(540,595), drying(580,598))
local dx = -300
local P = parts(dx):grow(0.3)
local function sh(pts) local q = {} for i, p in ipairs(pts) do q[i] = {p[1] + dx, p[2]} end return q end
holeA3 = poly(sh({{782,589},{795,588},{805,589.8},{811,588.6},{822,588},{840,588.6},{858,587.6},{866,588.8},{872,588.2},{881,588},
              {885,592},{890,598},{894,604},{886,603.6},{878,605},{868,604.2},{862,605.2},{852,604.4},{845,604.2},{836,605},{826,605.2},{818,604.2},{810,604.6},{803,605},{797,604.6},{792,600},{787,594}})):roughen(1.0, 2.5, 93) - P
-- inner walls seen from the upper left: far wall (top band, wavy lower boundary) + right end wall
local wallsL = poly(sh({{775,586},{900,586},{900,606},{880.5,606},{880.5,594.5},{870,595.5},{858,594},{845,595.8},{830,594.6},{815,596},{800,594.8},{785,595.6},{775,595}})) * holeA3
work(holeA3 - wallsL, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=holeA3 - wallsL, angle=0, seed=202})
work(wallsL, {hand="detail", tool={kind="round", width=1.6},
  piles={{pit_wall, function(x,y) return 1 - smoothstep(590, 596, y) end}, {cw_dark, function(x,y) return 0.25 + 0.5*smoothstep(590, 597, y) end}},
  coverage=3.5, clip=wallsL, angle=0, seed=203})
print(holeA3:area(), wallsL:area())

--@ chunk 9
print(drying(830,596), drying(886,600), drying(809,604))
local P = parts(0):grow(0.3)
local fill = (holeA:grow(2.5) + poly({{802,589},{850,587.5},{892,587},{899,601},{850,602.5},{796,603}}):grow(2.5)) - P
work(fill, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=fill, seed=301})
print(fill:area())

--@ chunk 10
wait(12*24*60)
print(drying(830,596), drying(886,600))

--@ chunk 11
zb_flash = pile{{"orange chrome", 1}, {"Naples yellow", 0.6}, {"burnt sienna", 0.3}, {"lead white", 0.2}, name="zb_flash"}
pit_warm = mix{{pit_wall, 0.75}, {zb_flash, 0.25}, name="pit_warm"}
local P = parts(0):grow(0.3)
holeC = poly({{784,588.6},{796,587.8},{806,589.4},{812,588.2},{824,587.6},{842,588.4},{858,587.4},{867,588.6},{874,587.8},{882,587.6},
              {886,591.5},{890.5,597.5},{894.5,604.2},{887,603.8},{879,605.2},{869,604.4},{862,605.4},{852,604.6},{845,604.6},{836,605.2},{826,605.6},{818,604.6},{810,605},{803,605.4},{797,605},{792.5,600.5},{788,594.5}}):roughen(0.7, 2.5, 95) - P
local endw = poly({{881.5,586},{900,586},{900,607},{881.5,607}}) * holeC
work(holeC - endw, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=holeC - endw, angle=0, seed=401})
work(endw, {hand="detail", tool={kind="round", width=1.6},
  piles={{pit_warm, function(x,y) return 1 - smoothstep(590, 604, y) end}, {pit_wall, function(x,y) return 0.2 + smoothstep(592, 605, y) end}},
  coverage=3.5, clip=endw, angle=1.2, seed=402})
print(holeC:area(), endw:area())

--@ chunk 12
-- cover trial C (dx 0) and holeA3 (dx -300) with ground; fresh third replica at dx -600 for the original slot as comparator
local P0 = parts(0):grow(0.3)
local c0 = (holeC:grow(2.5) + poly({{802,589},{850,587.5},{892,587},{899,601},{850,602.5},{796,603}}):grow(2.5)) - P0
work(c0, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=c0, seed=501})
local P1 = parts(-300):grow(0.3)
local c1 = (holeA3:grow(2.5)) - P1
work(c1, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=c1, seed=502})
replica(-600)
wait(16*24*60)
print(drying(840,596), drying(540,596), drying(240,596), drying(170,615))

--@ chunk 13
-- D (dx -300): same slot place and size, ragged lips, far wall graded from earth to dark (no hard band edge)
local dx = -300
local P = parts(dx):grow(0.3)
local function sh(pts) local q = {} for i, p in ipairs(pts) do q[i] = {p[1] + dx, p[2]} end return q end
holeD = poly(sh({{799,589.6},{808,588.4},{818,589.2},{830,588},{844,588.8},{856,587.6},{868,588.4},{880,587.4},{892,587.8},
                 {896,592},{899,597},{898.5,601.5},{890,602.6},{878,603.4},{866,602.6},{852,603.4},{838,602.8},{824,603.6},{810,603},{798,603.4},{796,598},{797,593}})):roughen(0.8, 2.5, 96) - P
work(holeD, {hand="detail", tool={kind="round", width=1.8},
  piles={{gm_dk, function(x,y) return 1 - smoothstep(589, 594, y) end},
         {heap_dk, function(x,y) return smoothstep(588, 592, y) * (1 - smoothstep(594, 598, y)) end},
         {cw_dark, function(x,y) return smoothstep(592, 598, y) end}},
  coverage=3.5, clip=holeD, angle=0, seed=601})
-- F (dx 0): a rectangular grave in true perspective, ends converging to the eye point (500,480)
dx = 0
P = parts(dx):grow(0.3)
holeF = poly({{762,588.4},{775,587.6},{790,588.6},{805,587.8},{820,588.4},{834,587.6},{848,588},
              {862,592.4},{880,598.2},{900,604.4},{886,605},{870,604.2},{856,605.2},{840,604.6},{826,605.4},{812,604.6},{800,605},{788,600.6},{775,594.6}}):roughen(0.8, 2.5, 97) - P
local endF = poly({{848,586},{910,586},{910,608},{848,608}}) * holeF
local inF = holeF - endF
work(inF, {hand="detail", tool={kind="round", width=1.8},
  piles={{heap_dk, function(x,y) return 1 - smoothstep(589, 595, y) end},
         {cw_dark, function(x,y) return smoothstep(590, 597, y) end}},
  coverage=3.5, clip=inF, angle=0, seed=602})
work(endF, {hand="detail", tool={kind="round", width=1.6},
  piles={{pit_wall, function(x,y) return 1 end}, {heap_dk, function(x,y) return 0.4*(1 - smoothstep(590, 600, y)) end}},
  coverage=3.5, clip=endF, angle=1.2, seed=603})
print(holeD:area(), holeF:area(), endF:area())

--@ chunk 14
-- REMOVAL trial: cover D (dx -300) with ground only
local P = parts(-300):grow(0.3)
local c1 = (holeD:grow(2.5) + poly({{502,589},{550,587.5},{592,587},{599,601},{550,602.5},{496,603}}):grow(3)) - P
work(c1, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=c1, seed=701})
print(c1:area())

--@ chunk 15
wait(14*24*60)
print(drying(540,596), drying(580,598))

--@ chunk 16
s2_dusk = pile{{"ultramarine blue", 0.8}, {"lead white", 0.8}, {"raw umber", 0.35}, {"rose madder", 0.12}, {"Prussian blue", 0.05}, name="s2_dusk"}
s2_mauve = pile{{"lead white", 1.5}, {"ultramarine blue", 0.4}, {"rose madder", 0.35}, {"raw umber", 0.2}, name="s2_mauve"}
s2_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}, name="s2_rose"}
cl_pink = pile{{"lead white", 2}, {"rose madder", 0.4}, {"vermilion", 0.15}, {"ultramarine blue", 0.15}, {"raw umber", 0.1}, name="cl_pink"}
local sk = rect(500, 40, 480, 220)
work(sk, {hand="broad", piles={
   {s2_dusk, function(x,y) return 1 - smoothstep(70, 120, y) end},
   {s2_mauve, function(x,y) return smoothstep(60, 110, y) * (1 - smoothstep(150, 200, y)) end},
   {s2_rose, function(x,y) return smoothstep(150, 200, y) end}},
  angle=0.03, coverage=2, fill=true, clip=sk, mix_jitter=0.05, seed=801})
wait(12*24*60)
print(drying(700,140), drying(600,220))

--@ chunk 17
local cb3 = brush{kind="filbert", width=14, stiffness=0.35}
cb3:reload(cl_pink, 0.4)
cb3:gesture({{640,104,0.05},{740,100,0.3},{860,94,0.35},{980,90,0.25}}, {wobble=6, orient="across"})
blend(rect(560, 60, 420, 80):soften(15), {angle=0.04})
wait(12*24*60)
print(drying(800,97))
