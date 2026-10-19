-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
sk_deep = pile{{"ultramarine blue", 1}, {"raw umber", 0.6}, {"lead white", 0.3}, {"rose madder", 0.15}, {"bone black", 0.1}}
sk_dusk = pile{{"ultramarine blue", 0.8}, {"lead white", 0.8}, {"raw umber", 0.35}, {"rose madder", 0.12}, {"Prussian blue", 0.05}}
cl_gray = pile{{"lead white", 1.2}, {"ultramarine blue", 0.5}, {"rose madder", 0.35}, {"raw umber", 0.35}}
cl_pink = pile{{"lead white", 2}, {"rose madder", 0.4}, {"vermilion", 0.15}, {"ultramarine blue", 0.15}, {"raw umber", 0.1}}
work(rect(0,0,1000,300), {hand="broad", piles={{sk_deep, function(x,y) return 1 - smoothstep(50, 150, y) end}, {sk_dusk, function(x,y) return smoothstep(50, 150, y) end}}, coverage=2, fill=true, clip=true, angle=0})
local cb2 = brush{kind="filbert", width=26, stiffness=0.35}
cb2:reload(cl_gray, 0.5) cb2:gesture({{-20,92,0.25},{160,108,0.5},{360,132,0.3},{430,140,0.1}}, {wobble=5, orient="across"})
cb2:reload(cl_gray, 0.45) cb2:gesture({{-20,128,0.3},{200,144,0.45},{400,163,0.2},{480,170,0.05}}, {wobble=5, orient="across"})
cb2:reload(cl_pink, 0.45) cb2:gesture({{10,150,0.2},{230,165,0.35},{420,180,0.05}}, {wobble=5, orient="across"})
local m1 = poly({{-10,80},{300,95},{540,150},{540,195},{300,190},{-10,175}}, true)
blend(m1, {angle=0.1})
wait(10*24*60)
print(drying(200,130))

--@ chunk 3
-- local colors for the fix
fix_top = mix{{sk_deep, 0.5}, {cl_gray, 0.5}, name="fix_top"}
fix_bank = mix{{cl_gray, 0.6}, {sk_dusk, 0.4}, name="fix_bank"}
fix_low = mix{{sk_dusk, 0.7}, {cl_gray, 0.3}, name="fix_low"}
local fb = brush{kind="filbert", width=12, stiffness=0.35}
local function w(p, pts, load) fb:reload(p, load or 0.45) fb:gesture(pts, {wobble=4, orient="across"}) end
-- top edge on the left half (x 0..250): edge y ~ 80..90
math.randomseed(5)
for i = 0, 7 do
  local x0 = i*32 - 10
  local yE = 80 + x0*0.05
  w(fix_top, {{x0, yE - 8 + rand(-3,3), 0.2}, {x0 + 30, yE - 4 + rand(-4,4), 0.45}, {x0 + 60, yE + rand(-4,4), 0.1}}, 0.4)
  w(fix_bank, {{x0 + 16, yE + 6 + rand(-3,3), 0.2}, {x0 + 46, yE + 2 + rand(-4,4), 0.4}, {x0 + 76, yE + rand(-4,4), 0.1}}, 0.35)
end
-- bottom edge left: y ~ 175..185
for i = 0, 7 do
  local x0 = i*32 - 10
  local yE = 176 + x0*0.05
  w(fix_low, {{x0, yE + 7 + rand(-3,3), 0.2}, {x0 + 30, yE + 2 + rand(-4,4), 0.45}, {x0 + 60, yE - 3 + rand(-3,3), 0.1}}, 0.4)
  w(fix_bank, {{x0 + 16, yE - 7 + rand(-3,3), 0.2}, {x0 + 46, yE - 2 + rand(-4,4), 0.4}, {x0 + 76, yE + 3 + rand(-3,3), 0.1}}, 0.35)
end
local band = (ribbon({{-20,80},{260,92}}, 30) + ribbon({{-20,176},{260,189}}, 30)):soften(12)
blend(band, {angle=0.05})

--@ chunk 4
local R = rect(300, 0, 700, 250)
work(R, {hand="broad", piles={{sk_deep, function(x,y) return 1 - smoothstep(50, 150, y) end}, {sk_dusk, function(x,y) return smoothstep(50, 150, y) end}}, coverage=2, fill=true, angle=0, edge={lost=1, found=0}, seed=8})
local cb2 = brush{kind="filbert", width=22, stiffness=0.35}
local function c(p, pts, load) cb2:reload(p, load or 0.45) cb2:gesture(pts, {wobble=6, orient="across"}) end
c(cl_gray, {{330,96,0.1},{420,104,0.4},{540,118,0.5},{660,126,0.4},{760,136,0.1}}, 0.45)
c(cl_gray, {{350,130,0.1},{460,136,0.45},{600,148,0.45},{720,156,0.15}}, 0.45)
c(cl_pink, {{380,150,0.05},{480,156,0.35},{600,166,0.35},{690,172,0.05}}, 0.4)
c(cl_pink, {{420,112,0.05},{520,118,0.3},{620,126,0.2},{680,130,0.0}}, 0.35)

--@ chunk 5
local R = rect(300, 0, 700, 250)
blend(R:shrink(25):soften(25), {angle=0.05})

--@ chunk 6
fg_dark = pile{{"raw umber", 1}, {"bone black", 0.45}, {"ultramarine blue", 0.55}, {"rose madder", 0.15}, {"lead white", 0.08}}
work(rect(850,650,150,64), {hand="body", pile=fg_dark, coverage=2, fill=true, clip=true, angle=0})
wait(10*24*60)
sig_p = pile{{"red earth", 1}, {"lead white", 0.35}, {"raw umber", 0.2}, medium=0.2, name="sig"}
function sign(x0, yb, s)
  local rb = brush{kind="rigger", width=1.3*s, point=0.9, stiffness=0.5}
  local function L(pts) local q = {} for i, p in ipairs(pts) do q[i] = {x0 + p[1]*s, yb + p[2]*s, p[3] or 0.6} end rb:reload(sig_p, 0.6) rb:gesture(q, {wobble=0.1}) end
  L({{4,-8.5,0.4},{1.5,-9,0.6},{0,-5,0.7},{0.6,-1,0.7},{3,0,0.6},{5,-1.2,0.3}})          -- C
  L({{7.5,-11,0.5},{7,-5,0.7},{7.2,0,0.6},{8.4,-0.6,0.3}})                                -- l
  L({{13.6,-5.2,0.5},{11.5,-6,0.6},{10,-3.5,0.7},{11,-0.2,0.7},{13.5,-1.4,0.6},{13.7,-5.5,0.6},{13.8,-0.5,0.6},{15,-0.3,0.3}})  -- a
  L({{16.5,-6,0.5},{16.6,-2,0.7},{18,0,0.7},{20,-1.5,0.6},{20.3,-6,0.6},{20.4,-1,0.6},{21.6,-0.3,0.3}}) -- u
  L({{26.8,-5.2,0.5},{24.5,-6,0.6},{23,-3.5,0.7},{24,-0.2,0.7},{26.6,-1.4,0.6},{27,-11,0.6},{27.1,-0.5,0.6},{28.3,-0.3,0.3}}) -- d
  L({{29.8,-2.8,0.5},{32.6,-3.6,0.6},{32.3,-5.8,0.6},{30.2,-5.6,0.6},{29.6,-2.6,0.7},{31,-0.1,0.6},{33.4,-0.8,0.3}}) -- e
end
sign(905, 700, 1.4)
