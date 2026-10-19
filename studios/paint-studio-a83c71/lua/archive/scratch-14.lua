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
crack_dark = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.2}, name="crack_dark"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
work(rect(0,0,1000,714), {hand="broad", pile=mist_bright, coverage=3, fill=true, clip=true, angle=0})
local o = outline{{540, 716, "c"}, {540, 500, "c"}, {556, 494, "c"}, {562, 499, "c"}, {563, 521, "c"}, {580, 523, "c"}, {582, 527, "c"}, {585, 548, "c"}, {595, 550, "c"}, {597, 555, "c"}, {601, 582, "c"}, {613, 584, "c"}, {616, 590, "c"}, {618, 604, "c"}, {622, 618, "c"}, {625, 640}, {627, 668, "c"}, {637, 672, "c"}, {639, 690}, {641, 716, "c"}, char="broken", seed=1501, closed=true, amount=0.35}
NEWFACE = o:mask()
work(NEWFACE + rect(400, 495, 145, 221), {hand="body", piles={{fg_dark, 1}, {fg_deep, 0.6}}, coverage=3, fill=true, clip=NEWFACE + rect(400, 495, 145, 221), angle=1.4})
wait(12*24*60)
print(drying(560, 600))

--@ chunk 3
sand_face = pile{{"raw umber", 2}, {"lead white", 0.55}, {"red earth", 0.3}, {"yellow ochre", 0.3}, {"bone black", 0.35}, {"rose madder", 0.1}, name="sand_face"}
local face = NEWFACE * rect(546, 490, 110, 230)
local nv = noise{seed=3, octaves=3, period=40, stretch={1.5708, 5}}
-- distance to the outer (right) edge: returns darker near it
local function edgex(y)
  for x = 660, 540, -0.5 do if NEWFACE:at(x, y) > 0.5 then return x end end
  return 540
end
local ex = {}
for y = 490, 716, 2 do ex[#ex+1] = edgex(y) end
local function ER(y) local i = clamp(math.floor((y - 490) / 2) + 1, 1, #ex); return ex[i] end
local function wface(x, y) return clamp(0.55 + 0.9 * nv(x, y), 0, 1) * clamp((ER(y) - x - 3) / 8, 0, 1) end
local function wret(x, y) return clamp(1 - (ER(y) - x) / 6, 0, 1) end
work(face, {hand="body", piles={{sand_face, wface}, {fg_dark, function(x, y) return 0.5 * (1 - wface(x, y)) + 0.1 end}, {fg_deep, wret}}, coverage=3, fill=true, clip=face, angle=1.5, angle_jitter=0.08, tool={kind="filbert", width=4}, length={15, 40}})
blend(face:shrink(1), {angle=1.5, tool={kind="badger", width=10}})
-- joints
local function joint(pts, w, seed)
  local m = ribbon(pts, w):roughen(0.5, 4, seed) * face
  work(m, {hand="detail", pile=crack_dark, coverage=3, fill=true, clip=m, angle=1.5, tool={kind="round", width=1.0}})
end
joint({{552, 502}, {553, 540}, {551, 575}}, {0.4, 1.4, 0.4}, 1)
joint({{566, 525}, {568, 560}, {570, 600}, {569, 650}, {571, 700}}, {0.4, 1.6, 1.2, 1.8, 0.6}, 2)
joint({{588, 552}, {590, 590}, {592, 630}, {590, 680}}, {0.4, 1.2, 1.6, 0.6}, 3)
joint({{606, 590}, {608, 640}, {610, 700}}, {0.4, 1.4, 0.6}, 4)
-- bedding
joint({{548, 610}, {575, 612}, {600, 609}}, {0.4, 1.1, 0.4}, 5)
joint({{550, 660}, {580, 662}, {620, 660}}, {0.4, 1.2, 0.4}, 6)
-- ledge tops
local b = brush{kind="flat", width=2.6}
for _, t in ipairs({{{565, 522}, {579, 524}}, {{584, 549}, {594, 551}}, {{599, 583}, {612, 585}}, {{627, 670}, {636, 673}}, {{548, 497}, {560, 498}}}) do
  b:load(fg_top, 0.5)
  b:stroke(t, {pressure={0.5, 0.25}, clip=NEWFACE})
end
print("ok")

--@ chunk 4
sand2 = mix{{sand_face, 0.45}, {fg_dark, 0.55}, name="sand2"}
local face = rect(420, 520, 110, 190)
local nv = noise{seed=3, octaves=3, period=40, stretch={1.5708, 5}}
local function wface(x, y) return clamp(0.5 + 0.9 * nv(x, y), 0, 1) end
work(face, {hand="body", piles={{sand2, wface}, {fg_dark, function(x, y) return 0.6 * (1 - wface(x, y)) + 0.15 end}}, coverage=2.5, fill=true, clip=face, angle=1.5, angle_jitter=0.08, tool={kind="filbert", width=4}, length={15, 40}, load=0.6})
blend(face:shrink(1), {angle=1.5, tool={kind="badger", width=10}})
local function joint2(pts, w, seed)
  local m = ribbon(pts, w):roughen(0.8, 5, seed):soften(0.8) * face
  work(m, {hand="detail", piles={{fg_deep, 1}, {crack_dark, 0.4}}, coverage=2.5, fill=true, clip=m, angle=1.5, tool={kind="round", width=1.2}})
end
joint2({{440, 525}, {442, 560}, {439, 600}}, {0.5, 2.4, 0.6}, 1)
joint2({{470, 540}, {472, 600}, {470, 650}, {473, 700}}, {0.5, 2.8, 2.0, 0.6}, 2)
joint2({{500, 580}, {502, 630}, {500, 690}}, {0.5, 2.2, 0.5}, 3)
joint2({{420, 620}, {450, 622}, {480, 619}}, {0.5, 1.8, 0.5}, 5)
print("ok")

--@ chunk 5
local face = rect(300, 520, 110, 190)
local nv = noise{seed=4, octaves=3, period=30, stretch={1.5708, 4}}
local cols = {300, 322, 351, 368, 392, 410}
local function colphase(x, y)
  local xx = x + 3 * nv(x, y)
  for i = 1, #cols - 1 do
    if xx >= cols[i] and xx < cols[i+1] then return (xx - cols[i]) / (cols[i+1] - cols[i]) end
  end
  return 0.5
end
-- light from the left/front (sky): the left-centre of each column is lighter, right edge into the groove dark
local function wl(x, y) local t = colphase(x, y); return clamp(math.sin(math.pi * t) * 1.2 - 0.25 * t, 0, 1) end
work(face, {hand="body", piles={{sand2, wl}, {fg_deep, function(x, y) return 1 - wl(x, y) end}}, coverage=3, fill=true, clip=face, angle=1.5, angle_jitter=0.06, tool={kind="filbert", width=3.5}, length={15, 40}})
blend(face:shrink(1), {angle=1.5, tool={kind="badger", width=8}})
print("ok")

--@ chunk 6
rim_mist = pile{{"raw umber", 1.5}, {"lead white", 1.0}, {"smalt", 0.8}, {"rose madder", 0.15}, {"bone black", 0.3}, name="rim_mist"}
local inner = NEWFACE:shrink(3.5)
local rim = (NEWFACE - inner) * rect(560, 520, 100, 200)
work(rim, {hand="detail", pile=rim_mist, coverage=2, fill=true, clip=rim, angle=1.5, load=0.6, tool={kind="round", width=1.6}})
blend(NEWFACE:shrink(0.5) * rect(560, 520, 100, 200), {angle=1.5, tool={kind="badger", width=6}})
print("ok")
