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
skyp = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}}
litW = pile{{"lead white",6},{"Naples yellow",0.14}}
litWarm = pile{{"lead white",6},{"Naples yellow",0.26},{"red earth",0.006}}
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}}
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}}
sC2 = pile{{"lead white",1.6},{"cobalt blue",0.8},{"smalt",0.5},{"Naples yellow",0.15},{"rose madder",0.08},{"raw umber",0.1}}
sDeep = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.12},{"raw umber",0.4}}
work(rect(0,0,1000,440), {hand="body", pile=skyp, clip=true, coverage=2, fill=true, angle=0})
A = {{150,420},{200,140},{250,40},{268,52},{300,420}}
Ae = {{268,52},{285,66},{320,180},{345,425},{300,420}}
C = {{320,180},{370,120},{560,420},{345,425}}
work(poly(A), {hand="broad", pile=litWarm, clip=true, coverage=2, fill=true, angle=-1.3, tool="filbert 8"})
work(poly(Ae), {hand="body", pile=sDeep, clip=true, coverage=2, fill=true, angle=1.4, tool="filbert 4"})
work(poly(C) - poly(Ae), {hand="broad", piles={{sC1,1},{sC2,1}}, clip=true, coverage=2, fill=true, angle=1.0, tool="filbert 8"})
wait(6*24*60)
print(drying(220,300))

--@ chunk 3
function L2(a,b,t) return {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t} end
-- teeth along edge a->b, pushed toward side s (+1 = left of direction a->b in screen coords: normal (dy,-dx))
function teeth(a, b, s, p, seed, opts)
  opts = opts or {}
  local n = opts.n or 6
  local dmax = opts.depth or 3.5
  local wmax = opts.width or 9
  local dx, dy = b[1]-a[1], b[2]-a[2]; local L = math.sqrt(dx*dx+dy*dy)
  local ux, uy = dx/L, dy/L
  local nx, ny = uy*s, -ux*s
  local ts = uneven(n, 0.05, 0.95, 0.7, 0.5, seed)
  local m
  for i,t in ipairs(ts) do
    local w = rand(wmax*0.35, wmax)
    local d = rand(dmax*0.3, dmax)
    local c = L2(a,b,t)
    local p1 = {c[1] - ux*w/2 - nx*0.8, c[2] - uy*w/2 - ny*0.8}
    local p2 = {c[1] + ux*w/2 - nx*0.8, c[2] + uy*w/2 - ny*0.8}
    local off = rand(-0.35,0.35)*w
    local p3 = {c[1] + ux*off + nx*d, c[2] + uy*off + ny*d}
    local tri
    if rand(0,1) < 0.5 then
      tri = poly({p1, p3, p2})
    else
      local p4 = {c[1] + ux*(off + w*0.3) + nx*d*0.6, c[2] + uy*(off + w*0.3) + ny*d*0.6}
      tri = poly({p1, p3, p4, p2})
    end
    m = m and (m + tri) or tri
  end
  if opts.avoid then m = m - opts.avoid end
  work(m, {hand="detail", pile=p, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.5}, seed=seed})
  return m
