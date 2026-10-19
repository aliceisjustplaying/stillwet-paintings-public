pathS = pile{{"yellow ochre", 2}, {"lead white", 2}, {"raw umber", 0.9}, {"red earth", 0.2}, {"pale smalt", 0.3}, medium=0.08}
pathD = pile{{"raw umber", 1.5}, {"yellow ochre", 1}, {"lead white", 0.8}, {"green earth", 0.6}, medium=0.08}
path_c = {{360,720},{392,690},{430,666},{480,646},{530,630},{570,618},{600,610},{622,605}}
path_w = {70,56,44,34,26,19,14,10}
path_m = ribbon(path_c, path_w):roughen(2.5, 12, 101) * below({{0,604},{1000,604}}) 
-- two ruts: the path is a cart track with grass in the middle
local mid = {} local mw = {}
for i,p in ipairs(path_c) do mid[i] = {p[1] + 1, p[2]}; mw[i] = path_w[i]*0.24 end
path_mid = ribbon(mid, mw):roughen(1.5, 6, 102)
work(path_m, {hand="body", pile=pathS, angle=function(x,y) return -0.45 + (x-360)/800 end, coverage=2.2, length={10,35}, pressure={0.45,0.75}, fill=true, clip=path_m, edge="soft"})
print(wait(0))
