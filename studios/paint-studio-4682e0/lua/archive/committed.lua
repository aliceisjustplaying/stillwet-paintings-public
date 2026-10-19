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
function zarms(dx, trim)
  local up = trim and ribbon(T({{668,337},{646,332.5},{626,324},{608,320}}, dx), {14,11,10,9})
                   or ribbon(T({{668,334},{646,330},{626,323},{608,320}}, dx), {16,13,11,9})
  local a = up
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
function leafRm(dx)
  return poly(T({{790,311},{778,313},{766,317},{754,322},{742,327},{730,330},{722,331},{722,500},{790,496}}, dx))
end
function door(dx) return rect(590 + dx, 210, 200, 350) end
function footN(dx)
  return poly(T({{726,541},{739,543},{741,550},{732,556},{721,561},{712,562},{714,557},{722,550}}, dx), true)
end
-- F: skull-like profile, flatter crown, brow ridge, long angular hanging jaw, neck slanting back to the hump
function headF2(dx, char, amount, seed)
  return outline{pts=T({
  {650, 274}, {662, 271}, {674, 273}, {682, 279}, {686, 289}, {684, 300}, {680, 308}, {686, 320}, {694, 334, "c"},
  {684, 346, "c"}, {666, 350, "c"}, {663, 334}, {660, 322}, {662, 314, "c"}, {648, 320}, {645, 319, "c"}, {643, 313, "c"},
  {652, 306, "c"}, {642, 303, "c"}, {641, 300}, {637, 297, "c"}, {641, 293}, {643, 290, "c"}, {639, 286, "c"},
  {642, 279}}, dx), char=char or "firm", amount=amount or 0.3, seed=seed or 67}:mask()
end
-- G: same, head dropped forward a little (lower, more lurching), jaw hanging further
function headG(dx)
  return outline{pts=T({
  {646, 278}, {658, 274}, {671, 275}, {680, 281}, {685, 291}, {683, 302}, {679, 309}, {686, 321}, {694, 334, "c"},
  {684, 346, "c"}, {666, 350, "c"}, {662, 334}, {658, 323}, {659, 316, "c"}, {645, 322}, {641, 321, "c"}, {639, 315, "c"},
  {649, 309, "c"}, {638, 306, "c"}, {636, 303}, {632, 300, "c"}, {636, 296}, {638, 293, "c"}, {634, 289, "c"},
  {638, 282}}, dx), char="broken", amount=0.45, seed=69}:mask()
end
local variants = {
  {dx=-580, head=function(dx) return headF2(dx) end},
  {dx=-370, head=function(dx) return headF2(dx, "broken", 0.5, 71) end},
  {dx=-160, head=headG},
}
work(rect(0, 150, 1000, 470), {hand="body", pile=wallS, coverage=2, fill=true, clip=true, angle=0})
for _, v in ipairs(variants) do
  local dx = v.dx
  local fig = zbody(dx, footN(dx)) + zarms(dx, true) + zflaps(dx) + v.head(dx)
  local lf = leafRm(dx)
  local light = door(dx) - fig - lf
  work(light, {hand="body", tool={kind="filbert", width=8}, pile=creamS, coverage=2.5, fill=true, clip=light, angle=1.57})
  work(lf * door(dx), {hand="body", pile=wallS, coverage=2, fill=true, clip=lf * door(dx), angle=1.57})
  work(fig, {hand="detail", tool={kind="round", width=2.5}, pile=zombS, coverage=4, fill=true, clip=fig, angle=0.5, length={3, 9}})
end
-- hair tufts on the middle and right variants (rigger)
local b = brush{kind="rigger", width=1.6, point=0.9}
for _, dx in ipairs({-370, -160}) do
  local tufts = {
    {{676, 278, 0.6}, {684, 276, 0.4}, {690, 279, 0.0}},
    {{681, 285, 0.6}, {688, 287, 0.35}, {693, 292, 0.0}},
    {{683, 292, 0.6}, {690, 297, 0.3}, {692, 304, 0.0}},
    {{682, 299, 0.6}, {687, 306, 0.3}, {688, 313, 0.0}},
    {{668, 273, 0.5}, {675, 269, 0.3}, {681, 269.5, 0.0}},
  }
  b:load(zombS, 0.6)
  for i, t in ipairs(tufts) do b:gesture(T(t, dx), {wobble=0.6}); if i % 3 == 0 then b:load(zombS, 0.6) end end
end

--@ chunk 3
print(wait(15 * 24 * 60))
print(drying(500, 320), drying(500, 230), drying(560, 400))

--@ chunk 4
local function figOf(dx, head)
  return zbody(dx, footN(dx)) + zarms(dx, true) + zflaps(dx) + head(dx)
