shrub = outline{{380,472,"c"},{384,450},{398,440},{414,437},{430,436},{446,434},{458,437},{470,440},{482,446},{492,455},{496,464},{498,471,"c"},{440,473}, closed=true, char="soft", seed=241, lobe=6, amount=1.1}
shrubM = shrub:mask()
work(shrubM, {hand="body", tool="filbert 5", pile=pUnder, angle=function(x,y) return 0.6*math.sin(x/12) end, angle_jitter=0.6, coverage=3.8, load=0.95, fill=true, length={8,20}, clip=shrubM:grow(1)})
stipple((shrubM:grow(4) - shrubM) * above(function(x) return 462 end), {pile=pUnder, width=3, coverage=0.8, pressure={0.5,0.9}, dips={12,0.9,0.2}, drag={1.5,0.6}, twist=0.6, cluster={0.6,3}, feather=0.4})
