local function under(m, d) return (m - m:offset(0) * m:shrink(0)) end
-- underside bands: part of each cloud within d units of its lower edge
local function lower(m, d)
  return m * mask(function(x,y) return (m:at(x, y + d) < 0.5) and 1 or 0 end)
end
uK1 = lower(K1, 16) - trees
uK2 = lower(K2, 14)
uK3 = lower(K3, 12)
pDarkC = pile{{"lead white",1},{"smalt",1},{"red earth",0.45},{"raw umber",0.4}}
pPeach = pile{{"lead white",4},{"chrome yellow",0.8},{"vermilion",0.45},{"red earth",0.05}}
local midK1 = (K1 - trees):shrink(12) * above(function(x) return 205 end)
local midK2 = K2:shrink(12)
work(midK1 + midK2, {hand="body", tool="filbert 8", pile=pDarkC, angle=0, angle_jitter=0.03, coverage=1.6, load=0.8, length={60,180}, pressure={0.4,0.7}})
work(uK1 + uK2 + uK3, {hand="body", tool="filbert 6", pile=pPeach, angle=0, angle_jitter=0.05, coverage=2.2, load=0.8, fill=true, length={30,90}, pressure={0.5,0.8}})
