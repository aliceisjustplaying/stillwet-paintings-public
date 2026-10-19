SKY = above(function(x) return far(x)+5 end)
local function skypile(t)
  local s = {}
  s[#s+1] = {"lead white", lerp(3.2, 10, t^0.8)}
  if t < 0.85 then s[#s+1] = {"smalt", 1.6*(1-t/0.85)^1.3} end
  if t < 0.6 then s[#s+1] = {"cobalt blue", 0.45*(1-t/0.6)^1.5} end
  s[#s+1] = {"pale smalt", lerp(1.1, 0.15, t)}
  if t > 0.55 then s[#s+1] = {"yellow ochre", 0.4*smoothstep(0.55,1,t)} end
  if t > 0.65 then s[#s+1] = {"vermilion", 0.035*math.sin(math.pi*smoothstep(0.65,1.05,t))} end
  if t > 0.8 then s[#s+1] = {"chrome yellow", 0.18*smoothstep(0.8,1,t)} end
  s.medium = 0.18
  return pile(s)
end
local ys = {0, 50, 100, 150, 200, 245, 285, 320, 350, 372, 400}
SKYP = {}
for i=1,#ys-1 do
  local t = (i-1)/(#ys-2)
  local p = skypile(t)
  SKYP[i] = p
  local m = rect(-10, ys[i]-4, 1020, ys[i+1]-ys[i]+8) * SKY
  work(m, {hand="body", tool="flat 12", pile=p, angle=0, angle_jitter=0.06, length={70,180}, coverage=2.6, fill=true, pressure={0.5,0.8}, seed=100+i})
end
print(SKYP[1], SKYP[10])
