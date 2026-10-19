willowD = pile{{"green earth", 2}, {"raw umber", 1.4}, {"smalt", 0.4}, {"lead white", 0.5}, {"bone black", 0.15}, medium=0.1}
willowL = pile{{"lead white", 2}, {"green earth", 1}, {"pale smalt", 0.5}, {"yellow ochre", 0.4}, {"raw umber", 0.3}, medium=0.1}
willowTrunk = pile{{"raw umber", 2}, {"bone black", 0.8}, {"lead white", 0.4}, {"green earth", 0.4}, medium=0.1}
ditchP = pile{{"raw umber", 2}, {"green earth", 1.2}, {"bone black", 0.4}, medium=0.1}
willows = {}
local dn, df = 1/134, 1/42
for i = 0, 7 do
  local d = lerp(dn, df, (i/7)^0.9)
  local y = 440 + 1/d
  local x = 842 + (y - 574) * (140/92) + rand(-2, 2)
  local h = 0.36 * (y - 440) * rand(0.85, 1.1)
  willows[#willows+1] = {x=x, y=y, h=h}
end
-- ditch along them (a thin dark line with a glint)
local dpts = {}
for i = 0, 20 do local y = lerp(582, 480, i/20); dpts[#dpts+1] = {842 + (y - 574) * (140/92) - 6*(y-440)/134, y} end
local dw = {}
for i = 1, #dpts do dw[i] = lerp(3.2, 0.7, (i-1)/(#dpts-1)) end
ditchM = ribbon(dpts, dw):roughen(0.5, 3, 111)
work(ditchM, {hand="detail", pile=ditchP, coverage=3, fill=true, clip=true, length={4,10}})
local dg = {}
for i = 1, #dpts do dg[i] = dw[i]*0.35 end
work(ribbon(dpts, dg), {hand="detail", pile=riverWarm, coverage=1.5, clip=true, length={3,8}, pressure={0.15,0.3}})
-- trees, far first
for i = #willows, 1, -1 do
  local W = willows[i]; local x, y, h = W.x, W.y, W.h
  local trunk = poly({{x - 0.1*h, y}, {x - 0.08*h, y - 0.25*h}, {x - 0.11*h, y - 0.44*h}, {x + 0.12*h, y - 0.46*h}, {x + 0.09*h, y - 0.25*h}, {x + 0.11*h, y}}, true)
  local crown = ellipse(x + rand(-1,1)*0.05*h, y - 0.72*h, 0.34*h, 0.3*h):roughen(math.max(0.8, 0.05*h), math.max(3, 0.15*h), 200+i)
  W.trunk = trunk; W.crown = crown
  local sw = math.max(1.2, 0.07*h)
  stipple(crown, {pile=willowD, width=sw, coverage=2.6, cluster={0.4, sw*2}, pressure={0.4,0.8}, dips={30, 0.7, 0}})
  stipple(crown * rect(0, y - h, 1000, 0.25*h), {pile=willowL, width=sw*0.9, coverage=0.7, cluster={0.5, sw*2}, pressure={0.3,0.6}, feather=0.4})
  work(trunk - crown:shrink(0.1*h), {hand="detail", pile=willowTrunk, coverage=3, fill=true, clip=true, angle=-1.57, length={2, math.max(3, 0.2*h)}})
end
