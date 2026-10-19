cpts5 = {{300,540},{450,506},{620,496},{780,512},{852,552},{886,614},
         {858,666},{898,756},{928,800},{40,800},{40,688},{108,640},{128,586},{210,556}}
m_cl = poly(cpts5, true):roughen(6, 40, 11):soften(2)
cl_lt  = pile{{"lead white",8},{"yellow ochre",0.8},{"raw umber",0.5}}
cl_sh  = pile{{"lead white",3.5},{"raw umber",4},{"cobalt blue",0.7},{"yellow ochre",0.4}}
cl_dsh = pile{{"lead white",1.4},{"raw umber",3.4},{"bone black",1.5},{"cobalt blue",0.6}}
litL = mask(function(x, y) return smoothstep(1.15, -0.25, (x - 120) / 520 + (y - 470) / 300) end)
litL2 = mask(function(x, y) return smoothstep(0.80, -0.30, (x - 120) / 520 + (y - 470) / 300) end)
t1 = ribbon({{236,596},{372,652},{508,724}}, 34):soften(24)
t2 = ribbon({{150,652},{296,712},{420,776}}, 30):soften(22)
t3 = ribbon({{706,596},{766,668},{812,762}}, 32):soften(24)
t4 = ribbon({{402,536},{506,596},{596,656}}, 26):soften(20)
c1 = ribbon({{186,566},{318,622},{452,690}}, 26):soften(20)
c2 = ribbon({{104,606},{244,664},{372,724}}, 24):soften(18)
c3 = ribbon({{654,566},{716,634},{766,716}}, 24):soften(20)
bowlsh = (ellipse(672, 664, 200, 58):soften(42) + ellipse(600, 646, 150, 40):soften(30))
print(work(m_cl, {hand="body", pile=p_clothmid, coverage=2.6, tool="filbert 20", angle=0.3, clip=true, edge="soft", seed=970}))
print(work(m_cl * litL, {hand="body", pile=cl_lt, coverage=0.8, tool="filbert 18", angle=0.35, clip=true, edge="soft", seed=971}))
print(work(m_cl * litL2, {hand="body", pile=cl_lt, coverage=0.5, tool="filbert 14", angle=0.35, clip=true, edge="soft", seed=972}))
print(work((t1 + t2 + t3 + t4) * m_cl, {hand="body", pile=cl_sh, coverage=0.85, tool="filbert 16", angle=0.5, clip=true, edge="soft", seed=973}))
print(work((t1 + t3) * m_cl, {hand="body", pile=cl_dsh, coverage=0.5, tool="filbert 12", angle=0.5, clip=true, edge="soft", seed=974}))
print(work((c1 + c2 + c3) * m_cl, {hand="body", pile=cl_lt, coverage=0.55, tool="filbert 12", angle=0.4, clip=true, edge="soft", seed=975}))
print(work(bowlsh * m_cl, {hand="body", pile=cl_dsh, coverage=0.9, tool="filbert 18", angle=0.2, clip=true, edge="soft", seed=976}))
print(blend(m_cl, {angle=0.3}))
