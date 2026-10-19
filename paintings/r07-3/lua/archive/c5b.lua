-- the water, first layer: the sky's piles again, more transparent and darker toward me, level strokes
waterpal = pal:only{"lead white", "pale smalt", "cobalt blue", "yellow ochre", "raw umber", "bone black", "red earth"}
WPILES = {{436, "#cbb98f"}, {450, "#b4ab93"}, {472, "#939798"}, {505, "#76808c"}, {548, "#5d6778"}, {592, "#4a5263"}, {640, "#3d4350"}}
waterTop = function(x) return shoreline(x) + 1 end
waterM = mask(function(x, y) return smoothstep(waterTop(x) - 2, waterTop(x) + 2, y) * (1 - smoothstep(bankcurve(x) + 4, bankcurve(x) + 12, y)) end)
ripple = noise{seed=21, period=120, octaves=3, stretch={0, 6}}
for i, p in ipairs(WPILES) do
  local top = (i == 1) and 400 or (WPILES[i-1][1] + p[1]) / 2
  local bot = (i == #WPILES) and 700 or (p[1] + WPILES[i+1][1]) / 2
  local soft = 3 + 0.12 * (p[1] - 430)
  local band = mask(function(x, y)
    local yy = y + 0.25 * soft * ripple(x, y)
    return smoothstep(top - soft, top + soft * 0.4, yy) * (1 - smoothstep(bot - soft * 0.4, bot + soft, yy))
  end) * waterM
  work(band, {hand="broad", color=p[2], angle=0, angle_jitter=0.004, length={90, 260}, coverage=4.0, medium=0.3, pal=waterpal, hug=false, curve={0.02, 0}, cross=0, drift={0, 1}})
end
-- (blend later)
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
