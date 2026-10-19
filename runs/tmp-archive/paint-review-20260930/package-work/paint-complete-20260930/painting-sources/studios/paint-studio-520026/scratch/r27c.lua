sil = ellipse(580,500,200,64) + ellipse(580,545,196,62) + ellipse(580,585,165,54) +
      ellipse(580,612,120,40) + ellipse(580,624,66,22)
bowl = sil:blur(4):roughen(4, 60, 3)
inner = ellipse(580, 500, 186, 56):roughen(3, 50, 5)
wall  = bowl - inner
work(bowl, {pile=p_bo_mid, tool="filbert 20", length={40,90}, coverage=2.6, fill=true,
     load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
print("base ok")
