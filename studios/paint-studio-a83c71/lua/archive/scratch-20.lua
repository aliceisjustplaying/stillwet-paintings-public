-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
mist_low = pile{{"lead white", 4}, {"smalt", 1.5}, {"raw umber", 0.3}, {"rose madder", 0.2}, name="mist_low"}
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
-- mist background
local bg = rect(0, 400, 1000, 314)
work(bg, {hand="broad", piles={{mist_bright, function(x,y) return clamp(1-(y-400)/250,0,1) end}, {mist_low, function(x,y) return clamp((y-450)/250,0,1)+0.2 end}}, angle=0, coverage=3.5, load=1, fill=true, clip=bg, tool={kind="filbert", width=22, lay=1.6}})
blend(bg, {angle=0, tool={kind="badger", width=60}})
-- cliffs: three test shapes
CL = {}
for i, x0 in ipairs({120, 420, 720}) do
  local o = outline{{x0 - 80, 716, "c"}, {x0 - 80, 470, "c"}, {x0 + 5, 470, "c"}, {x0 + 10, 500, "c"}, {x0 + 25, 503, "c"}, {x0 + 30, 530, "c"}, {x0 + 45, 535, "c"}, {x0 + 48, 570, "c"}, {x0 + 60, 575, "c"}, {x0 + 62, 610}, {x0 + 70, 650, "c"}, {x0 + 78, 655, "c"}, {x0 + 82, 716, "c"}, char="broken", seed=40 + i, closed=true, amount=0.35}
  CL[i] = o:mask()
  work(CL[i], {hand="body", piles={{fg_dark, 0.6}, {fg_deep, 0.6}, {fg_warm, 0.2}}, coverage=3, fill=true, clip=CL[i], angle=1.35, angle_jitter=0.25, tool={kind="filbert", width=5}})
  local rim = (CL[i] - CL[i]:shrink(3.5))
  work(rim, {hand="detail", pile=pile{{"raw umber", 1.5}, {"lead white", 1.0}, {"smalt", 0.8}, {"rose madder", 0.15}, {"bone black", 0.3}}, coverage=1.6, fill=true, clip=rim, angle=1.5, load=0.5, tool={kind="round", width=1.4}})
end
for i = 1, 30 do
  local t = wait(24*60)
  if drying(200, 600) == "dry" and drying(500, 450) == "dry" and drying(160, 600) == "dry" then print("dry", t) break end
end

--@ chunk 3
for i = 1, 3 do
  work(CL[i], {hand="body", piles={{fg_dark, 0.6}, {fg_deep, 0.6}, {fg_warm, 0.2}}, coverage=3, fill=true, clip=CL[i], angle=1.35, angle_jitter=0.25, tool={kind="filbert", width=5}})
end
for i = 1, 30 do
  local t = wait(24*60)
  if drying(100, 600) == "dry" and drying(400, 600) == "dry" then print("dry", t) break end
end
for i = 1, 3 do
  local rim = (CL[i] - CL[i]:shrink(3.5)) * mask(function(x, y) return y > 480 and 1 or 0 end)
  work(rim, {hand="detail", pile=pile{{"raw umber", 1.5}, {"lead white", 1.0}, {"smalt", 0.8}, {"rose madder", 0.15}, {"bone black", 0.3}}, coverage=1.6, fill=true, clip=rim, angle=1.5, load=0.5, tool={kind="round", width=1.4}})
  blend(CL[i]:shrink(0.5), {angle=1.5, tool={kind="badger", width=8}})
end
for i = 1, 30 do
  local t = wait(24*60)
  if drying(100, 600) == "dry" and drying(203, 600) == "dry" then print("dry", t) break end
end

