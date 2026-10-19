local sm
for i,k in ipairs(KERB) do
  local cut = k.y - k.ry*0.15 + rand(-0.5, 0.5)
  local m = (k.m:grow(0.6) * above(function(x) return cut + 0.8*math.sin(x*1.3 + i) end))
  sm = sm and (sm + m) or m
end
work(sm, {hand="detail", pile=capShade, coverage=4, fill=true, angle=0, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.2, point=0.6}})
-- the top edges catch the sky
local tb = brush{kind="round", width=1.4, point=0.8}
tb:load(snowTop, 0.7)
for i,k in ipairs(KERB) do
  if tb:fullness() < 0.3 then tb:load(snowTop, 0.7) end
  tb:stroke({{k.x - k.rx*0.8, k.y - k.ry*0.35}, {k.x - k.rx*0.2, k.y - k.ry*0.95}, {k.x + k.rx*0.5, k.y - k.ry*0.8}, {k.x + k.rx*0.9, k.y - k.ry*0.1}}, {pressure={tb:pressure_for(0.9), tb:pressure_for(0.6)}})
end
-- the leaning slab: snow along its upper edges
local slabS = poly({{740,474},{744,466},{749,459},{762,457},{770,462},{768,465},{760,462},{751,463},{746,469},{743,476}}, true)
work(slabS, {hand="detail", pile=capShade, coverage=4, fill=true, angle=0.9, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.4, point=0.6}})
tb:reload(snowTop, 0.7)
tb:stroke({{741,472},{745,464},{750,459},{761,457},{768,461}}, {pressure={tb:pressure_for(1.2), tb:pressure_for(0.7)}})
-- a lighter facet on the slab face, a darker right side
local face = SLAB:mask() * mask(function(x,y) return (x - 742) < (y - 455)*0.9 + 10 and 1 or 0 end)
work(face, {hand="detail", pile=rkC, coverage=1.5, fill=false, angle=1.2, pressure={0.3,0.5}, tool={kind="round", width=1.5, point=0.6}})
