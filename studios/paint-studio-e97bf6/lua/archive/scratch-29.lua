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
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
fgT2 = pile{{"lead white",1.0},{"cobalt blue",0.55},{"smalt",0.35},{"raw umber",0.24},{"Naples yellow",0.14},{"rose madder",0.05}, name="fgT2"}
fgB2 = pile{{"lead white",0.65},{"cobalt blue",0.42},{"smalt",0.3},{"raw umber",0.42},{"green earth",0.25},{"Naples yellow",0.14},{"red earth",0.04}, name="fgB2"}
shEdge = {{-5,571},{60,572.5},{118,574},{124,578},{205,580.5},{262,582},{268,587},{330,592},{410,595.5},{455,597},{461,601},{540,604},{600,606.5},{606,611},{660,615},{702,619},{760,624},{1005,640}}
work(above(shEdge), {hand="broad", pile=pl2, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 10", seed=1})
local m = below(shEdge)
work(m, {hand="broad", piles={{fgT2,function(x,y) return clamp(1-(y-590)/124*1.4,0,1)+0.05 end},{fgB2,function(x,y) return clamp((y-590)/124*1.3-0.15,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 12", seed=2})
blend(m:shrink(1), {angle=0.02, seed=3})
print(wait(7*24*60))

--@ chunk 3
cs1 = pile{{"lead white",1.8},{"cobalt blue",0.65},{"smalt",0.45},{"Naples yellow",0.12},{"rose madder",0.06},{"raw umber",0.07}, name="cs1"}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
sDeepG = pile{{"lead white",0.7},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.4},{"raw umber",0.25}, name="sDeepG"}
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}, name="litCool"}
crevD = pile{{"lead white",0.35},{"cobalt blue",1},{"Prussian blue",0.15},{"raw umber",0.55},{"rose madder",0.05}, name="crevD"}
litWarm = pile{{"lead white",6},{"Naples yellow",0.26},{"red earth",0.006}, name="litWarm"}
wedgeL2 = pile{{"lead white",3},{"cobalt blue",0.35},{"smalt",0.1},{"Naples yellow",0.3},{"raw umber",0.1}, name="wedgeL2"}
npDark = mix{{fgB2,0.5},{sDeepG,0.25},{fgT2,0.25}, name="npDark"}
function nearPlate(P, seed)
  local back = P.back
  local pts = {}
  for _,p in ipairs(back) do pts[#pts+1] = p end
  for _,p in ipairs(P.rest) do pts[#pts+1] = p end
  local top = poly(pts)
  local gn = noise{seed=seed, period=35, stretch={-0.1, 5}}
  local yb = back[1][2]
  work(top, {hand="detail", piles={{npDark,1},{fgT2, function(x,y) return clamp(1-(y-P.ytop)/45,0,1)*0.7 + math.max(0,gn(x,y))*0.35 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3.5}, angle=P.angle or -0.06, seed=seed+1})
  blend(top:shrink(1), {angle=P.angle or -0.06, seed=seed+2})
  -- left end (green thickness)
  local endF = poly(P.endF) - top
  work(endF, {hand="detail", piles={{edgeG,1},{sDeepG, function(x,y) return clamp((y-P.ytop)/70,0,1)+0.2 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.5, seed=seed+3})
  -- front thickness (dark)
  local frontF
  if P.front then
    frontF = poly(P.front) - top - endF
    work(frontF, {hand="detail", piles={{sDeepG,1},{crevD,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=P.frontAngle or 2.2, seed=seed+4})
  end
  -- lit raised rim: broken runs
  local lr = brush{kind="filbert", width=2.4}
  for _,r in ipairs(P.litRuns) do
    local seg = {}
    for k=r[1], r[2] do seg[#seg+1] = {back[k][1], back[k][2] + 0.6} end
    lr:reload(r[3] or wedgeL2, 0.55)
    lr:stroke(seg, {pressure={r[4] or 0.6, r[5] or 0.35}, shake=0.3, clip=top:grow(1.2)})
  end
  return top, endF, frontF
end
local P = {
  back = {{334,628},{341,623},{352,622},{360,617},{373,615},{382,618},{394,612},{410,611},{421,614},{433,609},{450,610},{461,615},{476,614},{491,619},{503,618},{517,624},{532,625},{548,631}},
  rest = {{585,676},{564,716},{316,716},{322,668}},
  endF = {{334,628},{322,668},{316,716},{300,716},{307,670},{322,632}},
  front = {{585,676},{591,683},{574,716},{564,716}},
  ytop = 612,
  litRuns = {{1,4,wedgeL2,0.65,0.5},{6,9,litWarm,0.6,0.4},{11,13,wedgeL2,0.45,0.25}},
}
local top, endF, frontF = nearPlate(P, 61)
local rg = brush{kind="rigger", width=1, point=1}
rg:reload(crevD, 0.45)
rg:stroke({{322,632},{307,670},{302,700},{300,716}}, {pressure={0.3,0.35}, shake=0.2})
rg:reload(crevD, 0.45)
rg:stroke({{548,631},{585,676}}, {pressure={0.25,0.3}, shake=0.15})
for i,f in ipairs({0.25,0.45,0.62,0.85}) do
  local y0 = lerp(634, 716, f)
  rg:reload(sDeepG, 0.35)
  rg:stroke({{lerp(322,334,1-f)+0.5, y0-1},{lerp(308,320,1-f)+rand(3,7), y0+rand(1,3)}}, {pressure={0.2,0.06}, shake=0.2, clip=endF})
end
local crack = {{452,611},{448,630},{452,645},{446,672},{450,694},{445,716}}
rg:reload(crevD, 0.45)
rg:stroke(crack, {pressure={0.22,0.4}, shake=0.1})
local lb = brush{kind="round", width=1.4, point=0.7}
lb:reload(fgT2, 0.45)
lb:stroke({{450,634},{452,645},{448,665}}, {pressure={0.3,0.15}, shake=0.2})
local sn = brush{kind="round", width=3, point=0.5}
for _,p in ipairs({{380,640,8},{410,662,12},{486,646,6},{520,690,14},{540,652,7}}) do
  sn:reload(fgT2, 0.5); sn:touch(p[1], p[2], {pressure=0.5, drag={p[3], 0.5}})
end

--@ chunk 4
local ox, oy = 400, 18
local function S(list) local o = {} for i,p in ipairs(list) do o[i] = {p[1]+ox, math.min(716, p[2]+oy)} end return o end
-- angular far edge: long straight runs rising to the left, a few square chips
local back = S{{330,626},{356,620},{358,616},{392,609},{398,612},{404,607},{446,601},{450,605},{470,604},{474,608},{512,617},{530,616},{550,624}}
local pts = {}
for _,p in ipairs(back) do pts[#pts+1] = p end
for _,p in ipairs(S{{586,672},{566,716},{318,716},{322,666}}) do pts[#pts+1] = p end
local top = poly(pts)
local gn = noise{seed=71, period=35, stretch={-0.1, 5}}
work(top, {hand="detail", piles={{npDark,1},{fgT2, function(x,y) return clamp(1-(y-605-oy)/45,0,1)*0.6 + math.max(0,gn(x,y))*0.3 end},{fgB2, function(x,y) return clamp((x-ox-430)/150,0,1)*0.5 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3.5}, angle=-0.2, seed=72})
blend(top:shrink(1), {angle=-0.2, seed=73})
-- thickness band along the far edge (seen because the far edge is raised): lit on the left run, greenish half-light on the right
local thk = S{{330,626},{356,620},{358,616},{392,609},{398,612},{404,607},{446,601},{450,605},{470,604},{474,608},{512,617},{530,616},{550,624},
              {550,622},{530,613},{512,614},{474,604},{470,600},{450,601},{446,596},{404,601},{398,606},{392,603},{358,609},{356,613},{330,620}}
local thkM = poly(thk) - top
work(thkM, {hand="detail", piles={{wedgeL2, function(x,y) return clamp(1-(x-ox-330)/150,0,1)+0.05 end},{edgeG, function(x,y) return clamp((x-ox-440)/60,0,1) end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.5}, angle=-0.15, seed=74})
local endF = poly(S{{330,620},{330,626},{322,666},{318,716},{302,716},{308,668},{320,626}}) - top
work(endF, {hand="detail", piles={{sDeepG,1},{edgeG, function(x,y) return clamp(1-(y-620-oy)/50,0,1)*0.8 end},{fgB2,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.5, seed=75})
local frontF = poly(S{{586,672},{592,680},{576,716},{566,716}}) - top
work(frontF, {hand="detail", piles={{sDeepG,1},{crevD,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=2.2, seed=76})
local rg = brush{kind="rigger", width=1, point=1}
local seg = S{{320,626},{308,668},{302,716}}
rg:reload(crevD, 0.45)
rg:stroke(seg, {pressure={0.3,0.35}, shake=0.15})
-- a crack: straight segments, dark wall on the right side, light lodged snow on left
local crack = S{{446,601},{441,626},{445,640},{438,668},{441,690},{436,716}}
rg:reload(crevD, 0.45)
rg:stroke(crack, {pressure={0.18,0.4}, shake=0.05})
local lb = brush{kind="round", width=1.6, point=0.6}
lb:reload(fgT2, 0.5)
lb:stroke(S{{439,630},{443,641},{437,666}}, {pressure={0.35,0.2}, shake=0.1})
-- strata on end face: broken
for i,f in ipairs({0.2,0.42,0.6,0.82}) do
  local y0 = lerp(628, 716, f)
  rg:reload(edgeG, 0.35)
  rg:stroke({{lerp(320,330,1-f)+ox+0.5, y0+oy-1},{lerp(308,320,1-f)+ox+rand(3,7), math.min(716,y0+oy+rand(1,3))}}, {pressure={0.2,0.06}, shake=0.2, clip=endF})
end

--@ chunk 5
palette{scrape={npDark}}
slabG3 = pile{{"lead white",0.6},{"cobalt blue",0.35},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.35},{"yellow ochre",0.08},{"Prussian blue",0.02}, name="slabG3"}
slabD = pile{{"lead white",0.42},{"cobalt blue",0.32},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.48},{"yellow ochre",0.05},{"Prussian blue",0.03}, name="slabD"}
restateBroad = function(m, piles, angle, tool, seed)
  work(m, {hand="broad", piles=piles, clip=true, coverage=2, fill=true, angle=angle, tool=tool, seed=seed})
  blend(m:shrink(1), {angle=angle, seed=seed+1})
end
restateBroad(rect(40,640,120,70), {{slabG3,1},{slabD,0}}, -0.24, "filbert 10", 91)
restateBroad(rect(170,640,120,70), {{slabD,1},{slabG3,0}}, -0.24, "filbert 10", 93)

--@ chunk 6
slabD2 = pile{{"lead white",0.45},{"cobalt blue",0.5},{"smalt",0.12},{"green earth",0.5},{"raw umber",0.36},{"Prussian blue",0.04}, name="slabD2"}
restateBroad(rect(300,640,120,70), {{slabD2,1},{slabG3,0}}, -0.24, "filbert 10", 97)

--@ chunk 7
mA = pile{{"lead white",2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.1},{"raw umber",0.08}, name="mA"}
mB = pile{{"lead white",2.5},{"cobalt blue",0.5},{"smalt",0.3},{"Naples yellow",0.2},{"rose madder",0.05}, name="mB"}
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}, name="sC1"}
print(palette())

--@ chunk 8
palette{scrape={slabD2, slabG3, slabD}}
cs0 = pile{{"lead white",1.1},{"cobalt blue",0.7},{"smalt",0.5},{"Naples yellow",0.08},{"rose madder",0.08},{"raw umber",0.12}, name="cs0"}
function plateShapes(cx, cy, w, d, th, rot, tiltUp, seed)
  math.randomseed(seed)
  local ux, uy = math.cos(rot), math.sin(rot)
  local vx, vy = d*0.45, -d*(1 + tiltUp)
  local FL = {cx - ux*w/2, cy - uy*w/2}
  local FR = {cx + ux*w/2, cy + uy*w/2}
  local fm = rand(0.3,0.7)
  local FM = {lerp(FL[1],FR[1],fm), lerp(FL[2],FR[2],fm) + rand(-0.3,0.3)*th}
  local BL = {FL[1] + vx*rand(0.7,1.1), FL[2] + vy*rand(0.7,1.1)}
  local BR = {FR[1] + vx*rand(0.7,1.1), FR[2] + vy*rand(0.6,1.0)}
  local bm = rand(0.25,0.75)
  local BM = {lerp(BL[1],BR[1],bm) + rand(-0.1,0.1)*w, lerp(BL[2],BR[2],bm) + vy*rand(-0.35,0.3)}
  local top = {FL, BL, BM, BR, FR, FM}
  local front = {FL, FM, FR, {FR[1], FR[2]+th}, {FM[1], FM[2]+th*rand(0.8,1.1)}, {FL[1], FL[2]+th*rand(0.7,1.0)}}
  local rightF = {FR, BR, {BR[1], BR[2]+th*0.9}, {FR[1], FR[2]+th}}
  local sl = (d+th)*rand(0.8,1.4)
  local shadow = {{FR[1], FR[2]+th}, {BR[1], BR[2]+th*0.9}, {BR[1]+sl, BR[2]+th*0.9+1}, {FR[1]+sl*0.8, FR[2]+th+1.5}}
  return top, front, rightF, shadow
end
function sunkPlate(cx, cy, w, d, th, rot, tilt, seed, variant)
  local top, front, rightF, shadow = plateShapes(cx, cy, w, d, th, rot, tilt, seed)
  local tm, fm, rm = poly(top), poly(front), poly(rightF)
  fm = fm - tm; rm = rm - tm - fm
  local sm = poly(shadow) - tm - fm - rm
  local tool = {kind="filbert", width=math.max(1.2, math.min(3, w*0.08))}
  if variant == "A" then
    work(sm, {hand="detail", piles={{cs1,1},{pl2,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    work(tm, {hand="detail", piles={{pl2,1},{litWarm,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=rot, seed=seed+1})
    work(fm, {hand="detail", piles={{mB,1},{mA,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=rot, seed=seed+2})
    work(rm, {hand="detail", piles={{sC1,1},{cs1,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.2, seed=seed+3})
  else
    -- B: top drifted over = snow colour; front edge only on the right two-thirds; shadow short, soft
    work(sm, {hand="detail", piles={{cs1,1},{pl2,0.9}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    blend(sm:grow(1), {angle=0, seed=seed+5})
    local fm2 = fm * mask(function(x,y) return clamp((x - (cx - w*0.2))/(w*0.2),0,1) end)
    work(fm2, {hand="detail", piles={{mA,1},{cs1,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=rot, seed=seed+2})
    work(rm, {hand="detail", piles={{sC1,1},{cs0,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.2, seed=seed+3})
  end
end
local list = {{120,420,14,4,1.5,-0.05,0.2},{180,450,24,7,2.2,0.08,0.4},{280,470,34,10,3,-0.06,0.6},{420,500,46,13,3.5,0.05,0.7}}
for i,p in ipairs(list) do sunkPlate(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 100+i*5, "A") end
for i,p in ipairs(list) do sunkPlate(p[1]+460,p[2],p[3],p[4],p[5],p[6],p[7], 200+i*5, "B") end

--@ chunk 9
function drawnPlate(P, seed)
  -- P.top: polygon, listed clockwise starting at the front-left corner; P.nf: number of front vertices (top[1..nf] = front edge, left to right)
  -- P.th: thickness per front vertex; P.nr: number of vertices after nf forming the right edge (going back); P.sl: shadow length
  local top = P.top
  local nf, nr = P.nf, P.nr or 1
  local tm = poly(top)
  local fpts = {}
  for i=1,nf do fpts[#fpts+1] = top[i] end
  for i=nf,1,-1 do fpts[#fpts+1] = {top[i][1], top[i][2] + P.th[i]} end
  local fm = poly(fpts) - tm
  local rpts = {}
  for i=nf, nf+nr do rpts[#rpts+1] = top[i] end
  local thR = P.th[nf]
  for i=nf+nr, nf, -1 do local f = (i-nf)/math.max(1,nr); rpts[#rpts+1] = {top[i][1], top[i][2] + thR*(1-0.25*f)} end
  local rm = poly(rpts) - tm - fm
  -- shadow: cast right along the ground from the right edge's foot points
  local sl = P.sl
  local spts = {}
  for i=nf, nf+nr do local f = (i-nf)/math.max(1,nr); spts[#spts+1] = {top[i][1], top[i][2] + thR*(1-0.25*f)} end
  local last = spts[#spts]; local first = spts[1]
  spts[#spts+1] = {last[1] + sl*0.85, last[2] + 0.6}
  spts[#spts+1] = {first[1] + sl, first[2] + 1.2}
  local sm = poly(spts) - tm - fm - rm
  -- a short shadow under the front edge too (contact)
  local w = 0
  for i=1,#top do w = math.max(w, top[i][1]) end
  local tool = {kind="filbert", width=1.6}
  work(sm, {hand="detail", piles={{cs1,1},{pl2, P.shL or 0.4}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
  work(tm, {hand="detail", piles={{pl2,1},{litWarm,P.lit or 0.7}}, clip=true, coverage=3, fill=true, tool=tool, angle=P.rot or 0, seed=seed+1})
  work(fm, {hand="detail", piles={{mB,1},{mA,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=P.rot or 0, seed=seed+2})
  work(rm, {hand="detail", piles={{sC1,1},{cs1,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=-1.2, seed=seed+3})
  return tm + fm + rm + sm
end
-- trial: three hand-drawn plates
drawnPlate({top={{140,300},{150,301.5},{158,300.5},{170,302},{176,298},{168,294},{160,292.5},{147,293.5},{141,296}}, nf=4, nr=2, th={0.3,1.4,1.8,2.4}, sl=10}, 301)
drawnPlate({top={{220,330},{232,332},{240,331},{256,334},{262,333.5},{266,328},{258,322},{246,320},{236,322},{224,323},{219,327}}, nf=5, nr=2, th={0.2,1.5,2.4,3.0,3.2}, sl=14, rot=0.05}, 311)
drawnPlate({top={{330,372},{344,368},{360,371},{372,370},{392,375},{396,371},{400,363},{386,356},{366,354},{356,357},{340,358},{329,365}}, nf=5, nr=3, th={1.0,2.8,3.6,4.2,4.6}, sl=22, rot=-0.03}, 321)

--@ chunk 10
palette{scrape={mB, litCool}}
sDeep = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.12},{"raw umber",0.4}, name="sDeep"}
aeM = mix{{sDeepG,0.45},{sC1,0.35},{sDeep,0.2}, name="aeM"}
work(rect(600,100,60,60), {hand="detail", pile=sDeepG, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, seed=1})
work(rect(670,100,60,60), {hand="detail", pile=aeM, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, seed=2})
work(rect(740,100,60,60), {hand="detail", pile=sC1, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, seed=3})

--@ chunk 11
palette{scrape={aeM, sDeep, fgT2, fgB2}}
wM = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.2},{"lead white",2},{"cobalt blue",0.4}, name="wM"}
wM2 = pile{{"bone black",0.5},{"Prussian blue",0.2},{"raw umber",0.2},{"lead white",2.4},{"cobalt blue",0.4},{"green earth",0.15}, name="wM2"}
work(rect(100,40,50,30), {hand="detail", pile=wM, clip=true, coverage=3, fill=true, tool={kind="filbert",width=2.5}, seed=1})
work(rect(170,40,50,30), {hand="detail", pile=wM2, clip=true, coverage=3, fill=true, tool={kind="filbert",width=2.5}, seed=2})

--@ chunk 12
palette{scrape={wM2}}
wM3 = pile{{"bone black",0.7},{"Prussian blue",0.25},{"raw umber",0.3},{"lead white",1.5},{"cobalt blue",0.35},{"green earth",0.15}, name="wM3"}
work(rect(240,40,50,30), {hand="detail", pile=wM3, clip=true, coverage=3, fill=true, tool={kind="filbert",width=2.5}, seed=3})

--@ chunk 13
palette{scrape={wM}}
wM4 = pile{{"bone black",0.8},{"Prussian blue",0.25},{"raw umber",0.38},{"lead white",1.3},{"cobalt blue",0.3},{"green earth",0.15}, name="wM4"}
work(rect(310,40,50,30), {hand="detail", pile=wM4, clip=true, coverage=3, fill=true, tool={kind="filbert",width=2.5}, seed=4})

--@ chunk 14
palette{scrape={wM3, wM4}}
litW = pile{{"lead white",6},{"Naples yellow",0.14}, name="litW"}
-- dry substrate pairs: A) shadow/shadow (sC1 | cs1) B) lit/half (litW | mB)
work(rect(520,60,80,140), {hand="detail", pile=sC1, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.4, seed=11})
work(rect(600,60,80,140), {hand="detail", pile=cs1, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.4, seed=12})
work(rect(720,60,80,140), {hand="detail", pile=litW, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.4, seed=13})
work(rect(800,60,80,140), {hand="detail", pile=mB, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.4, seed=14})
print(wait(5*24*60))

--@ chunk 15
-- trial 1 (upper half): lose() dragging the left colour across into the right mask
local n1 = lose(rect(600,60,80,70), {pile=sC1, where=1, reach={6,8}, load=0.25, tool="filbert 4", angle=0})
local n2 = lose(rect(800,60,80,70), {pile=litW, where=1, reach={6,8}, load=0.25, tool="filbert 4", angle=0})
-- trial 2 (lower half): a straddling band painted with both piles graded across, then blended
local function across(x0) return function(x,y) return clamp((x-(x0-7))/14,0,1) end end
local function across2(x0) return function(x,y) return clamp(1-(x-(x0-7))/14,0,1) end end
local b1 = rect(593,135,14,65)
work(b1, {hand="detail", piles={{sC1, across2(600)},{cs1, across(600)}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=2.5}, angle=1.57, seed=21})
blend(b1:grow(2), {angle=0, seed=22})
local b2 = rect(793,135,14,65)
work(b2, {hand="detail", piles={{litW, across2(800)},{mB, across(800)}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=2.5}, angle=1.57, seed=23})
blend(b2:grow(2), {angle=0, seed=24})
print(n1, n2)

--@ chunk 16
print(palette())
for _,p in ipairs{{100,670},{230,670},{360,670}} do print(drying(p[1],p[2])) end

--@ chunk 17
slabCool = pile{{"lead white",0.9},{"cobalt blue",0.5},{"smalt",0.25},{"green earth",0.35},{"raw umber",0.25},{"rose madder",0.03}, name="slabCool"}
slabCool2 = pile{{"lead white",1.2},{"cobalt blue",0.55},{"smalt",0.3},{"green earth",0.25},{"raw umber",0.18},{"rose madder",0.04}, name="slabCool2"}
work(rect(100,655,50,40), {hand="detail", pile=slabCool, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=-0.24, seed=71})
work(rect(230,655,50,40), {hand="detail", pile=slabCool2, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=-0.24, seed=72})

--@ chunk 18
fgB2 = pile{{"lead white",0.65},{"cobalt blue",0.42},{"smalt",0.3},{"raw umber",0.42},{"green earth",0.25},{"Naples yellow",0.14},{"red earth",0.04}, name="fgB2"}
slabDD = pile{{"lead white",0.28},{"cobalt blue",0.25},{"green earth",0.6},{"raw umber",0.6},{"Prussian blue",0.04},{"yellow ochre",0.04}, name="slabDD"}
work(rect(160,600,50,30), {hand="detail", piles={{slabCool,0.55},{fgB2,0.3},{sDeepG,0.15}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=-0.24, seed=81})
work(rect(300,600,50,30), {hand="detail", piles={{slabCool,0.45},{slabDD,0.25},{fgB2,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=-0.24, seed=82})

--@ chunk 19
palette{scrape={slabCool, slabCool2, slabDD, fgB2, wedgeL2, crevD}}
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}, name="litCool"}
local L = poly({{100,300},{160,300},{140,480},{80,480}})
local R = poly({{160,300},{260,300},{240,480},{140,480}})
work(L, {hand="detail", piles={{cs1,1},{sC1,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.45, seed=91})
work(R, {hand="detail", piles={{litW,1},{litCool,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.45, seed=92})
print(wait(6*24*60))

--@ chunk 20
-- softEdge2: the side is chosen by a reference point (refA lies on side A), not by travel direction
function softEdge2(line, half, refA, pilesA, pilesB, seed, opts)
  opts = opts or {}
  local function sd(x, y)
    local best, sgn = 1e9, 1
    for i=1,#line-1 do
      local p, q = line[i], line[i+1]
      local dx, dy = q[1]-p[1], q[2]-p[2]
      local t = clamp(((x-p[1])*dx + (y-p[2])*dy)/(dx*dx+dy*dy), 0, 1)
      local cx, cy = p[1]+t*dx, p[2]+t*dy
      local d = math.sqrt((x-cx)^2 + (y-cy)^2)
      if d < best then best = d; sgn = ((dx*(y-p[2]) - dy*(x-p[1])) > 0) and 1 or -1 end
    end
    return best*sgn
  end
  local flip = (sd(refA[1], refA[2]) > 0) and -1 or 1   -- make side A negative
  local soft = opts.soft or half*0.8
  local function wB(x,y) return smoothstep(-soft, soft, sd(x,y)*flip) end
  local piles = {}
  for _,pw in ipairs(pilesA) do piles[#piles+1] = {pw[1], function(x,y) return (1-wB(x,y))*pw[2] + 0.005 end} end
  for _,pw in ipairs(pilesB) do piles[#piles+1] = {pw[1], function(x,y) return wB(x,y)*pw[2] + 0.005 end} end
  local band = ribbon(line, half*2)
  if opts.clip then band = band * opts.clip end
  local ang = math.atan(line[#line][2]-line[1][2], line[#line][1]-line[1][1])
  work(band, {hand="detail", piles=piles, clip=true, coverage=3, fill=true, tool={kind="filbert", width=opts.tool or 2}, angle=ang, seed=seed})
  blend(band:shrink(0.5), {angle=ang, seed=seed+2})
  return band
end
softEdge2({{160,300},{150,390},{140,480}}, 5, {120,390}, {{cs1,1},{sC1,0.3}}, {{litW,1},{litCool,0.4}}, 101)

--@ chunk 21
local L = poly({{340,300},{400,300},{380,480},{320,480}})
local R = poly({{400,300},{500,300},{480,480},{380,480}})
work(L, {hand="detail", piles={{cs1,1},{sC1,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.45, seed=111})
work(R, {hand="detail", piles={{litW,1},{litCool,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert",width=3}, angle=1.45, seed=112})
print(wait(6*24*60))
function softEdge3(line, half, refA, pilesA, pilesB, seed, opts)
  opts = opts or {}
  local function sd(x, y)
    local best, sgn = 1e9, 1
    for i=1,#line-1 do
      local p, q = line[i], line[i+1]
      local dx, dy = q[1]-p[1], q[2]-p[2]
      local t = clamp(((x-p[1])*dx + (y-p[2])*dy)/(dx*dx+dy*dy), 0, 1)
      local cx, cy = p[1]+t*dx, p[2]+t*dy
      local d = math.sqrt((x-cx)^2 + (y-cy)^2)
      if d < best then best = d; sgn = ((dx*(y-p[2]) - dy*(x-p[1])) > 0) and 1 or -1 end
    end
    return best*sgn
  end
  local flip = (sd(refA[1], refA[2]) > 0) and -1 or 1
  local function wB(x,y) return clamp(0.5 + sd(x,y)*flip/(2*half*0.9), 0, 1) end
  local piles = {}
  for _,pw in ipairs(pilesA) do piles[#piles+1] = {pw[1], function(x,y) return (1-wB(x,y))*pw[2] + 0.001 end} end
  for _,pw in ipairs(pilesB) do piles[#piles+1] = {pw[1], function(x,y) return wB(x,y)*pw[2] + 0.001 end} end
  local band = opts.mask or ribbon(line, half*2)
  if opts.clip then band = band * opts.clip end
  local ang = math.atan(line[#line][2]-line[1][2], line[#line][1]-line[1][1])
  work(band, {hand="detail", piles=piles, clip=true, coverage=3, fill=true, tool={kind="filbert", width=opts.tool or 1.6}, angle=ang, seed=seed})
  return band
end
-- a quad band (no round caps) running the full height
local band = poly({{394,300},{406,300},{386,480},{374,480}})
softEdge3({{400,300},{380,480}}, 6, {360,390}, {{cs1,1},{sC1,0.3}}, {{litW,1},{litCool,0.4}}, 121, {mask=band})

--@ chunk 22
palette{scrape={litCool}}
sigD = pile{{"raw umber",1},{"bone black",0.6},{"Prussian blue",0.04}, medium=0.2, name="sigD"}
function sign(x, y, s)
  local rg = brush{kind="rigger", width=0.9, point=1}
  -- 'C'
  rg:reload(sigD, 0.35)
  rg:gesture({{x+3.2*s,y-4.2*s,0.15},{x+1.2*s,y-4.6*s,0.3},{x,y-2.6*s,0.35},{x+0.6*s,y-0.2*s,0.3},{x+2.8*s,y,0.15}}, {wobble=0.1})
  -- 'L'
  rg:reload(sigD, 0.35)
  rg:gesture({{x+5*s,y-5.2*s,0.15},{x+4.6*s,y-2.4*s,0.32},{x+4.4*s,y-0.1*s,0.35},{x+6.6*s,y+0.1*s,0.25},{x+7.6*s,y-0.4*s,0.1}}, {wobble=0.1})
  -- small dot
  local d = brush{kind="round", width=0.9, point=0.8}
  d:reload(sigD, 0.3)
  d:touch(x+9.2*s, y-0.3*s, {pressure=0.3})
end
sign(160, 700, 1)
sign(200, 700, 1.4)
