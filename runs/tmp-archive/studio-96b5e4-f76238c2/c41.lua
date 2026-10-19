wn1 = pile{{"lead white",2},{"cobalt blue",0.3},{"smalt",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, medium=0.1}
wn2 = pile{{"lead white",1.6},{"cobalt blue",0.4},{"smalt",0.5},{"raw umber",0.5}, medium=0.1}
local ang = function(x,y) return 0.03*math.sin(x/30+y/7) end
local A = creek * rect(0,548,1000,40)
local B = creek * below(function(x) return 585 + 4*math.sin(x/17) end)
local C = creek * below(function(x) return 645 + 5*math.sin(x/21) end)
work(A, {hand="body", pile=wn1, angle=ang, coverage=0.9, length={10,30}, tool={kind="flat", width=3.5, stiffness=0.5}, clip=creek, load=0.4, pressure={0.3,0.6}})
work(B, {hand="body", pile=wn1, angle=ang, coverage=2.4, length={15,40}, tool={kind="flat", width=5, stiffness=0.5}, fill=true, clip=creek, dips={3,0.8,0.3}, pressure={0.5,0.8}})
work(C, {hand="body", pile=wn2, angle=ang, coverage=2.4, length={18,45}, tool={kind="flat", width=6, stiffness=0.5}, fill=true, clip=creek, dips={3,0.8,0.3}, pressure={0.5,0.8}})
