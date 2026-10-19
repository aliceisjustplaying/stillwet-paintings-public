-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
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
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 2}, {"red earth", 1}, {"yellow ochre", 1}}, texture=0.35, um=90}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.25}, {"raw umber", 0.08}}, texture=0.4, um=45}}, linen={15, 13}, seed=6, size=1050}

--@ chunk 2
horizon=440
-- sky & a slab pair like A/Ae and C, dry, then articulation trials
skyp = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}}
litW = pile{{"lead white",6},{"Naples yellow",0.14}}
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}}
sC2 = pile{{"lead white",1.6},{"cobalt blue",0.8},{"smalt",0.5},{"Naples yellow",0.15},{"rose madder",0.08},{"raw umber",0.1}}
sDeep = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.12},{"raw umber",0.4}}
work(rect(0,0,1000,440), {hand="body", pile=skyp, clip=true, coverage=2, fill=true, angle=0})
A = {{150,420},{200,140},{250,40},{268,52},{300,420}}
Ae = {{268,52},{285,66},{320,180},{345,425},{300,420}}
C = {{320,180},{370,120},{560,420},{345,425}}
work(poly(A), {hand="body", pile=litW, clip=true, coverage=2, fill=true, angle=-1.3, tool="filbert 6"})
work(poly(Ae), {hand="body", pile=sDeep, clip=true, coverage=2, fill=true, angle=1.4, tool="filbert 4"})
work(poly(C) - poly(Ae), {hand="body", piles={{sC1,1},{sC2,1}}, clip=true, coverage=2, fill=true, angle=1.0, tool="filbert 6"})
-- copy on right for comparison
A2 = {} for i,p in ipairs(A) do A2[i] = {p[1]+450, p[2]} end
Ae2 = {} for i,p in ipairs(Ae) do Ae2[i] = {p[1]+450, p[2]} end
C2 = {} for i,p in ipairs(C) do C2[i] = {p[1]+450, p[2]} end
work(poly(A2), {hand="body", pile=litW, clip=true, coverage=2, fill=true, angle=-1.3, tool="filbert 6"})
work(poly(Ae2), {hand="body", pile=sDeep, clip=true, coverage=2, fill=true, angle=1.4, tool="filbert 4"})
work(poly(C2) - poly(Ae2), {hand="body", piles={{sC1,1},{sC2,1}}, clip=true, coverage=2, fill=true, angle=1.0, tool="filbert 6"})
wait(6*24*60)
print(drying(220,300), drying(330,300), drying(450,300))

--@ chunk 3
local ox = 450
local function S(pts) local q={} for i,p in ipairs(pts) do q[i]={p[1]+ox,p[2]} end return q end
csA = pile{{"cobalt blue",1},{"smalt",0.5},{"rose madder",0.05}, medium=0.7}
clr = pile{{"lead white",0.2},{"Naples yellow",0.02}, medium=0.95}
turq = pile{{"Prussian blue",0.25},{"cobalt blue",0.6},{"green earth",0.6}, medium=0.75}
-- 1 graded cool glaze on lower part of lit face
work(poly(A2), {hand="glaze", piles={{csA, function(x,y) return clamp((y-150)/270,0,1)^1.5 end},{clr, function(x,y) return clamp(1-(y-150)/270,0,1)+0.02 end}}, coverage=1, clip=true, angle=-1.3, seed=1})
-- 7 turquoise glaze at top of the thickness edge
work(poly(Ae2) * rect(0,0,1000,230), {hand="glaze", pile=turq, coverage=1, clip=true, angle=1.4, seed=2})
-- 2 reflected light at bottom of shadow face (warm, lighter) body scumble
refl = pile{{"lead white",2.5},{"cobalt blue",0.45},{"smalt",0.3},{"Naples yellow",0.3},{"rose madder",0.06}, thinner=0.3}
work((poly(C2) - poly(Ae2)) * below(function(x) return 330 + (x-770)*0.0 end), {hand="scumble", pile=refl, coverage=0.8, angle=0.1, seed=3})

--@ chunk 4
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}}
reflW = pile{{"lead white",2.2},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.3},{"rose madder",0.05}}
local lowA = poly(A) * below(function(x) return 260 end)
work(lowA, {hand="body", pile=litCool, edge="lost", clip=poly(A), coverage=1.6, fill=true, angle=-1.3, tool="filbert 5", seed=4})
local lowC = (poly(C) - poly(Ae)) * below(function(x) return 330 end)
work(lowC, {hand="body", pile=reflW, edge="lost", clip=poly(C)-poly(Ae), coverage=1.6, fill=true, angle=0.2, tool="filbert 5", seed=5})

--@ chunk 5
local ox = 450
crackD = pile{{"cobalt blue",1},{"smalt",0.5},{"raw umber",0.25},{"lead white",0.6}, name="crackD"}
crackL = pile{{"lead white",6},{"Naples yellow",0.2}, name="crackL"}
strata = pile{{"lead white",1.6},{"cobalt blue",0.9},{"smalt",0.5},{"green earth",0.2},{"raw umber",0.1}}
rg = brush{kind="rigger", width=1.2, point=1}
-- cracks on lit face A2: jagged lines
local cracks = {
  {{ox+190,180},{ox+205,215},{ox+200,238},{ox+222,270},{ox+230,320}},
  {{ox+170,330},{ox+190,345},{ox+215,342},{ox+240,365},{ox+262,362}},
}
for _,c in ipairs(cracks) do
  rg:reload(crackD, 0.5)
  rg:gesture({{c[1][1],c[1][2],0.1},{c[2][1],c[2][2],0.5},{c[3][1],c[3][2],0.35},{c[4][1],c[4][2],0.5},{c[5][1],c[5][2],0.05}}, {wobble=1.5})
  rg:reload(crackL, 0.5)
  rg:gesture({{c[1][1]-1.5,c[1][2],0.05},{c[2][1]-1.5,c[2][2],0.4},{c[3][1]-1.5,c[3][2],0.3},{c[4][1]-1.5,c[4][2],0.4},{c[5][1]-1.5,c[5][2],0.05}}, {wobble=1})
end
-- strata lines on the thickness edge Ae2: lines parallel to its long side
for k=1,5 do
  local t = k/6
  local a = {lerp(268+ox, 345+ox, 0)+t*17, lerp(52,425,0)+t*14}
  local p1 = {268+ox + t*(285-268), 52 + t*(66-52)}
  local p2 = {300+ox + t*(345-300), 420 + t*(425-420)}
  rg:reload(strata, 0.4)
  rg:stroke({{p1[1], p1[2]+6}, {lerp(p1[1],p2[1],0.5)+rand(-1,1), lerp(p1[2],p2[2],0.5)}, {p2[1], p2[2]-4}}, {pressure={0.25,0.15}, shake=0.6})
end
-- snow lip along top edge of C2 (370+ox,120)->(560+ox,420)
snowL = pile{{"lead white",6},{"Naples yellow",0.12}}
fb = brush{kind="filbert", width=3, stiffness=0.4}
fb:reload(snowL, 0.6)
fb:gesture({{372+ox,123,0.6},{420+ox,198,0.8},{470+ox,276,0.5},{520+ox,355,0.7},{556+ox,413,0.3}}, {wobble=2.5})
-- chips along A2 silhouette (sky colored)
skyp2 = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}}
local chips = {{{200+ox,140},{207+ox,146},{203+ox,152}},{{180+ox,250},{187+ox,262},{181+ox,268}}}
for _,c in ipairs(chips) do work(poly(c), {hand="detail", pile=skyp2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}}) end
