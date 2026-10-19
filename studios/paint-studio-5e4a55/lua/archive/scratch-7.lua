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
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
woods = pile{{"raw umber",2},{"red earth",1},{"Prussian blue",0.4},{"yellow ochre",0.5}, name="woods_dark"}
crevice = pile{{"bone black",1},{"Prussian blue",0.4},{"raw umber",1}, name="crevice"}
rockwarm = pile{{"lead white",1.5},{"yellow ochre",1},{"red earth",0.8},{"raw umber",1}, name="rockwarm"}
rockmid = pile{{"lead white",1},{"raw umber",2},{"smalt",0.5},{"yellow ochre",0.5},{"bone black",0.2}, name="rockmid"}
mossdark = pile{{"green earth",2},{"raw umber",1},{"Prussian blue",0.2},{"yellow ochre",1}, name="mossdark"}
moss = pile{{"green earth",3},{"chrome yellow",1},{"yellow ochre",1.2},{"raw umber",0.4}, name="moss"}
mosslit = pile{{"chrome yellow",1},{"yellow ochre",2},{"green earth",1.5},{"lead white",1.5},{"red earth",0.2}, name="moss_lit"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
work(rect(0,0,1000,1250), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{haze, 1},{amber, 0.5}}})
local wc = worley{seed=7, period=45, jitter=0.9}
local nn = noise{seed=9, period=60, octaves=3}
local LXd, LYd = -0.7, -0.7
local function facet(x, y)
  local d1, d2, wall, id = wc:at(x, y)
  return id
end
-- probe what worley returns
local a, b, c, d = wc:at(100, 100)
print(a, b, c, d)

--@ chunk 3
local wc = worley{seed=7, period=38, jitter=0.9}
local nn = noise{seed=9, period=50, octaves=3}
local B = outline{{80,520},{150,430},{260,395},{380,405},{470,450},{520,540},{530,700},{60,700}, char="broken", seed=21, amount=0.7}:mask()
local function topy_b(x) return 395 + ((x-260)/200)^2 * 60 end
local function sh(x, y)
  local d1, d2, wall, id = wc:at(x, y)
  local h = clamp(1 - (y - topy_b(x)) / 260, 0, 1) -- 1 at top
  local s = 0.25 + 0.45*h + 0.45*(id - 0.5) + 0.15*nn(x,y)
  -- facing the light (left/up) a little
  s = s + 0.15 * clamp((300 - x)/300, -1, 1)
  if wall < 0.06 then s = s - 0.5 end
  return clamp(s, 0, 1)
end
local function mossy(x, y)
  local d1, d2, wall, id = wc:at(x, y)
  local h = clamp(1 - (y - topy_b(x)) / 140, 0, 1)
  return clamp((h + 0.6*nn:at01(x*1.5, y*1.5) - 0.9) * 3, 0, 1)
end
work(B, {hand="body", tool={kind="flat", width=9, stiffness=0.6}, length={10,25}, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=30},
  angle=function(x,y) local d1,d2,w,id = wc:at(x,y); return id * 3.14 end,
  piles={{crevice, function(x,y) return clamp(1 - sh(x,y)*4, 0, 1) end},
         {rock, function(x,y) local s = sh(x,y); return math.exp(-((s-0.3)/0.15)^2) * (1 - mossy(x,y)) end},
         {rockmid, function(x,y) local s = sh(x,y); return math.exp(-((s-0.55)/0.15)^2) * (1 - mossy(x,y)) end},
         {rockwarm, function(x,y) local s = sh(x,y); return clamp((s - 0.65)*4, 0, 1) * (1 - mossy(x,y)) end},
         {mossdark, function(x,y) return mossy(x,y) * clamp(1 - sh(x,y)*1.5, 0, 1) end},
         {moss, function(x,y) return mossy(x,y) * math.exp(-((sh(x,y)-0.55)/0.2)^2) end},
         {mosslit, function(x,y) return mossy(x,y) * clamp((sh(x,y)-0.6)*3, 0, 1) end}}})

--@ chunk 4
local wc = worley{seed=8, period=70, jitter=0.85}
local nn = noise{seed=10, period=70, octaves=2}
local B = outline{{580,520},{650,430},{760,395},{880,405},{960,450},{990,540},{995,700},{560,700}, char="broken", seed=22, amount=0.7}:mask()
local function topy_b(x) return 395 + ((x-760)/200)^2 * 60 end
local function sh(x, y)
  local d1, d2, wall, id = wc:at(x, y)
  local h = clamp(1 - (y - topy_b(x)) / 240, 0, 1)
  local s = 0.1 + 0.6*h^1.5 + 0.28*(id - 0.5) + 0.08*nn(x,y)
  s = s + 0.12 * clamp((760 - x)/250, -1, 1)
  if wall < 0.04 then s = s - 0.35 end
  return clamp(s, 0, 1)
end
local function mossy(x, y)
  local h = clamp(1 - (y - topy_b(x)) / 120, 0, 1)
  return clamp((h + 0.7*nn:at01(x*1.3+50, y*1.3) - 0.95) * 3, 0, 1)
end
work(B, {hand="body", tool={kind="flat", width=10, stiffness=0.6}, length={14,30}, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=30},
  angle=function(x,y) local d1,d2,w,id = wc:at(x,y); return 0.3 + id * 1.2 end,
  piles={{crevice, function(x,y) return clamp(1 - sh(x,y)*5, 0, 1) end},
         {rock, function(x,y) local s = sh(x,y); return math.exp(-((s-0.25)/0.15)^2) * (1 - mossy(x,y)) end},
         {rockmid, function(x,y) local s = sh(x,y); return math.exp(-((s-0.5)/0.15)^2) * (1 - mossy(x,y)) end},
         {rockwarm, function(x,y) local s = sh(x,y); return clamp((s - 0.62)*4, 0, 1) * (1 - mossy(x,y)) end},
         {mossdark, function(x,y) return mossy(x,y) * clamp(1 - sh(x,y)*1.5, 0, 1) end},
         {moss, function(x,y) return mossy(x,y) * math.exp(-((sh(x,y)-0.5)/0.2)^2) end},
         {mosslit, function(x,y) return mossy(x,y) * clamp((sh(x,y)-0.6)*3, 0, 1) end}}})
blend(B:shrink(4):soften(6), {angle=0.6})
