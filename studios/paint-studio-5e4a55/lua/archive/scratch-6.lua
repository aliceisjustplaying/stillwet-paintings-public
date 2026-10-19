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
birch = pile{{"lead white",8},{"yellow ochre",0.25},{"chrome yellow",0.05}, name="birch"}
bshadow = pile{{"lead white",3},{"smalt",1},{"raw umber",0.7},{"cobalt blue",0.25},{"red earth",0.1}, name="birch_shadow"}
bmid = pile{{"lead white",5},{"raw umber",0.4},{"yellow ochre",0.3},{"smalt",0.4}, name="birch_mid"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lenticel"}
work(rect(0,0,1000,1250), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{haze, function(x,y) return 1 - x/1000 end},{amber, 0.5},{deeprust, function(x,y) return x/1000 end}}})
wait(14*60)
print(drying(500,500))

--@ chunk 3
wait(6*60)
print(drying(500,500))

--@ chunk 4
wait(6*60)
print(drying(500,500))

--@ chunk 5
-- birch builder
function birch_trunk(o)
  -- o.pts: axis points bottom->top {x,y,w}; o.seed; o.light: -1 light from left
  local left, right = {}, {}
  local nn = noise{seed=o.seed, period=40, octaves=2}
  for i, p in ipairs(o.pts) do
    local w = p[3]
    left[#left+1] = {p[1] - w/2 + nn(p[2], 0)*w*0.08, p[2]}
    right[#right+1] = {p[1] + w/2 + nn(p[2], 50)*w*0.08, p[2]}
  end
  local poly_pts = {}
  for i = 1, #left do poly_pts[#poly_pts+1] = left[i] end
  for i = #right, 1, -1 do poly_pts[#poly_pts+1] = right[i] end
  local m = poly(poly_pts, true)
  -- across-trunk coordinate u in -1..1
  local function axis_at(y)
    for i = 1, #o.pts - 1 do
      local a, b = o.pts[i], o.pts[i+1]
      if (y <= a[2] and y >= b[2]) then
        local t = (a[2] - y) / (a[2] - b[2])
        return lerp(a[1], b[1], t), lerp(a[3], b[3], t)
      end
    end
    return o.pts[#o.pts][1], o.pts[#o.pts][3]
  end
  local function u(x, y) local cx, w = axis_at(y); return (x - cx) / (w/2) end
  work(m, {hand="body", tool={kind="flat", width=o.bw or 7, stiffness=0.6}, length={25,60}, coverage=3, fill=true, clip=true,
    angle=function(x,y) return -math.pi/2 end,
    piles={{birch, function(x,y) return clamp(-u(x,y)*1.2 + 0.2, 0, 1)^1.5 end},
           {bmid, function(x,y) return math.exp(-((u(x,y)-0.15)/0.35)^2) end},
           {bshadow, function(x,y) return clamp(u(x,y)*1.4 - 0.1, 0, 1) end}}})
  return m, axis_at, u
end
bm, bax, bu = birch_trunk{pts={{300,1200,44},{305,900,40},{298,600,34},{290,300,28},{295,0,22}}, seed=3}

--@ chunk 6
bshadow = pile{{"lead white",2},{"raw umber",1},{"smalt",1},{"bone black",0.25},{"cobalt blue",0.2}, name="birch_shadow2"}
bwarm = pile{{"lead white",2},{"yellow ochre",1},{"red earth",0.4},{"raw umber",0.4}, name="birch_warm"}
function birch_trunk2(o)
  local left, right = {}, {}
  local nn = noise{seed=o.seed, period=30, octaves=3}
  for i, p in ipairs(o.pts) do
    local w = p[3]
    left[#left+1] = {p[1] - w/2, p[2]}
    right[#right+1] = {p[1] + w/2, p[2]}
  end
  local poly_pts = {}
  for i = 1, #left do poly_pts[#poly_pts+1] = left[i] end
  for i = #right, 1, -1 do poly_pts[#poly_pts+1] = right[i] end
  local m = poly(poly_pts, true):roughen(1.5, 12, o.seed)
  local function axis_at(y)
    for i = 1, #o.pts - 1 do
      local a, b = o.pts[i], o.pts[i+1]
      if (y <= a[2] and y >= b[2]) then
        local t = (a[2] - y) / (a[2] - b[2])
        return lerp(a[1], b[1], t), lerp(a[3], b[3], t)
      end
    end
    return o.pts[#o.pts][1], o.pts[#o.pts][3]
  end
  local function u(x, y) local cx, w = axis_at(y); return (x - cx) / (w/2) end
  work(m, {hand="body", tool={kind="flat", width=o.bw or 7, stiffness=0.6}, length={20,50}, coverage=3, fill=true, edge={found=0.7, soft=0.3, period=30},
    angle=function(x,y) return -math.pi/2 end,
    piles={{birch, function(x,y) return clamp(-u(x,y)*1.3 + 0.1, 0, 1)^1.3 end},
           {bmid, function(x,y) return math.exp(-((u(x,y)-0.05)/0.3)^2) * 0.8 end},
           {bshadow, function(x,y) local v = u(x,y); return clamp(v*1.6 - 0.2, 0, 1) * clamp((0.95 - v)*6, 0, 1) end},
           {bwarm, function(x,y) return clamp((u(x,y) - 0.78)*6, 0, 1) end}}})
  return m, axis_at, u
end
bm2, bax2, bu2 = birch_trunk2{pts={{600,1200,44},{605,900,40},{598,600,34},{590,300,28},{595,0,22}}, seed=4}

--@ chunk 7
function birch_marks(o, axis_at, nmarks, scars)
  local rd = brush{kind="round", width=o.mw or 4, point=0.6, stiffness=0.5}
  local ytop, ybot = o.pts[#o.pts][2], o.pts[1][2]
  for i = 1, nmarks do
    if i % 5 == 1 then rd:reload(lent, 0.55) end
    -- more marks lower on the trunk
    local y = lerp(ybot, ytop, rand(0,1)^1.3)
    local cx, w = axis_at(y)
    local len = w * rand(0.15, 0.6)
    local u0 = rand(-0.9, 0.9 - len/(w/2))
    local x0 = cx + u0 * w/2
    local bow = rand(1, 3)
    rd:gesture({{x0, y, 0.2}, {x0 + len*0.5, y + bow*0.4, rand(0.45, 0.8)}, {x0 + len, y + rand(-1,1), 0.1}}, {wobble=0.5})
  end
  -- scars: chevrons pointing down from a branch stub
  for _, s in ipairs(scars) do
    local cx, w = axis_at(s.y)
    rd:reload(lent, 0.7)
    local xm = cx + s.u * w/2
    rd:gesture({{xm - w*0.35, s.y - w*0.25, 0.3}, {xm, s.y + w*0.1, 0.9}, {xm + w*0.35, s.y - w*0.2, 0.25}}, {wobble=0.5})
    rd:gesture({{xm - w*0.2, s.y - w*0.12, 0.5}, {xm + w*0.1, s.y + w*0.05, 0.8}}, {wobble=0.5})
  end
end
birch_marks({pts={{600,1200,44},{605,900,40},{598,600,34},{590,300,28},{595,0,22}}, mw=4}, bax2, 55, {{y=420, u=-0.1}, {y=760, u=0.2}, {y=210, u=0.1}})
-- base: dark vertical furrows near the bottom
local rd = brush{kind="round", width=5, point=0.4}
for i = 1, 10 do
  rd:reload(lent, 0.5)
  local cx, w = bax2(1150)
  local x = cx + rand(-0.8, 0.8) * w/2
  rd:gesture({{x, 1200, 0.7}, {x + rand(-1,1), 1150, 0.5}, {x + rand(-2,2), 1100 - rand(0, 50), 0.05}}, {wobble=1})
end

--@ chunk 8
work(rect(700,0,300,1250), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{amber, 0.5},{deeprust, 1}}})
local m, ax, u = birch_trunk2{pts={{850,1200,40},{855,900,36},{848,600,30},{840,300,26},{845,0,20}}, seed=5}
birch_marks({pts={{850,1200,40},{855,900,36},{848,600,30},{840,300,26},{845,0,20}}, mw=4}, ax, 40, {{y=500, u=0}})
