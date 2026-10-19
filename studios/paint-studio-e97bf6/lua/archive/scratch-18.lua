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
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}}
cs0 = pile{{"lead white",1.1},{"cobalt blue",0.7},{"smalt",0.5},{"Naples yellow",0.08},{"rose madder",0.08},{"raw umber",0.12}}
work(rect(0,440,500,274), {hand="broad", pile=pl2, clip=true, coverage=2, fill=true, angle=0})
work(rect(500,440,500,274), {hand="broad", pile=cs0, clip=true, coverage=2, fill=true, angle=0})
wait(6*24*60)
litWarm = pile{{"lead white",6},{"Naples yellow",0.26},{"red earth",0.006}}
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}}
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}}
ctD = pile{{"lead white",0.9},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.06},{"raw umber",0.25}}
mB = pile{{"lead white",2.5},{"cobalt blue",0.5},{"smalt",0.3},{"Naples yellow",0.2},{"rose madder",0.05}}
shTop = pile{{"lead white",2.2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.18},{"rose madder",0.06},{"raw umber",0.05}}
shDeep = pile{{"lead white",0.7},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.06},{"raw umber",0.3}}
function blockShapes(x, y, w, h, lean, seed)
  math.randomseed(seed)
  local j = function(a) return rand(-a, a) end
  local fx = x - w/2; local rx = x + w*rand(0.05,0.3)
  local topL = {fx + lean*0.5 + j(w*0.1), y - h*rand(0.55,0.95)}
  local topR = {rx + lean + j(w*0.08), y - h}
  local side = w*rand(0.18,0.32)
  local front = {{fx, y}, topL, topR, {rx, y + h*0.03}}
  local right = {{rx, y + h*0.03}, topR, {topR[1] + side*0.9, topR[2] + h*rand(0.05,0.2)}, {rx + side, y - h*0.02}}
  local td = h*rand(0.08,0.18)
  local top = {topL, {topL[1] + side*0.6, topL[2] - td}, {topR[1] + side*0.9, topR[2] - td*0.6 + h*0.08}, topR}
  local shadow = {{rx + side, y - h*0.02}, {rx + side + h*rand(0.6,1.2), y - h*0.12}, {rx + side + h*rand(0.4,0.9), y + h*0.06}, {rx, y + h*0.06}}
  return front, right, top, shadow
end
function paintBlock(x, y, w, h, lean, seed, inShadow)
  local front, right, top, shadow = blockShapes(x, y, w, h, lean, seed)
  local tool = {kind="filbert", width=math.max(1.2, math.min(4, w*0.15))}
  if not inShadow then
    work(poly(shadow), {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool=tool, seed=seed})
    work(poly(front), {hand="detail", pile=litCool, clip=true, coverage=3, fill=true, tool=tool, angle=-1.4, seed=seed+1})
    work(poly(right), {hand="detail", pile=sC1, clip=true, coverage=3, fill=true, tool=tool, angle=-1.4, seed=seed+2})
    work(poly(top), {hand="detail", pile=litWarm, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+3})
  else
    work(poly(front), {hand="detail", pile=mB, clip=true, coverage=3, fill=true, tool=tool, angle=-1.4, seed=seed+1})
    work(poly(right), {hand="detail", pile=shDeep, clip=true, coverage=3, fill=true, tool=tool, angle=-1.4, seed=seed+2})
    work(poly(top), {hand="detail", pile=shTop, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+3})
  end
end
local k = 0
for _,b in ipairs({{80,520,40,30},{150,540,25,18},{200,530,14,10},{260,560,60,45},{350,600,30,22},{420,560,12,9}}) do k=k+1; paintBlock(b[1],b[2],b[3],b[4], rand(-3,6), 100+k*10, false) end
for _,b in ipairs({{580,520,40,30},{650,540,25,18},{700,530,14,10},{760,560,60,45},{850,600,30,22}}) do k=k+1; paintBlock(b[1],b[2],b[3],b[4], rand(-3,6), 100+k*10, true) end

