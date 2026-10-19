print(wait(60*5))
local sailD = pile{{"red earth",1},{"raw umber",0.7},{"lead white",0.9},{"pale smalt",0.35}, medium=0.08}
local shade = boatSail * mask(function(x,y) return smoothstep(656, 662, x + (y-465)*0.08) end)
work(shade, {hand="detail", pile=sailD, tool={kind="round", width=1.0, point=0.4}, angle=math.pi/2, coverage=3, fill=true, clip=true, pressure={0.45,0.7}, seed=3711})
local dk = pile{{"raw umber",1},{"bone black",0.6},{"lead white",0.25}, medium=0.1}
local r = brush{kind="rigger", width=0.6, point=1}
r:reload(dk, 0.6)
r:stroke({{651,481},{651,465},{650.9,446}}, {pressure={0.55,0.3}})      -- mast
r:stroke({{651.2,452.6},{657,450.2},{663.8,447.4}}, {pressure={0.35,0.3}}) -- gaff
r:stroke({{651.4,479.3},{658,479.2},{665.4,479.1}}, {pressure={0.3,0.25}}) -- boom
r:reload(dk, 0.3)
r:stroke({{650.9,446.5},{646,462},{642.6,479.8}}, {pressure={0.12,0.12}}) -- forestay
