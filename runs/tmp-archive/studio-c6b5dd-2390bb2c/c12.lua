hills = below({{380,452},{430,440},{500,432},{560,424},{620,414},{680,404},{730,402},{790,410},{840,404},{880,396},{930,400},{970,408},{1000,410}}) * above(function(x) return 452 end)
hills = hills:roughen(3, 40, 11, 0)
pHill = pile{{"lead white",3},{"smalt",1.2},{"red earth",0.35},{"raw umber",0.3},{"vermilion",0.08}}
work(hills, {hand="body", tool="filbert 8", pile=pHill, angle=0.05, angle_jitter=0.15, coverage=3, fill=true, length={30,80}, edge="firm"})
