-- a properly dark pile: all that raw umber in the old one kept it at mid value
g_dk2 = pile{{"bone black", 5}, {"raw umber", 1.5}}
-- clean ALL THREE regions of the zone: wall, cloth, bowl. The ghosts were surviving
-- above and left of the bowl because that part of the zone is neither cloth nor bowl.
rest = bowlzone * (-(CLOTH + BOWL:grow(2)))
for _, ang in ipairs{0.4, -0.6} do
  work(rest, {hand="body", tool="filbert 15", pile=g_wl, length={40, 110}, coverage=5, pressure=1,
       fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
  work(rest, {hand="body", tool="filbert 15", pile=g_dk2, length={40, 110}, coverage=3, pressure=1,
       fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
work(bowlzone * BOWL, {hand="body", tool="filbert 14", pile=g_bw, length={35, 95}, coverage=5,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.3, edge="soft"})
work(BOWL_IN, {hand="body", tool="filbert 12", pile=g_dk2, length={30, 80}, coverage=5,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:shrink(3)):soften(3), {angle=0.4})
work(BOWL_IN * (ellipse(452, 464, 124, 48):blur(44)), {hand="body", tool="filbert 10", pile=g_bw,
     length={25, 60}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(452, 458, 142, 64):blur(55)), {hand="body", tool="filbert 9", pile=g_bl,
     length={22, 55}, coverage=3.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(742, 514, 118, 64):blur(60)), {hand="body", tool="filbert 9", pile=g_dk2,
     length={22, 55}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(462, 548, 155, 88):blur(72)), {hand="body", tool="filbert 12", pile=g_bl,
     length={30, 80}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(745, 574, 124, 94):blur(80)), {hand="body", tool="filbert 12", pile=g_dk2,
     length={30, 80}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:grow(2)):soften(4), {angle=0.4})
