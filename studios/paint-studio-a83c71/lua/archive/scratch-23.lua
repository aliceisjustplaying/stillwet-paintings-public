-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_dk = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.2}, {"green earth", 0.4}, name="heath_dk"}
heath_lt = pile{{"raw umber", 1.6}, {"yellow ochre", 0.4}, {"green earth", 0.6}, {"lead white", 0.35}, {"smalt", 0.2}, {"rose madder", 0.15}, name="heath_lt"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
-- sky/mist strip above for context
local sk = rect(0, 0, 1000, 300)
work(sk, {hand="broad", pile=mist_bright, angle=0, coverage=3, fill=true, clip=sk, tool={kind="filbert", width=22, lay=1.6}})
-- substrate: plateau-like ground, two bands (A at left, B at right) from y 300 down
SUB = rect(0, 300, 1000, 414)
local nb = noise{seed=277, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - 300) / 300, 0, 1) end
work(SUB, {hand="body", piles={{fg_top, function(x, y) return clamp(0.45 + nb(x, y), 0, 1) * (1 - depth(x, y)) * 0.8 end}, {fg_dark, 0.6}, {fg_deep, function(x, y) return depth(x, y) * 1.2 end}, {fg_warm, 0.3}}, coverage=3, fill=true, clip=SUB, angle=0.03, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}})
blend(SUB, {angle=0, tool={kind="badger", width=24}})
for i = 1, 30 do local t = wait(24*60); if drying(500, 500) == "dry" and drying(500, 700) == "dry" then print("dry", t) break end end
local nz = noise{seed=126, octaves=3, period=45}
local zone = SUB * mask(function(x, y) return clamp(0.4 + 1.4 * nz(x, y * 1.6), 0, 1) end)
local function sc(x, y) return 0.5 + 1.5 * depth(x, y) end
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.6}, {fg_deep, 0.8}}, coverage=1.8, clip=SUB, angle=-1.5, angle_jitter=0.4, length={6, 14}, scale_at=sc, tool={kind="round", width=1.4, point=0.8}, pressure={0.4, 0.8}})
local tops = zone * mask(function(x, y) return clamp(nz(x + 30, y * 1.6 - 20) * 2.2, 0, 1) end)
work(tops, {hand="hatch", piles={{heath_lt, 1}, {fg_top, 0.6}}, coverage=0.25, clip=SUB, angle=-1.5, angle_jitter=0.4, length={4, 9}, scale_at=sc, tool={kind="round", width=1.0, point=0.9}, pressure={0.3, 0.5}})
for i = 1, 30 do local t = wait(24*60); if drying(500, 500) == "dry" and drying(500, 700) == "dry" and drying(200, 400) == "dry" then print("dry2", t) break end end

--@ chunk 3
moor_far = pile{{"raw umber", 2}, {"smalt", 1.0}, {"lead white", 0.55}, {"bone black", 0.45}, {"green earth", 0.3}, {"rose madder", 0.1}, name="moor_far"}
moor_mid = pile{{"raw umber", 2.5}, {"bone black", 1.0}, {"green earth", 0.5}, {"yellow ochre", 0.2}, {"Prussian blue", 0.1}, name="moor_mid"}
moor_near = pile{{"raw umber", 2}, {"bone black", 1.6}, {"Prussian blue", 0.25}, {"red earth", 0.1}, name="moor_near"}
local function d(y) return clamp((y - 300) / 300, 0, 1) end
local function wf(x, y) return clamp(1 - d(y) / 0.35, 0, 1) end
local function wm(x, y) return clamp(1 - math.abs(d(y) - 0.4) / 0.4, 0, 1) end
local function wn(x, y) return clamp((d(y) - 0.35) / 0.5, 0, 1) end
local nb = noise{seed=377, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
-- A: opaque graded repaint
local A = rect(0, 300, 330, 414)
work(A, {hand="body", piles={{moor_far, wf}, {moor_mid, wm}, {moor_near, wn}, {fg_warm, function(x, y) return 0.15 + 0.2 * clamp(nb(x, y), 0, 1) end}}, coverage=3, fill=true, clip=A, angle=function(x, y) return 0.03 + 0.04 * math.sin(x / 70) end, angle_jitter=0.08, tool={kind="filbert", width=8}, length={30, 90}, scale_at=function(x, y) return 0.6 + 0.9 * d(y) end})
blend(A, {angle=0, tool={kind="badger", width=24}})
-- B: medium .5 darkening, piles graded
moor_glz = pile{{"raw umber", 1.5}, {"bone black", 1.0}, {"Prussian blue", 0.15}, medium=0.5, name="moor_glz"}
moor_glz_far = pile{{"raw umber", 1.5}, {"bone black", 0.5}, {"smalt", 0.6}, {"lead white", 0.3}, medium=0.5, name="moor_glz_far"}
local B = rect(340, 300, 320, 414)
work(B, {hand="body", piles={{moor_glz_far, wf}, {moor_glz, function(x, y) return 1 - wf(x, y) end}}, coverage=2.5, fill=true, clip=B, angle=0.04, angle_jitter=0.08, tool={kind="filbert", width=12}})
blend(B, {angle=0, tool={kind="badger", width=24}})
print(drying(150, 500), drying(500, 500))

--@ chunk 4
-- wet-into-wet heather on the left half of A
local yh = 260
local function pg(x, y) local dd = math.max(4, y - yh); local Z = 4000 / dd; return (x - 470) * Z / 100, Z * 3 end
local nz = noise{seed=16, octaves=3, period=60}
local W1 = rect(0, 300, 160, 414)
local zone = W1 * mask(function(x, y) local X, Z = pg(x, y); return clamp(0.1 + 1.6 * nz(X, Z), 0, 1) end)
local function sc(x, y) return 0.4 + 1.6 * clamp((y - 300) / 414, 0, 1) end
stipple(zone, {pile=heath_dk, width=2.2, coverage=function(x, y) return 1.2 end, cluster={0.5, 6}, clip=W1, pressure={0.3, 0.6}})
print(drying(80, 600))

--@ chunk 5
heath_cool = pile{{"raw umber", 1.6}, {"bone black", 0.6}, {"smalt", 0.9}, {"lead white", 0.45}, {"rose madder", 0.12}, {"green earth", 0.3}, name="heath_cool"}
-- C (x 670-1000): dark heather masses, noise-shaped in perspective, opaque body, near ground. Then a soft dark gradient at the bottom.
local yh = 230
local function pg(x, y) local dd = math.max(4, y - yh); local Z = 4000 / dd; return (x - 830) * Z / 100, Z * 3 end
local nz = noise{seed=21, octaves=4, period=55}
local C = rect(670, 300, 330, 414)
local function d(y) return clamp((y - 300) / 414, 0, 1) end
local massv = function(x, y) local X, Z = pg(x, y); return clamp((nz(X, Z) + 0.15 + 0.5 * d(y)) * 3.5, 0, 1) end
local M = C * mask(massv)
local function sc(x, y) return 0.4 + 1.4 * d(y) end
work(M, {hand="body", piles={{moor_near, 1}, {heath_dk, 0.8}, {fg_deep, function(x, y) return d(y) end}}, coverage=3, fill=true, clip=M, angle=-1.45, angle_jitter=0.6, tool={kind="filbert", width=5}, length={6, 16}, scale_at=sc})
print(drying(800, 600))
