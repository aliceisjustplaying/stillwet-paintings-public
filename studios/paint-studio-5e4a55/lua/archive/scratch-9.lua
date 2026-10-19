-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
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
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
goldleaf = pile{{"chrome yellow",2},{"yellow ochre",1.5},{"red earth",0.3}, name="goldleaf"}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
brushdark = pile{{"raw umber",2},{"red earth",1.5},{"Prussian blue",0.3},{"yellow ochre",0.4}, name="brushdark"}
SGX, SGY = 600, 500
local function dist(x, y) return math.sqrt((x-SGX)^2 + ((y-SGY)/1.15)^2) end
work(rect(0,0,1000,700), {hand="broad", coverage=3, fill=true, angle=1.5, piles={{glow, function(x,y) return math.max(0, 1 - dist(x,y)/220)^1.3*1.8 end},{haze, function(x,y) return math.exp(-((dist(x,y)-190)/120)^2) end},{amber, function(x,y) return math.exp(-((dist(x,y)-330)/120)^2) end},{deeprust, function(x,y) return math.max(0,(dist(x,y)-400)/200) end}}})
function clump(c, seed, gxx, gyy)
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  local n = 11
  math.randomseed(seed)
  for i = 0, n - 1 do
    local a = i / n * 2 * math.pi + rand(-0.15, 0.15)
    local k = rand(0.8, 1.15)
    pts[#pts+1] = {cx + rx * k * math.cos(a), cy + ry * k * math.sin(a)}
  end
  local m = outline{pts=pts, char="soft", seed=seed, amount=0.9, lobe=math.min(rx, ry) * 0.35}:mask()
  local dx, dy = gxx - cx, gyy - cy
  local dl = math.sqrt(dx*dx + dy*dy)
  dx, dy = dx/dl, dy/dl
  local litk = clamp(1 - (dl - 200) / 400, 0.15, 1)
  local function P(x, y) local px, py = (x - cx)/rx, (y - cy)/ry; return px*dx + py*dy, py, math.sqrt(px*px + py*py) end
  work(m, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=2.5, fill=true, edge="loose", load=0.9,
    angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
    scale_at=function(x,y) return 0.8 + 0.6*(1 - litk) end,
    piles={{goldleaf, function(x,y) local u,v,r = P(x,y); return clamp((u - 0.35)*3, 0, 1) * clamp((r - 0.45)*3, 0, 1) * litk * 1.5 end},
           {orangeleaf, function(x,y) local u,v,r = P(x,y); return math.exp(-((u - 0.25)/0.3)^2) * (0.4 + 0.6*litk) end},
           {leafrust, function(x,y) local u,v,r = P(x,y); return math.exp(-(r/0.6)^2) * 0.7 end},
           {deeprust, function(x,y) return 0.5 end},
           {brushdark, function(x,y) local u,v,r = P(x,y); return clamp(-u*1.5, 0, 1) + clamp((v - 0.2)*1.5, 0, 1) + (1 - litk)*0.6 end}}})
  return m
end
clump({420, 300, 110, 75}, 1, SGX, SGY)
clump({300, 200, 130, 90}, 2, SGX, SGY)
clump({200, 380, 120, 80}, 3, SGX, SGY)

