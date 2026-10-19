-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
s2_dusk = pile{{"ultramarine blue", 0.8}, {"lead white", 0.8}, {"raw umber", 0.35}, {"rose madder", 0.12}, {"Prussian blue", 0.05}, name="s2_dusk"}
s2_mauve = pile{{"lead white", 1.5}, {"ultramarine blue", 0.4}, {"rose madder", 0.35}, {"raw umber", 0.2}, name="s2_mauve"}
s2_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}, name="s2_rose"}
cl_pink = pile{{"lead white", 2}, {"rose madder", 0.4}, {"vermilion", 0.15}, {"ultramarine blue", 0.15}, {"raw umber", 0.1}, name="cl_pink"}
local m = rect(540, 40, 440, 260)
work(m, {hand="body", tool={kind="filbert", width=14, stiffness=0.5},
  piles={{s2_dusk, function(x,y) return 1 - smoothstep(60, 130, y) end},
         {s2_mauve, function(x,y) return smoothstep(60, 130, y) * (1 - smoothstep(170, 240, y)) end},
         {cl_pink, function(x,y) return 0.6*smoothstep(150, 220, y) end},
         {s2_rose, function(x,y) return smoothstep(200, 270, y) end}},
  angle=function(x,y) return 0.05*math.sin(x/80) end, coverage=2, fill=true, clip=true, seed=5})
blend(m:shrink(4), {angle=0})
print(wait(30*24*60))
print(drying(700,150), drying(800,100))

--@ chunk 3
v_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.5}, {"rose madder", 0.2}, {"bone black", 0.3}, {"lead white", 0.2}, name="v_dk"}
v_md = mix{{v_dk, 0.7}, {s2_mauve, 0.3}, name="v_md"}
local wb = brush{kind="round", width=4.2, point=0.8, stiffness=0.55}
local fb = brush{kind="round", width=1.3, point=0.9, stiffness=0.55}
local function W(p, pts, l) wb:reload(p, l or 0.7) wb:gesture(pts, {wobble=0.15}) end
local function F(p, pts) fb:reload(p, 0.6) fb:gesture(pts, {wobble=0.05}) end
-- A1: soaring, slight dihedral, flying left, span ~32, at (640,150)
local ox, oy = 0, 0
W(v_dk, {{640,151,0.8},{633,148,0.85},{626,145.5,0.8},{620,143.5,0.6}})
F(v_dk, {{620,143.5,0.6},{616,140.5,0}})
F(v_dk, {{620,144,0.6},{615.5,142.5,0}})
F(v_dk, {{620.5,144.5,0.6},{616,145.5,0}})
W(v_dk, {{643,151,0.8},{650,148.5,0.85},{657,146.5,0.75},{662,145.5,0.55}})
F(v_dk, {{662,145.5,0.6},{666.5,142.5,0}})
F(v_dk, {{662,146,0.6},{667,144.8,0}})
F(v_dk, {{661.5,146.5,0.6},{666,147.5,0}})
wb:reload(v_dk, 0.7) wb:gesture({{636,151,0.5},{641,151.5,0.8},{646,153,0.5},{649,154.5,0.2}}, {wobble=0.1})
-- A2: banking, one wing raised (turning), smaller span ~22, at (760,110)
local sb = brush{kind="round", width=3.2, point=0.8, stiffness=0.55}
local function S(p, pts, l) sb:reload(p, l or 0.7) sb:gesture(pts, {wobble=0.1}) end
S(v_md, {{760,112,0.8},{755,108,0.85},{751,104,0.75},{748,101,0.5}})
F(v_md, {{748,101,0.5},{746,97.5,0}})
F(v_md, {{748.3,101.3,0.5},{745,99.5,0}})
S(v_md, {{762,112,0.8},{768,112.5,0.85},{774,113.5,0.7},{778,114.5,0.45}})
F(v_md, {{778,114.5,0.5},{781.5,113,0}})
F(v_md, {{778,115,0.5},{781.5,116,0}})
sb:reload(v_md, 0.6) sb:gesture({{758,112,0.5},{762,113,0.7},{765,115,0.2}}, {wobble=0.05})
-- A3: a far one, edge-on shallow V, span ~14, at (860,170)
local tb = brush{kind="round", width=2.2, point=0.85, stiffness=0.55}
tb:reload(v_md, 0.6) tb:gesture({{853,167,0.1},{857,169,0.6},{860,171,0.9}}, {wobble=0.05})
tb:reload(v_md, 0.6) tb:gesture({{860,171,0.9},{864,169.5,0.6},{868,168,0.1}}, {wobble=0.05})
print(wb:mark_width(0.8), sb:mark_width(0.8), tb:mark_width(0.9))

--@ chunk 4
local r = rag{width=8}
r:dip(1.0)
r:wipe({{748,100},{782,116}}, {pressure=0.9})
r:refold()
r:wipe({{782,114},{746,102}}, {pressure=0.9})
r:refold() r:dip(0.6)
r:wipe({{750,104},{780,112}}, {pressure=1})
print(r)