--@ chunk 3
litW = pile{{"lead white",6},{"Naples yellow",0.14}}
function shardShapes(x, y, size, seed)
  math.randomseed(seed)
  local standing = rand(0,1) < 0.6
  local ang
  if standing then ang = -math.pi/2 + rand(-0.7, 0.7) else ang = (rand(0,1)<0.5 and 0 or math.pi) + rand(-0.35,0.35) end
  local L = size*(standing and rand(1.0,1.9) or rand(1.4,2.4))
  local Wd = size*(standing and rand(0.6,1.0) or rand(0.35,0.6))
  local ux, uy = math.cos(ang), math.sin(ang)
  local nx, ny = -uy, ux
  local function P(a,b) return {x + a*ux + b*nx, y + a*uy + b*ny} end
  local pts
  if standing then
    pts = {P(0,-Wd/2), P(L*rand(0.45,0.7), -Wd*rand(0.4,0.6)), P(L, rand(-0.2,0.2)*Wd), P(L*rand(0.5,0.8), Wd*rand(0.4,0.55)), P(0, Wd/2)}
  else
    local c = {x - ux*L/2, y - Wd*0.3}
    local function Q(a,b) return {c[1] + a*ux + b*nx, c[2] + a*uy + b*ny} end
    pts = {Q(0,0), Q(L*rand(0.2,0.4), -Wd*rand(0.5,0.8)), Q(L*rand(0.7,0.9), -Wd*rand(0.4,0.7)), Q(L, rand(-0.1,0.2)*Wd), Q(L*0.6, Wd*0.15)}
  end
  for _,p in ipairs(pts) do if p[2] > y then p[2] = y end end
  local th = size*rand(0.12,0.22)
  local tvec = {th, -th*rand(0.0,0.4)}
  local sh = {} for i,p in ipairs(pts) do sh[i] = {p[1]+tvec[1], p[2]+tvec[2]} end
  for _,p in ipairs(sh) do if p[2] > y then p[2] = y end end
  local lit = (standing and ux < -0.05) or (not standing and rand(0,1) < 0.7)
  local xmax = -1e9 for _,p in ipairs(sh) do xmax = math.max(xmax, p[1]) end
  local hgt = 0 for _,p in ipairs(pts) do hgt = math.max(hgt, y - p[2]) end
  local shadow = {{xmax - size*0.3, y + 0.5}, {xmax + hgt*rand(0.5,1.0), y - math.min(hgt*0.15, 4)}, {xmax + hgt*rand(0.3,0.6), y + size*0.08}, {x - size*0.4, y + size*0.1}}
  return pts, sh, shadow, lit
end
function paintShard(x, y, size, seed, inShadow)
  local face, sh, shadow, lit = shardShapes(x, y, size, seed)
  local fm = poly(face); local sm = poly(sh) - fm
  local tool = {kind="filbert", width=math.max(1.2, math.min(4, size*0.12))}
  if not inShadow then
    work(poly(shadow) - fm - sm, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    work(fm, {hand="detail", piles=(lit and {{litWarm,1},{litW,0.6}} or {{litCool,1},{mB,0.8}}), clip=true, coverage=3, fill=true, tool=tool, seed=seed+1})
    work(sm, {hand="detail", pile=sC1, clip=true, coverage=3, fill=true, tool=tool, seed=seed+2})
  else
    work(fm, {hand="detail", piles=(lit and {{shTop,1},{mB,0.4}} or {{cs0,1},{shTop,0.5}}), clip=true, coverage=3, fill=true, tool=tool, seed=seed+1})
    work(sm, {hand="detail", pile=shDeep, clip=true, coverage=3, fill=true, tool=tool, seed=seed+2})
  end
end
local k = 0
for _,b in ipairs({{60,680,30},{120,690,18},{160,672,10},{230,700,40},{300,676,14},{340,690,22},{400,700,8},{440,682,26}}) do k=k+1; paintShard(b[1],b[2],b[3], 300+k*10, false) end
for _,b in ipairs({{560,680,30},{620,690,18},{660,672,10},{730,700,40},{800,676,14},{840,690,22},{900,700,8},{940,682,26}}) do k=k+1; paintShard(b[1],b[2],b[3], 300+k*10, true) end