--@ chunk 4
face_cool = pile{{"raw umber", 1.5}, {"bone black", 0.7}, {"smalt", 0.9}, {"lead white", 0.35}, {"rose madder", 0.12}, name="face_cool"}
sand_face = pile{{"raw umber", 2}, {"lead white", 0.55}, {"red earth", 0.3}, {"yellow ochre", 0.3}, {"bone black", 0.35}, {"rose madder", 0.1}, name="sand_face"}
sand2 = mix{{sand_face, 0.4}, {fg_dark, 0.6}, name="sand2"}
function face_pass(M, grow, veil, seed)
  local m = M:grow(grow)
  local d = M:distance()
  local nv = noise{seed=seed, octaves=3, period=40, stretch={1.5708, 5}}
  local function edgew(x, y) return clamp(1 - d:at(x, y) / 10, 0, 1) end
  local function vw(x, y) if not veil then return 0 end return veil(x, y) end
  local piles = {
    {face_cool, function(x, y) return (1 - vw(x, y)) * (0.25 + 0.9 * edgew(x, y)) end},
    {sand2, function(x, y) return (1 - vw(x, y)) * clamp(0.35 + 0.8 * nv(x, y), 0, 1) * 0.6 * (1 - edgew(x, y)) end},
    {fg_dark, function(x, y) return (1 - vw(x, y)) * 0.5 end},
    {fg_deep, function(x, y) return (1 - vw(x, y)) * clamp(-nv(x, y), 0, 1) * 0.8 end},
    {mist_low, function(x, y) return vw(x, y) * 1.2 end},
  }
  work(m, {hand="body", piles=piles, coverage=2.8, fill=true, clip=m, angle=1.5, angle_jitter=0.1, tool={kind="filbert", width=4}, length={12, 35}, load=0.8})
  blend(m, {angle=1.5, tool={kind="badger", width=8}})
end
local x0 = 120
local veil = function(x, y) return smoothstep(630, 714, y) * smoothstep(x0 + 20, x0 + 75, x) * 0.75 end
face_pass(CL[1], 0.8, veil, 61)
face_pass(CL[2], 0.0, nil, 62)
print(drying(100, 600))

--@ chunk 5
face_lit = pile{{"raw umber", 1.5}, {"bone black", 0.4}, {"smalt", 1.0}, {"lead white", 0.9}, {"rose madder", 0.15}, name="face_lit"}
local x0 = 720
local M = CL[3]
local veil = function(x, y) return smoothstep(625, 705, y) * smoothstep(x0 + 15, x0 + 80, x) * 0.8 end
local m = M:grow(0.8)
local d = M:distance()
local nv = noise{seed=63, octaves=3, period=40, stretch={1.5708, 5}}
local function edgew(x, y) return clamp(1 - d:at(x, y) / 10, 0, 1) end
local piles = {
  {face_cool, function(x, y) return (1 - veil(x, y)) * (0.25 + 0.9 * edgew(x, y)) end},
  {sand2, function(x, y) return (1 - veil(x, y)) * clamp(0.35 + 0.8 * nv(x, y), 0, 1) * 0.6 * (1 - edgew(x, y)) end},
  {fg_dark, function(x, y) return (1 - veil(x, y)) * 0.5 end},
  {fg_deep, function(x, y) return (1 - veil(x, y)) * clamp(-nv(x, y), 0, 1) * 0.8 end},
  {mist_low, function(x, y) return veil(x, y) * 1.4 end},
}
work(m, {hand="body", piles=piles, coverage=2.8, fill=true, clip=m, angle=function(x, y) return 1.5 * (1 - veil(x, y)) end, angle_jitter=0.1, tool={kind="filbert", width=4}, length={12, 35}, load=0.8})
blend(m, {angle=1.5, tool={kind="badger", width=8}})
local vz = m * mask(function(x, y) return clamp(veil(x, y) * 3, 0, 1) end)
blend(vz, {angle=0, tool={kind="badger", width=16}})
-- facets: soft lighter planes beside joints, wet into wet
local b = brush{kind="filbert", width=3}
for _, s in ipairs({{{x0 + 8, 505}, {x0 + 10, 560}}, {{x0 + 28, 538}, {x0 + 30, 600}}, {{x0 + 50, 580}, {x0 + 52, 640}}}) do
  b:load(face_lit, 0.5)
  b:stroke(s, {pressure={0.5, 0.2}, clip=M:shrink(1)})
end
local r = brush{kind="round", width=1.4, point=0.6}
for _, s in ipairs({{{x0 + 5, 500, 0.3}, {x0 + 6, 540, 0.7}, {x0 + 5, 590, 0.4}}, {{x0 + 26, 532, 0.3}, {x0 + 27, 580, 0.7}, {x0 + 28, 640, 0.3}}, {{x0 - 20, 560, 0.2}, {x0 + 10, 562, 0.6}, {x0 + 40, 560, 0.2}}}) do
  r:load(fg_deep, 0.7)
  r:gesture(s, {clip=M:shrink(1)})
end
print("ok")

--@ chunk 6
for i = 1, 30 do
  local t = wait(24*60)
  if drying(400, 600) == "dry" and drying(790, 690) == "dry" and drying(470, 500) == "dry" then print("dry", t) break end
end
-- what's the mist like near the bottom right of cliff 2?
print(drying(530, 700))

