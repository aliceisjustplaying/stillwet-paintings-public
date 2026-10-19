-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.3347921225382933, ground={{apply="knife", pile={{"lead white", 6}, {"yellow ochre", 0.05}}, texture=0.25, um=70}, {apply="roller", pile={{"lead white", 1}}, um=35}}, linen={17, 15}, seed=2417, size=610}

--@ chunk 2
lw = pile{{"lead white", 1}, medium=0.45, name="liquid_white"}
sky_top = pile{{"cobalt blue", 1}, {"Prussian blue", 0.25}, {"vermilion", 0.05}, {"lead white", 1.0}, name="sky_top"}
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.4}, {"vermilion", 0.2}, name="sky_mid"}
sky_glow = pile{{"lead white", 4}, {"chrome yellow", 0.6}, {"vermilion", 0.3}, name="sky_glow"}
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.6}, {"vermilion", 0.05}, name="sky_low"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
local function d(x,y) return math.sqrt(((x+80)/950)^2 + ((y-480)/440)^2) end
local function wtop(x,y) return clamp((d(x,y) - 0.7)/0.35, 0, 1)^1.3 * 1.5 end
local function wmid(x,y) return math.exp(-((d(x,y)-0.62)/0.2)^2) end
local function wglow(x,y) return math.exp(-((d(x,y)-0.36)/0.17)^2) end
local function wlow(x,y) return clamp(1 - d(x,y)/0.28, 0, 1) * 1.5 end
local sky = rect(0, 0, 1000, 480)
local P = {{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}}
work(sky, {hand="broad", piles=P, coverage=1.4, load=0.4, angle=0.7, length={60,120}})
work(sky, {hand="broad", piles=P, coverage=1.4, load=0.4, angle=-0.7, length={60,120}})
blend(rect(0, 0, 1000, 490):soften(20), {angle=0, clip=false})
blend(rect(0, 0, 1000, 490):soften(20), {angle=0.15, clip=false})
blend(rect(0, 0, 1000, 490):soften(20), {angle=-0.1, clip=false})