end
rg = brush{kind="rigger", width=1.0, point=1}
function fracture(pts, dk, lt, s, seed, opts)
  opts = opts or {}
  rg:reload(dk, opts.load or 0.4)
  local pr = opts.pr or 0.28
  rg:stroke(pts, {pressure={pr, pr*0.4}, shake=0.3, clip=opts.clip})
  if lt then
    local q = {}
    for i,p in ipairs(pts) do
      local a = pts[math.max(1,i-1)]; local b = pts[math.min(#pts,i+1)]
      local dx, dy = b[1]-a[1], b[2]-a[2]; local L = math.sqrt(dx*dx+dy*dy)
      q[i] = {p[1] + dy/L*s*1.3, p[2] - dx/L*s*1.3}
    end
    rg:reload(lt, (opts.load or 0.4)*0.9)
    rg:stroke(q, {pressure={pr*0.9, pr*0.3}, shake=0.3, clip=opts.clip})
  end
end
-- teeth on A's left silhouette (a=(150,420) -> (200,140) -> (250,40)); outward = left of upward direction = s=+1? direction up: (50,-280); normal (dy,-dx)*s = (-280,-50)*s -> s=+1 points left. good
teeth({150,420},{200,140}, 1, litWarm, 11, {n=7})
teeth({200,140},{250,40}, 1, litWarm, 12, {n=4})
-- teeth on C's top edge (370,120)->(560,420): outward is up-right; direction (190,300); normal (300,-190)*s -> s=+1 points right-up. good
teeth({370,120},{560,420}, 1, sC1, 13, {n=8, depth=3})
-- fractures on A
crk = pile{{"lead white",2},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.1}}
fracture({{168,300},{186,292},{203,296},{222,285},{240,290}}, crk, litW, -1, 21, {clip=poly(A)})
fracture({{205,180},{212,205},{209,226},{218,260}}, crk, litW, 1, 22, {clip=poly(A)})
-- faint strata on A (litCool, parallel to long axis)
for k=1,6 do
  local t = k/7 + rand(-0.04,0.04)
  local a = L2({150,420},{300,420},t); local b = L2({200,140},{268,52},t)
  local s0, s1 = rand(0,0.3), rand(0.6,1)
  rg:reload(litCool, 0.35)
  rg:stroke({L2(a,b,s0), L2(a,b,s1)}, {pressure={0.18,0.08}, shake=0.3, clip=poly(A)})
end

--@ chunk 4
function fracture2(pts, dk, lt, s, opts)
  opts = opts or {}
  local pr = opts.pr or 0.3
  for i=1,#pts-1 do
    local a, b = pts[i], pts[i+1]
    rg:reload(dk, opts.load or 0.45)
    local p0 = (i==1) and pr*0.5 or pr
    local p1 = (i==#pts-1) and pr*0.3 or pr
    rg:stroke({a, b}, {pressure={p0, p1}, shake=0.15, clip=opts.clip})
    if lt then
      local dx, dy = b[1]-a[1], b[2]-a[2]; local L = math.sqrt(dx*dx+dy*dy)
      local ox, oy = dy/L*s*1.4, -dx/L*s*1.4
      rg:reload(lt, (opts.load or 0.45)*0.9)
      rg:stroke({{a[1]+ox,a[2]+oy},{b[1]+ox,b[2]+oy}}, {pressure={p0*0.9, p1*0.9}, shake=0.15, clip=opts.clip})
    end
  end
end
local ox = 450
local function S(pts) local q={} for i,p in ipairs(pts) do q[i]={p[1]+ox,p[2]} end return q end
crk2 = pile{{"lead white",1.4},{"cobalt blue",0.7},{"smalt",0.45},{"raw umber",0.12}}
work(poly(S(A)), {hand="broad", pile=litWarm, clip=true, coverage=2, fill=true, angle=-1.3, tool="filbert 8"})
work(poly(S(Ae)), {hand="body", pile=sDeep, clip=true, coverage=2, fill=true, angle=1.4, tool="filbert 4"})
work(poly(S(C)) - poly(S(Ae)), {hand="broad", piles={{sC1,1},{sC2,1}}, clip=true, coverage=2, fill=true, angle=1.0, tool="filbert 8"})
wait(6*24*60)
fracture2(S({{166,300},{186,291},{203,297},{226,284},{246,289}}), crk2, nil, -1, {clip=poly(S(A))})
fracture2(S({{206,170},{213,206},{209,228},{219,262}}), crk2, nil, 1, {clip=poly(S(A))})
fracture2(S({{240,90},{246,118},{243,140}}), crk2, nil, 1, {clip=poly(S(A)), pr=0.22})
-- on shadow face: light fractures (catching skylight)
crkL = pile{{"lead white",3},{"cobalt blue",0.5},{"smalt",0.3}}
fracture2(S({{380,150},{372,200},{385,260},{378,320}}), sDeep, crkL, -1, {clip=poly(S(C))-poly(S(Ae))})
fracture2(S({{400,330},{440,312},{470,320},{505,300}}), sDeep, crkL, 1, {clip=poly(S(C))-poly(S(Ae))})
-- snow rim on C top edge: thin, lit (top surface catching sun)
snowW = pile{{"lead white",6},{"Naples yellow",0.2}}
local fb = brush{kind="filbert", width=2.6}
fb:reload(snowW, 0.6)
fb:stroke(S({{372,124},{430,215},{470,278}}), {pressure={0.6,0.4}, shake=0.6})
fb:reload(snowW, 0.6)
fb:stroke(S({{488,306},{525,364},{552,408}}), {pressure={0.5,0.2}, shake=0.6})
-- turquoise translucency at top of thickness edge
turq = pile{{"Prussian blue",0.25},{"cobalt blue",0.6},{"green earth",0.6}, medium=0.75}
work(poly(S(Ae)) * rect(0,0,1000,200), {hand="glaze", pile=turq, coverage=1, clip=true, angle=1.4})
