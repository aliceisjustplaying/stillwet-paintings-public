-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
-- underlayer like the painting's sky near the muzzle: sky body, dried; then a smoke body, dried
sk_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}}
sk_apricot = pile{{"lead white", 2}, {"orange chrome", 0.8}, {"vermilion", 0.25}, {"yellow ochre", 0.3}}
work(rect(0,0,1000,714), {hand="broad", piles={{sk_rose, function(x,y) return 1 - y/714 end}, {sk_apricot, function(x,y) return y/714 end}}, coverage=2, fill=true, clip=true})
sm_out = pile{{"lead white", 1.5}, {"ultramarine blue", 0.25}, {"raw umber", 0.3}, {"rose madder", 0.15}}
sm_mid = pile{{"lead white", 1.5}, {"raw umber", 0.15}, {"rose madder", 0.12}, {"orange chrome", 0.25}, {"ultramarine blue", 0.08}}
sm_in = pile{{"lead white", 2}, {"orange chrome", 0.6}, {"cadmium yellow", 0.3}}
function smoke_body(cx, cy, s, seed, clipm)
  math.randomseed(seed)
  local m = ellipse(cx + 22*s, cy - 2*s, 26*s, 18*s)
  for i = 1, 9 do
    local t = rand(0, 1)
    m = m + ellipse(cx + (20 + 75*t)*s + rand(-8,8)*s, cy - (4 + 30*t)*s + rand(-10,10)*s, (13 + 12*t)*s, (10 + 9*t)*s)
  end
  m = m:roughen(4*s, 18*s, seed):soften(2*s)
  if clipm then m = m * clipm end
  local function d(x, y) return math.sqrt(((x-cx-14*s)/1.3)^2 + (y-cy)^2) end
  work(m, {hand="body", tool={kind="filbert", width=8*s, stiffness=0.35},
    piles={{sm_in,  function(x,y) return 1 - smoothstep(14*s, 34*s, d(x,y)) end},
           {sm_mid, function(x,y) local v = d(x,y) return smoothstep(14*s, 34*s, v) * (1 - smoothstep(40*s, 70*s, v)) end},
           {sm_out, function(x,y) return smoothstep(40*s, 70*s, d(x,y)) end}},
    coverage=2.2, fill=true, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, curve={0.4, 0.2}, edge="soft", clip=clipm, seed=seed})
  blend(m:shrink(2*s), {angle=-0.3})
  return m
end
wait(5*24*60)
smoke_body(200, 300, 1.15, 21)
smoke_body(600, 300, 1.15, 21)
wait(9*24*60)
print(drying(230,300), drying(280,280))

