-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
-- replica of the cowboy's head passage
sky = pile{{"lead white", 1.5}, {"ultramarine blue", 0.4}, {"rose madder", 0.35}, {"raw umber", 0.2}, name="sky"}
cw_dark = pile{{"raw umber", 1}, {"bone black", 0.8}, {"ultramarine blue", 0.5}, name="cw_dark"}
coat = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.4}, {"bone black", 0.2}, name="coat"}
skin_sh = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.2}, {"rose madder", 0.12}, {"lead white", 0.15}, name="skin_sh"}
skin_lt = pile{{"Naples yellow", 1}, {"burnt sienna", 0.5}, {"vermilion", 0.3}, {"orange chrome", 0.12}, {"lead white", 0.35}, name="skin_lt"}
skin_md = mix{{skin_sh, 0.5}, {skin_lt, 0.5}, name="skin_md"}
work(rect(150, 200, 200, 140), {hand="body", pile=sky, coverage=2, fill=true, clip=true, angle=0.1, seed=1})
hat = poly({{180,246},{210,238},{214,205},{230,192},{262,193},{268,236},{304,246},{300,258},{240,262},{186,256}}, true)
head = poly({{232,256},{270,257},{272,262},{274,266},{273,270},{278,273},{285,278},{280,281},{282,284},{279,287},{281,289},{278,292},{281,296},{276,300},{264,301},{258,303},{242,302},{236,292},{231,278}}, false):soften(0.6) - hat
coatm = poly({{200,302},{240,298},{290,306},{300,340},{190,340}}, true) - head
work(hat, {hand="detail", tool={kind="round", width=3}, pile=cw_dark, coverage=3, clip=hat, seed=2})
work(coatm, {hand="detail", tool={kind="round", width=3}, pile=coat, coverage=3, clip=coatm, seed=3})
work(head, {hand="detail", tool={kind="round", width=3}, pile=skin_md, coverage=3, clip=head, seed=4})
wait(12*24*60)
print(drying(250,280), drying(250,230), drying(180,300))

--@ chunk 3
fc_shadow = pile{{"raw umber",1},{"burnt sienna",0.7},{"vermilion",0.08},{"ultramarine blue",0.18},{"lead white",0.08}, name="fc_shadow"}
fc_half = pile{{"raw umber",0.6},{"burnt sienna",0.8},{"Naples yellow",0.5},{"vermilion",0.15},{"lead white",0.15}, name="fc_half"}
hair_p = pile{{"raw umber",1},{"bone black",0.5},{"burnt sienna",0.3},{"ultramarine blue",0.2}, name="hair"}
hairm = poly({{229,256},{254,256},{252,262},{249,267},{247,275},{246,284},{243,292},{241,300},{236,301},{232,292},{229,280},{228,268}}, true) * head:grow(1)
ear = ellipse(253.5, 277, 4, 6.5)
local facesh = head - hairm - ear
work(facesh, {hand="detail", tool={kind="round", width=2.5}, piles={{fc_shadow, function(x,y) return 1 - smoothstep(256, 274, x) end}, {fc_half, function(x,y) return smoothstep(254, 274, x) end}}, coverage=3, clip=facesh, angle=1.5, seed=11})
work(hairm, {hand="detail", tool={kind="round", width=2.5}, pile=hair_p, coverage=3, clip=hairm, angle=1.6, seed=12})
work(ear, {hand="detail", tool={kind="round", width=2}, pile=fc_half, coverage=3, clip=ear, seed=13})
local rb = brush{kind="round", width=2, point=0.9, stiffness=0.55}
local function s(p, pts, load, clipm) rb:reload(p, load or 0.75) rb:gesture(pts, {wobble=0.15, clip=clipm}) end
-- ear inner
s(fc_shadow, {{254,273,0.5},{256,276,0.7},{255,281,0.5}}, 0.8, ear)
-- hair flicks at the nape, past the silhouette
s(hair_p, {{236,284,0.8},{232,291,0.6},{228,297,0.1}}, 0.8)
s(hair_p, {{240,290,0.8},{236,297,0.5},{233,302,0.05}}, 0.8)
s(hair_p, {{232,270,0.7},{229,276,0.5},{226,282,0.05}}, 0.7)
-- eye notch under brow, and moustache
s(hair_p, {{263,267,0.6},{267,268,0.8},{269,267,0.4}}, 0.8, head)
s(hair_p, {{281,281,0.5},{278,283,0.9},{275,287,0.9},{273,292,0.3}}, 0.85, head:grow(1.5))
wait(8*24*60)
print(drying(250,280), drying(270,280), drying(240,280))

