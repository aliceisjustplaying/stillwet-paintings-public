-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_dk = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.2}, {"green earth", 0.4}, name="heath_dk"}
heath_lt = pile{{"raw umber", 1.6}, {"yellow ochre", 0.4}, {"green earth", 0.6}, {"lead white", 0.35}, {"smalt", 0.2}, {"rose madder", 0.15}, name="heath_lt"}
fg_glaze2 = pile{{"raw umber", 1.5}, {"bone black", 0.8}, {"Prussian blue", 0.15}, medium=0.5, name="fg_glaze2"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
work(rect(0,0,1000,500), {hand="broad", pile=mist_bright, coverage=3, fill=true, clip=true, angle=0})
local m = rect(0, 498, 1000, 216)
local nb = noise{seed=277, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - 498) / 200, 0, 1) end
local function wtop(x, y) return clamp(0.45 + 1.0 * nb(x, y), 0, 1) * (1 - depth(x, y)) ^ 1.5 * 0.8 end
work(m, {hand="body", piles={{fg_top, wtop}, {fg_dark, function(x, y) return (1 - wtop(x, y)) * (1 - depth(x, y)) + 0.15 end}, {fg_deep, function(x, y) return depth(x, y) ^ 0.8 * 1.2 end}, {fg_warm, function(x, y) return 0.3 end}}, coverage=3, fill=true, clip=m, angle=0.04, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}, scale_at=function(x, y) return 0.6 + 0.9 * depth(x, y) end})
blend(m, {angle=0, tool={kind="badger", width=24}})
wait(10*24*60)
local nz = noise{seed=16, octaves=3, period=60}
local function pg(x, y) local d = math.max(4, y - 430); local Z = 4000 / d; return (x - 470) * Z / 100, Z * 3 end
local zone = mask(function(x, y) local X, Z = pg(x, y); return clamp(0.2 + 1.5 * nz(X, Z), 0, 1) end) * m
local function sc(x, y) return 0.3 + 1.3 * clamp((y - 490) / 220, 0, 1) end
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.7}, {fg_deep, 0.5}}, coverage=1.2, clip=zone, angle=-1.45, angle_jitter=0.35, length={4, 9}, scale_at=sc, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
wait(5*24*60)
local mm = m * mask(function(x, y) return smoothstep(575, 712, y) end)
work(mm, {hand="body", pile=fg_glaze2, coverage=2.5, fill=true, clip=mm, angle=0.04, tool={kind="filbert", width=12}, load_at=function(x, y) return clamp((y - 575) / 140, 0.05, 1) end})
wait(10*24*60)
print(drying(500, 600))

