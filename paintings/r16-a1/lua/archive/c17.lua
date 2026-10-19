function fir2(x, top, bot, w, tiers, seed)
  math.randomseed(seed)
  local R, L = {}, {}
  for i=1,tiers do
    local t = i/tiers
    local y = lerp(top, bot, t)
    local hw = w/2 * t^0.9
    R[#R+1] = {x + hw*rand(0.8,1.15), y + hw*0.25}   -- drooping branch tip
    R[#R+1] = {x + hw*0.35, y + (bot-top)/tiers*0.3}
    L[#L+1] = {x - hw*rand(0.8,1.15), y + hw*0.25 + rand(-0.5,0.5)}
    L[#L+1] = {x - hw*0.35, y + (bot-top)/tiers*0.3}
  end
  local pts = {{x, top-2}}
  for i=1,#R do pts[#pts+1] = R[i] end
  pts[#pts+1] = {x, bot+2}
  for i=#L,1,-1 do pts[#pts+1] = L[i] end
  return poly(pts)
end
local hzy = 462
math.randomseed(7)
local xs = uneven(26, 5, 330, 0.6, 0.5, 11)
firs2 = nil
for i,x in ipairs(xs) do
  local h = 22 + 22*math.abs(math.sin(x/47)) + rand(-5,6)
  if x > 260 then h = h*0.7 end
  local m = fir2(x, hzy-8-h, hzy-4, h*0.42, 8, 100+i)
  firs2 = firs2 and (firs2 + m) or m
end
local xr = uneven(7, 885, 998, 0.5, 0.4, 12)
for i,x in ipairs(xr) do firs2 = firs2 + fir2(x, hzy-12-rand(14,30), hzy-4, 14, 7, 200+i) end
work(firs2, {hand="detail", pile=fw, coverage=2.5, fill=true, angle=math.pi/2})