--@ chunk 5
local m = rect(40, 40, 440, 260)
work(m, {hand="body", tool={kind="filbert", width=14, stiffness=0.5},
  piles={{s2_dusk, function(x,y) return 1 - smoothstep(60, 130, y) end},
         {s2_mauve, function(x,y) return smoothstep(60, 130, y) * (1 - smoothstep(170, 240, y)) end},
         {cl_pink, function(x,y) return 0.6*smoothstep(150, 220, y) end},
         {s2_rose, function(x,y) return smoothstep(200, 270, y) end}},
  angle=function(x,y) return 0.05*math.sin(x/80) end, coverage=2, fill=true, clip=true, seed=6})
blend(m:shrink(4), {angle=0})
-- the cirrus streak, as on the painting (~290-460, y 90-100 here = 790-960 there)
local cb = brush{kind="filbert", width=8, stiffness=0.45}
cb:reload(cl_pink, 0.5)
cb:gesture({{285,97,0.2},{330,94,0.5},{380,92,0.6},{430,95,0.5},{465,93,0.1}}, {wobble=1})
print(wait(30*24*60), drying(200,150))

--@ chunk 6
v_far = mix{{v_dk, 0.5}, {s2_mauve, 0.5}, name="v_far"}
function bird1(cx, cy, p)
  local wb = brush{kind="round", width=3.6, point=0.8, stiffness=0.55}
  local fb = brush{kind="round", width=1.2, point=0.9, stiffness=0.55}
  local function W(pts) local q = {} for i, v in ipairs(pts) do q[i] = {cx + v[1], cy + v[2], v[3]} end wb:reload(p, 0.7) wb:gesture(q, {wobble=0.1}) end
  local function F(pts) local q = {} for i, v in ipairs(pts) do q[i] = {cx + v[1], cy + v[2], v[3]} end fb:reload(p, 0.6) fb:gesture(q, {wobble=0.05}) end
  -- left wing
  W({{-1,0,0.8},{-7,-2.5,0.85},{-13,-5,0.8},{-18,-6.5,0.55}})
  F({{-18,-6.5,0.6},{-21.5,-9,0}})
  F({{-18,-6.3,0.6},{-22,-7.6,0}})
  F({{-17.8,-6,0.6},{-21.6,-5.3,0}})
  -- right wing
  W({{2,0,0.8},{8,-2,0.85},{14,-4,0.75},{18.5,-4.8,0.5}})
  F({{18.5,-4.8,0.6},{22,-7.5,0}})
  F({{18.6,-4.4,0.6},{22.6,-5.4,0}})
  F({{18.2,-4,0.6},{21.8,-2.8,0}})
  -- body and tail
  wb:reload(p, 0.7) wb:gesture({{cx-3,cy,0.5},{cx+1,cy+0.5,0.8},{cx+4,cy+1.8,0.55},{cx+6.5,cy+3,0.2}}, {wobble=0.05})
end
function bird2(cx, cy, p)
  local wb = brush{kind="round", width=2.8, point=0.8, stiffness=0.55}
  local fb = brush{kind="round", width=1.1, point=0.9, stiffness=0.55}
  local function W(pts) local q = {} for i, v in ipairs(pts) do q[i] = {cx + v[1], cy + v[2], v[3]} end wb:reload(p, 0.7) wb:gesture(q, {wobble=0.08}) end
  local function F(pts) local q = {} for i, v in ipairs(pts) do q[i] = {cx + v[1], cy + v[2], v[3]} end fb:reload(p, 0.6) fb:gesture(q, {wobble=0.04}) end
  -- raised wing (banking)
  W({{-1,0,0.8},{-4,-3.5,0.85},{-7,-7,0.75},{-9,-9.5,0.5}})
  F({{-9,-9.5,0.55},{-10.5,-12.8,0}})
  F({{-9.2,-9.2,0.55},{-12.2,-11,0}})
  -- lower wing, foreshortened
  W({{1,0,0.8},{6,0.5,0.85},{11,1.3,0.7},{14,2,0.45}})
  F({{14,2,0.5},{16.6,0.7,0}})
  F({{14,2.4,0.5},{16.9,3.3,0}})
  -- body
  wb:reload(p, 0.6) wb:gesture({{cx-2,cy,0.5},{cx+1,cy+0.8,0.75},{cx+3.5,cy+2.5,0.2}}, {wobble=0.04})
end
function bird3(cx, cy, p)
  local tb = brush{kind="round", width=2.0, point=0.85, stiffness=0.55}
  tb:reload(p, 0.6) tb:gesture({{cx-7,cy-2.5,0.1},{cx-3.5,cy-0.8,0.6},{cx,cy+0.5,0.9}}, {wobble=0.03})
  tb:reload(p, 0.6) tb:gesture({{cx,cy+0.5,0.9},{cx+3.5,cy-1,0.6},{cx+7.5,cy-2,0.1}}, {wobble=0.03})
end
bird1(155, 152, v_dk)
bird2(235, 112, v_md)
bird3(360, 168, v_far)
