-- evening streaks: tapered bands, brushed thin and fused into the wet sky at their edges
local function streak(x0, x1, y, th, tilt, seed)
  local pts, ws = {}, {}
  local n = 9
  local sn = noise{seed=seed, period=90}
  for i = 0, n do
    local t = i / n
    local x = x0 + (x1 - x0) * t
    pts[#pts + 1] = {x, y + (x - x0) * tilt + 3 * sn(x, 0)}
    ws[#ws + 1] = th * (0.25 + 0.75 * math.sin(math.pi * t) ^ 0.6) * (0.7 + 0.5 * sn:at01(x, 50))
  end
  return ribbon(pts, ws):blur(3)
end
CL = {
  {m=streak(-60, 470, 410, 12, -0.012, 61), dark="#9d8e90", lit="#e8cb9a"},
  {m=streak(700, 1030, 399, 5, 0.004, 62), dark="#a09298", lit="#e5c79b"},
}
for i, c in ipairs(CL) do
  local d = color(c.dark)
  work(c.m, {hand="broad", tool="flat 8", length={40, 140}, coverage=1.4, load=0.45, medium=0.4, angle=0, broken=0.2, pal=skypal, 
    color_over=function(x, y, under) return mix(under, d, 0.42) end, hug=false})
  -- the glow catches the underside
  local low = c.m * mask(function(x, y) return 1 - c.m:at(x, y + 3) end)
  local l = color(c.lit)
  work(low, {hand="broad", tool="flat 4", length={30, 90}, coverage=1.2, load=0.4, medium=0.4, angle=0, pal=skypal, edge="soft",
    color_over=function(x, y, under) return mix(under, l, 0.5) end})
  blend(c.m:grow(4):blur(2), {angle=0, coverage=1.5})
end
local t = timesheet(); print(t.sitting)
