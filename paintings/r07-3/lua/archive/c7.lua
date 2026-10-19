-- another day: the upper sky stippled the same way, overlapping the glow zone's top
rest(16)
sitting{hours=5}
upperZone = skyM * mask(function(x, y) return 1 - smoothstep(245, 290, y) end)
stipple(upperZone, {width=4.5, coverage=function(x, y) return 1.35 * (1 - smoothstep(240, 292, y)) end, fade=1,
  color_over=function(x, y, under) return shift(mix(under, pileAt(x, y), 0.45), 0.008, 0, 0) end,
  pressure={0.4, 0.8}, dips={18, 0.35, 0.7}, medium=0.5, pal=skypal})
local t = timesheet(); print(string.format("sitting %.0f min, touches %d", t.sitting, t.touches))