--@ chunk 3
path_p = pile{{"raw umber", 1.8}, {"smalt", 0.8}, {"lead white", 0.6}, {"bone black", 0.35}, {"yellow ochre", 0.2}, {"rose madder", 0.08}, name="path_p"}
-- path centerline in canvas coords, from bottom (near, wide) to figure's feet (far, narrow)
PATHC = {{250, 716}, {300, 668}, {360, 622}, {410, 580}, {432, 548}, {448, 524}, {458, 508}, {466, 500}}
local function width_at(y) return 1.5 + (y - 498) * 0.28 end
local L, R = {}, {}
local n = noise{seed=3, octaves=3, period=20}
for i, p in ipairs(PATHC) do
  local w = width_at(p[2])
  L[#L+1] = {p[1] - w * (1 + 0.2 * n(p[1], p[2])), p[2]}
  R[#R+1] = {p[1] + w * (1 + 0.2 * n(p[1] + 50, p[2])), p[2]}
end
local q = {}
for _, p in ipairs(L) do q[#q+1] = p end
for i = #R, 1, -1 do q[#q+1] = R[i] end
local pm = poly(q, true):roughen(2, 12, 5):soften(3)
local function sc(x, y) return 0.3 + 1.3 * clamp((y - 490) / 220, 0, 1) end
work(pm, {hand="body", piles={{path_p, function(x, y) return clamp(1 - (y - 500) / 300, 0.3, 1) end}, {fg_dark, function(x, y) return clamp((y - 520) / 200, 0, 0.8) end}}, coverage=2.5, fill=true, clip=pm, angle=function(x, y) return 0.1 end, angle_jitter=0.15, tool={kind="filbert", width=5}, length={10, 40}, scale_at=sc, load_at=function(x, y) return 0.7 end})
blend(pm:grow(2), {angle=0.1, tool={kind="badger", width=14}})
print("ok")

--@ chunk 4
wait(10*24*60)
local m = rect(0, 498, 1000, 216)
work(m, {hand="body", piles={{fg_dark, 1}, {fg_deep, 0.5}}, coverage=3, fill=true, clip=m, angle=0.03, tool={kind="filbert", width=10}})
local nz = noise{seed=16, octaves=3, period=60}
local function pg(x, y) local d = math.max(4, y - 430); local Z = 4000 / d; return (x - 470) * Z / 100, Z * 3 end
local zone = mask(function(x, y) local X, Z = pg(x, y); return clamp(0.2 + 1.5 * nz(X, Z), 0, 1) end) * m
local function sc(x, y) return 0.3 + 1.3 * clamp((y - 490) / 220, 0, 1) end
wait(10*24*60)
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.7}, {fg_deep, 0.5}}, coverage=1.2, clip=zone, angle=-1.45, angle_jitter=0.35, length={4, 9}, scale_at=sc, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
wait(10*24*60)
path2 = mix{{path_p, 0.5}, {fg_dark, 0.5}, name="path2"}
local PC = {{330, 716}, {362, 676}, {392, 636}, {418, 598}, {436, 566}, {449, 540}, {458, 520}, {465, 506}, {468, 500}}
local function width_at(y) return 0.8 + (y - 498) * 0.11 end
local L, R = {}, {}
local n = noise{seed=4, octaves=3, period=15}
for i, p in ipairs(PC) do
  local w = width_at(p[2])
  L[#L+1] = {p[1] - w * (1 + 0.35 * n(p[1], p[2])), p[2]}
  R[#R+1] = {p[1] + w * (1 + 0.35 * n(p[1] + 50, p[2])), p[2]}
end
local q = {}
for _, p in ipairs(L) do q[#q+1] = p end
for i = #R, 1, -1 do q[#q+1] = R[i] end
local pm = poly(q, true):roughen(1.5, 8, 6) * mask(function(x, y) return clamp((705 - y) / 60, 0, 1) end)
work(pm, {hand="body", piles={{path2, function(x, y) return clamp(1 - (y - 500) / 260, 0.2, 1) end}, {fg_dark, function(x, y) return clamp((y - 540) / 180, 0, 0.9) end}}, coverage=1.6, fill=false, clip=pm, angle=-0.9, angle_jitter=0.2, tool={kind="filbert", width=4}, length={8, 25}, scale_at=sc, load=0.6})
-- grass across its edges
local edge = (pm:grow(3) - pm:shrink(2))
work(edge, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.6}}, coverage=0.8, clip=edge, angle=-1.45, angle_jitter=0.35, length={4, 9}, scale_at=sc, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
print("ok")

--@ chunk 5
heath_mid = mix{{heath, 0.6}, {heath_lt, 0.4}, name="heath_mid"}
local m = rect(600, 560, 400, 154)
local nz = noise{seed=26, octaves=3, period=45}
local zone = m * mask(function(x, y) return clamp(0.35 + 1.4 * nz(x, y * 1.6), 0, 1) end)
local function sc(x, y) return 0.9 + 1.4 * clamp((y - 560) / 154, 0, 1) end
-- near heath: fanning upward strokes, larger at the bottom
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.8}, {fg_deep, 0.4}}, coverage=1.6, clip=m, angle=-1.5, angle_jitter=0.45, length={6, 14}, scale_at=sc, tool={kind="round", width=1.4, point=0.8}, pressure={0.4, 0.8}})
local tops = zone * mask(function(x, y) return clamp(nz(x + 30, y * 1.6 - 20) * 2.2, 0, 1) end)
work(tops, {hand="hatch", piles={{heath_mid, 1}, {fg_top, 0.5}}, coverage=0.45, clip=m, angle=-1.5, angle_jitter=0.4, length={4, 9}, scale_at=sc, tool={kind="round", width=1.0, point=0.9}, pressure={0.3, 0.55}})
print("ok")

--@ chunk 6
wait(10*24*60)
dark_t = pile{{"raw umber", 1.5}, {"bone black", 1}, {"Prussian blue", 0.15}, thinner=0.5, name="dark_t"}
dark_m = pile{{"raw umber", 1.5}, {"bone black", 1}, {"Prussian blue", 0.15}, medium=0.6, name="dark_m"}
local A = rect(600, 520, 200, 194) * mask(function(x, y) return smoothstep(540, 640, y) end)
local B = rect(800, 520, 200, 194) * mask(function(x, y) return smoothstep(540, 640, y) end)
work(A, {hand="body", pile=dark_t, coverage=2.5, clip=A, angle=0.05, tool={kind="filbert", width=12}, load_at=function(x, y) return smoothstep(540, 660, y) end})
work(A, {hand="body", pile=dark_t, coverage=2.5, clip=A, angle=-0.1, tool={kind="filbert", width=12}, load_at=function(x, y) return smoothstep(560, 690, y) end})
work(B, {hand="glaze", pile=dark_m, coverage=2.5, clip=B, angle=0.05, load_at=function(x, y) return smoothstep(540, 660, y) end})
blend(B, {angle=0.05, tool={kind="badger", width=40}})
print("ok")
