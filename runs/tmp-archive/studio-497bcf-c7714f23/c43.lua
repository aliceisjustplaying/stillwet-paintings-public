-- near bank (the far, upper edge of the water is lit; the near lower edge a dark cut bank)
local bpts, bw = {}, {}
for i,p in ipairs(near_pts) do bpts[i] = {p[1], p[2] + near_w[i]*0.42}; bw[i] = near_w[i]*0.55 end
local bankm = ribbon(bpts, bw)
work(bankm, {hand="detail", pile=bank2, angle=0, coverage=2.2, length={4,10}, fill=true, clip=true, edge="firm"})
work(river2 - bankm:shrink(0.5), {hand="detail", pile=water2, angle=0, coverage=2.6, length={5,14}, fill=true, clip=true, edge="found"})
print(wait(0))
