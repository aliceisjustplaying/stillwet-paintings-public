-- the core shadow is the FAR side from the light, so it is one MINUS the light mask
function corem(a, t0, t1) return litf(a, t0, t1):map(function(v) return 1 - v end) end
local a = AP[3]
local S = ellipse(a.cx, a.cy, a.r, a.r*0.95):roughen(2.5, 70, 8):soften(2.5)
local cm = S * corem(a, -1.0, 0.05)
print(string.format("core area %.0f of %.0f", cm:area(), S:area()))
for _, p in ipairs{{"upper-left",-0.5,-0.5},{"centre",0,0},{"right",0.85,0},{"lower-right",0.5,0.5}} do
  print(string.format("  %-11s core=%.2f", p[1], cm:at(a.cx + p[2]*a.r, a.cy + p[3]*a.r*0.96)))
end
work(S, {hand="body", tool="filbert 16", pile=g_rb, length={30, 80}, coverage=5, pressure=1,
     fill=true, dips={1, 1.0, 0.0}, edge="found", clip=true})
work(cm, {hand="body", tool="filbert 16", pile=g_rc, length={30, 80}, coverage=3.4, pressure=1,
     fill=true, dips={1, 1.0, 0.0}, edge="soft"})