end
-- G (dx=-160): lose() dragging cream in from outside
local dx = -160
local figG = figOf(dx, headG)
local whereG = (ellipse(668 + dx, 282, 22, 14) + ellipse(728 + dx, 360, 10, 26) + ellipse(700 + dx, 335, 14, 7)):blur(4)
local n = lose(figG, {pile=creamS, where=whereG, tool="filbert 3", reach={3, 6}, load=0.25, seed=5})
print("lose strokes", n)
-- F broken (dx=-370): feathered stipple of cream over the edge
dx = -370
local figF = figOf(dx, function(d) return headF2(d, "broken", 0.5, 71) end)
local whereF = (ellipse(668 + dx, 280, 22, 14) + ellipse(728 + dx, 360, 10, 26) + ellipse(700 + dx, 335, 14, 7)):blur(4)
local eat = ((-figF):blur(4)) * figF * whereF
stipple(eat:grow(0.5), {pile=creamS, width=3, coverage=function(x, y) return 3.5 * eat:at(x, y) end, feather=1, pressure={0.2, 0.5}, dips={25, 0.4, 0}})

--@ chunk 5
local dx = -370
local hd = headF2(dx, "broken", 0.5, 71)
local fig = zbody(dx, footN(dx)) + zarms(dx, true) + zflaps(dx) + hd
local edgeBand = (fig:grow(5) - fig:shrink(5)) * rect(620 + dx, 262, 80, 80)
work(edgeBand - fig, {hand="detail", tool={kind="round", width=2.5}, pile=creamS, coverage=4, fill=true, clip=edgeBand - fig, angle=1.57, length={3, 8}})
work(edgeBand * fig, {hand="detail", tool={kind="round", width=2.5}, pile=zombS, coverage=4, fill=true, clip=edgeBand * fig, angle=0.5, length={3, 8}})
-- lose the edge at the crown/back of the skull: blend across the contour
local where = (ellipse(670 + dx, 280, 20, 12) + ellipse(686 + dx, 296, 8, 12)):blur(3)
local lostZone = (fig:grow(3) - fig:shrink(3)) * where
work(lostZone, {hand="blend", tool={kind="badger", width=5}, coverage=2, angle=function(x, y) return 1.2 end})
print(drying(668 + dx, 276))

--@ chunk 6
local dx = -160
local fig = zbody(dx, footN(dx)) + zarms(dx, true) + zflaps(dx) + headG(dx)
local soft = (-fig):blur(3)
local where = (ellipse(666 + dx, 282, 22, 13) + ellipse(684 + dx, 296, 9, 12) + ellipse(728 + dx, 362, 9, 26) + ellipse(705 + dx, 336, 14, 6)):blur(3)
local zone = (fig - fig:shrink(6)) * where
-- first restate the cream outside where the lose() flecks were
local outZ = (fig:grow(5) - fig) * where
work(outZ, {hand="detail", tool={kind="round", width=2.5}, pile=creamS, coverage=4, fill=true, clip=outZ, angle=1.57, length={3, 8}})
work(zone, {hand="detail", tool={kind="round", width=2}, piles={{creamS, function(x, y) return math.min(1, 1.6 * soft:at(x, y)) end}, {zombS, function(x, y) return 1 - math.min(1, 1.6 * soft:at(x, y)) end}}, coverage=5, fill=true, clip=zone, angle=0.5, length={2, 6}})

--@ chunk 7
local dx = -370
local hd = headF2(dx, "broken", 0.5, 71)
local fig = zbody(dx, footN(dx)) + zarms(dx, true) + zflaps(dx) + hd
local where = (ellipse(728 + dx, 365, 9, 30) + ellipse(708 + dx, 337, 14, 6)):blur(3)
local band = (fig:grow(5) - fig:shrink(5)) * where
work(band - fig, {hand="detail", tool={kind="round", width=2.5}, pile=creamS, coverage=4, fill=true, clip=band - fig, angle=1.57, length={3, 8}})
work(band * fig, {hand="detail", tool={kind="round", width=2.5}, pile=zombS, coverage=4, fill=true, clip=band * fig, angle=0.5, length={3, 8}})
local lostZone = (fig:grow(2.5) - fig:shrink(3.5)) * where
-- one light pass along the contour (vertical on the back), not across it
work(lostZone, {hand="blend", tool={kind="badger", width=4}, coverage=1.5, angle=1.57})

--@ chunk 8
print(wait(10 * 24 * 60))
print(drying(300, 280), drying(358, 360))

--@ chunk 9
-- no marks: just read values along a horizontal line across the shoulder halo of variant F
for x = 352, 372, 2 do
  print(x, 365)
end

--@ chunk 10
skyS = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}, name="sky"}
streetS = pile{{"lead white", 5}, {"Naples yellow", 1.6}, {"yellow ochre", 0.35}, name="street"}
deepS = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.4}, turps=0.3, name="deep"}
local x0 = 650
local sets = {
  {"fac", {{creamS, 1}, {creamS, 1}}},
  {"sky", {{skyS, 1}, {skyS, 1}}},
  {"fac+sky", {{creamS, 1}, {skyS, 1}}},
  {"street", {{streetS, 1}, {streetS, 1}}},
  {"fac+street", {{creamS, 1}, {streetS, 0.6}}},
}
for i, s in ipairs(sets) do
  local m = rect(x0 + (i - 1) * 68, 230, 60, 60)
  work(m, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles=s[2], coverage=2.5, fill=true, clip=m, angle=1.57})
  local m2 = rect(x0 + (i - 1) * 68, 300, 60, 60)
  work(m2, {hand="detail", tool={kind="round", width=2.5, lay=2.5}, piles=s[2], coverage=5, fill=true, clip=m2, angle=1.57, length={3, 8}})
