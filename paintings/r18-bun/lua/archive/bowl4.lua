b_mid = pile{{"yellow ochre",4},{"red earth",2},{"raw umber",1.2}}
b_lt  = pile{{"yellow ochre",3},{"lead white",2.2},{"red earth",1.2}}
b_sh  = pile{{"raw umber",3.5},{"red earth",1.8},{"bone black",1.4}}
b_rim = pile{{"yellow ochre",2},{"lead white",3},{"raw umber",0.5}}
m_bw = m_bowl:grow(2)
dBowl = function(x, y)
  local dx = (x - 596) / 176
  local dy = (y - 604) / 78
  return 0.78 * dx + 0.62 * dy
end
local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, dBowl(x, y)) end) end
rimshade = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  return smoothstep(34, 4, y - (530 + 54 * math.sqrt(1 - u * u)))
end)
rimlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  return smoothstep(9, 0, y - (530 + 54 * math.sqrt(1 - u * u))) * smoothstep(0.30, -0.45, (x - 596) / 150)
end)
botlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 160, -1, 1)
  return smoothstep(30, 10, (566 + 92 * math.sqrt(1 - u * u)) - y)
end)
print(work(m_bw, {hand="body", pile=b_mid, coverage=3.2, tool="filbert 14", clip=true, fill=true, edge="found", seed=1090}))
print(work(m_bw * zt(0.14, -0.22), {hand="body", pile=b_lt, coverage=1.0, tool="filbert 12", angle=-0.5, clip=true, fill=true, edge="soft", seed=1091}))
print(work(m_bw * zt(0.40, 0.70), {hand="body", pile=b_sh, coverage=1.0, tool="filbert 12", angle=0.5, clip=true, fill=true, edge="soft", seed=1092}))
print(work(rimshade, {hand="body", pile=b_sh, coverage=0.9, tool="filbert 10", angle=0.1, clip=true, fill=true, edge="soft", seed=1093}))
print(work(botlit, {hand="body", pile=p_clothmid, coverage=0.6, tool="filbert 10", angle=0.1, clip=true, fill=true, edge="soft", seed=1094}))
print(work(rimlit, {hand="body", pile=b_rim, coverage=0.7, tool="filbert 8", angle=-0.3, clip=true, edge="soft", seed=1095}))
