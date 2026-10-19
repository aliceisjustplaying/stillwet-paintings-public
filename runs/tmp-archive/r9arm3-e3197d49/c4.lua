-- a second lay-in wet into the first: shorter sweeps, fuller loads, to close the gaps
work(skym, {hand="broad", color=skycol, angle=function(x, y) return 0.03 * bands(x * 0.3, y + 40) end,
  length={60, 170}, coverage=3.5, medium=0.3, load=1})
blend(skym, {angle=0.01})