--@ chunk 4
fc_lt2 = pile{{"Naples yellow", 1}, {"orange chrome", 0.55}, {"vermilion", 0.25}, {"burnt sienna", 0.15}, {"lead white", 0.2}, name="fc_lt2"}
fc_hot = pile{{"Naples yellow", 1}, {"lead white", 0.7}, {"orange chrome", 0.35}, {"cadmium yellow", 0.2}, name="fc_hot"}
local rb = brush{kind="round", width=2.4, point=0.85, stiffness=0.55}
local function s(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.1, clip=clipm or head}) end
-- lit profile: brow, nose, lip/chin, jaw underside
s(fc_lt2, {{269,259,0.2},{271,263,0.5},{272,268,0.5},{273,271,0.3}})
s(fc_lt2, {{274,272,0.3},{278,274.5,0.6},{282,277.5,0.7},{283,279,0.4}})
s(fc_lt2, {{279,288,0.3},{280,291,0.6},{279,295,0.6},{276,299,0.5},{270,300.5,0.35},{262,301.5,0.15}})
-- cheekbone half-light and jaw
s(fc_half, {{262,275,0.3},{267,276,0.6},{272,278,0.4}}, 0.6)
-- hot spots
s(fc_hot, {{281.5,277.5,0.4},{283,279,0.3}}, 0.6)
s(fc_hot, {{279.5,291,0.4},{279,294,0.4}}, 0.55)
-- ear rim catching light
s(fc_lt2, {{256,272,0.2},{257.5,276,0.4},{256.5,281,0.2}}, 0.5, ear:grow(0.5))

--@ chunk 5
sk_apricot_r = pile{{"lead white", 2}, {"orange chrome", 0.8}, {"vermilion", 0.25}, {"yellow ochre", 0.3}, name="sk_apricot_r"}
sk_gold_r = pile{{"lead white", 3}, {"Naples yellow", 1.5}, {"orange chrome", 0.5}, {"yellow ochre", 0.3}, name="sk_gold_r"}
zb_cloth = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.3}, {"burnt sienna", 0.2}, {"lead white", 0.08}, name="zb_cloth"}
zb_skin_dk = pile{{"green earth", 1}, {"raw umber", 0.8}, {"bone black", 0.15}, {"lead white", 0.15}, {"rose madder", 0.08}, name="zb_skin_dk"}
gore = pile{{"Indian red", 1}, {"bone black", 0.45}, {"permanent alizarin", 0.35}, medium=0.5, name="gore"}
gore_dk = pile{{"Indian red", 1}, {"bone black", 0.9}, {"permanent alizarin", 0.3}, {"raw umber", 0.3}, name="gore_dk"}
gore_m = pile{{"Indian red", 1}, {"bone black", 0.6}, {"permanent alizarin", 0.35}, medium=0.5, name="gore_m"}
local skyz = rect(700, 200, 300, 200)
work(skyz, {hand="body", piles={{sk_apricot_r, function(x,y) return 1 - smoothstep(200, 400, y) end}, {sk_gold_r, function(x,y) return smoothstep(200, 400, y) end}}, coverage=2, fill=true, clip=true, angle=0.05, seed=21})
wait(3*24*60)
zh = ellipse(796, 318, 18, 24) + rect(770, 340, 50, 60)
work(zh, {hand="detail", tool={kind="round", width=3}, pile=zb_skin_dk, coverage=3, clip=zh, seed=22})
local cx, cy = 815, 309
local burst = (ellipse(822, 308, 8, 6) + ellipse(829, 303, 5, 4) + ellipse(828, 314, 4, 3) + ellipse(834, 308, 3.5, 3)):roughen(2, 4, 77)
stipple(burst - zh:shrink(1), {pile=gore_dk, width=2.5, coverage=2.2, cluster={0.5, 3}, pressure={0.5, 0.9}, seed=371})
local sb = brush{kind="round", width=6, stiffness=0.4}
sb:reload(gore, 1)
sb:spatter{at={812,312}, toward={110,-30}, spread=0.4, force=0.75}
sb:reload(gore, 1)
sb:spatter{at={814,308}, toward={80,-55}, spread=0.35, force=0.45}
wait(12*24*60)
print(drying(822,308), drying(850,300))

