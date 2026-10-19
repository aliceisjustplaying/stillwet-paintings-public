rest(16); sitting{hours=6}
farpal = pal:only{"lead white", "pale smalt", "cobalt blue", "raw umber", "bone black", "yellow ochre"}
farO = outline{pts=FAR, open=true, char="soft", lobe=7, amount=0.8, seed=71}
farM = farO:below(HZ + 30) * above(function(x) return HZ + 2.5 + 0.8 * math.sin(x / 37) end)
FARC = {wood="#58535c", land="#645d62", mist="#8f8a8f"}
-- the far land: darker under the wood, paler into the mist on the right
local c = function(x, y)
  local m = smoothstep(820, 1000, x)
  return mix(y < HZ - 2 and FARC.wood or FARC.land, FARC.mist, 0.75 * m)
end
work(farM, {hand="detail", tool="round 2.2", length={6, 22}, coverage=3, angle=0, angle_jitter=0.15, pal=farpal, clip=false,
  edge={found=0.55, soft=0.45, period=35, seed=5}, color=c, medium=0.2})
-- the wood's crowns, touched upward along its top
local rb = brush("round", 1.6)
for i = 1, 170 do
  local x = rand(45, 305)
  local top = nil
  for yy = 425, HZ, 0.5 do if farM:at(x, yy) > 0.5 then top = yy; break end end
  if top then
    if i % 12 == 1 then rb:reload(mix(FARC.wood, "#3f3c44", rand(0, 0.5)), 0.6) end
    rb:stroke({{x, top + rand(3, 7)}, {x + randn(0, 0.6), top + rand(-1.5, 0.8)}}, {pressure={0.55, 0.15}, ramps={0.1, 0.5}})
  end
end
