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
function heapshape(dx)
  return poly({{886+dx,620},{890+dx,606},{898+dx,594},{908+dx,585},{918+dx,581},{930+dx,582},{942+dx,587},{954+dx,594},{966+dx,602},{976+dx,610},{984+dx,617},{986+dx,623},{960+dx,626},{920+dx,627},{895+dx,625}}, true):roughen(2, 5, 81)
end
function slotshape(dx) return poly({{802+dx,589},{850+dx,587.5},{892+dx,587},{899+dx,601},{850+dx,602.5},{796+dx,603}}) end
function replica(dx)
  local g = rect(700 + dx, 545, 300, 105)
  work(g, {hand="body", tool={kind="flat", width=12, stiffness=0.6}, piles=pz,
    angle=function(x,y) return 0.05*math.sin(x/60 + y/35) end, length={25, 80},
    coverage=1.7, fill=true, clip=g, mix_jitter=0.06, seed=11})
  local all, legs, feet, cross = parts(dx)
  local pit = slotshape(dx)
  local heap = heapshape(dx) - legs - feet - cross - pit
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
print(drying(850,595), drying(550,595), drying(250,595))

--@ chunk 3
-- R (dx -300): removal only
local P = parts(-300):grow(0.3)
local cR = slotshape(-300):grow(2.5) - P
work(cR, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=cR, seed=301})
-- H (dx 0): removal + a torn crater in the heap's top
P = parts(0):grow(0.3)
local cH = slotshape(0):grow(2.5) - P - heapshape(0)
work(cH, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=cH, seed=302})
-- heap paint over the part of the old slot inside the heap outline
local hfix = (slotshape(0):grow(2.5) * heapshape(0)) - P
work(hfix, {hand="detail", tool={kind="round", width=2.5},
    piles={{gm_dk, function(x,y) return 1 - smoothstep(590, 620, y) end}, {heap_dk, function(x,y) return smoothstep(588, 618, y) end}},
    coverage=3.5, clip=hfix, angle=0.1, seed=303})
cratH = poly({{917,590.5},{923,588},{931,587.2},{939,588},{947,589.6},{954,592.2},{951,595.4},{943,597.2},{933,597.6},{925,596.6},{919,594}}):roughen(0.7, 2, 304) - P
work(cratH, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=cratH, angle=0, seed=305})
print(cR:area(), cH:area(), hfix:area(), cratH:area())
wait(14*24*60)
print(drying(550,595), drying(850,595), drying(935,592))

--@ chunk 4
local dx = -300
local function sh(pts) local q = {} for i, p in ipairs(pts) do q[i] = {p[1] + dx, p[2]} end return q end
local P = parts(dx):grow(0.3)
-- broken lips: lumps standing above the heap's top line around the opening
local lumps = (ellipse(916+dx,583.5,5,3.2) + ellipse(927+dx,580,4.5,3) + ellipse(944+dx,581.5,5.5,3.4) + ellipse(954+dx,586.5,4,2.8)):roughen(0.8, 2, 401) - P
work(lumps, {hand="detail", tool={kind="round", width=2}, piles={{gm_dk, function(x,y) return 1 end}, {heap_dk, function(x,y) return 0.25 end}}, coverage=3.5, clip=lumps, angle=0.2, seed=402})
-- torn opening: irregular, wider than deep, front lip lower
cratV2 = poly(sh({{914,589},{919,586.4},{924,587.6},{929,585.2},{935,586.4},{940,584.8},{946,586.6},{951,587.2},{955,590.4},{952,592.6},{946,592},{941,594.4},{934,593.4},{928,595},{922,593.2},{917,593.6},{913,591.6}})):roughen(0.9, 1.8, 403) - P
work(cratV2, {hand="detail", tool={kind="round", width=1.8}, pile=cw_dark, coverage=3.5, clip=cratV2, angle=0, seed=404})
print(lumps:area(), cratV2:area())

--@ chunk 5
-- dx -600: remove the slot as on the painting (ground piles outside heap, heap piles inside)
local dx = -600
local P = parts(dx):grow(0.3)
local c = slotshape(dx):grow(2.5) - P - heapshape(dx)
work(c, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3.5, clip=c, seed=501})
local hf = (slotshape(dx):grow(2.5) * heapshape(dx)) - P
work(hf, {hand="detail", tool={kind="round", width=2.5},
    piles={{gm_dk, function(x,y) return 1 - smoothstep(590, 620, y) end}, {heap_dk, function(x,y) return smoothstep(588, 618, y) end}},
    coverage=3.5, clip=hf, angle=0.1, seed=502})
-- dx 0: cover V1 crater with heap paint
dx = 0
P = parts(dx):grow(0.3)
local hc = (cratH:grow(2.5) * heapshape(dx)) - P
work(hc, {hand="detail", tool={kind="round", width=2.5},
    piles={{gm_dk, function(x,y) return 1 - smoothstep(590, 620, y) end}, {heap_dk, function(x,y) return smoothstep(588, 618, y) end}},
    coverage=3.5, clip=hc, angle=0.1, seed=503})
wait(14*24*60)
print(drying(250,595), drying(935,592))

--@ chunk 6
local function sh(pts, dx) local q = {} for i, p in ipairs(pts) do q[i] = {p[1] + dx, p[2]} end return q end
-- V3 (dx 0): torn, irregular crater in the heap top
local dx = 0
local P = parts(dx):grow(0.3)
cr3 = poly(sh({{915,590.8},{918,588.6},{922,589.4},{925,587.2},{930,587.8},{934,586.2},{938,587.6},{943,586.8},{947,588.8},{951,589.2},{954,591.4},{950,592.6},{947,594.6},{942,593.8},{938,595.8},{933,594.6},{928,596},{924,594.4},{919,594.8},{916,593}}, dx)):roughen(1.1, 2.2, 601) - P
work(cr3, {hand="detail", tool={kind="round", width=1.6}, pile=cw_dark, coverage=3.5, clip=cr3, angle=0, seed=602})
-- V4 (dx -600): same torn crater + a few dark clods thrown toward the zombie's feet
dx = -600
P = parts(dx):grow(0.3)
cr4 = poly(sh({{915,590.8},{918,588.6},{922,589.4},{925,587.2},{930,587.8},{934,586.2},{938,587.6},{943,586.8},{947,588.8},{951,589.2},{954,591.4},{950,592.6},{947,594.6},{942,593.8},{938,595.8},{933,594.6},{928,596},{924,594.4},{919,594.8},{916,593}}, dx)):roughen(1.1, 2.2, 601) - P
work(cr4, {hand="detail", tool={kind="round", width=1.6}, pile=cw_dark, coverage=3.5, clip=cr4, angle=0, seed=603})
local cl = {}
for i, c in ipairs({{878,612,2.8,1.7},{866,618,2.2,1.4},{884,622,2,1.3},{870,606,1.8,1.2},{858,624,1.6,1.1}}) do
  cl[#cl+1] = ellipse(c[1]+dx, c[2], c[3], c[4]):roughen(0.5, 1.5, 610+i)
end
cl4 = cl[1]; for i = 2, #cl do cl4 = cl4 + cl[i] end
cl4 = cl4 - P
work(cl4, {hand="detail", tool={kind="round", width=1.6}, pile=heap_dk, coverage=3.5, clip=cl4, angle=0, seed=604})
print(cr3:area(), cl4:area())
