-- the oak nearly in silhouette against the glow: stout wood as body paint (its foot stops at the snow),
-- a faint lit flank toward the west, then the limbs thick to thin, all dark
footcut = above(function(x) return 553 + 2 * crestn(x, 5) end)
local thick = oak:wood(3.5) * footcut
work(thick, {hand="body", tool="round 2", length={4, 12}, coverage=3.5, angle=1.5, clip=thick, color="#342e29", medium=0.15})
local stout = oak:wood(7) * footcut
work(stout * mask(function(x, y) return 1 - stout:at(x - 2.2, y + 0.6) end),
     {hand="body", tool="round 1.4", coverage=1.6, angle=1.5, clip=thick, color="#50473f", medium=0.15})
oak:paint_wood(brush("round", 2.4), {color="#37302a", min=1.2, max=3.5})
oak:paint_wood(brush("rigger", 0.9), {color="#3b342e", min=0.5, max=1.2, every=2})
oak:paint_wood(brush("rigger", 0.55), {color="#48413c", max=0.5, pressure=0.04, every=2})
