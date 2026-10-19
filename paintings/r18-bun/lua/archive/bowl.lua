b_mid = pile{{"yellow ochre",4},{"red earth",2.5},{"raw umber",1}}
b_lt  = pile{{"yellow ochre",3},{"lead white",2},{"red earth",1.2}}
b_sh  = pile{{"raw umber",4},{"red earth",2},{"bone black",1.2}}
m_bw = m_bowl:grow(2)
dBowl = function(x, y)
  local dx = (x - 596) / 176
  local dy = (y - 604) / 78
  return 0.78 * dx + 0.62 * dy
end
local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, dBowl(x, y)) end) end
rimshade = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  local yrim = 530 + 54 * math.sqrt(1 - u * u)
  return smoothstep(30, 3, y - yrim)
end)
botlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 160, -1, 1)
  local ybot = 566 + 92 * math.sqrt(1 - u * u)
  return smoothstep(34, 8, ybot - y)
end)
print(work(m_bw, {hand="body", pile=b_mid, coverage=3.0, tool="filbert 14", clip=true, edge="found", seed=880}))
print(work(m_bw * zt(0.16, -0.20), {hand="body", pile=b_lt, coverage=0.9, tool="filbert 12", angle=-0.5, clip=true, edge="soft", seed=881}))
print(work(m_bw * zt(0.42, 0.72), {hand="body", pile=b_sh, coverage=0.95, tool="filbert 12", angle=0.5, clip=true, edge="soft", seed=882}))
print(work(rimshade, {hand="body", pile=b_sh, coverage=0.9, tool="filbert 10", angle=0.1, clip=true, edge="soft", seed=883}))
print(work(botlit, {hand="body", pile=p_clothmid, coverage=0.5, tool="filbert 9", angle=0.1, clip=true, edge="soft", seed=884}))
print(blend(m_bw, {angle=0.2}))
