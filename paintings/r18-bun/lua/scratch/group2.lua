b_mid = pile{{"yellow ochre",3},{"red earth",2.5},{"raw umber",2},{"bone black",0.4}}
b_lt  = pile{{"yellow ochre",2.5},{"lead white",1.2},{"red earth",1.5}}
b_sh  = pile{{"raw umber",3},{"bone black",2},{"red earth",1}}
stem_p = pile{{"raw umber",4},{"bone black",2},{"red earth",1}}
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
print(work(m_bw, {hand="body", pile=b_mid, coverage=3.4, tool="filbert 14", clip=true, fill=true, edge="found", seed=1260}))
print(work(m_bw * zt(0.14, -0.22), {hand="body", pile=b_lt, coverage=1.1, tool="filbert 12", angle=-0.5, clip=true, fill=true, edge="soft", seed=1261}))
print(work(m_bw * zt(0.40, 0.70), {hand="body", pile=b_sh, coverage=1.1, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1262}))
print(work(rimshade, {hand="body", pile=b_sh, coverage=0.9, tool="filbert 10", angle=0.1, clip=true, fill=true, edge="soft", seed=1263}))
print(work(botlit, {hand="body", pile=b_lt, coverage=0.45, tool="filbert 10", angle=0.1, clip=true, fill=true, edge="soft", seed=1264}))

function apple2(m, cx, cy, rx, ry, c_mid, c_lt, c_hot, c_sh, c_rf, sd)
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
  work(mf, {hand="body", pile=c_mid, coverage=3.4, tool="filbert 14", clip=true, fill=true, edge="found", seed=sd+1})
  work(mf * zt(0.26, 0.58), {hand="body", pile=c_sh, coverage=1.1, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+2})
  work(mf * zt(0.60, 0.95), {hand="body", pile=c_sh, coverage=0.9, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+3})
  work(mf * zt(0.04, -0.18), {hand="body", pile=c_lt, coverage=1.0, tool="filbert 12", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+4})
  work(mf * zt(-0.28, -0.56), {hand="body", pile=c_hot, coverage=0.85, tool="filbert 9", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+5})
  work(rf, {hand="body", pile=c_rf, coverage=0.55, tool="filbert 8", angle=0.2, clip=true, edge="soft", seed=sd+6})
  blend(mf:shrink(10), {angle=-0.6})
  local cav = ellipse(cx - 0.10 * rx, cy - 0.86 * ry, 0.27 * rx, 0.12 * ry):soften(8) * mf
  work(cav, {hand="body", pile=c_sh, coverage=0.85, tool="filbert 8", clip=true, fill=true, edge="soft", seed=sd+7})
end
function stem(cx, cy, rx, ry, sd)
  local sb = brush{kind="round", width=5, point=1, stiffness=0.45}
  sb:load(stem_p, 0.95)
  sb:stroke({{cx - 0.09 * rx, cy - 0.80 * ry}, {cx - 0.17 * rx, cy - 1.00 * ry}, {cx - 0.21 * rx, cy - 1.17 * ry}},
            {pressure={0.95, 0.75, 0.25}, ramps={0.05, 0.5}, shake=1})
end
apple2(m_apA, 512, 516, 86, 80, r_mid, r_lt, r_hot, r_sh, b_lt, 1270)
apple2(m_apC, 696, 520, 80, 75, r_mid, r_lt, r_hot, r_sh, b_lt, 1290)
apple2(m_apB, 606, 498, 92, 86, gr_mid2, gr_lt2, gr_hot2, gr_sh2, b_lt, 1310)
stem(512, 516, 86, 80, 1330)
stem(696, 520, 80, 75, 1331)
stem(606, 498, 92, 86, 1332)
