dry()
-- two long thin streaks of cloud low in the glow, lit rose from below, gray above
local cn = noise{seed=181, octaves=5, period=260, stretch={0.0, 14}, warp={90, 8}}
local band = function(y0, th, x0, x1) return mask(function(x, y)
  local e = smoothstep(x0, x0 + 80, x) * (1 - smoothstep(x1 - 120, x1, x))
  local d = math.abs(y - y0 - 6*cn(x*0.3, 3)) / th
  return e * clamp(1.2 - d, 0, 1) * smoothstep(0.45, 0.7, cn:at01(x, y))
end) end
STREAKS = band(372, 5, 520, 1000) + band(398, 3.5, 60, 520) + band(344, 3, 700, 980)
work(STREAKS, {hand="scumble", tool="round 2", length={30, 90}, coverage=2.2, medium=0.35, angle=0, angle_jitter=0.02, hug=false,
  color=function(x, y) return mix("#a69ea6", "#d8b7a4", smoothstep(-3, 4, y - 372 + (x < 520 and -26 or 0))) end, edge="lost"})
-- the village church far off on the hills: nave, a slim tower and spire, as hazed as the hills
local chx, chy = 648, hills(648) + 5
CHURCH = rect(chx - 14, chy - 7, 20, 9) + poly({{chx - 15, chy - 7}, {chx - 4, chy - 11.5}, {chx + 7, chy - 7}}) +
  rect(chx + 4, chy - 22, 4.2, 22) + poly({{chx + 3.6, chy - 22}, {chx + 6.1, chy - 38}, {chx + 8.6, chy - 22}})
work(CHURCH, {hand="detail", tool="round 1", length={2, 6}, coverage=3.4, medium=0.15, angle=-1.57, color="#8a8590", edge={found=0.4, soft=0.6, period=8, seed=18}})
local roofs = rect(chx - 34, chy - 4, 14, 6) + poly({{chx - 35, chy - 4}, {chx - 27, chy - 8}, {chx - 19, chy - 4}}) + rect(chx + 16, chy - 3, 11, 5)
work(roofs, {hand="detail", tool="round 1", length={2, 6}, coverage=3, medium=0.15, angle=0, color="#948e97", edge="soft"})
-- the new moon, a thin crescent low in the west over the glow, its lit side toward the set sun
MOON = {x=452, y=236, r=6.5}
-- one stroke of a pointed brush from horn to horn along the lit limb, swelling in the middle
local mb = brush{kind="round", width=2.6, point=1}
mb:load("#f2ecd6", 1)
local arc = {}
for k = 0, 8 do local a = math.rad(-35 + 150*k/8)   -- lit limb toward the lower right
  arc[#arc+1] = {MOON.x + MOON.r*math.cos(a), MOON.y + MOON.r*math.sin(a)} end
mb:stroke(arc, {pressure={0.05, 0.85, 0.05}, ramps={0.45, 0.45}})
mb:reload("#f5f0de", 0.8)
mb:stroke(arc, {pressure={0.02, 0.55, 0.02}, ramps={0.4, 0.4}})
-- crows going home over the oak
local cb = brush{kind="round", width=1.4, point=1}
cb:load("#2f2b2d", 0.9)
for _, c in ipairs({{700, 214, 5.2, 0.1}, {731, 203, 4.4, -0.15}, {664, 238, 3.8, 0.25}, {848, 188, 3.2, 0}}) do
  local x, y, s, t = c[1], c[2], c[3], c[4]
  cb:stroke({{x - s, y - 0.9*s + t*s}, {x - 0.4*s, y - 0.1*s}, {x, y + 0.15*s}}, {pressure={0.1, 0.7}, ramps={0.5, 0.1}})
  cb:stroke({{x, y + 0.15*s}, {x + 0.45*s, y - 0.15*s}, {x + 1.1*s, y - 0.8*s - t*s}}, {pressure={0.7, 0.1}, ramps={0.1, 0.5}})
end
