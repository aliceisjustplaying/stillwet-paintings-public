print(wait(30*60))
bushD = pile{{"green earth", 2.2}, {"raw umber", 1.4}, {"lead white", 0.6}, {"pale smalt", 0.6}, {"Prussian blue", 0.1}, medium=0.08}
local spots = {{286, 500.5, 4.2}, {316, 494.5, 3.2}, {329, 494.0, 2.4}, {384, 487.4, 2.8}, {392, 486.8, 2.0}, {464, 480.6, 2.2}, {474, 480.2, 1.6}}
for i, s in ipairs(spots) do
  local x, y, r = s[1], s[2], s[3]
  local m = (ellipse(x, y - r*0.55, r, r*0.7) + ellipse(x + r*0.6, y - r*0.35, r*0.7, r*0.5)):roughen(r*0.15, r*0.4, 950 + i) * above({{0, y + 0.6}, {1000, y + 0.6}})
  local dk = m * mask(function(px, py) return ((px - x) + (py - (y - r*0.6)) * 0.8) > -r*0.3 and 1 or 0 end)
  stipple(dk, {pile=bushD, width=math.max(0.9, r*0.45), coverage=3.5, pressure={0.4,0.65}, clip=m, cluster=0.2})
end
print(wait(0))
