p_bgd = pile{{"raw umber",4},{"bone black",4},{"Prussian blue",0.7}}
cl_mid = pile{{"raw umber",3},{"bone black",1.5},{"lead white",1.6},{"cobalt blue",0.4},{"yellow ochre",0.4}}
b_mid = pile{{"yellow ochre",3},{"red earth",2.5},{"raw umber",2},{"bone black",0.4}}
print(work(rect(650, 0, 350, 140), {hand="broad", pile=p_bgd, tool="filbert 22", angle=0.22, coverage=4.0, clip=true, fill=true, edge="found", seed=1220}))
print(work(rect(650, 0, 350, 140), {hand="broad", pile=p_bgd, tool="filbert 18", angle=0.5, coverage=3.0, clip=true, fill=true, edge="found", seed=1221}))
-- the two apples on the cloth: take the hard ring away, put a real cast shadow back
work((m_apD:grow(11) - m_apD), {hand="body", pile=cl_mid, coverage=3.0, tool="filbert 12", clip=true, fill=true, edge="found", seed=1222})
work(ellipse(332, 732, 110, 36):soften(28), {hand="body", pile=p_rs2, coverage=0.85, tool="filbert 16", clip=true, fill=true, edge="soft", seed=1223})
work(ellipse(306, 766, 70, 18):soften(12), {hand="body", pile=p_rs2, coverage=0.6, tool="filbert 10", clip=true, edge="soft", seed=1224})
work((m_apE:grow(11) - m_apE), {hand="body", pile=cl_mid, coverage=3.0, tool="filbert 12", clip=true, fill=true, edge="found", seed=1225})
work(ellipse(502, 770, 88, 30):soften(24), {hand="body", pile=p_rs2, coverage=0.85, tool="filbert 16", clip=true, fill=true, edge="soft", seed=1226})
work(ellipse(482, 792, 56, 15):soften(10), {hand="body", pile=p_rs2, coverage=0.6, tool="filbert 10", clip=true, edge="soft", seed=1227})
-- soften the rings round the fruit in the bowl, and seat them with a contact shadow
for _, q in ipairs{{m_apA, 512, 566, 74}, {m_apC, 696, 568, 68}, {m_apB, 606, 556, 78}} do
  local mm, cx, cy, rw = q[1], q[2], q[3], q[4]
  work(mm:grow(12) - mm, {hand="body", pile=p_rs2, coverage=0.8, tool="filbert 12", clip=true, edge="soft", seed=1230 + cx})
  work(ellipse(cx + 6, cy, rw, 22):soften(16) * m_bw, {hand="body", pile=p_rs2, coverage=0.7, tool="filbert 10", clip=true, edge="soft", seed=1240 + cx})
end
