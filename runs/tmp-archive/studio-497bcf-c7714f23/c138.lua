local pts = {{-5,462}}
for x = -5, 205, 4 do
  local top = 447 + 3*math.sin(x/13) + 2*math.sin(x/5.3)
  if x > 150 then top = top + (x - 150) * 0.12 end
  pts[#pts+1] = {x, top}
end
pts[#pts+1] = {205, 462}
local yard = poly(pts, true):roughen(1.2, 4, 201) - roof:grow(0.3) - walls:grow(0.3)
stipple(yard, {pile=bush, width=2.2, coverage=4, pressure={0.4,0.7}, clip=yard, cluster=0.3})
stipple(yard * mask(function(x,y) return 1 end) - yard:shrink(2), {pile=tM2, width=1.6, coverage=0.8, pressure={0.35,0.55}, clip=yard, cluster={0.6,4}, feather=0.6})
-- trunks over it
local rb = brush{kind="round", width=2.6, point=0.5}
for ti, t in ipairs(lime_trees) do
  rb:load(brD, 0.7)
  rb:stroke({{t.bx, t.by - 8}, {t.fx, t.fy}}, {pressure={0.85, 0.75}})
end
-- house details: windows, a door, chimney, the ridge line
local win = pile{{"raw umber", 1}, {"bone black", 0.5}, {"pale smalt", 0.6}, {"lead white", 0.5}, medium=0.08}
for _, x in ipairs({76, 88, 104, 118, 134, 148}) do
  work(rect(x, 464.2, 2.6, 2.8), {hand="detail", pile=win, coverage=3, length={1,2}, fill=true, clip=true, edge="found"})
end
work(rect(96, 463.5, 3, 6.3), {hand="detail", pile=win, coverage=3, length={1,2}, fill=true, clip=true, edge="found"})
local ch = pile{{"red earth", 1.2}, {"lead white", 1}, {"raw umber", 0.5}, {"pale smalt", 0.4}, medium=0.08}
work(rect(112, 441.5, 3.2, 5), {hand="detail", pile=ch, coverage=3, length={1,2}, fill=true, clip=true, edge="found"})
local r = brush{kind="round", width=0.9, point=0.8}
r:load(thatchL, 0.4)
r:stroke({{69,447.3},{149,445.3}}, {pressure={0.4,0.35}})
-- smoke from the chimney, a thin pale drift to the right
local sm = pile{{"lead white", 5}, {"pale smalt", 0.8}, {"raw umber", 0.15}, medium=0.3}
local s = brush{kind="round", width=2.2, point=0.5}
s:load(sm, 0.25)
s:stroke({{113.6,441},{115,436},{119,431},{126,428},{136,426}}, {pressure={0.3,0.05}, ramps={0.1,0.6}})
print(wait(0))
