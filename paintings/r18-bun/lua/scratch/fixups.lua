r_sh  = pile{{"raw umber",3},{"red earth",1.4},{"bone black",1.6},{"Prussian blue",0.3}}
gr_sh = pile{{"raw umber",3},{"green earth",1.6},{"bone black",1.8},{"Prussian blue",0.4}}
b_sh  = pile{{"raw umber",3},{"bone black",2.2},{"red earth",0.8}}
b_mid = pile{{"raw umber",3.2},{"red earth",2},{"yellow ochre",1.4},{"bone black",0.8}}
b_lt  = pile{{"yellow ochre",2.2},{"red earth",1.6},{"lead white",0.9}}
stem_p = pile{{"raw umber",4},{"bone black",2.2},{"red earth",0.8}}
p_bgd = pile{{"raw umber",4},{"bone black",4},{"Prussian blue",0.7}}
cl_mid = pile{{"raw umber",3},{"bone black",1.5},{"lead white",1.6},{"cobalt blue",0.4},{"yellow ochre",0.4}}

-- 1. bury the white bounce slashes: repaint the shadow side of every apple, then fuse
local fruitq = {{512,516,86,80,r_sh,m_apA,1},{696,520,80,75,r_sh,m_apC,1},
                {606,498,92,86,gr_sh,m_apB,1},{300,690,92,86,r_sh,m_apD,0},
                {478,736,72,66,gr_sh,m_apE,0}}
for _, q in ipairs(fruitq) do
  local cx, cy, rx, ry, c_sh, m, oncloth = q[1], q[2], q[3], q[4], q[5], q[6], q[7]
  local mf = m:grow(1.5)
  local d = function(x, y)
    local dx = (x - cx) / rx
    local dy = (y - cy) / ry
    return 0.80 * dx + 0.58 * dy + 0.20 * (dx * dx + dy * dy)
  end
  local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, d(x, y)) end) end
  work(mf * zt(0.40, 0.80), {hand="body", pile=c_sh, coverage=1.2, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1760 + cx})
  work(mf * zt(0.70, 1.05), {hand="body", pile=c_sh, coverage=0.9, tool="filbert 10", angle=0.5, clip=true, fill=true, edge="soft", seed=1770 + cx})
  blend(mf:shrink(12), {angle=-0.6})
end
-- 2. the beaded rim light becomes the rim's own shadow
m_bw = m_bowl:grow(2)
rimband = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  return smoothstep(13, 1, y - (530 + 54 * math.sqrt(1 - u * u)))
end)
print(work(rimband, {hand="body", pile=b_sh, coverage=1.3, tool="filbert 9", angle=0.1, clip=true, fill=true, edge="soft", seed=1780}))
-- 3. stems: take the hairs away, redraw short and thick
for _, q in ipairs({{512,516,86,80,p_bgd},{696,520,80,75,p_bgd},{606,498,92,86,p_bgd},
                    {300,690,92,86,cl_mid},{478,736,72,66,cl_mid}}) do
  local cx, cy, rx, ry, sur = q[1], q[2], q[3], q[4], q[5]
  local band = ellipse(cx - 0.14 * rx, cy - 1.12 * ry, 0.30 * rx, 0.30 * ry)
  print(work(band, {hand="body", pile=sur, coverage=2.4, tool="filbert 10", clip=true, fill=true, edge="soft", seed=1790 + cx}))
end
for _, q in ipairs({{512,516,86,80},{696,520,80,75},{606,498,92,86},{300,690,92,86},{478,736,72,66}}) do
  local sb = brush{kind="round", width=9, point=1, stiffness=0.55}
  sb:load(stem_p, 1.0)
  sb:stroke({{q[1] - 0.07 * q[3], q[2] - 0.87 * q[4]},
              {q[1] - 0.15 * q[3], q[2] - 1.00 * q[4]},
              {q[1] - 0.19 * q[3], q[2] - 1.09 * q[4]}},
            {pressure={1.0, 0.8, 0.4}, ramps={0.06, 0.4}, shake=1})
end
-- 4. the bowl gets a form: shadow right, reflected light low-left, foot shadow
dBowl = function(x, y) return 0.78 * (x - 596) / 176 + 0.62 * (y - 604) / 78 end
print(work(m_bw * mask(function(x, y) return smoothstep(0.30, 0.62, dBowl(x, y)) end),
      {hand="body", pile=b_sh, coverage=0.9, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1810}))
print(work(m_bw * mask(function(x, y)
        local u = clamp((x - 596) / 160, -1, 1)
        return smoothstep(20, 7, (566 + 92 * math.sqrt(1 - u * u)) - y) * smoothstep(0.40, -0.55, (x - 596) / 150)
      end), {hand="body", pile=b_lt, coverage=0.6, tool="filbert 10", angle=0.1, clip=true, fill=true, edge="soft", seed=1811}))
print(work(m_bw * mask(function(x, y)
        local u = clamp((x - 596) / 160, -1, 1)
        return smoothstep(16, 3, (566 + 92 * math.sqrt(1 - u * u)) - y)
      end), {hand="body", pile=b_sh, coverage=0.8, tool="filbert 9", angle=0.1, clip=true, fill=true, edge="soft", seed=1812}))
print(blend(m_bw:shrink(8), {angle=0.2}))