--@ chunk 3
leafshade = pile{{"red earth",2},{"raw umber",2.5},{"vermilion",0.2}, name="leafshade"}
function clump2(c, seed, gxx, gyy, o)
  o = o or {}
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  local n = 11
  math.randomseed(seed)
  for i = 0, n - 1 do
    local a = i / n * 2 * math.pi + rand(-0.15, 0.15)
    local k = rand(0.8, 1.15)
    pts[#pts+1] = {cx + rx * k * math.cos(a), cy + ry * k * math.sin(a)}
  end
  local m = outline{pts=pts, char="soft", seed=seed, amount=0.9, lobe=math.min(rx, ry) * 0.35}:mask()
  if o.minus then m = m - o.minus end
  local dx, dy = gxx - cx, gyy - cy
  local dl = math.sqrt(dx*dx + dy*dy)
  dx, dy = dx/dl, dy/dl
  local litk = clamp(1 - (dl - 200) / 450, 0.1, 1) * (o.lit or 1)
  local function P(x, y) local px, py = (x - cx)/rx, (y - cy)/ry; return px*dx + py*dy, py, math.sqrt(px*px + py*py) end
  work(m, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=2.5, fill=true, edge="loose", load=0.9,
    angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
    scale_at=function(x,y) return 0.8 + 0.6*(1 - litk) end,
    piles={{goldleaf, function(x,y) local u,v,r = P(x,y); return clamp((u - 0.4)*3, 0, 1) * clamp((r - 0.5)*3, 0, 1) * litk * 1.2 end},
           {orangeleaf, function(x,y) local u,v,r = P(x,y); return math.exp(-((u - 0.3)/0.3)^2) * (0.3 + 0.7*litk) end},
           {leafrust, function(x,y) local u,v,r = P(x,y); return math.exp(-((u + 0.1)/0.4)^2) * 0.8 end},
           {deeprust, function(x,y) return 0.45 end},
           {leafshade, function(x,y) local u,v,r = P(x,y); return clamp(-u*1.5, 0, 1) + clamp((v - 0.2)*1.5, 0, 1) + (1 - litk)*0.7 end}}})
  -- silhouette leaves: small dabs scattered across the clump edge
  local rim = (m:grow(10) - m:shrink(12))
  local nh = noise{seed=seed + 7, period=12, octaves=2}
  local sm = rim * mask(function(x,y) return clamp((nh:at01(x,y) - 0.5)*4, 0, 1) end)
  work(sm, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={4,8}, coverage=0.9, load=0.8,
    angle=function(x,y) return 1.57 + rand(-1, 1) end,
    piles={{orangeleaf, function(x,y) local u = P(x,y); return clamp(u + 0.3, 0, 1) * litk end},
           {leafrust, 0.5}, {leafshade, function(x,y) local u = P(x,y); return clamp(-u, 0, 1) + (1-litk)*0.5 end}}})
  -- a few holes inside
  local hn = noise{seed=seed + 9, period=11, octaves=2}
  local holes = m:shrink(14) * mask(function(x,y) return clamp((hn:at01(x,y) - 0.76)*8, 0, 1) end)
  work(holes, {hand="detail", tool={kind="round", width=4}, length={3,6}, coverage=2, fill=true, load=0.8,
    angle=function(x,y) return rand(0,3.14) end, piles={{o.holepile or amber, 1}, {haze, litk}}})
  return m
end
work(rect(0,560,1000,690), {hand="broad", coverage=3, fill=true, angle=1.5, piles={{amber, 1},{haze, function(x,y) return x/1000 end},{deeprust, function(x,y) return 1 - x/1000 end}}})
clump2({520, 800, 110, 75}, 11, 900, 1100)
clump2({380, 720, 130, 90}, 12, 900, 1100)
clump2({300, 900, 120, 80}, 13, 900, 1100)
clump2({160, 760, 120, 90}, 14, 900, 1100)

--@ chunk 4
local function dist(x, y) return math.sqrt((x-SGX)^2 + ((y-SGY)/1.15)^2) end
work(rect(0,0,1000,560), {hand="broad", coverage=3, fill=true, angle=1.5, piles={{glow, function(x,y) return math.max(0, 1 - dist(x,y)/220)^1.3*1.8 end},{haze, function(x,y) return math.exp(-((dist(x,y)-190)/120)^2) end},{amber, function(x,y) return math.exp(-((dist(x,y)-330)/120)^2) end},{deeprust, function(x,y) return math.max(0,(dist(x,y)-400)/200) end}}})
function clump3(c, seed, gxx, gyy, o)
  o = o or {}
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  local n = 11
  math.randomseed(seed)
  for i = 0, n - 1 do
    local a = i / n * 2 * math.pi + rand(-0.15, 0.15)
    local k = rand(0.8, 1.15)
    pts[#pts+1] = {cx + rx * k * math.cos(a), cy + ry * k * math.sin(a)}
  end
  local m = outline{pts=pts, char="soft", seed=seed, amount=0.9, lobe=math.min(rx, ry) * 0.35}:mask()
  if o.minus then m = m - o.minus end
  local dx, dy = gxx - cx, gyy - cy
  local dl = math.sqrt(dx*dx + dy*dy)
  dx, dy = dx/dl, dy/dl
  local litk = o.lit or clamp(1 - (dl - 200) / 450, 0.1, 1)
  local function P(x, y) local px, py = (x - cx)/rx, (y - cy)/ry; return px*dx + py*dy, py, math.sqrt(px*px + py*py) end
  work(m, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=2.5, fill=true, edge="loose", load=0.9,
    angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
    scale_at=function(x,y) return 0.8 + 0.6*(1 - litk) end,
    piles={{goldleaf, function(x,y) local u,v,r = P(x,y); return clamp((u - 0.35)*3, 0, 1) * clamp((r - 0.45)*3, 0, 1) * litk * 1.5 end},
           {orangeleaf, function(x,y) local u,v,r = P(x,y); return math.exp(-((u - 0.25)/0.3)^2) * (0.4 + 0.6*litk) end},
           {leafrust, function(x,y) local u,v,r = P(x,y); return math.exp(-(r/0.6)^2) * 0.7 end},
           {deeprust, function(x,y) return 0.5 end},
           {leafshade, function(x,y) local u,v,r = P(x,y); return clamp(-u*1.5, 0, 1) + clamp((v - 0.2)*1.5, 0, 1) + (1 - litk)*0.6 end}}})
  local rim = (m:grow(8) - m:shrink(8))
  local nh = noise{seed=seed + 7, period=14, octaves=2}
  local sm = rim * mask(function(x,y) return clamp((nh:at01(x,y) - 0.6)*4, 0, 1) end)
  work(sm, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={4,8}, coverage=0.6, load=0.8,
    angle=function(x,y) return 1.57 + rand(-1, 1) end,
    piles={{orangeleaf, function(x,y) local u = P(x,y); return clamp(u + 0.3, 0, 1) * litk end},
           {goldleaf, function(x,y) local u = P(x,y); return clamp(u - 0.3, 0, 1) * litk end},
           {leafshade, function(x,y) local u = P(x,y); return clamp(-u, 0, 1) + (1-litk)*0.4 end}}})
  return m
