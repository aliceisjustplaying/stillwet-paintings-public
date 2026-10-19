p_bo2_lit = pile{{"yellow ochre", 3.5}, {"red earth", 2}, {"lead white", 2.5}, {"raw umber", 0.8}}
p_bo2_mid = pile{{"yellow ochre", 3}, {"red earth", 3}, {"raw umber", 2}, {"bone black", 0.5}}
p_bo2_sh  = pile{{"red earth", 2}, {"raw umber", 2.5}, {"bone black", 1}, {"cobalt blue", 0.3}}
p_bo2_dk  = pile{{"raw umber", 1.5}, {"bone black", 2.5}, {"Prussian blue", 0.4}}

tline = function(x) return 468 - 0.04*x end
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

-- the chart rectangle, feathered well past its edges this time
work(below(tline) * rect(690, 520, 310, 280):soften(110) * -cloth_r,
     {pile=p_tbl, hand="broad", coverage=2.8, fill=true, load=1.0, pressure={1.0,0.9},
      dips={1,1.0,0.0}, angle=0.2, clip=true})

rim_o  = ellipse(580, 500, 200, 64)
skirt  = poly({{380,500},{384,528},{398,558},{422,582},{456,600},{500,614},{542,622},
               {580,626},{618,622},{660,614},{704,600},{738,582},{762,558},{776,528},{780,500}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
inner  = ellipse(580, 500, 184, 54):roughen(2, 45, 11)
wall   = bowl - inner

work(bowl, {pile=p_bo2_mid, tool="filbert 20", length={40,90}, coverage=2.8, fill=true,
     load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.4, clip=true})
-- the inside: dark, deepest at the back
work(inner, {pile=p_bo2_sh, tool="filbert 16", length={40,90}, coverage=2.2, fill=true,
     load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, angle=0.2, clip=true})
work(inner * ellipse(580, 462, 168, 40):soften(26), {pile=p_bo2_dk, tool="filbert 16",
     length={30,64}, coverage=1.8, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, clip=true})
-- the outside: the light comes over the left shoulder and dies on the right
work(wall * ellipse(420, 545, 170, 145):soften(66), {pile=p_bo2_lit, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(716, 588, 175, 125):soften(70), {pile=p_bo2_sh, tool="filbert 16",
     length={40,90}, coverage=1.9, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(bowl * below(function() return 596 end):soften(22), {pile=p_bo2_dk, tool="filbert 16",
     length={30,64}, coverage=1.5, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
-- the rim: the brightest band, running round the front
work((rim_o - inner) * below(function(x) return 508 - 0.0*(x-580) end):soften(14),
     {pile=p_bo2_lit, tool="filbert 12", length={30,64}, coverage=1.7, fill=true, load=1.0,
      pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.25, clip=true})
blend(bowl:soften(5), {angle=0.4})
print("bowl 2", wait(0))
