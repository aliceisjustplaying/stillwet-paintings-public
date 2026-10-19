-- bring the new drift down into the field: glaze its face, keep its crest
local mound = poly({{130, 490}, {142, 460}, {178, 444}, {205, 440}, {290, 440}, {336, 450}, {360, 468}, {352, 490}, {300, 496}, {220, 496}}, true):soften(6)
local m = mound - oakLive:grow(0.5) - fallenM:grow(1)
work(m, {hand="glaze", tool={kind="filbert", width=14}, pile=duskLand, angle=0.03, clip=true,
  load_at=function(x, y) return 0.12 + 0.4 * smoothstep(450, 488, y) end, pressure={0.3, 0.45}, coverage=1.8, seed=1111})