--@ chunk 7
face_lit2 = mix{{face_cool, 0.6}, {face_lit, 0.4}, name="face_lit2"}
local x0 = 420
local M = CL[2]
local d = M:distance()
local nh = noise{seed=71, octaves=3, period=50, stretch={0, 4}}
local veil = function(x, y) return smoothstep(615, 708, y + 22 * nh(x, y)) * clamp(1.15 - d:at(x, y) / 40, 0, 1) end
local m = M:grow(0.6)
local nv = noise{seed=64, octaves=3, period=40, stretch={1.5708, 5}}
local function edgew(x, y) return clamp(1 - d:at(x, y) / 10, 0, 1) end
local piles = {
  {face_cool, function(x, y) return (1 - veil(x, y)) * (0.25 + 0.9 * edgew(x, y)) end},
  {sand2, function(x, y) return (1 - veil(x, y)) * clamp(0.35 + 0.8 * nv(x, y), 0, 1) * 0.6 * (1 - edgew(x, y)) end},
  {fg_dark, function(x, y) return (1 - veil(x, y)) * 0.5 end},
  {fg_deep, function(x, y) return (1 - veil(x, y)) * clamp(-nv(x, y), 0, 1) * 0.8 end},
  {mist_low, function(x, y) return veil(x, y) ^ 0.7 * 2.0 end},
}
work(m, {hand="body", piles=piles, coverage=2.8, fill=true, clip=m, angle=function(x, y) return 1.5 * (1 - veil(x, y)) end, angle_jitter=0.1, tool={kind="filbert", width=4}, length={12, 35}, load=0.8})
blend(m * mask(function(x, y) return 1 - clamp(veil(x, y) * 2, 0, 1) end), {angle=1.5, tool={kind="badger", width=8}})
local vz = (m:grow(6) * mask(function(x, y) return clamp(veil(x, y) * 2.5, 0, 1) end)):soften(3)
blend(vz, {angle=0, tool={kind="badger", width=16}})
local b = brush{kind="filbert", width=4}
for _, s in ipairs({{{x0 + 9, 506}, {x0 + 11, 560}}, {{x0 + 30, 540}, {x0 + 32, 600}}}) do
  b:load(face_lit2, 0.35)
  b:stroke(s, {pressure={0.35, 0.1}, clip=M:shrink(1)})
end
local function joint(pts, w, seed)
  local jm = ribbon(pts, w):roughen(0.8, 5, seed) * M:shrink(1)
  work(jm, {hand="detail", pile=fg_deep, coverage=2.5, fill=true, clip=jm, angle=1.5, tool={kind="round", width=1.2}})
end
joint({{x0 + 6, 502}, {x0 + 7, 545}, {x0 + 5, 600}}, {0.5, 2.0, 0.6}, 1)
joint({{x0 + 27, 534}, {x0 + 28, 590}, {x0 + 30, 640}}, {0.5, 2.2, 0.6}, 2)
joint({{x0 - 40, 600}, {x0 - 10, 602}, {x0 + 30, 599}}, {0.4, 1.4, 0.4}, 3)
print("ok")

--@ chunk 8
for i = 1, 30 do
  local t = wait(24*60)
  if drying(400, 600) == "dry" and drying(790, 690) == "dry" and drying(470, 680) == "dry" and drying(700, 600) == "dry" then print("dry", t) break end
end
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_dk = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.2}, {"green earth", 0.4}, name="heath_dk"}
heath_lt = pile{{"raw umber", 1.6}, {"yellow ochre", 0.4}, {"green earth", 0.6}, {"lead white", 0.35}, {"smalt", 0.2}, {"rose madder", 0.15}, name="heath_lt"}
-- plateau patch on the left part of CL[3]
local edge_n = noise{seed=81, octaves=3, period=30}
function edgeX(y) return 722 - (y - 470) * 0.02 + 4 * edge_n(0, y) end
PL3 = CL[3] * mask(function(x, y) return x < edgeX(y) and 1 or 0 end)
local nb = noise{seed=277, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
work(PL3, {hand="body", piles={{fg_top, function(x, y) return clamp(0.45 + nb(x, y), 0, 1) * 0.5 end}, {fg_dark, 0.6}, {fg_deep, 0.4}, {fg_warm, 0.25}}, coverage=3, fill=true, clip=PL3, angle=0.03, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}})
blend(PL3, {angle=0, tool={kind="badger", width=24}})
for i = 1, 30 do
  local t = wait(24*60)
  if drying(680, 600) == "dry" then print("dry2", t) break end