--@ chunk 3
fl_white_b = pile{{"lead white", 4}, {"lemon chrome", 0.3}, blot=0.25, name="fl_white_b"}
fl_yel = pile{{"cadmium yellow", 1}, {"lead white", 0.8}, {"lemon chrome", 0.3}, name="fl_yel"}
fl_org = pile{{"orange chrome", 1}, {"cadmium yellow", 0.4}, {"vermilion", 0.15}, name="fl_org"}
fl_red = pile{{"vermilion", 1}, {"orange chrome", 0.5}, name="fl_red"}
fl_halo = pile{{"lead white", 3}, {"Naples yellow", 1}, {"cadmium yellow", 0.6}, name="fl_halo"}
spark_p = pile{{"lead white", 1}, {"cadmium yellow", 0.8}, {"orange chrome", 0.3}, medium=0.45, name="spark"}
function flame_big(cx, cy, s, seed, clipm)
  math.randomseed(seed or 1)
  -- 1. halo of hot light, soft, forward-weighted
  local halo = (ellipse(cx + 34*s, cy - 2*s, 52*s, 30*s) + ellipse(cx + 8*s, cy, 22*s, 20*s)):roughen(4*s, 16*s, seed):soften(6*s)
  if clipm then halo = halo * clipm end
  work(halo, {hand="body", tool={kind="filbert", width=9*s, stiffness=0.35}, pile=fl_halo, coverage=1.6, fill=true,
     angle=function(x,y) return math.atan(y-cy, x-cx) end, edge="lost", clip=clipm, seed=seed})
  -- 2. white-hot core
  local cb = brush{kind="filbert", width=11*s, stiffness=0.7, lay=6}
  cb:reload(fl_white_b, 1)
  cb:gesture({{cx + 1*s, cy, 0.7}, {cx + 14*s, cy - 0.5*s, 1.0}, {cx + 30*s, cy - 1.5*s, 0.8}, {cx + 46*s, cy - 2.5*s, 0.1}}, {wobble=1})
  cb:reload(fl_white_b, 0.9)
  cb:gesture({{cx + 6*s, cy + 4*s, 0.6}, {cx + 20*s, cy + 6*s, 0.7}, {cx + 34*s, cy + 8*s, 0.0}}, {wobble=1})
  cb:reload(fl_white_b, 0.9)
  cb:gesture({{cx + 6*s, cy - 4*s, 0.6}, {cx + 20*s, cy - 8*s, 0.7}, {cx + 32*s, cy - 13*s, 0.0}}, {wobble=1})
  -- 3. tongues from the core's edge outward
  local rb = brush{kind="round", width=7*s, point=0.85, stiffness=0.5, lay=2.5}
  local function tongue(pile, ang, r0, len, w0, bend, load)
    rb:reload(pile, load or 0.85)
    local ox, oy = cx + 18*s, cy
    local x0, y0 = ox + math.cos(ang)*r0, oy + math.sin(ang)*r0*0.7
    local a2 = ang + (bend or 0)
    local x1, y1 = x0 + math.cos(ang)*len*0.5, y0 + math.sin(ang)*len*0.5
    local x2, y2 = x1 + math.cos(a2)*len*0.5, y1 + math.sin(a2)*len*0.5
    rb:gesture({{x0, y0, w0}, {x1, y1, w0*0.9}, {x2, y2, 0}}, {wobble=1.2})
  end
  for i = 1, 6 do local a = rand(-0.35, 0.35) tongue(fl_yel, a, 22*s, rand(30, 50)*s, 0.9, rand(-0.2, 0.2)) end
  for i = 1, 6 do local a = (i <= 3 and -1 or 1) * rand(0.35, 0.95) tongue(fl_org, a, 16*s, rand(28, 50)*s, 0.9, rand(-0.3, 0.3)) end
  for i = 1, 3 do local a = rand(-0.25, 0.25) tongue(fl_org, a, 44*s, rand(20, 34)*s, 0.7, rand(-0.3, 0.3)) end
  for i = 1, 4 do local a = rand(-0.8, 0.8) tongue(fl_red, a, 40*s, rand(12, 22)*s, 0.5, rand(-0.3,0.3), 0.6) end
  -- 4. sparks: burning grains thrown forward
  local sb = brush{kind="round", width=4*s, stiffness=0.4}
  sb:reload(spark_p, 0.9)
  sb:spatter{at={cx + 30*s, cy}, toward={110*s, -4*s}, spread=0.35, force=0.75, clip=clipm}
end
flame_big(600, 300, 1.0, 51)

