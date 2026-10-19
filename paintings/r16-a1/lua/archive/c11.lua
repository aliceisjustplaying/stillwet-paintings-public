local function band(a, b) return below(function(x) return a end) * above(function(x) return b end) end
stipple(band(-10,150), {pile=sA, width=7, coverage=function(x,y) return 1.4*clamp((170-y)/120,0,1) end, pressure={0.3,0.5}, feather=0.5})
stipple(band(120,260), {pile=sB, width=7, coverage=function(x,y) return 0.9*clamp(1-math.abs(y-180)/80,0,1) end, pressure={0.3,0.5}, feather=0.5})
blend(band(-10,300)*skym, {angle=0})
