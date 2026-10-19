sil = ellipse(580,500,200,64) + ellipse(580,545,196,62) + ellipse(580,585,165,54) +
      ellipse(580,612,120,40) + ellipse(580,624,66,22)
bowl = sil:blur(4):roughen(4, 60, 3)
inner = ellipse(580, 500, 186, 56):roughen(3, 50, 5)
wall  = bowl - inner
work(inner, {pile=p_bo_sh, tool="filbert 16", length={40,90}, coverage=1.9, fill=true,
     load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
print("inner ok")
work(ellipse(580, 470, 170, 44):soften(30), {pile=p_bo_dk, tool="filbert 16", length={30,64},
     coverage=1.5, fill=true, load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, clip=true})
print("inner dark ok")
