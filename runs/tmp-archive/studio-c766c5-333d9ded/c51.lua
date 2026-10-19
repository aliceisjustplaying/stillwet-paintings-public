wfree = wallmask - objall
wdark_top = mask(function(x,y) return clamp(1 - (y/455)*1.5, 0, 1) end):soften(90)
work(wdark_top * wfree, {hand="broad", pile=pwall4, clip=true, coverage=2.0, angle=0.1, seed=531})
pwlight2 = pile{{"lead white",2},{"yellow ochre",1.2},{"raw umber",1}}
wlight_low = mask(function(x,y) return clamp(1 - (455-y)/150, 0, 1) end):soften(60)
work(wlight_low * wfree, {hand="broad", pile=pwlight2, clip=true, coverage=1.7, angle=0.1, seed=532})