--@ chunk 6
local rb = brush{kind="round", width=2.2, point=0.95, stiffness=0.5}
local cx, cy = 824, 308
local a0 = -0.38
local n = 11
for i = 1, n do
  local a = a0 + (rand(-1, 1)) * 0.55
  local r0 = rand(5, 9)
  local L = rand(14, 42)
  local x0, y0 = cx + math.cos(a)*r0, cy + math.sin(a)*r0
  local bend = rand(-0.08, 0.08)
  local x1, y1 = cx + math.cos(a+bend)*(r0+L*0.5), cy + math.sin(a+bend)*(r0+L*0.5)
  local x2, y2 = cx + math.cos(a+2*bend)*(r0+L), cy + math.sin(a+2*bend)*(r0+L)
  rb:reload((i % 3 == 0) and gore_m or gore_dk, 0.6)
  rb:gesture({{x0, y0, rand(0.6, 0.9)}, {x1, y1, rand(0.35, 0.5)}, {x2, y2, 0.0}}, {wobble=0.3})
end
-- a few heavier drops thrown along the same line, low force: bigger, stretched
local sb = brush{kind="round", width=4, stiffness=0.4}
sb:reload(gore_m, 0.9)
print(sb:spatter{at={cx+6, cy-2}, toward={70,-26}, spread=0.3, force=0.2})
sb:reload(gore_m, 0.9)
print(sb:spatter{at={cx+6, cy+1}, toward={85,-12}, spread=0.25, force=0.25})

--@ chunk 7
local skyz = rect(420, 200, 280, 200)
work(skyz, {hand="body", piles={{sk_apricot_r, function(x,y) return 1 - smoothstep(200, 400, y) end}, {sk_gold_r, function(x,y) return smoothstep(200, 400, y) end}}, coverage=2, fill=true, clip=true, angle=0.05, seed=31})
wait(3*24*60)
local zh = ellipse(496, 318, 18, 24) + rect(470, 340, 50, 60)
work(zh, {hand="detail", tool={kind="round", width=3}, pile=zb_skin_dk, coverage=3, clip=zh, seed=32})
-- earlier state: rosette + spray
local cx, cy = 515, 309
local burst = (ellipse(522, 308, 8, 6) + ellipse(529, 303, 5, 4) + ellipse(528, 314, 4, 3) + ellipse(534, 308, 3.5, 3)):roughen(2, 4, 77)
stipple(burst - zh:shrink(1), {pile=gore_dk, width=2.5, coverage=2.2, cluster={0.5, 3}, pressure={0.5, 0.9}, seed=371})
local sb = brush{kind="round", width=6, stiffness=0.4}
sb:reload(gore, 1)
sb:spatter{at={512,312}, toward={110,-30}, spread=0.4, force=0.75}
sb:reload(gore, 1)
sb:spatter{at={514,308}, toward={80,-55}, spread=0.35, force=0.45}
wait(12*24*60)
-- now: a ragged cone of mist trailing from the clot, densest near the skull
local a0 = -0.33
local cone = mask(function(x, y)
  local dx, dy = x - (cx+4), y - cy
  local ang = math.atan(dy, dx)
  local r = math.sqrt(dx*dx + dy*dy)
  if dx < -4 then return 0 end
  local half = 0.22 + 0.12*smoothstep(0, 40, r)
  return (1 - smoothstep(half*0.5, half, math.abs(ang - a0))) * (1 - smoothstep(20, 62, r))
end):roughen(3, 7, 9)
stipple(cone - zh, {pile=gore_m, width=1.6, coverage=function(x,y) local r = math.sqrt((x-cx)^2+(y-cy)^2) return 1.6*(1 - smoothstep(8, 60, r)) end, cluster={0.5, 2.5}, pressure={0.3, 0.7}, feather=1, seed=33})
local sb2 = brush{kind="round", width=4, stiffness=0.4}
sb2:reload(gore_m, 0.9)
print(sb2:spatter{at={cx+6, cy-2}, toward={70,-24}, spread=0.22, force=0.2})
sb2:reload(gore_m, 0.9)
print(sb2:spatter{at={cx+6, cy+1}, toward={85,-14}, spread=0.2, force=0.25})

