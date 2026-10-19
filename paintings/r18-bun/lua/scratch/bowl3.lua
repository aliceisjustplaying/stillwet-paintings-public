b_mid = pile{{"yellow ochre",4},{"red earth",2},{"raw umber",1.2}}
b_lt  = pile{{"yellow ochre",3},{"lead white",2.2},{"red earth",1.2}}
b_sh  = pile{{"raw umber",3.5},{"red earth",1.8},{"bone black",1.4}}
b_rim = pile{{"yellow ochre",2},{"lead white",3},{"raw umber",0.5}}
local C = {hand="body", clip=true, tool="filbert 14", length={20,52}, curve={0.2,0.16},
           angle_jitter=0.3, dips={4, 1.0, 0.1}, fill=true, edge="soft"}
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
  return smoothstep(34, 4, y - yrim)
end)
rimlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  local yrim = 530 + 54 * math.sqrt(1 - u * u)
  return smoothstep(9, 0, y - yrim) * smoothstep(0.30, -0.45, (x - 596) / 150)
end)
botlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 160, -1, 1)
  local ybot = 566 + 92 * math.sqrt(1 - u * u)
  return smoothstep(30, 10, ybot - y)
end)
print(work(m_bw, {pile=b_mid, coverage=5.0, seed=1080, table.unpack(C)}))
print(work(m_bw * zt(0.14, -0.22), {pile=b_lt, coverage=1.0, angle=-0.5, seed=1081, table.unpack(C)}))
print(work(m_bw * zt(0.40, 0.70), {pile=b_sh, coverage=1.0, angle=0.5, seed=1082, table.unpack(C)}))
print(work(rimshade, {pile=b_sh, coverage=0.9, angle=0.1, seed=1083, table.unpack(C)}))
print(work(botlit, {pile=p_clothmid, coverage=0.6, angle=0.1, seed=1084, table.unpack(C)}))
print(work(rimlit, {pile=b_rim, coverage=0.7, tool="filbert 8", angle=-0.3, length={12,34}, seed=1085, table.unpack(C)}))
