cloth_r = cloth:roughen(9, 70, 12)
work(cloth_r, {pile=p_clm2, hand="broad", coverage=2.8, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
work(cloth_r, {pile=p_clm2, hand="broad", coverage=2.0, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
print("base only", wait(0))
