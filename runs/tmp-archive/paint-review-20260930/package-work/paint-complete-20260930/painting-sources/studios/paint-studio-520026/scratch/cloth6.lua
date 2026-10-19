m_cl = poly(cpts5, true):roughen(6, 40, 11):soften(2)
cl_mid = pile{{"raw umber",3},{"bone black",1.5},{"lead white",1.6},{"cobalt blue",0.4},{"yellow ochre",0.4}}
cl_lit = pile{{"lead white",4},{"raw umber",2.8},{"yellow ochre",0.7}}
cl_tr  = pile{{"lead white",1.2},{"raw umber",3.5},{"bone black",1.6},{"cobalt blue",0.6},{"red earth",0.4}}
drapefold = function(x, y) return 1.10 + 0.95 * smoothstep(880, 200, x) + 0.07 * math.sin(y / 95) end
T = ribbon({{300,560},{240,640},{180,730},{150,800}}, 30):soften(20)
   + ribbon({{400,540},{350,630},{300,720},{270,800}}, 26):soften(18)
   + ribbon({{500,530},{470,620},{440,720},{420,800}}, 24):soften(18)
   + ribbon({{680,530},{720,620},{760,720},{790,800}}, 28):soften(20)
   + ribbon({{790,560},{830,650},{860,740},{880,800}}, 26):soften(20)
grpsh = ellipse(700, 664, 205, 58):soften(40) + ellipse(420, 706, 108, 32):soften(26)
       + ellipse(560, 748, 88, 28):soften(22)
print(work(m_cl, {hand="body", pile=cl_mid, coverage=6.0, tool="filbert 12", angle=drapefold,
  length={24,64}, curve={0.22,0.26}, angle_jitter=0.3, broken=0.2, clump=0.25,
  dips={4, 1.0, 0.1}, fill=true, clip=true, edge="soft", seed=1060}))
print(stipple(T * m_cl, {pile=cl_tr, width=7, coverage=0.9, feather=0.5, cluster=0.3, clip=true, seed=1061}))
print(stipple(grpsh * m_cl, {pile=cl_tr, width=8, coverage=1.0, feather=0.5, cluster=0.3, clip=true, seed=1062}))
