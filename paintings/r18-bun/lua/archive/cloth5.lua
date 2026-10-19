m_cl = poly(cpts5, true):roughen(6, 40, 11):soften(2)
cl_lit  = pile{{"lead white",4},{"raw umber",2.8},{"yellow ochre",0.7}}
cl_tr   = pile{{"lead white",1.2},{"raw umber",3.5},{"bone black",1.6},{"cobalt blue",0.6},{"red earth",0.4}}
drapefold = function(x, y) return 1.10 + 0.95 * smoothstep(880, 200, x) + 0.07 * math.sin(y / 95) end
litA = mask(function(x, y) return smoothstep(1.30, 0.10, (x - 150) / 480 + (y - 480) / 300) end)
litB = mask(function(x, y) return smoothstep(0.80, -0.15, (x - 150) / 480 + (y - 480) / 300) end)
T = ribbon({{300,560},{240,640},{180,730},{150,800}}, 30):soften(20)
   + ribbon({{400,540},{350,630},{300,720},{270,800}}, 26):soften(18)
   + ribbon({{500,530},{470,620},{440,720},{420,800}}, 24):soften(18)
   + ribbon({{680,530},{720,620},{760,720},{790,800}}, 28):soften(20)
   + ribbon({{790,560},{830,650},{860,740},{880,800}}, 26):soften(20)
K = ribbon({{340,556},{285,640},{230,730},{205,800}}, 26):soften(18)
   + ribbon({{445,536},{400,628},{355,718},{330,800}}, 24):soften(16)
   + ribbon({{560,528},{545,618},{520,718},{500,800}}, 24):soften(16)
   + ribbon({{730,540},{775,628},{812,722},{838,800}}, 26):soften(18)
grpsh = ellipse(700, 664, 205, 58):soften(40) + ellipse(420, 706, 108, 32):soften(26)
       + ellipse(560, 748, 88, 28):soften(22)
local C = {hand="body", clip=true, edge="soft", angle=drapefold, tool="filbert 12",
           length={24,64}, curve={0.22,0.26}, angle_jitter=0.3, broken=0.2, clump=0.25,
           dips={4, 1.0, 0.1}, fill=true}
print(work(m_cl * litA, {pile=cl_lit, coverage=0.75, seed=1050, table.unpack(C, 1, 8)}))
print(work(m_cl * litB, {pile=cl_lit, coverage=0.55, seed=1051, table.unpack(C, 1, 8)}))
print(work(T * m_cl, {pile=cl_tr, coverage=0.65, seed=1052, table.unpack(C, 1, 8)}))
print(work(K * m_cl, {pile=cl_lit, coverage=0.45, seed=1053, table.unpack(C, 1, 8)}))
print(work(grpsh * m_cl, {pile=cl_tr, coverage=0.85, seed=1054, table.unpack(C, 1, 8)}))
