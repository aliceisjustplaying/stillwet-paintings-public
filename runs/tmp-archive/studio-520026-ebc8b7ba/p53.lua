local a = AP[2]
local S = ellipse(a.cx, a.cy, a.r, a.r*0.95):roughen(2.5, 70, 3):soften(2.5)
local core_m = S * litf(a, -1.0, -0.02)
local lit_m  = S * litf(a, 0.45, 0.95)
local mid_m  = S * litf(a, 0.0, 0.55)
print(string.format("areas: S %.0f  mid %.0f  lit %.0f  core %.0f", S:area(), mid_m:area(), lit_m:area(), core_m:area()))
local pts = {{"centre", 0, 0}, {"upper-left", -0.5, -0.5}, {"right", 0.85, 0}, {"lower-right", 0.5, 0.5}, {"lower-left", -0.5, 0.6}}
for _, p in ipairs(pts) do
  local x, y = a.cx + p[2]*a.r, a.cy + p[3]*a.r*0.96
  print(string.format("  %-11s S=%.2f  mid=%.2f  lit=%.2f  core=%.2f",
    p[1], S:at(x, y), mid_m:at(x, y), lit_m:at(x, y), core_m:at(x, y)))
end