--@ chunk 4
spark_p = pile{{"orange chrome", 1}, {"cadmium yellow", 0.5}, {"lead white", 0.3}, medium=0.5, name="spark2"}
function flame_big2(cx, cy, s, seed, clipm)
  math.randomseed(seed or 1)
  local halo = (ellipse(cx + 30*s, cy - 1*s, 44*s, 24*s) + ellipse(cx + 8*s, cy, 18*s, 16*s)):soften(8*s)
  if clipm then halo = halo * clipm end
  work(halo, {hand="body", tool={kind="filbert", width=8*s, stiffness=0.35}, pile=fl_halo, coverage=1.4, fill=true,
     angle=function(x,y) return math.atan(y-cy, x-cx) end, edge="lost", clip=clipm, seed=seed})
  blend(halo:rim(10*s, 4*s), {angle=0})
  local cb = brush{kind="filbert", width=10*s, stiffness=0.7, lay=6}
  cb:reload(fl_white_b, 1)
  cb:gesture({{cx + 1*s, cy, 0.7}, {cx + 14*s, cy - 0.5*s, 1.0}, {cx + 32*s, cy - 1.5*s, 0.8}, {cx + 50*s, cy - 2.5*s, 0.05}}, {wobble=1})
  cb:reload(fl_white_b, 0.8)
  cb:gesture({{cx + 6*s, cy + 4*s, 0.5}, {cx + 20*s, cy + 7*s, 0.6}, {cx + 32*s, cy + 10*s, 0.0}}, {wobble=1})
  cb:reload(fl_white_b, 0.8)
  cb:gesture({{cx + 6*s, cy - 4*s, 0.5}, {cx + 20*s, cy - 8*s, 0.6}, {cx + 30*s, cy - 12*s, 0.0}}, {wobble=1})
  local rb = brush{kind="round", width=6.5*s, point=0.85, stiffness=0.5, lay=2.5}
  local function tongue(pile, ang, r0, len, w0, bend, load)
    rb:reload(pile, load or 0.85)
    local ox, oy = cx + 18*s, cy
    local x0, y0 = ox + math.cos(ang)*r0, oy + math.sin(ang)*r0*0.7
    local a2 = ang + (bend or 0)
    local x1, y1 = x0 + math.cos(ang)*len*0.5, y0 + math.sin(ang)*len*0.5
    local x2, y2 = x1 + math.cos(a2)*len*0.5, y1 + math.sin(a2)*len*0.5
    rb:gesture({{x0, y0, w0}, {x1, y1, w0*0.9}, {x2, y2, 0}}, {wobble=1.2})
  end
  for i = 1, 8 do local a = (i % 2 == 0 and -1 or 1) * rand(0.15, 1.0) tongue(fl_org, a, 18*s, rand(34, 58)*s, 0.9, rand(-0.3, 0.3)) end
  for i = 1, 3 do local a = rand(-0.2, 0.2) tongue(fl_org, a, 46*s, rand(24, 40)*s, 0.7, rand(-0.25, 0.25)) end
  for i = 1, 5 do local a = rand(-0.9, 0.9) tongue(fl_red, a, 44*s, rand(12, 24)*s, 0.5, rand(-0.3,0.3), 0.6) end
  local sb = brush{kind="round", width=4*s, stiffness=0.4}
  sb:reload(spark_p, 1)
  sb:spatter{at={cx + 30*s, cy}, toward={120*s, -4*s}, spread=0.3, force=0.5, clip=clipm}
  sb:reload(spark_p, 1)
  sb:spatter{at={cx + 30*s, cy}, toward={90*s, 4*s}, spread=0.4, force=0.4, clip=clipm}
end
flame_big2(200, 300, 1.0, 52)

--@ chunk 5
cw_coat = pile{{"raw umber", 1.5}, {"burnt sienna", 0.6}, {"bone black", 0.35}, {"lead white", 0.15}}
cw_coat_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.45}, {"burnt sienna", 0.4}, {"lead white", 0.05}}
cw_coat_md = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.3}, {"rose madder", 0.12}, {"lead white", 0.18}}
local base = rect(50, 450, 400, 250)
work(base, {hand="body", pile=cw_coat_md, coverage=2, fill=true, clip=true, angle=1.5})
wait(10*24*60)
-- trial A (left half): body dark layer then lighter fold gestures wet-in-wet
coat_hi = pile{{"raw umber", 1}, {"burnt sienna", 0.7}, {"Naples yellow", 0.4}, {"lead white", 0.35}, {"rose madder", 0.1}, name="coat_hi"}
coat_vdk = pile{{"bone black", 0.6}, {"raw umber", 1}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, name="coat_vdk"}
work(rect(50,450,200,250), {hand="body", pile=cw_coat_dk, coverage=1.5, fill=true, clip=true, angle=1.5, seed=3})
local fb = brush{kind="filbert", width=10, stiffness=0.5}
for i = 0, 3 do
  fb:reload(coat_hi, 0.5)
  fb:gesture({{80 + i*45, 470, 0.2}, {78 + i*45, 560, 0.6}, {72 + i*45, 680, 0.3}}, {wobble=2, clip=rect(50,450,200,250)})
end
local nb = brush{kind="filbert", width=6, stiffness=0.5}
for i = 0, 3 do
  nb:reload(coat_vdk, 0.6)
  nb:gesture({{100 + i*45, 480, 0.1}, {98 + i*45, 570, 0.7}, {94 + i*45, 690, 0.5}}, {wobble=2, clip=rect(50,450,200,250)})
end
-- trial B (right half): glaze, then rag lift the ridges
coat_glaze = pile{{"burnt sienna", 1}, {"ultramarine blue", 0.9}, {"bone black", 0.1}, medium=0.75, name="coat_glaze"}
work(rect(250,450,200,250), {hand="glaze", pile=coat_glaze, coverage=1.2, clip=true, angle=1.5, seed=4})
local r = rag{width=8}
for i = 0, 3 do
  r:wipe({{280 + i*45, 470}, {278 + i*45, 560}, {272 + i*45, 680}}, {pressure={0.3, 0.5}})
