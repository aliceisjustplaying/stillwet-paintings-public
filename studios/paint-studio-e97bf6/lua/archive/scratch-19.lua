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
mB = pile{{"lead white",2.5},{"cobalt blue",0.5},{"smalt",0.3},{"Naples yellow",0.2},{"rose madder",0.05}}
mA = pile{{"lead white",2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.1},{"raw umber",0.08}}
shTop = pile{{"lead white",2.2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.18},{"rose madder",0.06},{"raw umber",0.05}}
shDeep = pile{{"lead white",0.7},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.06},{"raw umber",0.3}}
function blockShapes(x, y, w, h, seed)
  math.randomseed(seed)
  local tilt = rand(-0.35, 0.35)  -- slope of the top edge
  local fx = x - w/2; local rx = x + w/2
  local yl = y - h*rand(0.6,1.0); local yr = y - h*rand(0.6,1.0)
  local lean = rand(-0.15,0.25)*h
  local tl = {fx + lean*0.6, yl}
  local tr = {rx + lean, yr}
  local tm = {lerp(tl[1],tr[1],rand(0.3,0.7)), lerp(tl[2],tr[2],0.5) - h*rand(-0.15,0.3)}
  local front = {{fx, y}, tl, tm, tr, {rx, y}}
  local dep = w*rand(0.25,0.55)
  local d = {dep*0.75, -dep*0.35}
  local top = {tl, {tl[1]+d[1], tl[2]+d[2]}, {tm[1]+d[1], tm[2]+d[2]}, {tr[1]+d[1], tr[2]+d[2]}, tr, tm}
  local right = {{rx, y}, tr, {tr[1]+d[1], tr[2]+d[2]}, {rx + d[1], y - math.min(-d[2], h*0.3)}}
  local hh = y - math.min(tl[2], tr[2], tm[2])
  local shadow = {{rx, y+0.5}, {rx + d[1], y - math.min(-d[2], h*0.3)}, {rx + d[1] + hh*rand(0.7,1.3), y - h*0.05}, {rx + hh*rand(0.5,0.9), y + h*0.12}, {x, y + h*0.08}}
  return front, top, right, shadow
end
function paintBlock(x, y, w, h, seed, inShadow)
  local front, top, right, shadow = blockShapes(x, y, w, h, seed)
  local fm, tm, rm = poly(front), poly(top), poly(right)
  tm = tm - fm; rm = rm - fm - tm
  local tool = {kind="filbert", width=math.max(1.2, math.min(4, w*0.12))}
  if not inShadow then
    work(poly(shadow) - fm - tm - rm, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    work(fm, {hand="detail", piles={{mB,1},{litCool,0.7}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+1})
    work(tm, {hand="detail", pile=litWarm, clip=true, coverage=3, fill=true, tool=tool, angle=-0.3, seed=seed+2})
    work(rm, {hand="detail", pile=sC1, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+3})
  else
    work(fm, {hand="detail", piles={{cs0,1},{shTop,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+1})
    work(tm, {hand="detail", pile=shTop, clip=true, coverage=3, fill=true, tool=tool, angle=-0.3, seed=seed+2})
    work(rm, {hand="detail", pile=shDeep, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+3})
  end
end
local k=0
for _,b in ipairs({{60,560,30,22},{110,570,18,10},{150,552,10,8},{230,590,50,30},{300,566,14,12},{350,580,22,18},{420,590,8,6},{450,572,26,20}}) do k=k+1; paintBlock(b[1],b[2],b[3],b[4], 500+k*10, false) end
for _,b in ipairs({{560,560,30,22},{610,570,18,10},{650,552,10,8},{730,590,50,30},{800,566,14,12},{850,580,22,18},{920,590,8,6},{950,572,26,20}}) do k=k+1; paintBlock(b[1],b[2],b[3],b[4], 500+k*10, true) end

--@ chunk 3
function blockShapes(x, y, w, h, seed)
  math.randomseed(seed)
  local t = rand(-0.3, 0.3)
  local ux, uy = math.cos(t), math.sin(t)
  local vx, vy = math.sin(t), -math.cos(t)
  local function P(a,b) return {x + a*ux + b*vx, y + a*uy + b*vy} end
  local hl, hr = h*rand(0.55,1.0), h*rand(0.55,1.0)
  local lean = rand(-0.1,0.2)*h
  local bl, br = P(-w/2, 0), P(w/2, 0)
  local tl = P(-w/2 + lean*0.5, hl)
  local tr = P(w/2 + lean, hr)
  local f1, f2 = rand(0.2,0.45), rand(0.55,0.85)
  local j1 = P(lerp(-w/2, w/2, f1) + lean*0.7, lerp(hl, hr, f1) + h*rand(-0.18,0.08))
  local j2 = P(lerp(-w/2, w/2, f2) + lean*0.8, lerp(hl, hr, f2) + h*rand(-0.12,0.1))
  local front = {bl, tl, j1, j2, tr, br}
  local dep = w*rand(0.2,0.5)
  local d = {dep*0.8, -dep*0.3}
  local function D(p) return {p[1]+d[1], p[2]+d[2]} end
  local top = {tl, D(tl), D(j1), D(j2), D(tr), tr, j2, j1}
  local right = {br, tr, D(tr), D(br)}
  for _,list in ipairs({front, top, right}) do for _,p in ipairs(list) do if p[2] > y + 1 then p[2] = y + 1 end end end
  local hh = h
  local rxp = math.max(br[1], tr[1]) + d[1]
  local shadow = {{br[1]-w*0.2, y+1}, {rxp, y - math.min(dep*0.3, h*0.3)}, {rxp + hh*rand(0.7,1.3), y - h*0.06}, {br[1] + hh*rand(0.5,0.9), y + h*0.12}, {x, y + h*0.1}}
  return front, top, right, shadow
end
function paintBlock(x, y, w, h, seed, inShadow)
  local front, top, right, shadow = blockShapes(x, y, w, h, seed)
  local fm, tm, rm = poly(front), poly(top), poly(right)
  tm = tm - fm; rm = rm - fm - tm
  local tool = {kind="filbert", width=math.max(1.2, math.min(4, w*0.12))}
  if not inShadow then
    work(poly(shadow) - fm - tm - rm, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    work(fm, {hand="detail", piles={{mB,1},{mA,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+1})
    work(tm, {hand="detail", pile=litWarm, clip=true, coverage=3, fill=true, tool=tool, angle=-0.3, seed=seed+2})
    work(rm, {hand="detail", pile=sC1, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+3})
  else
    work(fm, {hand="detail", piles={{cs0,1},{shTop,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+1})
    work(tm, {hand="detail", pile=shTop, clip=true, coverage=3, fill=true, tool=tool, angle=-0.3, seed=seed+2})
    work(rm, {hand="detail", pile=shDeep, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+3})
  end
end
local k=0
for _,b in ipairs({{60,660,30,22},{110,670,18,10},{150,652,10,8},{230,690,50,30},{300,666,14,12},{350,680,22,18},{420,690,8,6},{450,672,26,20}}) do k=k+1; paintBlock(b[1],b[2],b[3],b[4], 700+k*10, false) end
for _,b in ipairs({{560,660,30,22},{610,670,18,10},{650,652,10,8},{730,690,50,30},{800,666,14,12},{850,680,22,18},{920,690,8,6},{950,672,26,20}}) do k=k+1; paintBlock(b[1],b[2],b[3],b[4], 700+k*10, true) end
