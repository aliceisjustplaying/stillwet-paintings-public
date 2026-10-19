p_bo_lit = pile{{"yellow ochre", 5}, {"red earth", 2}, {"lead white", 2.5}}
p_bo_mid = pile{{"yellow ochre", 3.5}, {"red earth", 3}, {"raw umber", 1.2}, {"bone black", 0.5}}
p_bo_sh  = pile{{"red earth", 2.5}, {"raw umber", 2}, {"bone black", 1.2}}
p_bo_dk  = pile{{"raw umber", 1.5}, {"bone black", 2.5}, {"Prussian blue", 0.5}, {"lead white", 0.2}}
p_bo_rf  = pile{{"lead white", 2}, {"yellow ochre", 2}, {"red earth", 0.8}}

-- bury the chart rectangle with a pass that feathers well past it
tline = function(x) return 468 - 0.04*x end
work(below(tline) * (rect(700,560,300,240):soften(90) + rect(786,634,214,166)) * -cloth_r,
     {pile=p_tbl, hand="broad", coverage=2.8, fill=true, load=1.0, pressure={1.0,0.9},
      dips={1,1.0,0.0}, angle=0.2, clip=true})

-- the bowl's shadow on the cloth, to the lower right
R = function(pts, w, s) return ribbon(pts, w):soften(s) end
work(R({{500,628},{640,668},{772,706}}, 96, 44)*cloth_r, {pile=p_bo_dk, tool="filbert 20",
     length={50,100}, coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(R({{528,632},{636,662}}, 42, 20)*cloth_r, {pile=p_bo_dk, tool="filbert 12",
     length={30,64}, coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.4, clip=true})

-- the bowl itself: a silhouette from a stack of ellipses, then modelled
sil = ellipse(580,500,200,64) + ellipse(580,545,196,62) + ellipse(580,585,165,54) +
      ellipse(580,612,120,40) + ellipse(580,624,66,22)
bowl = sil:blur(4):roughen(4, 60, 3)
inner = ellipse(580, 500, 186, 56):roughen(3, 50, 5)
rim   = (ellipse(580,500,200,64):blur(2) - inner)
wall  = bowl - inner

work(bowl, {pile=p_bo_mid, tool="filbert 20", length={40,90}, coverage=2.6, fill=true,
     load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
-- the inside of the bowl is in shadow, deepest at the back
work(inner, {pile=p_bo_sh, tool="filbert 16", length={40,90}, coverage=1.9, fill=true,
     load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(ellipse(580, 470, 170, 44):soften(30), {pile=p_bo_dk, tool="filbert 16", length={30,64},
     coverage=1.5, fill=true, load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, clip=true})
-- the outside: lit from the upper left, dark to the right and under
work(wall * ellipse(430, 520, 190, 150):soften(70), {pile=p_bo_lit, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.6, clip=true})
work(wall * ellipse(700, 590, 200, 130):soften(80), {pile=p_bo_sh, tool="filbert 16",
     length={40,90}, coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.6, clip=true})
work(bowl * below(600):soften(24), {pile=p_bo_dk, tool="filbert 16", length={30,64},
     coverage=1.4, fill=true, load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, angle=1.2, clip=true})
blend(bowl:soften(6), {angle=0.5})
print("bowl", wait(0))
