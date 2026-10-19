clothpts2 = {{-12, 594}, {100, 556}, {220, 534}, {350, 526}, {480, 532}, {610, 540},
             {730, 533}, {860, 546}, {1012, 588}, {1012, 812}, {-12, 812}}
CLOTH = poly(clothpts2, true):soften(2.5)
print(string.format("cloth area %.0f of %.0f", CLOTH:area(), everywhere():area()))
-- lay the cloth in: a warm mid tone first, opaque, so everything after sits on solid paint
work(CLOTH, {hand="broad", tool="filbert 24", pile=g_cm, length={110, 250},
             coverage=3.5, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.15, edge="soft"})
