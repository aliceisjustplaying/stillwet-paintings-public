local lights = (oakF:lit{soft=0.15}:map(function(v) return smoothstep(0.6, 0.9, v) end)) * crownF:lit{soft=0.3} * oakSil:shrink(2)
local lt = pile{{"yellow ochre",2},{"chrome yellow",0.5},{"Prussian blue",0.18},{"lead white",1.6}, medium=0.03}
stipple(lights, {pile=lt, width=1.5, coverage=0.55, pressure={0.35,0.75}, drag={1.0,-1.0}, twist=0.5, cluster={0.7,4}, feather=0.8, seed=1111})