--@ chunk 3
skyline = {{0,410},{60,404},{120,398},{170,402},{220,396},{270,388},{320,374},{360,360},{395,344},{425,326},{452,304},{474,282},{494,262},{512,246},{528,232},{545,214},{560,198},{574,186},{586,176},{593,172},{601,177},{614,189},{630,205},{648,224},{664,243},{678,258},{690,266},{702,263},{716,256},{732,248},{748,238},{762,232},{772,236},{786,246},{804,258},{826,271},{852,283},{884,293},{920,302},{960,312},{1000,322}}
function skyline_y(x)
  for i = 1, #skyline - 1 do
    local a, b = skyline[i], skyline[i+1]
    if x >= a[1] and x <= b[1] then
      local t = (x - a[1]) / (b[1] - a[1])
      return a[2] + t * (b[2] - a[2])
    end
  end
  return skyline[#skyline][2]
end
local pts = {}
for i, p in ipairs(skyline) do pts[#pts+1] = {p[1], p[2]} end
pts[#pts+1] = {1000, 470}; pts[#pts+1] = {0, 470}
mtn = poly(pts):roughen(2.5, 18, 21)
mtn_dark = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"red earth", 0.6}, {"bone black", 0.3}, {"lead white", 0.6}, name="mtn_dark"}
work(mtn, {hand="body", pile=mtn_dark, coverage=2.2, load=0.7, clip=true, fill=true, angle=function(x,y) return 1.2 end, length={25,60}})
print(mtn:area())

--@ chunk 4
snow_lit = pile{{"lead white", 5}, {"vermilion", 0.2}, {"chrome yellow", 0.25}, blot=0.15, name="snow_lit"}
snow_sh = pile{{"lead white", 3}, {"cobalt blue", 0.6}, {"red earth", 0.12}, {"Prussian blue", 0.04}, blot=0.15, name="snow_sh"}
math.randomseed(7)
local ks = knife{width=22}
-- lit face of main peak, left ridge: pull from ridge point down-left along the slope fall line
local function lit_strokes(x0, x1, n, len, ang_down)
  for i = 1, n do
    local x = lerp(x0, x1, (i-1)/(n-1)) + rand(-6, 6)
    local y = skyline_y(x) + rand(1, 4)
    ks:wipe(); ks:load(snow_lit, rand(0.3, 0.45))
    local L = len * rand(0.5, 1.2)
    local a = ang_down + rand(-0.15, 0.15)
    ks:lay({{x, y}, {x + math.cos(a)*L*0.5, y + math.sin(a)*L*0.5}, {x + math.cos(a)*L, y + math.sin(a)*L}}, {pressure={rand(0.15, 0.25), rand(0.25, 0.4)}, angle=a + rand(-0.5,0.5)})
  end
end
lit_strokes(480, 590, 12, 45, 2.0)   -- down-left from left ridge of main peak
lit_strokes(700, 760, 6, 35, 2.1)
lit_strokes(330, 460, 8, 30, 1.9)
-- shadow face: right of the peak, down-right
local function sh_strokes(x0, x1, n, len, ang)
  for i = 1, n do
    local x = lerp(x0, x1, (i-1)/(n-1)) + rand(-6, 6)
    local y = skyline_y(x) + rand(1, 4)
    ks:wipe(); ks:load(snow_sh, rand(0.25, 0.4))
    local L = len * rand(0.5, 1.2)
    local a = ang + rand(-0.15, 0.15)
    ks:lay({{x, y}, {x + math.cos(a)*L*0.5, y + math.sin(a)*L*0.5}, {x + math.cos(a)*L, y + math.sin(a)*L}}, {pressure={rand(0.2, 0.3), rand(0.3, 0.45)}, angle=a + rand(-0.5,0.5)})
  end
end
sh_strokes(600, 680, 9, 40, 1.1)
sh_strokes(770, 880, 9, 30, 1.0)

--@ chunk 5
math.randomseed(9)
local kb = knife{width=34}
-- broad lit swaths on the left foothill slope (x 150-420), blade along ridge, path down the fall line
for i = 1, 9 do
  local x = 160 + (i-1) * 30 + rand(-5, 5)
  local y = skyline_y(x) + 1
  kb:wipe(); kb:load(snow_lit, 0.45)
  local a = 1.85 + rand(-0.12, 0.12)
  local L = rand(40, 70)
  kb:lay({{x, y}, {x + math.cos(a)*L*0.5, y + math.sin(a)*L*0.5}, {x + math.cos(a)*L, y + math.sin(a)*L}}, {pressure={0.18, 0.55}, angle=2.75 + rand(-0.15, 0.15)})
end
-- on the right shoulder (x 820-990), shadow-side snow, blade across the path
for i = 1, 7 do
  local x = 820 + (i-1) * 26 + rand(-5, 5)
  local y = skyline_y(x) + 1
  kb:wipe(); kb:load(snow_sh, 0.45)
  local a = 1.25 + rand(-0.12, 0.12)
  local L = rand(35, 60)
  kb:lay({{x, y}, {x + math.cos(a)*L*0.5, y + math.sin(a)*L*0.5}, {x + math.cos(a)*L, y + math.sin(a)*L}}, {pressure={0.2, 0.55}, angle=0.35 + rand(-0.15, 0.15)})
end

--@ chunk 6
mist = pile{{"lead white", 4}, {"cobalt blue", 0.25}, {"vermilion", 0.12}, {"chrome yellow", 0.08}, medium=0.2, name="mist"}
local band = mask(function(x, y)
  local t = (y - 400) / 70
  return clamp(t, 0, 1) * clamp((475 - y)/6, 0, 1)
end)
work(band, {hand="scumble", pile=mist, coverage=0.9, angle=0, length={20,40}})
local lift = mask(function(x, y) return clamp((y - 380)/60, 0, 1) * clamp((480 - y)/10, 0, 1) end)
blend(lift, {angle=-math.pi/2 + 0.1})
blend(lift, {angle=0})

--@ chunk 7
local r = rect(0, 520, 1000, 130)
work(r, {hand="body", pile=mtn_dark, coverage=2.4, load=0.7, clip=true, angle=1.2, length={25,60}})
mist = pile{{"lead white", 4}, {"cobalt blue", 0.3}, {"vermilion", 0.12}, {"chrome yellow", 0.1}, name="mist"}
mist_t = pile{{"lead white", 4}, {"cobalt blue", 0.3}, {"vermilion", 0.12}, {"chrome yellow", 0.1}, thinner=0.5, name="mist_t"}
-- A: broad horizontal, load graded upward, then blend up
local A = rect(0, 560, 330, 90)
work(A, {hand="broad", pile=mist, coverage=1.0, load_at=function(x,y) return clamp((y-560)/90, 0, 1) * 0.35 end, angle=0, length={60,120}, clip=true})
blend(rect(0, 540, 330, 110), {angle=-math.pi/2})
-- B: thinned mist, several light passes, no blend
local B = mask(function(x,y) if x < 340 or x > 660 then return 0 end return clamp((y-560)/90, 0, 1) end)
for i=1,3 do work(B, {hand="body", pile=mist_t, coverage=0.8, load=0.4, angle=0, length={30,70}, clip=true, seed=900+i}) end
-- C: stipple with clean dry brush upward lifts? use touches of mist with fan, drag up
local fanb = brush{kind="fan", width=20}
for i=1,40 do
  fanb:load(mist, 0.25)
  local x = rand(680, 990); local y = rand(610, 648)
  fanb:touch(x, y, {pressure=0.5, drag={rand(-3,3), -rand(8, 20)}, angle=0})
end
blend(rect(670, 560, 330, 90), {angle=0})

--@ chunk 8
local r = rect(0, 660, 1000, 85)
work(r, {hand="body", pile=mtn_dark, coverage=2.4, load=0.7, clip=true, angle=1.2, length={25,60}})
local fanb = brush{kind="fan", width=22}
for i=1,140 do
  if i % 2 == 1 then fanb:load(mist, 0.35) end
  local x = rand(20, 600); local y = 745 - 60 * rand(0,1)^1.8
  fanb:touch(x, y, {pressure=rand(0.4,0.65), drag={rand(-4,4), -rand(10, 26)}, angle=rand(-0.2,0.2)})
end
local soft = mask(function(x,y) return smoothstep(650, 700, y) * smoothstep(0, 30, x) * (1 - smoothstep(590, 640, x)) end)
blend(soft, {angle=0})
blend(soft, {angle=-math.pi/2 + 0.15})

--@ chunk 9
r1 = rag()
local m = mask(function(x,y) if x < 650 then return 0 end return smoothstep(670, 745, y) end)
r1:wipe(m, {pressure=0.5, angle=0, passes=2, refold=0.6})
print(r1)

--@ chunk 10
mist_b = pile{{"lead white", 4}, {"cobalt blue", 0.3}, {"vermilion", 0.12}, {"chrome yellow", 0.1}, blot=0.2, name="mist_b"}
local D = rect(650, 660, 170, 85)
stipple(D, {pile=mist_b, width=10, coverage=function(x,y) return 2.5 * smoothstep(670, 745, y) end, pressure={0.3, 0.6}, feather=0.5, clip=true})
work(rect(830, 690, 170, 55), {hand="body", pile=mist_b, coverage=1.2, load_at=function(x,y) return 0.1 + 0.45 * smoothstep(690, 745, y) end, angle=0, length={15,35}, clip=true, pressure={0.2,0.45}})
local soft = mask(function(x,y) return smoothstep(650, 680, y) * smoothstep(640, 660, x) end)
blend(soft, {angle=0})