end

--@ chunk 6
local base = rect(500, 400, 300, 300)
work(base, {hand="body", pile=cw_coat_md, coverage=2, fill=true, clip=true, angle=1.5, seed=5})
wait(10*24*60)
work(base, {hand="body", pile=cw_coat_dk, coverage=1.5, fill=true, clip=true, angle=1.5, seed=6})
local fb = brush{kind="filbert", width=16, stiffness=0.45}
local function fold(pts, p, load, br) br = br or fb br:reload(p, load) br:gesture(pts, {wobble=3, clip=base}) end
fold({{560,410,0.05},{556,470,0.5},{545,560,0.8},{530,660,0.6},{522,700,0.3}}, coat_hi, 0.45)
fold({{640,430,0.05},{642,500,0.45},{646,590,0.7},{652,690,0.5}}, coat_hi, 0.4)
fold({{720,450,0.1},{728,530,0.5},{740,620,0.75},{752,700,0.6}}, coat_hi, 0.45)
local nb = brush{kind="filbert", width=9, stiffness=0.45}
fold({{595,440,0.0},{594,520,0.6},{588,620,0.8},{584,700,0.7}}, coat_vdk, 0.6, nb)
fold({{690,460,0.0},{694,540,0.6},{700,630,0.8},{706,700,0.6}}, coat_vdk, 0.6, nb)
blend(base, {angle=1.5})

--@ chunk 7
wait(8*24*60)
print(drying(600,500), drying(650,600))
coat_glaze2 = pile{{"ultramarine blue", 0.8}, {"burnt sienna", 0.8}, {"bone black", 0.15}, medium=0.8, name="coat_glaze2"}
work(rect(500,400,150,300), {hand="glaze", pile=coat_glaze2, coverage=1, clip=true, angle=1.5, seed=7})
coat_glaze3 = pile{{"ultramarine blue", 0.8}, {"burnt sienna", 0.8}, {"bone black", 0.25}, medium=0.7, name="coat_glaze3"}
work(rect(650,400,150,300), {hand="glaze", pile=coat_glaze3, coverage=1.5, clip=true, angle=1.5, seed=8})

--@ chunk 8
local base = rect(100, 100, 300, 250)
work(base, {hand="body", pile=cw_coat_md, coverage=2, fill=true, clip=true, angle=1.5, seed=15})
wait(10*24*60)
work(base, {hand="body", pile=cw_coat_dk, coverage=1.5, fill=true, clip=true, angle=1.5, seed=16})
local fb = brush{kind="filbert", width=16, stiffness=0.45}
local function fold(pts, p, load, br) br = br or fb br:reload(p, load) br:gesture(pts, {wobble=3, clip=base}) end
fold({{160,110,0.05},{156,170,0.5},{145,260,0.8},{130,340,0.5}}, coat_hi, 0.45)
fold({{240,130,0.05},{242,200,0.45},{246,290,0.7},{252,345,0.5}}, coat_hi, 0.4)
fold({{320,150,0.1},{328,230,0.5},{340,320,0.75},{348,345,0.6}}, coat_hi, 0.45)
local nb = brush{kind="filbert", width=9, stiffness=0.45}
fold({{195,140,0.0},{194,220,0.6},{188,320,0.8},{184,345,0.7}}, coat_vdk, 0.6, nb)
fold({{290,160,0.0},{294,240,0.6},{300,330,0.8},{304,345,0.6}}, coat_vdk, 0.6, nb)
blend(base, {angle=1.5})
wait(10*24*60)
coat_glaze4 = pile{{"burnt sienna", 1}, {"ultramarine blue", 0.55}, {"bone black", 0.2}, medium=0.75, name="coat_glaze4"}
local L = rect(100,100,150,250)
work(L, {hand="glaze", pile=coat_glaze4, coverage=2, fill=true, clip=true, angle=1.5, seed=17})
blend(L, {angle=1.5})
local R = rect(250,100,150,250)
coat_glaze5 = pile{{"burnt sienna", 1}, {"ultramarine blue", 0.55}, {"bone black", 0.2}, thinner=0.5, name="coat_glaze5"}
work(R, {hand="body", tool={kind="filbert", width=14, stiffness=0.4}, pile=coat_glaze5, coverage=2, fill=true, clip=true, angle=1.5, seed=18})