--@ chunk 8
local cx, cy = 515, 309
local zh = ellipse(496, 318, 18, 24) + rect(470, 340, 50, 60)
local a0 = -0.33
local ux, uy = math.cos(a0), math.sin(a0)
local tail = (ribbon({{cx+12, cy-1}, {cx+12+ux*12, cy-1+uy*12}, {cx+12+ux*26, cy-1+uy*26}}, {8, 5, 1.5})
            + ribbon({{cx+10, cy+3}, {cx+10+ux*10+2, cy+3+uy*10+1}, {cx+10+ux*20+4, cy+3+uy*20+3}}, {5, 3, 1})):roughen(1.5, 3, 41)
stipple(tail - zh, {pile=gore_dk, width=2, coverage=1.6, cluster={0.5, 2}, pressure={0.4, 0.8}, feather=1, seed=42})
-- the dense mist right at the clot
local near = ellipse(cx+18+ux*6, cy-1+uy*6, 14, 7)
stipple(near - zh, {pile=gore_m, width=1.4, coverage=1.0, cluster={0.4, 2}, pressure={0.3, 0.6}, feather=1, seed=43})

--@ chunk 9
sm_out = pile{{"lead white", 1.5}, {"ultramarine blue", 0.25}, {"raw umber", 0.3}, {"rose madder", 0.15}, name="sm_out"}
sm_mid = pile{{"lead white", 1.5}, {"raw umber", 0.15}, {"rose madder", 0.12}, {"orange chrome", 0.25}, {"ultramarine blue", 0.08}, name="sm_mid"}
sm_in = pile{{"lead white", 2}, {"orange chrome", 0.6}, {"cadmium yellow", 0.3}, name="sm_in"}
s2_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}, name="s2_rose"}
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
local skyz = rect(380, 420, 380, 260)
work(skyz, {hand="body", piles={{s2_rose, function(x,y) return 1 - smoothstep(420, 560, y) end}, {sk_apricot_r, function(x,y) return smoothstep(420, 560, y) end}}, coverage=2, fill=true, clip=true, angle=0.05, seed=61})
wait(4*24*60)
puff_m = smoke_body(470, 560, 1.15, 21)
wait(10*24*60)
print(drying(520,560), drying(560,530))

--@ chunk 10
-- duplicate puff so I can test two softening methods side by side
local skyz = rect(380, 40, 380, 260)
work(skyz, {hand="body", piles={{s2_rose, function(x,y) return 1 - smoothstep(40, 180, y) end}, {sk_apricot_r, function(x,y) return smoothstep(40, 180, y) end}}, coverage=2, fill=true, clip=true, angle=0.05, seed=62})
wait(4*24*60)
puff2_m = smoke_body(470, 180, 1.15, 21)
wait(10*24*60)
-- A (lower puff): lose() with a semi-transparent smoke gray, from outside in
sm_veil = pile{{"lead white", 1.5}, {"ultramarine blue", 0.2}, {"raw umber", 0.25}, {"rose madder", 0.15}, {"orange chrome", 0.1}, medium=0.55, name="sm_veil"}
print(lose(puff_m, {pile=sm_veil, where=1, tool="filbert 6", reach={10, 6}, load=0.25, seed=63}))

