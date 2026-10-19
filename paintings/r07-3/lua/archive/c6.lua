-- next day: the sky's second layer, stippled, the glow zone first. Each touch from the pile of its band
-- (the painter alternates two piles where bands meet), dirtied with what is already there.
rest(16)
sitting{hours=5}
pileAt = function(x, y)
  local yy = y + G(x, 505, 260) * 26 * (y > 300 and 1 or 0.4) + 9 * rag(x, y)
  for i = 1, #PILES - 1 do
    local b = (PILES[i][1] + PILES[i+1][1]) / 2
    if yy < b + 14 then
      return mix(PILES[i][2], PILES[i+1][2], smoothstep(b - 14, b + 14, yy))
    end
  end
  return color(PILES[#PILES][2])
end
glowZone = skyM * mask(function(x, y) return smoothstep(215, 260, y) end)
stipple(glowZone, {width=4, coverage=function(x, y) return 1.5 * smoothstep(215, 265, y) end, fade=1,
  color_over=function(x, y, under) return shift(mix(under, pileAt(x, y), 0.45), 0.01, 0, 0.002) end,
  pressure={0.4, 0.8}, dips={18, 0.35, 0.7}, medium=0.5, pal=skypal})
local t = timesheet(); print(string.format("sitting %.0f min, touches %d", t.sitting, t.touches))
