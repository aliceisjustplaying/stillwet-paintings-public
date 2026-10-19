-- the scumble spread warm and wide: cool it back into the snowfield while it is wet
coolSnow = pile{{"lead white",3},{"smalt",1.2},{"pale smalt",1},{"bone black",0.12},{"red earth",0.05}, medium=0.5}
local sm = poly({{484, 458}, {560, 452}, {650, 460}, {676, 484}, {656, 500}, {560, 496}, {488, 486}}, true):soften(4)
local pm = sm - ellipse(0,0,1,1)
work(sm, {hand="glaze", tool={kind="filbert", width=8}, pile=coolSnow, load=0.35, pressure={0.3, 0.45}, coverage=1.5, angle=0.02, clip=true,
  load_at=function(x, y) return 0.15 + 0.35 * smoothstep(455, 495, y) end})
blend(sm:grow(6), {angle=0})
