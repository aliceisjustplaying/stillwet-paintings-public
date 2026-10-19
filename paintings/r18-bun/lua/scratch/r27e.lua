sil = ellipse(580,500,200,64) + ellipse(580,545,196,62) + ellipse(580,585,165,54) +
      ellipse(580,612,120,40) + ellipse(580,624,66,22)
bowl = sil:blur(4):roughen(4, 60, 3)
inner = ellipse(580, 500, 186, 56):roughen(3, 50, 5)
wall  = bowl - inner
work(wall * ellipse(430, 520, 190, 150):soften(70), {pile=p_bo_lit, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.6, clip=true})
work(wall * ellipse(700, 590, 200, 130):soften(80), {pile=p_bo_sh, tool="filbert 16",
     length={40,90}, coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.6, clip=true})
work(bowl * below(function() return 600 end):soften(24), {pile=p_bo_dk, tool="filbert 16",
     length={30,64}, coverage=1.4, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
blend(bowl:soften(6), {angle=0.5})
print("bowl modelled", wait(0))
