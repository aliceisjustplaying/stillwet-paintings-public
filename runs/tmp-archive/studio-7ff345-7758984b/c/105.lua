-- snow lying along the top of the fallen limb and capping the stones
local top = fallenM * mask(function(x, y) return (fallenM:at(x, y - 1.2) < 0.4) and 1 or 0 end)
local capS = (stoneM * mask(function(x, y) return (stoneM:at(x, y - 1.3) < 0.4) and 1 or 0 end))
local m = (top:grow(0.5) + capS:grow(0.6)):roughen(0.2, 1, 1051)
work(m, {hand="detail", tool={kind="round", width=0.8, point=0.8}, pile=capP, load=0.9, pressure={0.5, 0.8}, coverage=3, fill=true, clip=true, angle=0})
