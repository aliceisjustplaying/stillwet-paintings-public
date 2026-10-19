b_mid = pile{{"yellow ochre",3},{"red earth",2.5},{"raw umber",2},{"bone black",0.4}}
b_lt  = pile{{"yellow ochre",2.5},{"lead white",1.2},{"red earth",1.5}}
b_sh  = pile{{"raw umber",3},{"bone black",2},{"red earth",1}}
m_bw = m_bowl:grow(2)
dBowl = function(x, y) return 0.78 * (x - 596) / 176 + 0.62 * (y - 604) / 78 end
local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, dBowl(x, y)) end) end
rimshade = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  return smoothstep(34, 4, y - (530 + 54 * math.sqrt(1 - u * u)))
end)
botlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 160, -1, 1)
  return smoothstep(26, 8, (566 + 92 * math.sqrt(1 - u * u)) - y) * smoothstep(0.45, -0.5, (x - 596) / 150)
end)
print(work(m_bw, {hand="body", pile=b_mid, coverage=3.2, tool="filbert 14", clip=true, fill=true, edge="found", seed=1100}))
print(work(m_bw * zt(0.14, -0.22), {hand="body", pile=b_lt, coverage=1.0, tool="filbert 12", angle=-0.5, clip=true, fill=true, edge="soft", seed=1101}))
print(work(m_bw * zt(0.40, 0.70), {hand="body", pile=b_sh, coverage=1.0, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1102}))
print(work(rimshade, {hand="body", pile=b_sh, coverage=0.9, tool="filbert 10", angle=0.1, clip=true, fill=true, edge="soft", seed=1103}))
print(work(botlit, {hand="body", pile=b_lt, coverage=0.45, tool="filbert 10", angle=0.1, clip=true, edge="soft", seed=1104}))

function halo(m, r, sd)
  work((m:grow(r) - m):blur(4), {hand="body", pile=p_rs2, coverage=2.0,
        tool="filbert 12", clip=true, fill=true, edge="found", seed=sd})
end
function apple(m, cx, cy, rx, ry, c_mid, c_lt, c_hot, c_sh, c_rf, sd)
  halo(m, 10, sd)
  local mf = m:grow(1.5)
  local d = function(x, y)
    local dx = (x - cx) / rx
    local dy = (y - cy) / ry
    return 0.80 * dx + 0.58 * dy + 0.20 * (dx * dx + dy * dy)
  end
  local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, d(x, y)) end) end
  local rf = mf * mask(function(x, y)
    local dy = (y - cy) / ry
    return smoothstep(0.80, 1.20, d(x, y)) * smoothstep(0.30, 0.78, dy)
  end)
  work(mf, {hand="body", pile=c_mid, coverage=4.0, tool="filbert 14", clip=true, fill=true, edge="found", seed=sd+1})
  work(mf * zt(0.30, 0.62), {hand="body", pile=c_sh, coverage=1.0, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+2})
  work(mf * zt(0.66, 1.00), {hand="body", pile=c_sh, coverage=0.9, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+3})
  work(mf * zt(0.06, -0.16), {hand="body", pile=c_lt, coverage=0.95, tool="filbert 12", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+4})
  work(mf * zt(-0.24, -0.52), {hand="body", pile=c_hot, coverage=0.8, tool="filbert 9", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+5})
  work(rf, {hand="body", pile=c_rf, coverage=0.5, tool="filbert 8", angle=0.2, clip=true, edge="soft", seed=sd+6})
  blend(mf:shrink(6), {angle=-0.6})
end
apple(m_apD, 300, 690, 92, 86, r_mid, r_lt, r_hot, r_sh, p_clothmid, 1110)
apple(m_apE, 478, 736, 72, 66, gr_mid2, gr_lt2, gr_hot2, gr_sh2, p_clothmid, 1130)
apple(m_apA, 512, 516, 86, 80, r_mid, r_lt, r_hot, r_sh, b_lt, 1150)
apple(m_apC, 696, 520, 80, 75, r_mid, r_lt, r_hot, r_sh, b_lt, 1170)
apple(m_apB, 606, 498, 92, 86, gr_mid2, gr_lt2, gr_hot2, gr_sh2, b_lt, 1190)
