local cys = {626, 618, 645, 652}
local all = puddles[1] + puddles[2] + puddles[3] + puddles[4]
local g1 = pile{{"raw umber",1.5},{"smalt",0.8},{"red earth",0.2}, medium=0.8}
work(all:grow(1), {hand="glaze", tool="filbert 6", pile=g1, angle=0, coverage=1.3, length={20,60}, clip=true, pressure={0.2,0.3}})
local lower
for i, p in ipairs(puddles) do
  local c = cys[i]
  local m = p * mask(function(x, y) return smoothstep(c - 1, c + 3, y) end)
  lower = lower and (lower + m) or m
end
work(lower, {hand="glaze", tool="filbert 6", pile=g1, angle=0, coverage=1.2, length={20,50}, clip=true, pressure={0.2,0.3}})
