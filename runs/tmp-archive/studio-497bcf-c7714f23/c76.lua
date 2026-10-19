local trunks
for i, w in ipairs(willows) do
  local r = rect(w.x - 5, w.top - 2, 10, w.yb - w.top + 3)
  trunks = trunks and (trunks + r) or r
end
local hay = fieldB - river2:grow(1.5) - trunks - fore_m
work(hay, {hand="body", pile=straw, angle=-0.02, coverage=2.0, length={20,60}, pressure={0.45,0.75}, fill=true, clip=hay:grow(0.8), edge="firm"})
blend(hay, {angle=-0.02, coverage=1.0, clip=true, tool={kind="badger", width=16}, pressure={0.25,0.4}})
local strip = (mid_m * mask(function(x,y) return y > 560 and 1 or 0 end)) - fieldB - river2:grow(1.5)
work(strip, {hand="body", pile=gG, angle=0, coverage=2.0, length={15,50}, pressure={0.45,0.75}, fill=true, clip=strip:grow(0.8), edge="soft"})
blend(strip, {angle=0, coverage=1.0, clip=true, tool={kind="badger", width=14}, pressure={0.25,0.4}})
print(wait(0))
