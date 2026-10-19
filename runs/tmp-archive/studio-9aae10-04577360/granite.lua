rkMid = pile{{"lead white",1.2},{"raw umber",0.9},{"smalt",0.45},{"bone black",0.25},{"yellow ochre",0.1}, medium=0.1}
rkDeep = pile{{"bone black",1.0},{"raw umber",0.8},{"smalt",0.3}, medium=0.1}
lichG = pile{{"lead white",1.2},{"yellow ochre",0.5},{"raw umber",0.3},{"smalt",0.3}, medium=0.1}
local rock = (ROCKBAND + UPM) * rect(540, 440, 205, 55)
local g = noise{seed=77, octaves=3, period=7, kind="ridged", stretch={0.1, 1.6}}
work(rock:shrink(0.8):times(function(x,y) return clamp(g(x,y)*1.6-0.35, 0, 1) end), {hand="detail", pile=rkMid, coverage=1.5, fill=true, angle=0.1, load=0.8, pressure={0.35,0.6}, tool={kind="round", width=1.3, point=0.8}})
-- cracks and joints
local b = brush{kind="rigger", width=1.2, point=1}
b:load(rkDeep, 0.6)
local cracks = {
 {{566,452},{570,458},{569,463}}, {{612,450},{615,456},{621,459}}, {{660,452},{657,457},{661,462}},
 {{700,451},{703,457}}, {{590,473},{592,480},{591,488}}, {{617,476},{616,486}}, {{667,473},{669,482},{667,489}}, {{711,474},{713,484}}}
for _,c in ipairs(cracks) do b:stroke(c, {pressure={0.6,0.2}}) end
-- sky-lit left edges of the uprights and the capstone's left end
local R = (ROCKBAND + UPM)
local rim = mask(function(x,y) if x < 540 or x > 750 or y < 440 or y > 495 then return 0 end return R:at(x,y) * (1 - R:at(x-2.2,y)) end)
work(rim, {hand="detail", pile=rkC, coverage=3, fill=true, angle=math.pi/2, load=0.8, pressure={0.4,0.7}, tool={kind="round", width=1, point=1}})
-- lichen specks
math.randomseed(5)
local lb2 = brush{kind="round", width=1.2, point=0.8}
lb2:load(lichG, 0.5)
for i=1,26 do local x, y = rand(552,735), rand(452,488) if R:at(x,y) > 0.9 then lb2:stroke({{x,y},{x+rand(0.5,1.5),y+rand(-0.4,0.4)}}, {pressure={0.4,0.3}}) end end
