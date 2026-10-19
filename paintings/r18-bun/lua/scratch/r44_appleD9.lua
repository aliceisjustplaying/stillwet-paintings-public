D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
p_rhalf = pile{{"red earth", 3}, {"bone black", 2}, {"raw umber", 2}, {"vermilion", 1}}
-- a coherent turn from the light into the core shadow
work(D * (ellipse(330, 682, 86, 82):soften(24) - ellipse(272, 628, 70, 66):soften(28)),
     {pile=p_rhalf, tool="filbert 16", length={40,90}, coverage=1.2, fill=true, load=1.0,
      pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=0.3, clip=true})
-- the shadow-side edge melts into the shadow it throws
work((D:grow(7):soften(9) - D) * ellipse(368, 706, 150, 120):soften(30), {pile=p_rsh,
     tool="filbert 16", length={40,90}, coverage=1.3, fill=true, load=1.0, pressure={0.85,0.7},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
blend(D:soften(5), {angle=0.3})
work(ellipse(263, 613, 17, 13):soften(6) * D:grow(6), {pile=p_rhi, tool="filbert 8",
     length={14,26}, coverage=1.1, fill=false, load=1.0, pressure={0.7,0.5}, clip=true})
rg = brush{kind="round", width=8, point=0.95}
rg:load(p_stem, 1.0)
rg:stroke({{303, 578}, {309, 562}, {318, 547}}, {pressure={1.0,0.6,0.05}})
work(ellipse(303, 580, 13, 7):soften(4), {pile=p_stem, tool="filbert 5", length={8,16},
     coverage=1.4, fill=false, load=1.0, pressure={0.85,0.6}, clip=D:grow(3)})
print("apple D 9", wait(0))