--@ chunk 11
-- B (upper puff): drifting wisps of veil smoke from the puff's top/back, soft brush, then blend only the new wet veil
local fb = brush{kind="filbert", width=12, stiffness=0.3}
local function w(pts, load) fb:reload(sm_veil, load or 0.35) fb:gesture(pts, {wobble=3, orient="across"}) end
-- smoke rolls forward then is drawn up and back over the top
w({{560,170,0.5},{575,150,0.45},{565,128,0.3},{540,118,0.15},{510,116,0.0}}, 0.35)
w({{548,150,0.4},{540,132,0.35},{516,126,0.2},{486,128,0.0}}, 0.3)
w({{575,185,0.45},{590,172,0.4},{598,152,0.25},{596,132,0.0}}, 0.3)
-- veil across the scalloped outer edge, straddling it
w({{530,148,0.4},{555,142,0.5},{578,152,0.45},{586,175,0.4},{578,196,0.3},{560,204,0.1}}, 0.35)
local zone = (puff2_m:grow(18) - puff2_m:shrink(10)) * mask(function(x, y) return smoothstep(500, 530, x) end) + ellipse(540, 125, 50, 18)
blend(zone, {angle=-0.6})

--@ chunk 12
cw_coat_md = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.3}, {"rose madder", 0.12}, {"lead white", 0.18}, name="cw_coat_md"}
cw_coat_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.45}, {"burnt sienna", 0.4}, {"lead white", 0.05}, name="cw_coat_dk"}
coat_vdk = pile{{"bone black", 0.6}, {"raw umber", 1}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, name="coat_vdk"}
coat_glaze4 = pile{{"burnt sienna", 1}, {"ultramarine blue", 0.55}, {"bone black", 0.2}, medium=0.75, name="coat_glaze4"}
coat_hi = pile{{"raw umber", 1}, {"burnt sienna", 0.7}, {"Naples yellow", 0.4}, {"lead white", 0.35}, {"rose madder", 0.1}, name="coat_hi"}
-- coat replica: a flared skirt panel
coatR = poly({{60,330},{150,320},{170,420},{185,520},{200,600},{170,612},{140,600},{110,612},{80,600},{50,612},{30,600},{40,500},{50,420}}, true)
work(coatR, {hand="body", tool={kind="filbert", width=11, stiffness=0.55}, piles={{cw_coat_dk, function(x,y) return 0.6 end},{cw_coat_md, function(x,y) return 0.5 end}}, angle=1.5, coverage=2, fill=true, clip=coatR, seed=71})
wait(5*24*60)
work(coatR, {hand="glaze", pile=coat_glaze4, coverage=2, fill=true, clip=coatR, angle=1.5, seed=72})
blend(coatR:shrink(1.5), {angle=1.5})
wait(10*24*60)
print(drying(100,450))

--@ chunk 13
fold_dk = pile{{"bone black", 0.5}, {"raw umber", 0.6}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.5}, medium=0.55, name="fold_dk"}
fold_lt = pile{{"raw umber", 1}, {"burnt sienna", 0.8}, {"Naples yellow", 0.35}, {"lead white", 0.3}, {"rose madder", 0.12}, name="fold_lt"}
local vb = brush{kind="filbert", width=9, stiffness=0.4}
local lb = brush{kind="filbert", width=12, stiffness=0.45}
local function v(pts, load) vb:reload(fold_dk, load or 0.45) vb:gesture(pts, {wobble=1.2, clip=coatR}) end
local function l(pts, load) lb:reload(fold_lt, load or 0.2) lb:gesture(pts, {wobble=1.5, clip=coatR}) end
-- valleys: start thin high on the back, widen and deepen toward the hem troughs
v({{100,380,0.0},{94,450,0.35},{86,530,0.6},{80,598,0.75}})
v({{125,370,0.0},{128,450,0.35},{134,530,0.6},{140,598,0.75}})
-- ridges: dry-brushed, light pressure
l({{78,400,0.0},{66,470,0.3},{56,540,0.4},{50,600,0.35}}, 0.22)
l({{112,400,0.0},{111,470,0.3},{110,540,0.45},{110,605,0.35}}, 0.22)
l({{150,400,0.0},{158,470,0.3},{165,540,0.4},{170,604,0.3}}, 0.2)