end
clump3({420, 300, 110, 75}, 1, SGX, SGY)
clump3({300, 200, 130, 90}, 2, SGX, SGY)
clump3({200, 380, 120, 80}, 3, SGX, SGY)
clump3({120, 160, 140, 100}, 4, SGX, SGY)

--@ chunk 5
function clump4(c, seed, gxx, gyy, o)
  o = o or {}
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  local n = 11
  math.randomseed(seed)
  for i = 0, n - 1 do
    local a = i / n * 2 * math.pi + rand(-0.15, 0.15)
    local k = rand(0.8, 1.15)
    pts[#pts+1] = {cx + rx * k * math.cos(a), cy + ry * k * math.sin(a)}
  end
  local m = outline{pts=pts, char="soft", seed=seed, amount=0.9, lobe=math.min(rx, ry) * 0.35}:mask()
  if o.minus then m = m - o.minus end
  local dx, dy = gxx - cx, gyy - cy
  local dl = math.sqrt(dx*dx + dy*dy)
  dx, dy = dx/dl, dy/dl
  local litk = o.lit or clamp(1 - (dl - 200) / 450, 0.1, 1)
  local function P(x, y) local px, py = (x - cx)/rx, (y - cy)/ry; return px*dx + py*dy, py, math.sqrt(px*px + py*py) end
  work(m, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=2.5, fill=true, edge="loose", load=0.9,
    angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
    scale_at=function(x,y) return 0.8 + 0.6*(1 - litk) end,
    piles={{orangeleaf, function(x,y) local u,v,r = P(x,y); return clamp((u + 0.1)*2, 0, 1) * (0.3 + 0.7*litk) end},
           {leafrust, function(x,y) local u,v,r = P(x,y); return math.exp(-((u + 0.2)/0.45)^2) end},
           {leafshade, function(x,y) local u,v,r = P(x,y); return clamp(-u*2, 0, 1.5) + clamp((v - 0.3)*2, 0, 1) + (1 - litk)*0.8 end}}})
  local lit = m:shrink(3) * mask(function(x,y) local u,v,r = P(x,y); return clamp((u - 0.25)*4, 0, 1) * clamp((r - 0.35)*4, 0, 1) end)
  local nh = noise{seed=seed + 5, period=16, octaves=2}
  lit = lit * mask(function(x,y) return clamp((nh:at01(x,y) - 0.3)*3, 0, 1) end)
  work(lit, {hand="body", tool={kind="filbert", width=6, stiffness=0.5, lay=3}, length={4,9}, coverage=1.1, load=1.0,
    angle=function(x,y) return 1.57 + rand(-1, 1) end,
    piles={{goldleaf, litk}, {orangeleaf, 1 - litk*0.5}, {glow, litk*litk*0.5}}})
  local rim = (m:grow(8) - m:shrink(6))
  local sm = rim * mask(function(x,y) return clamp((nh:at01(x+40,y) - 0.62)*4, 0, 1) end)
  work(sm, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={4,8}, coverage=0.6, load=0.8,
    angle=function(x,y) return 1.57 + rand(-1, 1) end,
    piles={{orangeleaf, function(x,y) local u = P(x,y); return clamp(u + 0.3, 0, 1) * litk end},
           {leafshade, function(x,y) local u = P(x,y); return clamp(-u, 0, 1) + (1-litk)*0.4 end}}})
  return m
end
work(rect(0,560,1000,690), {hand="broad", coverage=3, fill=true, angle=1.5, piles={{glow, function(x,y) return math.max(0, 1 - math.sqrt((x-600)^2+(y-1100)^2)/220)^1.3*1.8 end},{haze, 0.5},{amber, 0.5}}})
clump4({420, 800, 110, 75}, 21, 600, 1100)
clump4({300, 700, 130, 90}, 22, 600, 1100)
clump4({200, 880, 120, 80}, 23, 600, 1100)
clump4({120, 660, 140, 100}, 24, 600, 1100)