end
print(wait(15 * 24 * 60))

--@ chunk 11
print("use probe")

--@ chunk 12
function headNewF(dx) return headF2(dx, "broken", 0.5, 71) end
function oldFootM(dx) return poly(T({{725,545},{743,548},{741,558},{723,557}}, dx), true) end
-- the whole doorway campaign as one function: dx shift, door mask, piles table, current shapes
function redoDoor(dx, o)
  local P = o.piles
  local hd = headNewF(dx)
  local ft = footN(dx)
  local bodyKeep = o.body * mask(function(x, y) return (y > 344 or (x > 686 + dx and y > 326)) and 1 or 0 end) - oldFootM(dx):grow(2)
  local keep = bodyKeep + o.arms + o.flaps + hd + ft
  local zone = o.door * (rect(588 + dx, 210, 118, 272) + rect(704 + dx, 532, 50, 28)) - o.leafSl
  local L = zone - keep
  local function wTop(x, y) return 1 - smoothstep(446, 458, y) end
  local function wBot(x, y) return smoothstep(446, 458, y) end
  -- 1. door light, laid as the door was: vertical filbert strokes, thick
  work(L, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles={{P.sky, wTop}, {P.fac, wTop}, {P.street, wBot}}, coverage=2.5, fill=true, clip=L, angle=1.57, angle_jitter=0.15, length={10, 26}})
  -- 2. a second, small-brush pass where dark lay before (old head, tufts, old toe)
  local wasDark = L * (rect(628 + dx, 266, 72, 88) + rect(704 + dx, 532, 50, 28))
  work(wasDark, {hand="detail", tool={kind="round", width=2.5, lay=2.5}, piles={{P.sky, wTop}, {P.fac, wTop}, {P.street, wBot}}, coverage=5, fill=true, clip=wasDark, angle=1.57, length={3, 8}})
  -- 3. the new head and the trailing foot, dark, into the wet light
  local dk = hd + ft
  work(dk, {hand="detail", tool={kind="round", width=2.5}, piles={{P.zomb, 1}, {P.deep, 0.4}}, coverage=5, fill=true, clip=dk, angle=0.5, angle_jitter=0.4, length={3, 9}})
  -- 4. lose the crown into the light: one light blend along the contour
  local where = (ellipse(664 + dx, 276, 22, 9) + ellipse(684 + dx, 292, 7, 12)):blur(3)
  local lostZone = (hd:grow(2.5) - hd:shrink(3.5)) * where
  work(lostZone, {hand="blend", tool={kind="badger", width=4}, coverage=1.5, angle=function(x, y) return math.atan(y - 300, x - (664 + dx)) + math.pi / 2 end})
  -- 5. a few hair tufts
  local b = brush{kind="rigger", width=1.6, point=0.9}
  local tufts = {
    {{676, 278, 0.6}, {684, 276, 0.4}, {690, 279, 0.0}},
    {{681, 285, 0.6}, {688, 287, 0.35}, {693, 292, 0.0}},
    {{683, 292, 0.6}, {690, 297, 0.3}, {692, 304, 0.0}},
    {{682, 299, 0.6}, {687, 306, 0.3}, {688, 313, 0.0}},
    {{668, 273, 0.5}, {675, 269, 0.3}, {681, 269.5, 0.0}},
  }
  b:load(P.zomb, 0.6)
  for i, t in ipairs(tufts) do b:gesture(T(t, dx), {wobble=0.6}); if i % 3 == 0 then b:load(P.zomb, 0.6) end end
  return L, hd
end
local dx = -580
local Ls = redoDoor(dx, {piles={sky=skyS, fac=creamS, street=streetS, zomb=zombS, deep=deepS},
  body=zbody(dx, nil), arms=zarms(dx, false), flaps=zflaps(dx), door=door(dx), leafSl=rect(588 + dx, 388, 11, 120)})
print(Ls:area())

--@ chunk 13
kT = knife{width=20}
-- swatch 1 (fac, filbert lay 2.5, dry): knife-lay fac over the top half, light pressure
kT:load(creamS, 0.8)
kT:lay({{670, 232}, {670, 258}}, {pressure={0.5, 0.5}, angle=0})
kT:load(creamS, 0.8)
kT:lay({{690, 232}, {690, 258}}, {pressure={0.5, 0.5}, angle=0})
-- swatch 2 (sky): harder pressure
kT:wipe()
kT:load(skyS, 0.8)
kT:lay({{738, 232}, {738, 258}}, {pressure={0.9, 0.9}, angle=0})
kT:load(skyS, 0.8)
kT:lay({{758, 232}, {758, 258}}, {pressure={0.9, 0.9}, angle=0})
print(wait(20 * 24 * 60))