--@ chunk 14
coatR2 = poly({{260,330},{350,320},{370,420},{385,520},{400,600},{370,612},{340,600},{310,612},{280,600},{250,612},{230,600},{240,500},{250,420}}, true)
work(coatR2, {hand="body", tool={kind="filbert", width=11, stiffness=0.55}, piles={{cw_coat_dk, function(x,y) return 0.6 end},{cw_coat_md, function(x,y) return 0.5 end}}, angle=1.5, coverage=2, fill=true, clip=coatR2, seed=81})
wait(5*24*60)
work(coatR2, {hand="glaze", pile=coat_glaze4, coverage=2, fill=true, clip=coatR2, angle=1.5, seed=82})
blend(coatR2:shrink(1.5), {angle=1.5})
wait(10*24*60)
fold_lt2 = mix{{fold_lt, 0.4}, {cw_coat_md, 0.6}, name="fold_lt2"}
print(fold_lt2)

--@ chunk 15
local vb = brush{kind="filbert", width=9, stiffness=0.4}
local lb = brush{kind="filbert", width=12, stiffness=0.45}
local function v(pts, load) vb:reload(fold_dk, load or 0.45) vb:gesture(pts, {wobble=1.2, clip=coatR2}) end
local function l(pts, load) lb:reload(fold_lt2, load or 0.3) lb:gesture(pts, {wobble=1.5, clip=coatR2}) end
v({{300,380,0.0},{294,450,0.35},{286,530,0.6},{280,598,0.75}})
v({{325,370,0.0},{328,450,0.35},{334,530,0.6},{340,598,0.75}})
local r1 = {{278,400},{266,470},{256,540},{250,600}}
local r2 = {{312,400},{311,470},{310,540},{310,605}}
local r3 = {{350,400},{358,470},{365,540},{370,604}}
l({{278,400,0.0},{266,470,0.4},{256,540,0.55},{250,600,0.45}}, 0.3)
l({{312,400,0.0},{311,470,0.4},{310,540,0.55},{310,605,0.45}}, 0.3)
l({{350,400,0.0},{358,470,0.4},{365,540,0.5},{370,604,0.4}}, 0.28)
local rib = (ribbon(r1, {6, 9, 11, 12}) + ribbon(r2, {6, 9, 11, 12}) + ribbon(r3, {6, 9, 11, 12})) * coatR2:shrink(1.5)
blend(rib, {angle=1.5})

--@ chunk 16
local z = ribbon({{300,380},{294,450},{286,530},{280,598}}, {14, 20, 24, 26}) * coatR2:shrink(1.5)
blend(z, {angle=1.5})

--@ chunk 17
local skyz = rect(620, 420, 380, 260)
work(skyz, {hand="body", piles={{s2_rose, function(x,y) return 1 - smoothstep(420, 560, y) end}, {sk_apricot_r, function(x,y) return smoothstep(420, 560, y) end}}, coverage=2, fill=true, clip=true, angle=0.05, seed=91})
wait(4*24*60)
puff3_m = smoke_body(720, 560, 1.15, 21)
wait(10*24*60)
-- edge veil: smoke gray thinned toward sky, laid ALONG the contour straddling it, then blend the rim band only
sm_edge = mix{{sm_out, 0.5}, {s2_rose, 0.5}, name="sm_edge"}
local rim = (puff3_m:grow(6) - puff3_m:shrink(6)) * mask(function(x, y) return smoothstep(760, 790, x) end)
work(rim, {hand="body", tool={kind="filbert", width=6, stiffness=0.3}, pile=sm_edge, coverage=1.2, load=0.35, angle=function(x,y) return math.atan(y-540, x-800) + 1.57 end, length={8, 20}, seed=92})
blend(rim:grow(3), {angle=-0.4})
