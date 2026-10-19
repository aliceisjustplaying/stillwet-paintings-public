glazeM = land * below({{-10,528},{1010,528}})
work(glazeM, {hand="glaze", pile=glazeSoft, coverage=1.3, clip=true, angle=0, pressure={0.3,0.5}, load=0.5,
  load_at=function(x, y) return clamp((y - 535) / 150, 0, 1) * 0.6 + 0.04 end})
blend(glazeM, {angle=0})
