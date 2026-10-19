-- the water's second layer, looking up at the sky for each band and laying its reflection a shade
-- darker, darker still toward me; then the town's reflection dragged down into it while wet
local base = HZ + 2
water2 = mask(function(x, y) return smoothstep(base - 1, base + 1.5, y) * (1 - smoothstep(bankcurve(x) + 2, bankcurve(x) + 9, y)) end)
local wn = noise{seed=81, period=160, octaves=3, stretch={0, 8}}
work(water2, {hand="broad", angle=0, angle_jitter=0.002, length={200, 520}, coverage=3.4, medium=0.3, pal=waterpal, hug=false,
  curve={0.01, 0}, cross=0, drift={0, 1},
  color_over=function(x, y, under)
    local d = y - base
    local sky = sample(x, math.max(4, HZ - 8 - d * 1.8), 8)
    local dark = smoothstep(4, 230, d)
    local want = mix(shift(sky, -0.05 - 0.02 * wn(x, y), 0, -0.005), "#3a4150", 0.62 * dark^0.9)
    return mix(under, want, 0.7)
  end})
-- the town mirrored in the calm water: same width, a little shorter, softer and lighter than itself
local rp = {}
for _, p in ipairs(TOWN2) do rp[#rp+1] = {p[1], base + (base - p[2]) * 0.92} end
rp[#rp+1] = {TOWN2[#TOWN2][1], base}; rp[#rp+1] = {TOWN2[1][1], base}
townRefl = poly(rp):roughen(0.8, 6, 83, 1)
work(townRefl, {hand="detail", tool="round 1.6", angle=1.57, angle_jitter=0.05, length={4, 14}, coverage=2.6, medium=0.3, pal=farpal, hug=false,
  color_over=function(x, y, under) return mix(under, "#666674", 0.4 * (1 - 0.7 * smoothstep(base, base + 90, y))) end})
blend(water2, {angle=0, angle_jitter=0.001, coverage=1.3, length={160, 420}, curve={0.005, 0}, cross=0, drift={0, 1}})
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
