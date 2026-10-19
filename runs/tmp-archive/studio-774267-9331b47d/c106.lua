local dk = pile{{"smalt", 0.8}, {"raw umber", 0.8}, {"bone black", 0.3}, {"lead white", 0.35}, medium=0.1}
local lt = pile{{"lead white", 2.2}, {"yellow ochre", 0.3}, {"red earth", 0.12}, {"pale smalt", 0.4}, medium=0.1}
local f = brush{kind="round", width=0.5, point=1, stiffness=0.4}
-- finials: a thin rod with a ball and a vane on each spire tip
for _,t in ipairs(TW) do
  f:load(dk, 0.35)
  f:stroke({{t.x, t.top + 0.5}, {t.x, t.top - 4.5}}, {pressure={0.3, 0.25}})
  f:touch(t.x, t.top - 2, {pressure=0.35})
  f:stroke({{t.x - 1.2, t.top - 3.6}, {t.x + 1.2, t.top - 3.6}}, {pressure={0.2, 0.2}})
end
-- eaves and ridges of the naves: dark eave line, light along the west hip
for _,nv in ipairs({{606,652,13,12},{675,716,14,13},{731,764,10,9}}) do
  local by = math.max(far(nv[1]) + 1.5, far(nv[2]) + 1.5)
  local ey = by - nv[3]
  f:load(dk, 0.4)
  f:stroke({{nv[1] + 0.3, ey + 0.4}, {nv[2] - 0.3, ey + 0.4}}, {pressure={0.3, 0.3}})
  f:load(lt, 0.35)
  f:stroke({{nv[1] + 0.4, ey - 0.3}, {nv[1] + 1.6, ey - nv[4] + 0.5}}, {pressure={0.35, 0.2}})
  f:stroke({{nv[1] + 1.8, ey - nv[4] + 0.4}, {nv[2] - 1.8, ey - nv[4] + 0.4}}, {pressure={0.18, 0.12}})
end
