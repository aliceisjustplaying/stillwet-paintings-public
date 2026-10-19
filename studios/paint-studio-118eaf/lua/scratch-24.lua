-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}, name="ld_mid2"}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}, name="ld_near2"}
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}, name="cw_dark"}
jeans_dk2 = pile{{"ultramarine blue", 0.5}, {"bone black", 0.5}, {"raw umber", 0.9}, {"burnt sienna", 0.2}, {"rose madder", 0.08}, name="jeans_dk2"}
gm_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"rose madder", 0.15}, {"bone black", 0.15}, {"lead white", 0.15}, name="gm_dk"}
heap_dk = mix{{gm_dk, 0.65}, {cw_dark, 0.35}, name="heap_dk"}
cr_dk = pile{{"raw umber", 1}, {"bone black", 0.3}, {"burnt sienna", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 0.08}, name="cr_dk"}
pz = {{ld_mid2, function(x,y) return 1 - smoothstep(600, 650, y) end},
      {ld_near2, function(x,y) return smoothstep(600, 650, y) + 0.3 end}}
function parts(dx)
  local legs = poly({{769+dx,540},{782+dx,540},{776+dx,612},{773+dx,617},{767+dx,617},{765+dx,612}})
             + poly({{828+dx,540},{841+dx,540},{855+dx,600},{853+dx,605},{847+dx,605},{845+dx,600}})
  local L = poly({{763+dx,603},{776+dx,603},{779+dx,612},{781+dx,623.5},{779.5+dx,629},{766+dx,629.6},{750+dx,630.4},{743.5+dx,629.2},{742.5+dx,625.5},{746+dx,620.5},{755+dx,616.5},{761+dx,611}})
  local R = poly({{843+dx,597},{839+dx,603},{833+dx,609},{827+dx,614},{823+dx,617.5},{821+dx,620.5},{821.5+dx,623.5},{825+dx,624.6},{836+dx,624.4},{845+dx,620.5},{854+dx,614},{859.5+dx,608.5},{858.5+dx,600},{855+dx,596}})
  local cross = poly({{901+dx,545},{913+dx,545},{908+dx,592},{906+dx,598},{898+dx,598},{896+dx,592}})
  return legs + L + R + cross, legs, L + R, cross
end
function replica(dx)
  local g = rect(700 + dx, 545, 300, 105)
  work(g, {hand="body", tool={kind="flat", width=12, stiffness=0.6}, piles=pz,
    angle=function(x,y) return 0.05*math.sin(x/60 + y/35) end, length={25, 80},
    coverage=1.7, fill=true, clip=g, mix_jitter=0.06, seed=11})
  local all, legs, feet, cross = parts(dx)
  local pit = poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}})
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
replica(-600)
wait(16*24*60)
print(drying(800,620), drying(850,595), drying(550,595), drying(930,600), drying(300,600))

--@ chunk 3
local function sh(pts, dx) local q = {} for i, p in ipairs(pts) do q[i] = {p[1] + dx, p[2]} end return q end
local heapP = {{gm_dk, function(x,y) return 1 - smoothstep(588, 612, y) end}, {heap_dk, function(x,y) return smoothstep(586, 610, y) end}}
-- T1 (dx 0): rectangular slot removed; broken mound left of the cross with a ragged crater; dark clods
local dx = 0
local P = parts(dx):grow(0.3)
local oldpit = poly(sh({{802,589},{850,587.5},{892,587},{899,601},{850,602.5},{796,603}}, dx)):grow(2.5) - P
work(oldpit, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=oldpit, seed=101})
mnd1 = poly(sh({{808,611},{811,604},{818,599},{830,594.5},{844,591.5},{858,589.4},{872,588.2},{886,587.6},{898,588.2},{900,612},{872,612.5},{846,612},{824,612}}, dx), true):roughen(1.5, 4, 111) - P
work(mnd1, {hand="detail", tool={kind="round", width=2.5}, piles=heapP, coverage=3.2, clip=mnd1, angle=0.1, seed=102})
crat1 = poly(sh({{836,596},{842,593.4},{850,592.8},{856,594},{862,592},{870,591.4},{878,592.2},{886,591.6},{893,593},{895,596.4},{890,599},{882,600},{874,599.2},{866,601},{856,600.4},{848,601.2},{840,600}}, dx)):roughen(0.8, 2.5, 112) - P
work(crat1, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=crat1, angle=0, seed=103})
local cl = {}
for i, c in ipairs({{798,607,3.2,2},{805,614,2.4,1.6},{790,612,2,1.4},{872,616,3,1.8},{884,619,2.2,1.5},{815,618,1.8,1.3},{863,620,1.6,1.2}}) do
  cl[#cl+1] = ellipse(c[1]+dx, c[2], c[3], c[4]):roughen(0.5, 1.5, 120+i)
end
clods1 = cl[1]; for i = 2, #cl do clods1 = clods1 + cl[i] end
clods1 = clods1 - P
work(clods1, {hand="detail", tool={kind="round", width=1.6}, pile=heap_dk, coverage=3.5, clip=clods1, angle=0, seed=104})
-- T2 (dx -300): keep the slot, add a spoil bank behind it running into the heap
dx = -300
P = parts(dx):grow(0.3)
local slot2 = poly(sh({{802,589},{850,587.5},{892,587},{899,601},{850,602.5},{796,603}}, dx))
bank2 = poly(sh({{794,591},{797,585.5},{804,582.4},{814,582},{824,580.2},{836,580.8},{848,579.2},{860,580.2},{872,579.2},{884,579.8},{896,581},{906,582},{916,581},{916,592},{860,591},{820,591}}, dx), true):roughen(1.2, 3, 131) - P - slot2
work(bank2, {hand="detail", tool={kind="round", width=2.5}, piles={{gm_dk, function(x,y) return 1 - smoothstep(580, 592, y) end}, {heap_dk, function(x,y) return 0.3 + smoothstep(582, 592, y) end}}, coverage=3.2, clip=bank2, angle=0.05, seed=201})
print(mnd1:area(), crat1:area(), clods1:area(), bank2:area())

--@ chunk 4
wait(14*24*60)
print(drying(860,596), drying(850,590), drying(560,584), drying(805,614))
