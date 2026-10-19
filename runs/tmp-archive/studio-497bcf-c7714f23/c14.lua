mL = pile{{"yellow ochre", 3}, {"lead white", 2.5}, {"green earth", 2}, {"Prussian blue", 0.12}, {"chrome yellow", 0.2}, {"raw umber", 0.2}, medium=0.1}
mS = pile{{"green earth", 2}, {"yellow ochre", 1.5}, {"raw umber", 1}, {"Prussian blue", 0.22}, {"lead white", 1}, {"smalt", 0.3}, medium=0.1}
meadow = below({{-10,448},{1010,448}}) - Zfore
local n = noise{seed=21, period=1, octaves=3, persistence=0.5}
shadow_fn = function(x, y)
  if y < 446 then return 0 end
  local d = y - 430
  local u = x / (60 * d / 60) 
  local v = 900 / d
  local s = n(u * 2.2 / 3.0, v * 0.9)
  return smoothstep(0.0, 0.18, s)
end
cshadow = mask(shadow_fn) * meadow
work(meadow, {hand="body", pile=mL, angle=function(x,y) return 0.02*math.sin(x/150) end, coverage=1.6, length={20,55}, pressure={0.45,0.75}, fill=true, clip=meadow, edge="soft"})
work(cshadow, {hand="body", pile=mS, angle=0, coverage=1.6, length={15,45}, pressure={0.45,0.75}, fill=true, clip=meadow, edge="soft"})
print(cshadow:area()/meadow:area(), wait(0))
