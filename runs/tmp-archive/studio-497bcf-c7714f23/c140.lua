local fix = rect(104, 445, 14, 17) * roof
work(fix, {hand="detail", pile=thatch, angle=0, coverage=3, length={2,6}, fill=true, clip=true, edge="found"})
local chm = pile{{"red earth", 0.8}, {"lead white", 1.4}, {"raw umber", 0.6}, {"pale smalt", 0.7}, medium=0.08}
work(rect(112, 441.5, 3.2, 5), {hand="detail", pile=chm, coverage=3, length={1,2}, fill=true, clip=true, edge="found"})
local pts = {{-5,462}}
for x = -5, 205, 4 do
  local top = 449 + 3*math.sin(x/13) + 2*math.sin(x/5.3)
  if x > 150 then top = top + (x - 150) * 0.12 end
  pts[#pts+1] = {x, top}
end
pts[#pts+1] = {205, 462}
local yard = poly(pts, true):roughen(1.2, 4, 202) - roof:grow(0.3) - walls:grow(0.3) - lime_sil2
stipple(yard, {pile=hedgeD, width=2.0, coverage=3.5, pressure={0.4,0.7}, clip=yard, cluster=0.3})
print(wait(0))
