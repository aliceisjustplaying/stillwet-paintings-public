local mud = poly({{0,548},{300,545},{600,548},{606,580},{588,620},{578,667},{0,667}}, true)
local boat = poly({{180,540},{395,535},{395,615},{180,615}}, true):soften(6)
local grad = mask(function(x,y) return smoothstep(548,660,y) end)
local m = (mud - boat) * grad
local gl = pile{{"raw umber",2},{"bone black",0.5},{"smalt",0.3}, medium=0.7}
work(m, {hand="glaze", pile=gl, angle=function(x,y) return 0.03*math.sin(x/140) end, coverage=1.6, clip=true, pressure={0.2,0.35}})
