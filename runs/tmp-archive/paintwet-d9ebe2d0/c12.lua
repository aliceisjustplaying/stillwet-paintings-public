-- the spit: a low grassy tongue running out from the wood's foot. First the water relaid over the smudged
-- drips under it (full load, laid lightly, level), then the spit, its reeds and its short mirror.
SPIT = outline{pts={{318,446},{336,455},{352,459},{372,462},{396,465},{420,467.5},{442,469.5},{456,471},
                    {440,472.5},{380,473},{318,474}}, char="soft", lobe=4, amount=0.6, seed=52}
spitM = SPIT:mask()
spitRefl = mask(function(x, y) local wl = 472
  if y <= wl then return 0 end return spitM:at(x, wl - (y - wl)/0.8) end):soften(0.8)
local fixW = mask(function(x, y)
  return smoothstep(338, 356, x) * (1 - smoothstep(470, 492, x)) * smoothstep(469, 472, y) * (1 - smoothstep(496, 508, y)) end) - reflM - spitM
work(fixW, {hand="body", tool="filbert 5", color=waterCol, angle=0, angle_jitter=0.004, curve={0, 0}, length={30, 90},
  coverage=3.0, medium=0.25, load=1.0, pressure={0.3, 0.45}, ramps={0.3, 0.3}, pal=skypal, clip=fixW:grow(1) * waterM})
work(spitM, {hand="body", tool="filbert 3", color=function(x, y)
    return mix("#3a3a32", "#22231e", smoothstep(460, 471, y)) end, angle=0.06, angle_jitter=0.1, length={8, 26},
  coverage=2.8, medium=0.2, load=0.9, clip=spitM:grow(0.6) - wood})
work(spitRefl, {hand="body", tool="filbert 3", color="#2c2e2a", angle=math.pi/2, length={3, 8}, coverage=2.4, medium=0.25, load=0.8,
  clip=spitRefl:grow(0.8)})
blend(spitRefl:grow(3), {angle=0, angle_jitter=0.004, length={20, 60}, coverage=1.6, clip=waterM - spitM})
-- reeds on the spit, a few upright flicks, darker near the wood, sparse toward the tip
local rr = brush("rigger", 0.6)
local n = 0
for x = 326, 440, 3.2 do
  if rand() < 0.75 - 0.5*smoothstep(360, 440, x) then
    local y0 = 458 + (x - 320)*0.095 + rand(0, 2)
    local h = rand(3, 9) * (1 - 0.5*smoothstep(360, 440, x))
    if n % 5 == 0 then rr:reload(rand() < 0.3 and "#5d5a4a" or "#23241f", 0.7) end
    rr:stroke({{x, y0}, {x + rand(-1, 1), y0 - h*0.6}, {x + rand(-2, 2.5), y0 - h}}, {pressure={0.5, 0}, ramps={0.05, 0.7}})
    n = n + 1
  end
end
-- small firs down the wood's steep right flank, so it isn't one cut edge
FLANK = {}
for i, p in ipairs({{314, 392, 46}, {326, 418, 36}, {333, 437, 26}, {344, 452, 17}}) do
  local f = fir{x=p[1], y=p[2] + p[3], height=p[3], width=p[3]*rand(0.22, 0.3), habit="spire", seed=300 + i}
  FLANK[#FLANK + 1] = f
  local nd = f:needles()
  work(nd, {hand="hatch", tool="round 1.2", length={2, 5}, coverage=2.6, clip=nd, angle=1.57, angle_jitter=0.4, color="#1b201c", medium=0.2})
  f:paint(brush("round", math.max(0.8, f.hatch)), {color="#171c19", lit={0, 1}})
end
print(n, spitM:area())
