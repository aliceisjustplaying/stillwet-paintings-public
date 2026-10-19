dry()
-- the far hills: a thin hazed band, a little darker than the sky above them, then stippled into the air
HILLM = (below(hills) * above(function(x) return shore(x) + 2 end)):roughen(0.8, 9, 3, 0.4)
function hillcol(x, y) local t = smoothstep(hills(x), HZ + 4, y)
  return mix(mix("#a49ea7", "#9b9aa6", hn:at01(x*2, 3)), "#c2b6ac", 0.6*t) end
work(HILLM, {hand="body", length={18, 50}, coverage=3.2, medium=0.25,
  angle=function(x, y) return 0.04*hn(x*3, 1) end, edge={found=0.3, soft=0.5, lost=0.2, period=60, seed=5}, color=hillcol})
