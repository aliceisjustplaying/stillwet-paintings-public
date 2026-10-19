r_mid = pile{{"vermilion",2.6},{"red earth",3},{"raw umber",1.2}}
r_lt  = pile{{"vermilion",2},{"red earth",1.6},{"yellow ochre",1.6},{"lead white",1}}
r_hot = pile{{"vermilion",1.2},{"yellow ochre",1.6},{"lead white",2.4}}
r_sh  = pile{{"raw umber",3},{"red earth",1.4},{"bone black",1.6},{"Prussian blue",0.3}}
gr_mid = pile{{"green earth",5},{"yellow ochre",1.2},{"raw umber",1}}
gr_lt  = pile{{"green earth",3},{"yellow ochre",2.2},{"chrome yellow",0.6},{"lead white",0.6}}
gr_hot = pile{{"chrome yellow",1},{"lead white",2.6},{"yellow ochre",1.6}}
gr_sh  = pile{{"raw umber",3},{"green earth",1.6},{"bone black",1.8},{"Prussian blue",0.4}}
b_mid = pile{{"raw umber",3.2},{"red earth",2},{"yellow ochre",1.4},{"bone black",0.8}}
b_lt  = pile{{"yellow ochre",2.2},{"red earth",1.6},{"lead white",0.9}}
b_sh  = pile{{"raw umber",3},{"bone black",2.2},{"red earth",0.8}}
b_rim = pile{{"yellow ochre",1.5},{"lead white",2.5},{"raw umber",0.4}}

m_bw = m_bowl:grow(2)
dBowl = function(x, y) return 0.78 * (x - 596) / 176 + 0.62 * (y - 604) / 78 end
local ztB = function(a, b) return mask(function(x, y) return smoothstep(a, b, dBowl(x, y)) end) end
print(work(m_bw, {hand="body", pile=b_mid, coverage=3.4, tool="filbert 14", clip=true, fill=true, edge="found", seed=1620}))
print(work(m_bw * ztB(0.10, -0.26), {hand="body", pile=b_lt, coverage=0.7, tool="filbert 12", angle=-0.5, clip=true, fill=true, edge="soft", seed=1621}))
print(work(m_bw * ztB(0.24, 0.56), {hand="body", pile=b_sh, coverage=0.6, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1622}))
print(work(m_bw * ztB(0.52, 0.84), {hand="body", pile=b_sh, coverage=0.5, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=1623}))
print(work(m_bw * mask(function(x, y)
      local u = clamp((x - 596) / 158, -1, 1)
      return smoothstep(26, 3, y - (530 + 54 * math.sqrt(1 - u * u)))
    end), {hand="body", pile=b_sh, coverage=0.7, tool="filbert 9", angle=0.1, clip=true, fill=true, edge="soft", seed=1624}))
print(blend(m_bw:shrink(8), {angle=0.2}))

function apple5(m, cx, cy, rx, ry, c_mid, c_lt, c_hot, c_sh, c_rf, sd)
  local mf = m:grow(1.5)
  local d = function(x, y)
    local dx = (x - cx) / rx
    local dy = (y - cy) / ry
    return 0.80 * dx + 0.58 * dy + 0.20 * (dx * dx + dy * dy)
  end
  local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, d(x, y)) end) end
  work(mf, {hand="body", pile=c_mid, coverage=3.4, tool="filbert 14", clip=true, fill=true, edge="found", seed=sd+1})
  work(mf * zt(0.14, -0.06), {hand="body", pile=c_lt, coverage=0.7, tool="filbert 12", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+2})
  work(mf * zt(-0.18, -0.44), {hand="body", pile=c_hot, coverage=0.6, tool="filbert 9", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+3})
  work(mf * zt(0.16, 0.48), {hand="body", pile=c_sh, coverage=0.6, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+4})
  work(mf * zt(0.44, 0.78), {hand="body", pile=c_sh, coverage=0.5, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+5})
  work(mf * zt(0.74, 1.02), {hand="body", pile=c_sh, coverage=0.45, tool="filbert 9", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+6})
  work(mf * mask(function(x, y)
        local dy = (y - cy) / ry
        return smoothstep(0.78, 1.18, d(x, y)) * smoothstep(0.28, 0.76, dy)
      end), {hand="body", pile=c_rf, coverage=0.5, tool="filbert 8", angle=0.2, clip=true, fill=true, edge="soft", seed=sd+7})
  work(ellipse(cx - 0.08 * rx, cy - 0.85 * ry, 0.28 * rx, 0.13 * ry):soften(9) * mf,
       {hand="body", pile=c_sh, coverage=0.8, tool="filbert 8", clip=true, fill=true, edge="soft", seed=sd+8})
  blend(mf:shrink(12), {angle=-0.6})
end
apple5(m_apA, 512, 516, 86, 80, r_mid, r_lt, r_hot, r_sh, b_lt, 1630)
apple5(m_apC, 696, 520, 80, 75, r_mid, r_lt, r_hot, r_sh, b_lt, 1650)
apple5(m_apB, 606, 498, 92, 86, gr_mid, gr_lt, gr_hot, gr_sh, b_lt, 1670)
apple5(m_apD, 300, 690, 92, 86, r_mid, r_lt, r_hot, r_sh, cl_mid, 1690)
apple5(m_apE, 478, 736, 72, 66, gr_mid, gr_lt, gr_hot, gr_sh, cl_mid, 1710)
