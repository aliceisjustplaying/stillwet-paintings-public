rest(16); sitting{hours=6}
barkpal = pal:only{"lead white", "yellow ochre", "raw umber", "bone black", "pale smalt", "red earth"}
BARK = {dark="#29241f", body="#342c25", ridge="#4a4036", rim="#6f6c70", cleft="#1a1715"}
-- the bole: body strokes up the form, found against the light
local lean = function(x, y) return -1.57 + 0.004 * (x - 500) end
work(trunkM, {hand="body", tool="filbert 4", length={12, 36}, coverage=2.8, medium=0.15, pal=barkpal, angle=lean, angle_jitter=0.2,
  color=function(x, y) return mix(BARK.body, BARK.dark, smoothstep(450, 610, y) * 0.7) end, edge={found=0.65, soft=0.35, period=25, seed=13}})
local t = timesheet(); print(t.sitting)
