local function crowns(x0, x1, hmax, seed)
  local m
  local nn = noise{seed=seed, octaves=2, period=40}
  local x = x0
  local i = 0
  while x < x1 do
    i = i + 1
    local env = math.sin(math.pi*clamp((x-x0)/(x1-x0), 0, 1))^0.5
    local hh = hmax * (0.35 + 0.65*env) * (0.7 + 0.6*nn:at01(x, seed))
    local rw = 2.5 + hh*0.28 + rand(-0.8, 1.2)
    local base = far(x) + 1
    local e = ellipse(x, base - hh + rw*0.9, rw, rw*1.05) + rect(x - rw*0.9, base - hh + rw, rw*1.8, hh - rw)
    m = m and (m + e) or e
    x = x + rw*rand(0.9, 1.5)
  end
  return m
end
local function poplar(x, h)
  local base = far(x) + 1
  return ellipse(x, base - h*0.55, 2.2, h*0.5) + rect(x-0.4, base - h*0.1, 0.8, h*0.1)
end
TREES2 = crowns(-8, 128, 17, 1) + crowns(178, 258, 9, 2) + crowns(255, 278, 13, 3) + crowns(288, 362, 8, 4) + crowns(414, 552, 13, 5) + crowns(742, 808, 10, 6) + crowns(826, 866, 7, 7) + crowns(884, 1008, 19, 8)
TREES2 = TREES2 + poplar(392, 24) + poplar(398, 20) + poplar(812, 22) + poplar(817, 18) + poplar(164, 16)
TREES2 = (TREES2:roughen(1.2, 5, 41) + FARTREES:grow(0.8)) * above(function(x) return far(x) + 2.5 end) - TOWN
local tp = pile{{"pale smalt", 1.4}, {"lead white", 1.1}, {"green earth", 0.7}, {"raw umber", 0.35}, {"bone black", 0.07}, medium=0.1}
work(TREES2, {hand="detail", pile=tp, coverage=2.2, fill=true, seed=3201})
stipple(TREES2:rim(2, 1), {pile=tp, width=1.6, coverage=1.2, cluster=0.4, clip=false, seed=3202})
