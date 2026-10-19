wfree = wallmask - objall
wm_dark = mask(function(x,y)
  return clamp(0.15 + 0.85*(1 - y/455) + 0.45*(x/1000), 0, 1)
end):soften(85) * wfree
work(wm_dark, {hand="broad", pile=pwall4, clip=true, coverage=2.4, angle=0.1, seed=681})
blend((wm_dark + (wfree - wm_dark)):soften(20) * wfree, {seed=682, coverage=1.0, pressure={0.28,0.28}})
