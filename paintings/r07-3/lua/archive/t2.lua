rest(16)
sitting{hours=8}
local b = rect(0, 380, 1000, 50) * skyM
print("area", b:area())
stipple(b, {width=3.2, color="#e3c28e", coverage=2.0, pressure={0.4, 0.8}, dips={18, 0.35, 0.7}, medium=0.5, pal=skypal})
local t = timesheet(); print(string.format("sitting %.0f min, touches %d", t.sitting, t.touches))
