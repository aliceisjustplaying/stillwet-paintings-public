local kinds = {
  gold = {{"lead white", 2}, {"yellow ochre", 1.5}, {"chrome yellow", 0.25}, {"green earth", 0.3}},
  green = {{"lead white", 1.4}, {"green earth", 1.6}, {"yellow ochre", 0.9}, {"pale smalt", 0.3}},
  shade = {{"lead white", 1.1}, {"green earth", 1.5}, {"pale smalt", 0.8}, {"raw umber", 0.12}, {"yellow ochre", 0.3}},
  fallow = {{"lead white", 1.5}, {"yellow ochre", 1}, {"red earth", 0.3}, {"raw umber", 0.25}},
  lush = {{"lead white", 1}, {"green earth", 1.4}, {"yellow ochre", 0.9}, {"chrome yellow", 0.15}, {"Prussian blue", 0.04}},
}
local order = {"green","gold","shade","lush","fallow","green","gold","lush","shade","green","gold","fallow","lush"}
local function mkpile(kind, t)
  local s = {}
  for _,c in ipairs(kinds[kind]) do s[#s+1] = {c[1], c[2]} end
  s[#s+1] = {"lead white", 2.2*(1-t)}
  s[#s+1] = {"pale smalt", 1.0*(1-t) + 0.01}
  s.medium = 0.2
  return pile(s)
end
local y = 398
local ybs = {}
while y < 466 do ybs[#ybs+1] = y; y = y + 3 + (y-398)*0.13 end
ybs[#ybs+1] = 468
FIELDS = {}
local k = 0
for i=1,#ybs-1 do
  local ya, yb = ybs[i], ybs[i+1]
  local t = ((ya+yb)/2 - 398)/70
  local xs = uneven(math.random(2,4), 60, 940, 0.8, 0.2, 1800+i)
  local xb = {-20}
  for _,x in ipairs(xs) do xb[#xb+1] = x end
  xb[#xb+1] = 1020
  for j=1,#xb-1 do
    k = k + 1
    local sl = rand(-0.9, 0.9)
    local x0, x1 = xb[j], xb[j+1]
    local sa, sb = randn(0, 0.6), randn(0, 0.6)
    local m = mask(function(px, py)
      local top = ya + sa + 0.004*(px-500)*(i%2==0 and 1 or -1)
      local bot = yb + sb + 0.004*(px-500)*((i+1)%2==0 and 1 or -1)
      local l = x0 + (py - ya)*sl
      local r = x1 + (py - ya)*sl
      return (py >= top and py < bot and px >= l and px < r) and 1 or 0 end) * LAND
    local kind = order[(k*7 + i) % #order + 1]
    FIELDS[#FIELDS+1] = {m=m, kind=kind}
    local w = 2 + t*4
    work(m, {hand="body", tool={kind="flat", width=w}, pile=mkpile(kind, t), angle=0, angle_jitter=0.04, length={20,70}, coverage=1.6, fill=true, pressure={0.4,0.7}, edge="firm", seed=1800+k})
  end
end
print(k)
