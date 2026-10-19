p_walll = pile{{"raw umber", 4}, {"bone black", 2}, {"red earth", 1.3}, {"yellow ochre", 0.6}}
p_glow  = pile{{"raw umber", 3.4}, {"bone black", 1.1}, {"red earth", 1.6}, {"yellow ochre", 1.3}, {"lead white", 0.6}}
p_dk    = pile{{"bone black", 3}, {"raw umber", 1.6}, {"Prussian blue", 0.9}}

pool1 = ellipse(430, 300, 540, 400):soften(200)
pool2 = ellipse(400, 320, 380, 270):soften(150)
pool3 = ellipse(360, 330, 240, 165):soften(110)

work(pool1, {pile=p_walll, tool="flat 20", length={30,70}, coverage=1.6, fill=true,
             load=1.0, pressure={1.0,0.9}, dips={3,1.0,0.05}, edge="soft"})
work(pool2, {pile=p_walll, tool="flat 20", length={26,60}, coverage=1.3, fill=true,
             load=1.0, pressure={1.0,0.9}, dips={3,1.0,0.05}, edge="soft"})
work(pool3, {pile=p_glow,  tool="flat 16", length={22,50}, coverage=1.2, fill=true,
             load=1.0, pressure={1.0,0.9}, dips={3,1.0,0.05}, edge="soft"})

dark_side = rect(600, 0, 400, 470):soften(160)
work(dark_side, {pile=p_dk, tool="flat 20", length={30,70}, coverage=1.2, fill=true,
                 load=1.0, pressure={1.0,0.9}, dips={3,1.0,0.05}, edge="soft"})
print("wall graded")
