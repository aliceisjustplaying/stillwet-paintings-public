-- a thin waxing crescent low over the afterglow, its lit limb toward the set sun (down and left)
local mx, my, r = 268, 214, 6.2
local lit = ellipse(mx, my, r, r) - ellipse(mx + 2.0, my - 1.7, r * 1.0, r * 1.0)
work(lit, {hand="detail", tool="round 0.8", length={1, 3}, coverage=4, medium=0.12, aim="masstone", color="#f1ead0", edge={found=0.7, soft=0.3, period=8, seed=4}})
local halo = ellipse(mx, my, r * 3.2, r * 3.2):blur(r * 1.2)
glaze(halo - ellipse(mx, my, r, r), {color="#e9e2cc", coats=0.06, pigment="semi"})
