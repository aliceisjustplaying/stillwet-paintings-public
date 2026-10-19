m_cl = poly(cpts5, true):roughen(6, 40, 11):soften(2)
cl_base = pile{{"raw umber",4.5},{"lead white",2.2},{"cobalt blue",0.5},{"yellow ochre",0.5}}
cl_lt  = pile{{"lead white",7},{"yellow ochre",0.8},{"raw umber",0.6}}
cl_dsh = pile{{"raw umber",3.2},{"bone black",1.6},{"lead white",0.8},{"cobalt blue",0.5}}
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
grpsh = ellipse(700, 660, 210, 62):soften(44) + ellipse(420, 700, 110, 34):soften(28)
       + ellipse(560, 742, 90, 30):soften(24)
local common = {hand="body", clip=true, edge="soft", angle=drapefold,
                length={26,80}, curve={0.25,0.3}, angle_jitter=0.35, broken=0.3, clump=0.35}
print(work(m_cl, {pile=cl_base, coverage=5.0, tool="filbert 12", seed=1000, table.unpack(common, 1, 5)}))
print(work(m_cl * litA, {pile=p_clothmid, coverage=1.1, tool="filbert 16", seed=1001, table.unpack(common, 1, 5)}))
print(work(m_cl * litB, {pile=cl_lt, coverage=0.7, tool="filbert 13", seed=1002, table.unpack(common, 1, 5)}))
print(work(T * m_cl, {pile=cl_dsh, coverage=0.9, tool="filbert 16", seed=1003, table.unpack(common, 1, 5)}))
print(work(K * m_cl, {pile=cl_lt, coverage=0.55, tool="filbert 13", seed=1004, table.unpack(common, 1, 5)}))
print(work(grpsh * m_cl, {pile=cl_dsh, coverage=0.9, tool="filbert 18", seed=1005, table.unpack(common, 1, 5)}))
