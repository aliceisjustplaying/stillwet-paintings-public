print(wait(20*60))
bush = pile{{"green earth", 2.5}, {"raw umber", 0.8}, {"lead white", 1.5}, {"pale smalt", 0.9}, {"yellow ochre", 0.6}, {"Prussian blue", 0.05}, medium=0.1}
local pts = {{-5,470}}
local x = -5
while x < 250 do
  local top = 446 + 4*math.sin(x/17) + 3*math.sin(x/7.3)
  if x > 190 then top = top + (x - 190) * 0.35 end
  pts[#pts+1] = {x, top}
  x = x + 4
end
pts[#pts+1] = {250, 471}
local back = poly(pts, true):roughen(1.5, 4, 92) - roof - walls - lime_sil2:shrink(0.5)
stipple(back, {pile=bush, width=2.2, coverage=4, pressure={0.4,0.7}, clip=back, cluster=0.3})
-- redraw trunks down to the ground, over the new shrubs
local rb = brush{kind="round", width=3.0, point=0.5}
for ti, t in ipairs(lime_trees) do
  if ti ~= 2 then
    rb:load(brD, 0.7)
    rb:stroke({{t.bx, t.by + 1}, {t.bx + 0.5, (t.by + t.fy)/2}, {t.fx, t.fy}}, {pressure={0.9, 0.8}})
  end
end
print(wait(0))
