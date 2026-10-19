-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
mist_far = pile{{"lead white", 6}, {"smalt", 1.2}, {"rose madder", 0.25}, {"raw umber", 0.1}, name="mist_far"}
mist_low = pile{{"lead white", 4}, {"smalt", 1.5}, {"raw umber", 0.3}, {"rose madder", 0.2}, name="mist_low"}
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_dk = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.2}, {"green earth", 0.4}, name="heath_dk"}
heath_lt = pile{{"raw umber", 1.6}, {"yellow ochre", 0.4}, {"green earth", 0.6}, {"lead white", 0.35}, {"smalt", 0.2}, {"rose madder", 0.15}, name="heath_lt"}
FGL = {{-5.0,474.2},{15.0,469.4},{35.0,466.6},{55.0,461.5},{75.0,457.5},{95.0,461.9},{115.0,465.9},{135.0,476.8},{155.0,486.2},{175.0,486.7},{195.0,489.0},{215.0,493.0},{235.0,493.8},{255.0,495.1},{275.0,495.7},{295.0,496.8},{315.0,497.1},{335.0,498.0},{355.0,498.1},{375.0,496.8},{395.0,497.3},{415.0,497.7},{435.0,496.7},{455.0,497.5},{475.0,497.4},{495.0,495.8},{515.0,497.3},{535.0,498.9},{555.0,507.4},{576.0,550.6},{600.5,674.4},{606,720},{-5,720}}
PL = poly(FGL)
local sky = -PL
work(sky, {hand="broad", piles={{mist_far, function(x, y) return clamp(1 - (y - 300) / 150, 0, 1) end}, {mist_bright, function(x, y) return clamp(1 - math.abs(y - 500) / 150, 0, 1) end}, {mist_low, function(x, y) return clamp((y - 520) / 200, 0, 1) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=sky, tool={kind="filbert", width=22, lay=1.6}})
blend(sky, {angle=0, tool={kind="badger", width=60}})
cF = function(x) for y = 440, 720, 0.5 do if PL:at(x, y) > 0.5 then return y end end return 720 end
local nb = noise{seed=277, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - 490) / 200, 0, 1) end
local function wtop(x, y) return clamp(0.45 + 1.0 * nb(x, y), 0, 1) * (1 - depth(x, y)) ^ 1.5 * 0.8 end
local function wdark(x, y) return (1 - wtop(x, y)) * (1 - depth(x, y)) + 0.15 end
local function wdeep(x, y) return depth(x, y) ^ 0.8 * 1.2 end
local function wwarm(x, y) return 0.2 + 0.3 * clamp(nb(x + 300, y), 0, 1) end
P = PL:shrink(1)
work(P, {hand="body", piles={{fg_top, wtop}, {fg_dark, wdark}, {fg_deep, wdeep}, {fg_warm, wwarm}}, coverage=3, fill=true, clip=P, angle=0.03, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}, scale_at=function(x, y) return 0.6 + 0.9 * depth(x, y) end})
blend(P, {angle=0, tool={kind="badger", width=24}})
for i = 1, 30 do local t = wait(24*60); if drying(300, 600) == "dry" and drying(300, 700) == "dry" and drying(500, 400) == "dry" then print("dry", t) break end end
local nz = noise{seed=16, octaves=3, period=60}
local yh = 430
function pg(x, y) local d = math.max(4, y - yh); local Z = 4000 / d; return (x - 470) * Z / 100, Z * 3 end
local zone = mask(function(x, y) local X, Z = pg(x, y); return clamp(0.2 + 1.5 * nz(X, Z), 0, 1) end) * P
local function sc(x, y) return 0.3 + 1.3 * clamp((y - 490) / 220, 0, 1) end
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.7}, {fg_deep, 0.5}}, coverage=1.2, clip=zone, angle=-1.45, angle_jitter=0.35, length={4, 9}, scale_at=sc, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
local tops = zone * mask(function(x, y) local X, Z = pg(x, y); return clamp(nz(X + 40, Z - 30) * 2, 0, 1) end)
work(tops, {hand="hatch", piles={{heath_lt, 1}, {fg_top, 0.6}}, coverage=0.3, clip=tops, angle=-1.45, angle_jitter=0.35, length={3, 7}, scale_at=sc, tool={kind="round", width=1.0, point=0.8}, pressure={0.3, 0.5}})
for i = 1, 30 do local t = wait(24*60); if drying(300, 600) == "dry" and drying(300, 700) == "dry" then print("dry2", t) break end end
fg_glaze2 = pile{{"raw umber", 1.5}, {"bone black", 0.8}, {"Prussian blue", 0.15}, medium=0.5, name="fg_glaze2"}
local m = P * mask(function(x, y) return smoothstep(575, 712, y) end)
work(m, {hand="body", pile=fg_glaze2, coverage=2.5, fill=true, clip=m, angle=0.04, angle_jitter=0.08, tool={kind="filbert", width=12}, load_at=function(x, y) return clamp((y - 575) / 140, 0.05, 1) end})
local band = P * mask(function(x, y) return smoothstep(596, 612, y) * (1 - smoothstep(640, 660, y)) end)
blend(band, {angle=1.45, tool={kind="badger", width=14}})
blend(band, {angle=0.1, tool={kind="badger", width=30}})
for i = 1, 30 do local t = wait(24*60); if drying(300, 690) == "dry" and drying(300, 625) == "dry" then print("dry3", t) break end end
heath_mid = mix{{heath, 0.6}, {heath_lt, 0.4}, name="heath_mid"}
local nz2 = noise{seed=126, octaves=3, period=45}
local function fade(y) return smoothstep(585, 640, y) end
local zone2 = P:shrink(1) * mask(function(x, y) return clamp(0.5 + 1.4 * nz2(x, y * 1.6) - 1.6 * (1 - fade(y)), 0, 1) end)
local function sc2(x, y) return 0.8 + 1.2 * clamp((y - 580) / 134, 0, 1) end
work(zone2, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.6}, {fg_deep, 0.8}}, coverage=1.8, clip=P:shrink(1), angle=-1.5, angle_jitter=0.4, length={6, 14}, scale_at=sc2, tool={kind="round", width=1.4, point=0.8}, pressure={0.4, 0.8}})
local tops2 = zone2 * mask(function(x, y) return clamp(nz2(x + 30, y * 1.6 - 20) * 2.2, 0, 1) * clamp((685 - y) / 60, 0, 1) end)
work(tops2, {hand="hatch", piles={{heath_mid, 1}, {fg_top, 0.6}}, coverage=0.25, clip=P:shrink(1), angle=-1.5, angle_jitter=0.4, length={4, 9}, scale_at=sc2, tool={kind="round", width=1.0, point=0.9}, pressure={0.3, 0.5}})
for i = 1, 30 do local t = wait(24*60); if drying(300, 690) == "dry" and drying(300, 625) == "dry" then print("dry4", t) break end end

