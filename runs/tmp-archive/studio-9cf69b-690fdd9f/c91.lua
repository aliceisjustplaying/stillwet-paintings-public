local m = land * below({{-10,590},{1010,590}})
work(m, {hand="glaze", pile=glazeSoft, coverage=1.3, clip=true, angle=0, pressure={0.3,0.5}, load=0.5,
  load_at=function(x, y) return clamp((y - 600) / 110, 0, 1) * 0.65 + 0.03 end})
-- the drift pads at the fence feet sit in the same half-light
local pads = (ellipse(93, 643, 24, 7) + ellipse(152, 625, 20, 6) + ellipse(214, 608, 15, 5)) - postsM
work(pads, {hand="glaze", pile=glazeSoft, coverage=1.2, clip=true, angle=0, pressure={0.3,0.5}, load=0.6})
blend(m, {angle=0})
