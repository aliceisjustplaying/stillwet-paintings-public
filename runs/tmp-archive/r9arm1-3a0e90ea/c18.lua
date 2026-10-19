-- long wind-drift swells over the plain: a cool lee under each crest, a lighter lip along it.
-- One pass each over the open snow; the swells are in the coverage, fading, not in a mask's edge.
local sw = noise{seed=91, octaves=3, period=260}
local CRESTS = {{-40, 668, 470, 0.9}, {520, 690, 1040, 0.7}, {-40, 603, 330, 0.8}, {120, 560, 400, 0.6}, {-40, 528, 250, 0.5}, {548, 512, 652, 0.4}}
local function swell(x, y, lip)
  local v = 0
  for i, c in ipairs(CRESTS) do
    local x0, y0, x1, amt = c[1], c[2], c[3], c[4]
    if x > x0 and x < x1 then
      local t = (x - x0) / (x1 - x0)
      local taper = math.sin(math.pi * t) ^ 0.7
      local cy = y0 + 10 * sw(x, i * 50) * (y0 - HZ) / 200
      local s = per_m(cy)
      local d = y - cy
      if lip then
        local w = 0.07 * s
        v = v + amt * taper * math.exp(-(d / w)^2)
      else
        local w = 0.3 * s
        if d > 0 then v = v + amt * taper * math.exp(-((d - 0.35 * w) / w)^2) end
      end
    end
  end
  return clamp(v, 0, 1)
end
local open = SNOW - KEEP:grow(10) - STREAMM:grow(4)
local leeM = mask(function(x, y) return smoothstep(0.08, 0.35, swell(x, y, false)) end) * open
local lipM = mask(function(x, y) return smoothstep(0.1, 0.4, swell(x, y, true)) end) * open
work(leeM, {hand="broad", tool="filbert 4", length={30, 90}, coverage=2.4, load_at=function(x, y) return 0.25 + 0.75 * swell(x, y, false) end, medium=0.3, angle=0.02, angle_jitter=0.05,
  edge="lost", color_over={shift={-0.04, -0.002, -0.016}}})
work(lipM, {hand="detail", tool="filbert 2", length={15, 50}, coverage=1.8, load_at=function(x, y) return 0.3 + 0.7 * swell(x, y, true) end, medium=0.18, angle=0.02,
  edge="lost", color_over={shift={0.018, 0.0, 0.004}}})