--@ chunk 3
heath_sil = pile{{"raw umber", 2}, {"bone black", 1}, {"green earth", 0.6}, {"Prussian blue", 0.2}, name="heath_sil"}
straw = pile{{"raw umber", 1.6}, {"yellow ochre", 0.7}, {"lead white", 0.35}, {"red earth", 0.15}, {"smalt", 0.15}, name="straw"}
-- a clump of tall dry grasses + heather stems rising from the near ground, bottom-left
function grass_clump(cx, base, w, h, n, seed, pdark, plight, lightshare)
  math.randomseed(seed)
  local b = brush{kind="round", width=1.3, point=0.95}
  local b2 = brush{kind="round", width=1.0, point=0.95}
  for i = 1, n do
    local u = rand(-1, 1)
    local x0 = cx + u * w * 0.5 + randn(0, 2)
    local y0 = base + rand(-3, 4)
    local L = h * rand(0.45, 1.0) * (1 - 0.35 * math.abs(u))
    local lean = u * 0.45 + randn(0, 0.18)
    local a = -math.pi / 2 + lean
    local bend = randn(0, 0.25) + lean * 0.4
    local p1 = {x0 + math.cos(a) * L * 0.5, y0 + math.sin(a) * L * 0.5}
    local a2 = a + bend
    local p2 = {p1[1] + math.cos(a2) * L * 0.5, p1[2] + math.sin(a2) * L * 0.5}
    local light = math.random() < lightshare
    local br = light and b2 or b
    if (i - 1) % 6 == 0 or light then br:reload(light and plight or pdark, 0.7) end
    br:gesture({{x0, y0, light and 0.45 or 0.7}, {p1[1], p1[2], light and 0.35 or 0.5}, {p2[1], p2[2], 0.0}})
  end
end
grass_clump(70, 712, 110, 70, 70, 11, heath_sil, straw, 0.12)
grass_clump(170, 716, 60, 45, 35, 12, heath_sil, straw, 0.1)
print("ok")

--@ chunk 4
crack_dark = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.2}, name="crack_dark"}
straw2 = pile{{"raw umber", 1.4}, {"yellow ochre", 0.8}, {"lead white", 0.5}, {"red earth", 0.2}, {"rose madder", 0.1}, {"smalt", 0.1}, name="straw2"}
grass_clump(360, 714, 120, 80, 80, 21, crack_dark, straw2, 0.22)
-- a few seed heads: tiny touches at some light stem tips
print("ok")
