-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 1}}, texture=0.25, um=70}, {apply="brush", pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25}}, linen={16, 14}, seed=1873, size=700}

--@ chunk 2
creamS = pile{{"lead white", 5}, {"Naples yellow", 1}, {"raw umber", 0.12}, {"ultramarine blue", 0.06}, name="cream"}
wallS = pile{{"raw umber", 0.56}, {"burnt sienna", 0.33}, {"bone black", 0.11}, name="wall"}
zombS = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zomb"}
function T(pts, dx, dy)
  local o = {}
  for i, p in ipairs(pts) do o[i] = {p[1] + dx, p[2] + (dy or 0), p[3]} end
  return o
end
function zbody(dx, footNew)
  local m = poly(T({{652,338},{668,334},{678,352},{658,356}}, dx))
   + poly(T({{648,352},{672,340},{705,334},{722,345},{730,372},{728,405},{724,440},{716,466},{706,458},{698,470},{688,460},{680,468},{676,432},{668,398},{655,374}}, dx), true)
   + ribbon(T({{688,455},{673,502},{665,560}}, dx), {22,16,12})
   + poly(T({{650,567},{668,556},{677,569},{654,574}}, dx), true)
   + ribbon(T({{706,455},{720,505},{732,548}}, dx), {20,15,11})
   + ribbon(T({{714,458},{719,478}}, dx), {6,2}) + ribbon(T({{694,464},{690,482}}, dx), {5,2})
  if footNew then m = m + footNew
  else m = m + poly(T({{725,545},{743,548},{741,558},{723,557}}, dx), true) end
  return m:roughen(2, 10, 9)
end
function zarms(dx)
  local a = ribbon(T({{668,334},{646,330},{626,323},{608,320}}, dx), {16,13,11,9})
   + ribbon(T({{672,352},{650,358},{628,362},{610,362}}, dx), {16,13,10,8})
   + ribbon(T({{610,318},{600,313}}, dx), {4,1.5}) + ribbon(T({{609,321},{599,321}}, dx), {4,1.5}) + ribbon(T({{609,324},{601,329}}, dx), {3.5,1.5})
   + ribbon(T({{611,360},{601,355}}, dx), {4,1.5}) + ribbon(T({{611,363},{600,363}}, dx), {4,1.5}) + ribbon(T({{611,366},{602,371}}, dx), {3.5,1.5})
  return a:roughen(1, 6, 13)
end
function zflaps(dx)
  return (poly(T({{668,440},{663,452},{661,466},{664,470},{667,458},{671,450}}, dx))
      + poly(T({{671,452},{669,470},{672,478},{674,466},{676,455}}, dx))
      + poly(T({{667,362},{659,366},{655,373},{660,372},{664,369},{668,368}}, dx))):roughen(0.8, 5, 61)
end
function headA(dx)
  return outline{pts=T({
  {664, 289}, {675, 292}, {683, 299}, {686, 309}, {684, 320}, {679, 329}, {678, 338}, {684, 346, "c"},
  {664, 350, "c"}, {661, 341}, {655, 342, "c"}, {646, 340, "c"}, {644, 333}, {646, 327, "c"},
  {652, 321, "c"}, {643, 316, "c"}, {644, 313, "c"}, {636, 311, "c"}, {642, 305, "c"}, {640, 302, "c"},
  {645, 296}, {652, 291}}, dx), char="firm", amount=0.3, seed=59}:mask()
end
function leafRm(dx)
  return poly(T({{790,311},{778,313},{766,317},{754,322},{742,327},{730,330},{722,331},{722,500},{790,496}}, dx))
end
function door(dx) return rect(590 + dx, 210, 200, 350) end
-- the dark room around all three doors
work(rect(0, 150, 1000, 470), {hand="body", pile=wallS, coverage=2, fill=true, clip=true, angle=0})
print(wait(60))

--@ chunk 3
function headB(dx)
  return outline{pts=T({
  {661, 281}, {672, 282}, {681, 288}, {686, 297}, {687, 307}, {684, 316}, {678, 323}, {677, 333}, {684, 346, "c"},
  {664, 350, "c"}, {662, 338}, {658, 326}, {656, 318, "c"}, {648, 317}, {643, 316, "c"}, {641, 312, "c"},
  {655, 306, "c"}, {640, 302, "c"}, {637, 300}, {633, 297, "c"}, {637, 293}, {636, 289, "c"},
  {642, 284}, {652, 281}}, dx), char="firm", amount=0.3, seed=59}:mask()
end
function headC(dx)
  return outline{pts=T({
  {666, 280}, {677, 284}, {684, 292}, {687, 302}, {685, 312}, {680, 320}, {677, 333}, {684, 346, "c"},
  {664, 350, "c"}, {662, 336}, {660, 322}, {657, 316, "c"}, {648, 314}, {642, 312, "c"}, {639, 305, "c"},
  {653, 298, "c"}, {640, 293, "c"}, {638, 290}, {636, 285, "c"}, {641, 283}, {644, 279, "c"},
  {650, 278}, {657, 278}}, dx), char="firm", amount=0.3, seed=61}:mask()
end
function footN(dx)
  return poly(T({{726,541},{739,543},{741,550},{732,556},{721,561},{712,562},{714,557},{722,550}}, dx), true)
end
local variants = {
  {dx=-580, head=headA, foot=nil},
  {dx=-370, head=headB, foot=footN},
  {dx=-160, head=headC, foot=footN},
}
for _, v in ipairs(variants) do
  local dx = v.dx
  local fig = zbody(dx, v.foot and v.foot(dx) or nil) + zarms(dx) + zflaps(dx) + v.head(dx)
  local lf = leafRm(dx)
  local light = door(dx) - fig - lf
  work(light, {hand="body", tool={kind="filbert", width=8}, pile=creamS, coverage=2.5, fill=true, clip=light, angle=1.57})
  work(lf * door(dx), {hand="body", pile=wallS, coverage=2, fill=true, clip=lf * door(dx), angle=1.57})
  work(fig, {hand="detail", tool={kind="round", width=2.5}, pile=zombS, coverage=4, fill=true, clip=fig, angle=0.5, length={3, 9}})
end
