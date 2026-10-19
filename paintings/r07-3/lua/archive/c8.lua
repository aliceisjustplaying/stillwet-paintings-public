-- next day: three strata, dull violet-gray bodies lit from below by the set sun, laid in body color
-- over the dry stipple and blended while wet, their undersides touched in warm
rest(16)
sitting{hours=3}
cloudpal = pal:only{"lead white", "pale smalt", "cobalt blue", "yellow ochre", "raw umber", "red earth", "vermilion", "bone black"}
local function strandM(x0, x1, y, tilt, w)
  local pts, ws, n = {}, {}, math.max(4, math.floor((x1 - x0) / 25))
  for k = 0, n do
    local t = k / n
    pts[#pts+1] = {x0 + (x1 - x0) * t, y - tilt * t + randn(0, 0.8)}
    ws[#ws+1] = w * (0.25 + 0.75 * math.sin(math.pi * t)^0.6) * rand(0.7, 1.15)
  end
  return ribbon(pts, ws)
end
local function cloud(list, tilt, seed)
  local m
  for _, s in ipairs(list) do local r = strandM(s[1], s[2], s[3], tilt, s[4]); m = m and (m + r) or r end
  return m:roughen(1.2, 18, seed, 1.2)
end
cA = cloud({{60, 330, 78, 5}, {150, 520, 86, 7}, {230, 610, 92, 6}, {310, 470, 99, 4}, {520, 700, 88, 3}, {95, 260, 83, 4}, {400, 560, 95, 5}}, 5, 31)
cB = cloud({{560, 860, 168, 5}, {640, 990, 174, 6}, {720, 900, 179, 3}, {880, 1010, 166, 3}}, -4, 32)
local cn = noise{seed=41, period=60}
local function veil(m, body, warm, amt, seed)
  local soft = m:blur(5)
  local und = function(x, y) return clamp(1.6 * (soft:at(x, y) - soft:at(x, y + 5)), 0, 1) end
  work(soft, {hand="broad", angle=-0.005, length={40, 120}, coverage=2.6, medium=0.3, pal=cloudpal, hug=false, seed=seed,
    color_over=function(x, y, under)
      local c = mix(body, warm, und(x, y))
      return mix(under, c, amt * (0.55 + 0.45 * soft:at(x, y)) * (0.8 + 0.4 * cn:at01(x, y)))
    end})
  blend(m:grow(4):blur(3), {angle=0, coverage=1.4, seed=seed + 1})
end
veil(cA, "#7e7a8c", "#c4a09a", 0.75, 51)
veil(cB, "#8c8a98", "#c9aa9a", 0.55, 53)
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
