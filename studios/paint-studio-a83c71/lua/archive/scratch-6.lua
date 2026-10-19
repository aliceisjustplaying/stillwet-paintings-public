-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
mist_low = pile{{"lead white", 4}, {"smalt", 1.5}, {"raw umber", 0.3}, {"rose madder", 0.2}, name="mist_low"}
work(rect(0,0,1000,714), {hand="broad", piles={{mist_bright, function(x,y) return 1 - y/714 end}, {mist_low, function(x,y) return y/714 end}}, angle=0, coverage=3.5, load=1.0, fill=true, clip=true, tool={kind="filbert", width=22, lay=1.6}})
blend(rect(0,0,1000,714), {angle=0, tool={kind="badger", width=60}})
wait(16*24*60)
print(drying(500,300))

--@ chunk 3
spruce_dark = pile{{"Prussian blue", 1}, {"raw umber", 2.5}, {"bone black", 1}, {"yellow ochre", 0.4}, name="spruce_dark"}
function spruce_shape(s, seed)
  local h = s.base - s.tip
  local n = math.max(5, math.floor(h / clamp(h / 16, 4, 13)))
  local sp = h / n
  local L, R = {}, {}
  math.randomseed(seed)
  L[#L+1] = {s.x, s.tip}
  local tiers = {}
  for i = 1, n do
    local yb = s.tip + i * sp
    local t = (yb - s.tip) / h
    local hw = s.w / 2 * (t ^ 0.85) * (0.82 + 0.3 * math.random())
    local hwL = hw * (0.85 + 0.3 * math.random())
    local hwR = hw * (0.85 + 0.3 * math.random())
    local droop = sp * (0.35 + 0.35 * math.random())
    local yin = yb - sp * 0.65
    tiers[#tiers+1] = {y=yb, hwL=hwL, hwR=hwR, droop=droop, yin=yin}
    L[#L+1] = {s.x - hwL * 0.3, yin}
    L[#L+1] = {s.x - hwL, yb + droop * 0.4}
    L[#L+1] = {s.x - hwL * 0.55, yb + droop * 0.2}
    R[#R+1] = {s.x + hwR * 0.3, yin}
    R[#R+1] = {s.x + hwR, yb + droop * 0.4}
    R[#R+1] = {s.x + hwR * 0.55, yb + droop * 0.2}
  end
  local q = {}
  for _, p in ipairs(L) do q[#q+1] = p end
  q[#q+1] = {s.x - 1.5, s.base + 5}; q[#q+1] = {s.x + 1.5, s.base + 5}
  for i = #R, 1, -1 do q[#q+1] = R[i] end
  return poly(q), tiers
end
function paint_spruce(s, pile_, seed, clipm)
  local m, tiers = spruce_shape(s, seed)
  if clipm then m = m * clipm end
  work(m, {hand="body", pile=pile_, angle=1.2, coverage=2.5, fill=true, clip=m, tool={kind="filbert", width=math.max(2, s.w / 10)}})
  -- branch tips: drooping gestures from the trunk outward
  local b = brush{kind="round", width=math.max(1.6, s.w / 14), point=0.9}
  b:load(pile_, 0.7)
  for i, t in ipairs(tiers) do
    if i % 3 == 0 then b:load(pile_, 0.6) end
    for _, side in ipairs({-1, 1}) do
      local hw = side < 0 and t.hwL or t.hwR
      local x0, y0 = s.x, t.yin
      local pts = {{x0, y0, 0.7}, {x0 + side * hw * 0.5, t.y - t.droop * 0.1, 0.5}, {x0 + side * hw * 1.08, t.y + t.droop * 0.45, 0.05}}
      b:gesture(pts, {clip=clipm})
    end
  end
  local tb = brush{kind="round", width=1.2, point=1}
  tb:load(pile_, 0.5)
  tb:gesture({{s.x, s.tip + h_or(s) * 0.08, 0.6}, {s.x + 0.3, s.tip - 4, 0.0}}, {clip=clipm})
end
function h_or(s) return s.base - s.tip end
paint_spruce({x=300, tip=150, base=650, w=90}, spruce_dark, 3)
paint_spruce({x=450, tip=350, base=650, w=50}, spruce_dark, 4)
paint_spruce({x=560, tip=480, base=650, w=26}, spruce_dark, 5)
print("ok")

--@ chunk 4
wait(20*24*60)
work(rect(150,100,600,600), {hand="broad", piles={{mist_bright, function(x,y) return 1 - y/714 end}, {mist_low, function(x,y) return y/714 end}}, angle=0, coverage=3.5, load=1.0, fill=true, clip=true, tool={kind="filbert", width=22, lay=1.6}})
blend(rect(150,100,600,600), {angle=0, tool={kind="badger", width=60}})
wait(16*24*60)
print(drying(400,300))

--@ chunk 5
function spruce2(s, seed)
  math.randomseed(seed)
  local h = s.base - s.tip
  local parts = {}
  local branches = {}
  -- leader
  parts[#parts+1] = ribbon({{s.x, s.tip}, {s.x + rand(-1,1), s.tip + h * 0.12}}, {0.6, math.max(1.2, s.w * 0.04)})
  parts[#parts+1] = ribbon({{s.x, s.tip + h*0.1}, {s.x, s.base}}, {math.max(1.2, s.w*0.04), math.max(2, s.w * 0.08)})
  local y = s.tip + h * 0.04
  while y < s.base - 4 do
    local t = (y - s.tip) / h
    local env = s.w / 2 * math.min(1, (t ^ 0.8) * 1.05) 
    local sp = clamp(h / 30, 2.2, 16) * (0.6 + 0.8 * math.random())
    for _, side in ipairs({-1, 1}) do
      if math.random() > 0.12 then
        local L = env * (0.45 + 0.7 * math.random())
        local droop = L * (0.25 + 0.3 * math.random())
        local y0 = y + rand(-sp*0.3, sp*0.3)
        local th = clamp(sp * (0.55 + 0.4*math.random()), 1.2, 14)
        local pts = {{s.x, y0}, {s.x + side * L * 0.45, y0 + droop * 0.55}, {s.x + side * L * 0.85, y0 + droop}, {s.x + side * L, y0 + droop * 0.85}}
        parts[#parts+1] = ribbon(pts, {th, th * 0.8, th * 0.55, th * 0.25})
        branches[#branches+1] = {pts=pts, th=th}
        -- pendant clumps under the branch
        local nc = math.floor(L / math.max(3, th * 1.2))
        for k = 1, nc do
          local u = math.random() * 0.9 + 0.1
          local cx = s.x + side * L * u
          local cy = y0 + droop * u + th * (0.3 + 0.4 * math.random())
          parts[#parts+1] = ellipse(cx, cy, th * (0.25 + 0.3 * math.random()), th * (0.35 + 0.4 * math.random()))
        end
      end
    end
    y = y + sp
  end
  local m = parts[1]
  for i = 2, #parts do m = m + parts[i] end
  m = m:roughen(math.max(0.8, s.w * 0.02), math.max(4, s.w * 0.12), seed)
  return m, branches
end
function paint_spruce2(s, pile_, seed, clipm)
  local m, br = spruce2(s, seed)
  if clipm then m = m * clipm end
  work(m, {hand="body", pile=pile_, angle=1.3, coverage=2.5, fill=true, clip=m, tool={kind="filbert", width=clamp(s.w / 12, 1.5, 7)}})
  return m
end
local m1 = paint_spruce2({x=300, tip=150, base=650, w=95}, spruce_dark, 3)
local m2 = paint_spruce2({x=450, tip=350, base=650, w=50}, spruce_dark, 4)
local m3 = paint_spruce2({x=560, tip=480, base=650, w=26}, spruce_dark, 5)
local m4 = paint_spruce2({x=620, tip=540, base=650, w=16}, spruce_dark, 6)
print("ok")

--@ chunk 6
function spruce2(s, seed)
  math.randomseed(seed)
  local h = s.base - s.tip
  local parts = {}
  local tw = math.max(0.8, s.w * 0.03)
  parts[#parts+1] = ribbon({{s.x, s.tip}, {s.x + rand(-0.6,0.6), s.tip + h * 0.15}}, {0.5, tw})
  parts[#parts+1] = ribbon({{s.x, s.tip + h*0.14}, {s.x, s.base}}, {tw, math.max(1.6, s.w * 0.07)})
  local y = s.tip + h * 0.03
  while y < s.base - 4 do
    local t = (y - s.tip) / h
    local env = s.w / 2 * math.min(1, (t ^ 0.85) * 1.05)
    local spBase = clamp(h / 32, 2, 14)
    local sp = spBase * (0.35 + 0.65 * t) * (0.6 + 0.8 * math.random())
    sp = math.max(sp, 1.6)
    for _, side in ipairs({-1, 1}) do
      if math.random() > 0.1 + 0.1 * t then
        local L = env * (0.45 + 0.7 * math.random())
        local droop = L * (0.2 + 0.35 * math.random())
        local y0 = y + rand(-sp*0.3, sp*0.3)
        local th = clamp(spBase * (0.25 + 0.6 * t) * (0.7 + 0.5 * math.random()), 0.8, 13)
        local pts = {{s.x, y0}, {s.x + side * L * 0.45, y0 + droop * 0.55}, {s.x + side * L * 0.85, y0 + droop}, {s.x + side * L, y0 + droop * 0.8}}
        parts[#parts+1] = ribbon(pts, {th, th * 0.8, th * 0.5, th * 0.2})
        if t > 0.18 then
          local nc = math.floor(L / math.max(3, th * 1.4))
          for k = 1, nc do
            local u = math.random() * 0.85 + 0.15
            local cx = s.x + side * L * u
            local cy = y0 + droop * u + th * (0.3 + 0.3 * math.random())
            local rx = th * (0.15 + 0.2 * math.random())
            local ry = th * (0.3 + 0.45 * math.random())
            parts[#parts+1] = ellipse(cx, cy, rx, ry)
          end
        end
      end
    end
    y = y + sp
  end
  local m = parts[1]
  for i = 2, #parts do m = m + parts[i] end
  m = m:roughen(math.max(0.6, s.w * 0.015), math.max(3, s.w * 0.08), seed)
  return m
end
local m1 = paint_spruce2({x=820, tip=120, base=650, w=95}, spruce_dark, 13)
local m2 = paint_spruce2({x=700, tip=350, base=650, w=50}, spruce_dark, 14)
local m3 = paint_spruce2({x=180, tip=480, base=650, w=26}, spruce_dark, 15)
local m4 = paint_spruce2({x=130, tip=540, base=650, w=16}, spruce_dark, 16)
print("ok")

--@ chunk 7
wait(10*24*60)
function paint_spruce3(s, top_pile, mist_list, seed, fadeY, fadeLen)
  local m = spruce2(s, seed)
  local wt = function(x, y) return clamp((fadeY - y) / fadeLen, 0, 1) end
  local piles = {{top_pile, wt}}
  for _, mp in ipairs(mist_list) do
    piles[#piles+1] = {mp[1], function(x, y) return (1 - wt(x, y)) * mp[2](x, y) end}
  end
  work(m, {hand="body", piles=piles, angle=1.3, coverage=2.5, fill=true, clip=m, tool={kind="filbert", width=clamp(s.w / 12, 1.5, 7)}})
  return m
end
local ml = {{mist_bright, function(x,y) return 1 - y/714 end}, {mist_low, function(x,y) return y/714 end}}
spruce_far = mix{{spruce_dark, 0.45}, {mist_low, 0.55}, name="spruce_far"}
paint_spruce3({x=400, tip=300, base=700, w=60}, spruce_dark, ml, 21, 560, 110)
paint_spruce3({x=500, tip=380, base=700, w=40}, spruce_far, ml, 22, 560, 90)
print("ok")

--@ chunk 8
eshadow = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.3}, {"raw umber", 0.2}, name="eshadow"}
belt = pile{{"lead white", 8}, {"rose madder", 0.7}, {"Naples yellow", 0.8}, {"vermilion", 0.1}, name="belt"}
glow = pile{{"lead white", 7}, {"Naples yellow", 0.8}, {"smalt", 0.7}, {"rose madder", 0.2}, name="glow"}
local m = rect(30, 30, 260, 200)
work(m, {hand="broad", piles={{belt, function(x,y) return clamp(1-(y-30)/120,0,1) end}, {eshadow, function(x,y) return clamp((y-60)/120,0,1) end}, {glow, function(x,y) local dx,dy=(x-160)/60,(y-140)/40; return 0.7*math.exp(-(dx*dx+dy*dy)) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=true, tool={kind="filbert", width=22, lay=1.6}})
blend(m, {angle=0, tool={kind="badger", width=60}})
wait(14*24*60)
print(drying(160,140))

--@ chunk 9
moon = pile{{"lead white", 6}, {"Naples yellow", 1.2}, {"vermilion", 0.03}, name="moon"}
moon_b = pile{{"lead white", 6}, {"Naples yellow", 1.2}, {"vermilion", 0.03}, blot=0.2, name="moon_b"}
-- A: body fill, soft edge
local mA = ellipse(90, 140, 15, 15)
work(mA, {hand="detail", pile=moon, coverage=3, fill=true, edge="soft", tool={kind="round", width=4}})
-- B: blotted, thicker, firm edge, dabbed
local mB = ellipse(160, 140, 15, 15)
work(mB, {hand="detail", pile=moon_b, coverage=3, fill=true, edge="firm", tool={kind="round", width=5, lay=3}})
-- C: stippled disk
local mC = ellipse(230, 140, 15, 15)
stipple(mC:soften(1.5), {pile=moon, width=3, coverage=6, clip=mC:grow(1)})
print("ok")