end
local nz = noise{seed=16, octaves=3, period=40}
local zone = PL3 * mask(function(x, y) return clamp(0.3 + 1.5 * nz(x, y * 2), 0, 1) end)
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.7}, {fg_deep, 0.5}}, coverage=1.5, clip=PL3, angle=-1.45, angle_jitter=0.35, length={6, 12}, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
for i = 1, 30 do
  local t = wait(24*60)
  if drying(680, 600) == "dry" then print("dry3", t) break end
end

--@ chunk 9
face_cool = pile{{"raw umber", 1.5}, {"bone black", 0.7}, {"smalt", 0.9}, {"lead white", 0.35}, {"rose madder", 0.12}, name="face_cool"}
function face_repaint(FM, outer, joints, seed)
  local d = outer:distance()
  local nv = noise{seed=seed, octaves=3, period=40, stretch={1.5708, 5}}
  local function edgew(x, y) return clamp(1 - d:at(x, y) / 9, 0, 1) end
  local piles = {
    {face_cool, function(x, y) return 0.1 + 0.9 * edgew(x, y) end},
    {sand2, function(x, y) return clamp(0.3 + 0.8 * nv(x, y), 0, 1) * 0.45 * (1 - edgew(x, y)) end},
    {fg_dark, 0.4},
    {fg_deep, function(x, y) return (0.45 + clamp(-nv(x, y), 0, 1) * 0.6) * (1 - 0.6 * edgew(x, y)) end},
  }
  work(FM, {hand="body", piles=piles, coverage=2.8, fill=true, clip=FM, angle=1.5, angle_jitter=0.1, tool={kind="filbert", width=4}, length={12, 35}, load=0.8})
  for i, j in ipairs(joints) do
    local jm = ribbon(j.pts, j.w):roughen(0.9, 6, seed + i) * FM:shrink(0.8)
    work(jm, {hand="detail", pile=fg_deep, coverage=2.5, fill=true, clip=jm, angle=1.5, tool={kind="round", width=1.6}})
  end
  blend(FM:shrink(0.4), {angle=1.5, tool={kind="badger", width=8}})
end
local x0 = 720
FACE3 = CL[3] - PL3
face_repaint(FACE3, CL[3], {
  {pts={{x0 + 6, 503}, {x0 + 7, 545}, {x0 + 6, 600}}, w={0.6, 3.2, 1.0}},
  {pts={{x0 + 28, 535}, {x0 + 29, 590}, {x0 + 31, 650}}, w={0.6, 3.4, 1.0}},
  {pts={{x0 + 47, 573}, {x0 + 49, 620}, {x0 + 50, 700}}, w={0.6, 3.0, 1.2}},
}, 91)
print("ok")

--@ chunk 10
for i = 1, 30 do
  local t = wait(24*60)
  if drying(760, 600) == "dry" and drying(735, 520) == "dry" then print("dry", t) break end
end
local x0 = 720
local b = brush{kind="flat", width=2.8}
for _, t in ipairs({{{x0 + 11, 503.5}, {x0 + 24, 505}}, {{x0 + 31, 535.5}, {x0 + 43, 537}}, {{x0 + 49, 575.5}, {x0 + 59, 577}}, {{x0 + 71, 655.5}, {x0 + 77, 657}}}) do
  b:load(fg_top, 0.45)
  b:stroke(t, {pressure={0.45, 0.2}, clip=CL[3]:grow(0.5)})
end
-- heath hanging over the edge line: short hatch tufts along it
local edge_band = CL[3] * mask(function(x, y) local e = edgeX(y); return (x > e - 5 and x < e + 4) and 1 or 0 end)
local nz = noise{seed=33, octaves=2, period=25}
local zone = edge_band * mask(function(x, y) return clamp(0.2 + 1.6 * nz(x, y), 0, 1) end)
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.8}}, coverage=1.6, clip=zone:grow(1.5), angle=-1.35, angle_jitter=0.4, length={5, 10}, tool={kind="round", width=1.2, point=0.8}, pressure={0.35, 0.6}})
local tops = zone * mask(function(x, y) return clamp(nz(x + 40, y - 20) * 2, 0, 1) end)
work(tops, {hand="hatch", piles={{heath_lt, 1}, {fg_top, 0.6}}, coverage=0.4, clip=zone:grow(1.5), angle=-1.35, angle_jitter=0.4, length={3, 7}, tool={kind="round", width=1.0, point=0.8}, pressure={0.3, 0.5}})
print("ok")
