strat = pile{{"lead white",2.5},{"smalt",0.6},{"red earth",0.5},{"raw umber",0.3}}
rimP = pile{{"lead white",4},{"vermilion",0.25},{"yellow ochre",0.6},{"chrome yellow",0.3}}
local b = brush("filbert", 7)
local streaks = {
  {40, 372, 330, 4}, {120, 382, 260, 3}, {760, 362, 230, 4}, {820, 374, 180, 3},
  {-10, 345, 190, 3}, {470, 340, 160, 2.5}, {880, 318, 140, 3}, {280, 322, 120, 2.5},
  {690, 402, 150, 2.5}, {0, 402, 120, 3},
}
for i, s in ipairs(streaks) do
  b:reload(strat, 0.5)
  local x0, y0, L, wv = s[1], s[2], s[3], s[4]
  local pts = {}
  for k = 0, 6 do
    local t = k/6
    pts[#pts+1] = {x0 + L*t, y0 + wv*math.sin(t*3.1 + i) - 3*t}
  end
  b:stroke(pts, {pressure={0.35, 0.05}, ramps={0.2, 0.5}, swell={0.8,1.1,0.7}})
end
-- lit underside of the bank
local under = bank:grow(4) - bank:shrink(3)
local lowerHalf = mask(function(x,y) local c = 205 + 25*math.sin(x/260+0.5) - 0.02*(x-500); return clamp((y - c)/10, 0, 1) end)
work(under*lowerHalf, {hand="detail", pile=rimP, angle=-0.04, coverage=1.2, pressure={0.3,0.6}})
