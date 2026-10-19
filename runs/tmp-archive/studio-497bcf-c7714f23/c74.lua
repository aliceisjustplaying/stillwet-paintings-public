wg2 = pile{{"smalt", 1.5}, {"pale smalt", 1}, {"raw umber", 0.3}, {"green earth", 0.4}, {"lead white", 0.3}, medium=0.6}
local rv = river2:shrink(0.3)
-- darker on the near (lower) half of each reach
local low = {} local lw = {}
for i,p in ipairs(near_pts) do low[i] = {p[1], p[2] + near_w[i]*0.15}; lw[i] = near_w[i]*0.7 end
local lowm = ribbon(low, lw) * rv
work(rv, {hand="detail", pile=wg2, angle=0, coverage=1.2, length={6,16}, pressure={0.3,0.5}, load=0.35, fill=true, clip=true})
work(lowm, {hand="detail", pile=wg2, angle=0, coverage=1.2, length={6,16}, pressure={0.3,0.5}, load=0.4, fill=true, clip=true})
blend(rv, {angle=0, coverage=1.2, clip=true, tool={kind="badger", width=6}, pressure={0.2,0.3}})
-- the track: shade and ruts
pathG = pile{{"raw umber", 1.2}, {"green earth", 1}, {"yellow ochre", 0.5}, {"pale smalt", 0.3}, medium=0.55}
work(path_m, {hand="glaze", pile=pathG, angle=-0.3, coverage=1.2, load=0.4})
print(wait(0))
