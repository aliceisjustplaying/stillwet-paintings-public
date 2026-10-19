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
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}}
cs0 = pile{{"lead white",1.1},{"cobalt blue",0.7},{"smalt",0.5},{"Naples yellow",0.08},{"rose madder",0.08},{"raw umber",0.12}}
cs1 = pile{{"lead white",1.8},{"cobalt blue",0.65},{"smalt",0.45},{"Naples yellow",0.12},{"rose madder",0.06},{"raw umber",0.07}}
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}}
work(rect(0,440,1000,274), {hand="broad", pile=pl2, clip=true, coverage=2, fill=true, angle=0})
work(rect(500,440,500,120), {hand="broad", piles={{cs0,1},{cs1,0.6}}, clip=true, coverage=2, fill=true, angle=0})
work(rect(0,380,1000,80), {hand="broad", pile=sC1, clip=true, coverage=2, fill=true, angle=0})
wait(6*24*60)
litWarm = pile{{"lead white",6},{"Naples yellow",0.26},{"red earth",0.006}}
litW = pile{{"lead white",6},{"Naples yellow",0.14}}
mA = pile{{"lead white",2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.1},{"raw umber",0.08}}
mB = pile{{"lead white",2.5},{"cobalt blue",0.5},{"smalt",0.3},{"Naples yellow",0.2},{"rose madder",0.05}}
shTop2 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.15},{"rose madder",0.05},{"raw umber",0.04}}
shDeep = pile{{"lead white",0.7},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.06},{"raw umber",0.3}}
crevD = pile{{"lead white",0.35},{"cobalt blue",1},{"Prussian blue",0.15},{"raw umber",0.55},{"rose madder",0.05}}
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
function paintPlate(cx, cy, w, d, th, rot, tiltUp, seed, mode, clipM)
  local top, front, rightF, shadow = plateShapes(cx, cy, w, d, th, rot, tiltUp, seed)
  local tm, fm, rm = poly(top), poly(front), poly(rightF)
  fm = fm - tm; rm = rm - tm - fm
  if clipM then tm = tm * clipM; fm = fm * clipM; rm = rm * clipM end
  local tool = {kind="filbert", width=math.max(1.2, math.min(3.5, w*0.1))}
  local P
  if mode == "lit" then
    local sm = poly(shadow) - tm - fm - rm
    if clipM then sm = sm * clipM end
    work(sm, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    P = {top={{litWarm,1},{litW,0.5}}, front={{mA,1},{mB,0.6}}, right={{sC1,1},{cs0,0.4}}}
  elseif mode == "edge" then
    P = {top={{litWarm,1},{litW,0.4}}, front={{cs0,1},{cs1,0.5}}, right={{shDeep,1},{cs0,0.4}}}
  else
    P = {top={{shTop2,1},{cs1,0.4}}, front={{cs0,1},{shDeep,0.4}}, right={{shDeep,1},{crevD,0.3}}}
  end
  work(tm, {hand="detail", piles=P.top, clip=true, coverage=3, fill=true, tool=tool, angle=rot, seed=seed+1})
  work(fm, {hand="detail", piles=P.front, clip=true, coverage=3, fill=true, tool=tool, angle=rot, seed=seed+2})
  work(rm, {hand="detail", piles=P.right, clip=true, coverage=3, fill=true, tool=tool, angle=-1.2, seed=seed+3})
  return tm + fm + rm
end
-- lit side clump against a 'slab bottom' at y=460
local k = 0
local lit = {{60,468,40,10,5,-0.05,1.2},{100,472,28,7,4,0.1,0.6},{40,482,22,5,3,0.15,0.2},{140,476,34,8,5,-0.1,0.4},{90,488,18,5,3,-0.2,0.1},{170,486,14,4,2.5,0.25,0.0},{130,494,10,3,2,0.1,0},{210,490,8,3,2,-0.1,0}}
for _,p in ipairs(lit) do k=k+1; paintPlate(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 100+k*5, "lit") end
local sh = {{560,468,44,10,6,0.05,1.4},{610,472,30,7,4,-0.1,0.6},{540,486,24,5,3,0.15,0.2},{650,478,36,8,5,0.08,0.3},{600,490,20,5,3,-0.2,0.1},{690,488,14,4,2.5,0.25,0.0},{640,500,12,3,2,0.1,0},{720,494,8,3,2,-0.1,0}}
for _,p in ipairs(sh) do k=k+1; paintPlate(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 100+k*5, "shade") end
local ed = {{620,560,24,6,4,0.05,0.2},{680,566,16,5,3,-0.1,0.1}}
for _,p in ipairs(ed) do k=k+1; paintPlate(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 100+k*5, "edge") end

--@ chunk 3
t1 = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}}
t2 = pile{{"lead white",4.0},{"cobalt blue",1},{"Prussian blue",0.03},{"Naples yellow",0.08}}
t3 = pile{{"lead white",4.6},{"cobalt blue",1},{"Prussian blue",0.03},{"Naples yellow",0.12}}
work(rect(800,20,50,60), {hand="body", pile=t1, clip=true, coverage=2, fill=true})
work(rect(860,20,50,60), {hand="body", pile=t2, clip=true, coverage=2, fill=true})
work(rect(920,20,50,60), {hand="body", pile=t3, clip=true, coverage=2, fill=true})
