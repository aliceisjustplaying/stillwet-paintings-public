r_mid = pile{{"vermilion",2.4},{"red earth",3.2},{"raw umber",1.3}}
r_lt  = pile{{"vermilion",1.8},{"red earth",2},{"yellow ochre",1.6},{"lead white",0.9}}
r_hot = pile{{"vermilion",1.1},{"yellow ochre",1.7},{"lead white",2.3}}
r_sh  = pile{{"raw umber",3},{"red earth",1.5},{"bone black",1.5},{"Prussian blue",0.3}}
gr_mid = pile{{"green earth",5},{"yellow ochre",1.3},{"raw umber",1}}
gr_lt  = pile{{"green earth",3},{"yellow ochre",2.2},{"chrome yellow",0.5},{"lead white",0.6}}
gr_hot = pile{{"chrome yellow",0.9},{"lead white",2.6},{"yellow ochre",1.6}}
gr_sh  = pile{{"raw umber",3},{"green earth",1.7},{"bone black",1.7},{"Prussian blue",0.4}}
b_mid = pile{{"raw umber",3.2},{"red earth",2},{"yellow ochre",1.4},{"bone black",0.8}}
b_lt  = pile{{"yellow ochre",2.2},{"red earth",1.6},{"lead white",0.9}}
b_sh  = pile{{"raw umber",3},{"bone black",2.2},{"red earth",0.8}}
stem_p = pile{{"raw umber",4},{"bone black",2.2},{"red earth",0.8}}

-- ---- the bowl first, so the fruit covers it where they overlap
m_bw = m_bowl:grow(2)
dBowl = function(x, y) return 0.78 * (x - 596) / 176 + 0.62 * (y - 604) / 78 end
local ztB = function(a, b) return mask(function(x, y) return smoothstep(a, b, dBowl(x, y)) end) end
rimshade = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  return smoothstep(11, 1, y - (530 + 54 * math.sqrt(1 - u * u)))
end)
footsh = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 160, -1, 1)
  return smoothstep(15, 3, (566 + 92 * math.sqrt(1 - u * u)) - y)
end)
botlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 160, -1, 1)
  return smoothstep(26, 9, (566 + 92 * math.sqrt(1 - u * u)) - y) * smoothstep(0.42, -0.55, (x - 596) / 150)
end)
print(work(m_bw, {hand="body", pile=b_mid, coverage=3.4, tool="filbert 14", clip=true, fill=true, edge="found", seed=1820}))
print(work(m_bw * ztB(0.10, -0.26), {hand="body", pile=b_lt, coverage=0.7, tool="filbert 12", angle=-0.5, clip=true, fill=true, edge="soft", seed=1821}))
print(work(m_bw * ztB(0.24, 0.56), {hand="body", pile=b_sh, coverage=0.6, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1822}))
print(work(m_bw * ztB(0.52, 0.84), {hand="body", pile=b_sh, coverage=0.5, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=1823}))
print(work(rimshade, {hand="body", pile=b_sh, coverage=1.1, tool="filbert 8", angle=0.1, clip=true, fill=true, edge="soft", seed=1824}))
print(work(botlit, {hand="body", pile=b_lt, coverage=0.55, tool="filbert 10", angle=0.1, clip=true, fill=true, edge="soft", seed=1825}))
print(work(footsh, {hand="body", pile=b_sh, coverage=0.7, tool="filbert 9", angle=0.1, clip=true, fill=true, edge="soft", seed=1826}))
print(blend(m_bw:shrink(8), {angle=0.2}))

-- ---- the fruit
function apple6(m, cx, cy, rx, ry, c_mid, c_lt, c_hot, c_sh, c_rf, sd)
  local mf = m:grow(1.5)
  local d = function(x, y)
    local dx = (x - cx) / rx
    local dy = (y - cy) / ry
    return 0.80 * dx + 0.58 * dy + 0.20 * (dx * dx + dy * dy)
  end
  local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, d(x, y)) end) end
  work(mf, {hand="body", pile=c_mid, coverage=3.4, tool="filbert 14", clip=true, fill=true, edge="found", seed=sd+1})
  work(mf * zt(0.14, -0.06), {hand="body", pile=c_lt, coverage=0.7, tool="filbert 12", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+2})
  work(mf * zt(-0.18, -0.44), {hand="body", pile=c_hot, coverage=0.55, tool="filbert 9", angle=-0.7, clip=true, fill=true, edge="soft", seed=sd+3})
  work(mf * zt(0.16, 0.48), {hand="body", pile=c_sh, coverage=0.55, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+4})
  work(mf * zt(0.44, 0.78), {hand="body", pile=c_sh, coverage=0.5, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+5})
  work(mf * zt(0.74, 1.02), {hand="body", pile=c_sh, coverage=0.45, tool="filbert 9", angle=0.5, clip=true, fill=true, edge="soft", seed=sd+6})
  work(mf * mask(function(x, y)
        local dy = (y - cy) / ry
        return smoothstep(0.80, 1.20, d(x, y)) * smoothstep(0.30, 0.78, dy)
      end), {hand="body", pile=c_rf, coverage=0.45, tool="filbert 9", angle=0.2, clip=true, fill=true, edge="soft", seed=sd+7})
  work(ellipse(cx - 0.08 * rx, cy - 0.84 * ry, 0.26 * rx, 0.12 * ry):soften(9) * mf,
       {hand="body", pile=c_sh, coverage=0.8, tool="filbert 8", clip=true, fill=true, edge="soft", seed=sd+8})
  blend(mf:shrink(12), {angle=-0.6})
end
apple6(m_apA, 512, 516, 86, 80, r_mid, r_lt, r_hot, r_sh, b_lt, 1830)
apple6(m_apC, 696, 520, 80, 75, r_mid, r_lt, r_hot, r_sh, b_lt, 1850)
apple6(m_apB, 606, 498, 92, 86, gr_mid, gr_lt, gr_hot, gr_sh, b_lt, 1870)
apple6(m_apD, 300, 690, 92, 86, r_mid, r_lt, r_hot, r_sh, cl_mid, 1890)
apple6(m_apE, 478, 736, 72, 66, gr_mid, gr_lt, gr_hot, gr_sh, cl_mid, 1910)
-- stems and catchlights, and nothing else
local fruitq = {{512,516,86,80,r_hot},{696,520,80,75,r_hot},{606,498,92,86,gr_hot},
                {300,690,92,86,r_hot},{478,736,72,66,gr_hot}}
for _, q in ipairs(fruitq) do
  local sb = brush{kind="round", width=9, point=1, stiffness=0.55}
  sb:load(stem_p, 1.0)
  sb:stroke({{q[1] - 0.07 * q[3], q[2] - 0.86 * q[4]},
              {q[1] - 0.15 * q[3], q[2] - 1.00 * q[4]},
              {q[1] - 0.19 * q[3], q[2] - 1.10 * q[4]}},
            {pressure={1.0, 0.8, 0.35}, ramps={0.06, 0.4}, shake=1})
end
for _, q in ipairs(fruitq) do
  local hb = brush{kind="round", width=8, point=1, stiffness=0.3}
  hb:load(q[5], 1.0)
  hb:touch(q[1] - 0.38 * q[3], q[2] - 0.42 * q[4], {pressure=0.7})
  hb:wipe(0.4)
  hb:touch(q[1] - 0.48 * q[3], q[2] - 0.10 * q[4], {pressure=0.28})
end
