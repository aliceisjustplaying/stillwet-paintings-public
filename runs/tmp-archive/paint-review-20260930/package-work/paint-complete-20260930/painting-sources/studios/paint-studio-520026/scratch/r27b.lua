tline = function(x) return 468 - 0.04*x end
R = function(pts, w, s) return ribbon(pts, w):soften(s) end
sil = ellipse(580,500,200,64) + ellipse(580,545,196,62) + ellipse(580,585,165,54) +
      ellipse(580,612,120,40) + ellipse(580,624,66,22)
bowl = sil:blur(4):roughen(4, 60, 3)
inner = ellipse(580, 500, 186, 56):roughen(3, 50, 5)
rim   = (ellipse(580,500,200,64):blur(2) - inner)
wall  = bowl - inner
print("geoms ok", bowl, wall, rim)
work(below(tline) * (rect(700,560,300,240):soften(90) + rect(786,634,214,166)) * -cloth_r,
     {pile=p_tbl, hand="broad", coverage=2.8, fill=true, load=1.0, pressure={1.0,0.9},
      dips={1,1.0,0.0}, angle=0.2, clip=true})
work(R({{500,628},{640,668},{772,706}}, 96, 44)*cloth_r, {pile=p_bo_dk, tool="filbert 20",
     length={50,100}, coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(R({{528,632},{636,662}}, 42, 20)*cloth_r, {pile=p_bo_dk, tool="filbert 12",
     length={30,64}, coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
print("shadow ok")
