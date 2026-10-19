gr_mid = pile{{"green earth",5},{"yellow ochre",1.6},{"raw umber",0.8}}
gr_lt  = pile{{"green earth",3},{"yellow ochre",2.2},{"chrome yellow",0.6},{"lead white",0.6}}
gr_sh  = pile{{"raw umber",3},{"green earth",1.6},{"bone black",1.8},{"Prussian blue",0.4}}
r_sh  = pile{{"raw umber",3},{"red earth",1.4},{"bone black",1.6},{"Prussian blue",0.3}}
b_sh  = pile{{"raw umber",3},{"bone black",2.2},{"red earth",0.8}}
cl_tr  = pile{{"lead white",1.2},{"raw umber",3.5},{"bone black",1.6},{"cobalt blue",0.6},{"red earth",0.4}}
function deepen(m, cx, cy, rx, ry, c_sh, c_rf, sd)
  local mf = m:grow(1.5)
  local d = function(x, y)
    local dx = (x - cx) / rx
    local dy = (y - cy) / ry
    return 0.80 * dx + 0.58 * dy + 0.20 * (dx * dx + dy * dy)
  end
  local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, d(x, y)) end) end
  work(mf * zt(0.20, 0.54), {hand="body", pile=c_sh, coverage=1.2, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+1})
  work(mf * zt(0.56, 0.95), {hand="body", pile=c_sh, coverage=1.0, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+2})
  local base = ellipse(cx + 0.04 * rx, cy + 0.88 * ry, 0.74 * rx, 0.20 * ry):soften(11) * mf
  work(base, {hand="body", pile=c_sh, coverage=0.75, tool="filbert 9", angle=0.2, clip=true, fill=true, edge="soft", seed=sd+3})
  blend(mf:shrink(8), {angle=-0.6})
end
deepen(m_apA, 512, 516, 86, 80, r_sh, b_lt, 1560)
deepen(m_apC, 696, 520, 80, 75, r_sh, b_lt, 1570)
deepen(m_apB, 606, 498, 92, 86, gr_sh, b_lt, 1580)
deepen(m_apD, 300, 690, 92, 86, r_sh, cl_mid, 1590)
deepen(m_apE, 478, 736, 72, 66, gr_sh, cl_mid, 1600)
-- deepen the bowl's shadow side and the shadow under its rim
m_bw = m_bowl:grow(2)
dBowl = function(x, y) return 0.78 * (x - 596) / 176 + 0.62 * (y - 604) / 78 end
work(m_bw * mask(function(x, y) return smoothstep(0.34, 0.66, dBowl(x, y)) end),
     {hand="body", pile=b_sh, coverage=1.3, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1610})
work(m_bw * mask(function(x, y)
      local u = clamp((x - 596) / 158, -1, 1)
      return smoothstep(26, 3, y - (530 + 54 * math.sqrt(1 - u * u)))
    end), {hand="body", pile=b_sh, coverage=1.1, tool="filbert 9", angle=0.1, clip=true, fill=true, edge="soft", seed=1611})
blend(m_bw, {angle=0.2})
-- and the group's shadow on the cloth
grpsh = ellipse(700, 664, 205, 58):soften(40) + ellipse(420, 706, 108, 32):soften(26)
       + ellipse(560, 748, 88, 28):soften(22)
m_cl = poly(cpts5, true):roughen(6, 40, 11):soften(2)
print(stipple(grpsh * m_cl, {pile=cl_tr, width=8, coverage=1.3, feather=0.5, cluster=0.3, clip=true, seed=1612}))
