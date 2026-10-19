glow = mask(function(x,y)
  return clamp(1 - math.sqrt(((x-230)/430)^2 + ((y-360)/300)^2), 0, 1)
end):soften(80)
pglow = pile{{"lead white",3},{"yellow ochre",1},{"raw umber",1}}
work(glow * wallmask, {hand="broad", pile=pglow, clip=true, coverage=2, angle=0.05, load=0.7, seed=31})
blend((glow * wallmask):soften(60), {seed=32})
