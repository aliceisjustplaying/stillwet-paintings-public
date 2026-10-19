cl_mid = pile{{"raw umber",3},{"bone black",1.5},{"lead white",1.6},{"cobalt blue",0.4},{"yellow ochre",0.4}}
warm_sh = pile{{"raw umber",2.4},{"bone black",1.6},{"red earth",1}}
for _, q in ipairs{{m_apD, 2}, {m_apE, 2}} do
  local m = q[1]
  print(work(m:grow(7) - m:grow(1.5), {hand="body", pile=cl_mid, coverage=2.6,
        tool="filbert 10", clip=true, fill=true, edge="found", seed=2140 + q[2]}))
end
print(stipple(ellipse(332, 732, 108, 36):soften(26) + ellipse(502, 770, 86, 30):soften(24),
      {pile=warm_sh, width=8, coverage=1.2, feather=0.5, cluster=0.3, clip=true, seed=2150}))
print(stipple(ellipse(306, 766, 70, 18):soften(12) + ellipse(482, 792, 56, 15):soften(10),
      {pile=warm_sh, width=7, coverage=1.0, feather=0.5, cluster=0.3, clip=true, seed=2151}))
