local cys = {626, 618, 645, 652}
local dark = pile{{"raw umber",2.5},{"bone black",0.6},{"red earth",0.3},{"lead white",0.2}}
local mudc = pile{{"raw umber",2.8},{"red earth",0.6},{"bone black",0.45},{"lead white",0.35},{"smalt",0.4}}
local all = puddles[1] + puddles[2] + puddles[3] + puddles[4]
local n = lose(all, {pile=mudc, where=0.6, tool="filbert 3", reach={4,5}, load=0.3, angle=0.05})
print("lose", n)
local lip
for i, p in ipairs(puddles) do
  local c = cys[i]
  local m = p:grow(0.8) - p:shrink(0.6)
  m = m * mask(function(x, y) return 1 - smoothstep(c - 2, c, y) end)
  lip = lip and (lip + m) or m
end
work(lip, {hand="detail", tool={kind="round", width=1.2, point=0.6}, pile=dark, angle=0, coverage=1.5, clip=true, pressure={0.3,0.5}})
