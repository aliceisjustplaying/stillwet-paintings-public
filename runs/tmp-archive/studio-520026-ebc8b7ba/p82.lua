groupm = BOWL
for _, a in ipairs(AP) do groupm = groupm + ashape(a) end
-- a warm glaze over the whole group, so the fruit and the bowl sit in the same air
g_warm = pile{{"raw umber", 2}, {"red earth", 1.2}, {"yellow ochre", 0.7}, {"lead white", 0.4}}
work(groupm:grow(2), {hand="glaze", tool="filbert 26", pile=g_warm, length={120, 280},
     coverage=0.9, pressure={0.5, 0.3}, angle=0.4, edge="soft"})
-- a cool glaze in the room's corners, which is what makes the darks read as air
g_cool = pile{{"bone black", 3}, {"pale smalt", 1.2}}
work(ellipse(960, 400, 380, 300):blur(190), {hand="glaze", pile=g_cool, coverage=1.6})
work(ellipse(120, 780, 330, 220):blur(170), {hand="glaze", pile=g_cool, coverage=1.4})
work(everywhere() * (ellipse(500, 40, 700, 180):blur(140)), {hand="glaze", pile=g_cool, coverage=1.0})
-- crisp accents last: the bowl's rim, its contact on the cloth, and the two near fruit
local rb = brush{kind="filbert", width=5, point=0.75}
rb:load(g_bl, 0.95)
rb:stroke(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 3.36, 5.55, 24),
  {pressure={0.9, 0.12}, ramps={0.06, 0.3}, orient="across", swell={1, 1.1, 0.7}, clip=BOWL:grow(2)})
rb:wipe(0.92); rb:load(g_dk2, 0.85)
rb:stroke({{418, 560}, {500, 596}, {590, 606}, {676, 596}, {748, 566}},
  {pressure={0.5, 0.8}, ramps={0.1, 0.25}, orient="across", clip=BOWL:grow(2)})
-- a small light on the two fruit nearest the eye
local hb = brush{kind="filbert", width=9, point=0.8}
for _, a in ipairs{AP[4], AP[5]} do
  hb:load(a.k == "g" and g_hg or g_hl, 0.7)
  hb:touch(a.cx + LX*a.r*0.55, a.cy + LY*a.r*0.55, {pressure=0.42, clip=ashape(a)})
end
