cx, cy, rx, ry = 606, 498, 92, 86
g_mid  = pile{{"green earth",4},{"yellow ochre",2.5},{"chrome yellow",0.6},{"lead white",0.6}}
g_lite = pile{{"chrome yellow",0.6},{"lead white",2},{"yellow ochre",3},{"green earth",1.2}}
g_hot  = pile{{"lead white",3},{"yellow ochre",2},{"chrome yellow",0.8},{"green earth",0.5}}
mfB = m_apB:grow(1.5)
dB = function(x, y)
  local dx = (x - cx) / rx
  local dy = (y - cy) / ry
  return 0.80 * dx + 0.58 * dy + 0.20 * (dx * dx + dy * dy)
end
local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, dB(x, y)) end) end
m_shB  = mfB * zt(0.30, 0.62)
m_sh2B = mfB * zt(0.62, 0.95)
m_litB = mfB * zt(0.05, -0.18)
m_lit2B = mfB * zt(-0.25, -0.55)
m_rfB = mfB * mask(function(x, y)
  local dy = (y - cy) / ry
  return smoothstep(0.75, 1.15, dB(x, y)) * smoothstep(0.35, 0.80, dy)
end)
print(work(mfB, {hand="body", pile=g_mid, coverage=3.0, tool="filbert 14", clip=true, edge="found", seed=860}))
print(work(m_shB, {hand="body", pile=p_gs2, coverage=0.9, tool="filbert 12", angle=0.5, clip=true, edge="soft", seed=861}))
print(work(m_sh2B, {hand="body", pile=p_gs2, coverage=0.8, tool="filbert 10", angle=0.5, clip=true, edge="soft", seed=862}))
print(work(m_litB, {hand="body", pile=g_lite, coverage=0.85, tool="filbert 12", angle=-0.7, clip=true, edge="soft", seed=863}))
print(work(m_lit2B, {hand="body", pile=g_hot, coverage=0.7, tool="filbert 9", angle=-0.7, clip=true, edge="soft", seed=864}))
print(work(m_rfB, {hand="body", pile=p_clothmid, coverage=0.45, tool="filbert 8", angle=0.2, clip=true, edge="lost", seed=865}))
print(blend(mfB, {angle=-0.6}))
