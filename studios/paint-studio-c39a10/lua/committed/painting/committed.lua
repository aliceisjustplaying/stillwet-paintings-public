-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box cezanne
--@ engine 5

--@ chunk 1
canvas{size=730, aspect=1.25, linen={18,16}, seed=1906,
 ground={{pile={{"lead white",10},{"yellow ochre",0.25}}, um=120, apply="knife", texture=0.3}}}
print(table.concat(tubes(), ", "))
print(W,H)

--@ chunk 2
drawp = pile{{"ultramarine blue",2},{"cobalt blue",1},{"bone black",0.3},{"red earth",0.2}, medium=0.3, name="drawp"}
db = brush{kind="round", width=3, point=0}
function line(pts, p, w)
  local g = {}
  for i,pt in ipairs(pts) do g[i] = {pt[1], pt[2], pt[3] or p or 0.7} end
  if db:fullness() < 0.35 then db:load(drawp, 0.8) end
  db:gesture(g, {wobble=w or 1.5})
end
function arc(cx, cy, rx, ry, a0, a1, p, n)
  n = n or 7
  local g = {}
  for i=0,n do
    local a = a0 + (a1-a0)*i/n
    g[#g+1] = {cx + rx*math.cos(a), cy + ry*math.sin(a), p*(0.6+0.4*math.sin(math.pi*i/n))}
  end
  line(g, nil, 1)
end
db:load(drawp, 0.8)
-- table back edges (misaligned)
line({{0,410,0.5},{200,409},{380,411,0.4}}, 0.5)
line({{680,428,0.5},{740,426},{790,424,0.3}}, 0.5)
-- table front edge
line({{0,688,0.6},{300,690},{600,694},{1000,699,0.5}}, 0.6, 2)
-- curtain left edge
line({{805,0,0.4},{786,120},{800,250},{772,380},{752,470},{760,560},{790,690},{812,800,0.3}}, 0.6, 2)
-- pitcher
line({{600-62,470,0.5},{560,410},{520,370},{520,330},{532,300},{548,262},{548,245},{535,222},{518,212,0.4}}, 0.7)
line({{518,212,0.4},{570,214},{640,214},{658,222},{652,245},{652,262},{668,300},{682,340},{680,390},{660,440},{662,470,0.5}}, 0.7)
arc(600, 470, 62, 14, 0.1, math.pi-0.1, 0.6)
arc(590, 214, 64, 12, math.pi, 2*math.pi, 0.5)
line({{668,262,0.6},{708,268},{722,300},{708,350},{684,388,0.5}}, 0.7)
-- bottle
line({{266,445,0.6},{264,350},{265,220},{272,190},{290,165},{291,120},{290,82,0.4}}, 0.7)
line({{311,82,0.4},{312,120},{313,165},{330,190},{336,220},{337,350},{335,445,0.6}}, 0.7)
arc(300, 444, 35, 9, 0.1, math.pi-0.1, 0.5)
-- plate
arc(395, 535, 135, 42, 0.2, math.pi-0.2, 0.6, 9)
arc(395, 535, 135, 42, math.pi+0.6, 2*math.pi-0.2, 0.5, 6)
-- apples
apples = {{340,505,38},{420,498,40},{476,522,33},{382,460,35},{215,592,36},{278,645,34},{560,612,37},{652,560,33}}
for i,a in ipairs(apples) do
  arc(a[1], a[2], a[3], a[3]*0.94, -0.3, math.pi*1.1, 0.6)
  arc(a[1], a[2], a[3]*1.02, a[3]*0.96, math.pi*1.0, math.pi*1.85, 0.45)
end
-- cloth
line({{140,447,0.4},{300,442},{470,436},{545,440,0.3}}, 0.5)
line({{660,465,0.4},{700,472},{735,540},{722,620},{692,690},{672,740},{642,800,0.4}}, 0.6, 2)
line({{140,447,0.4},{112,490},{120,560},{150,650},{195,690},{218,740},{240,800,0.4}}, 0.6, 2)
-- cloth folds
line({{300,700,0.5},{330,750},{350,800,0.3}}, 0.5)
line({{470,700,0.4},{455,760},{470,800,0.3}}, 0.5)
line({{580,700,0.4},{600,750},{590,800,0.3}}, 0.4)
line({{180,520,0.3},{230,555},{260,600,0.3}}, 0.4)
line({{470,600,0.3},{520,650},{560,690,0.3}}, 0.4)
line({{680,500,0.3},{690,560},{670,640,0.3}}, 0.4)
-- dado line on wall
line({{0,285,0.4},{150,284},{260,286,0.3}}, 0.4)
line({{337,290,0.3},{500,292,0.3}}, 0.4)
-- curtain folds
line({{860,0,0.3},{850,200},{870,400},{850,560},{880,800,0.3}}, 0.4, 3)
line({{930,0,0.3},{945,250},{925,500},{950,800,0.3}}, 0.4, 3)

--@ chunk 3
db:load(drawp, 0.7)
line({{540,470,0.6},{524,430},{518,380},{522,335},{534,300,0.4}}, 0.6)
-- spout lip
line({{532,224,0.3},{512,210},{528,206,0.3}}, 0.4)

--@ chunk 4
pitcherM = poly({{518,212},{570,211},{640,213},{658,222},{652,245},{652,262},{668,300},{682,340},{680,390},{664,440},{662,470},{600,484},{540,470},{524,430},{518,380},{522,335},{534,300},{548,262},{548,245},{535,222}}, true)
handleM = ribbon({{666,264},{706,268},{720,300},{707,350},{682,388}}, 9)
pitcherAll = pitcherM + handleM
bottleM = poly({{266,445},{264,350},{265,220},{272,190},{290,165},{291,120},{290,80},{311,80},{312,120},{313,165},{330,190},{336,220},{337,350},{335,445},{300,452}}, true)
clothM = poly({{140,447},{300,442},{470,436},{545,440},{610,452},{660,465},{700,472},{735,540},{722,620},{692,690},{672,740},{642,805},{240,805},{218,740},{195,690},{150,650},{120,560},{112,490}}, true)
plateM = ellipse(395,535,135,42)
applesM = ellipse(apples[1][1],apples[1][2],apples[1][3],apples[1][3]*0.95)
for i=2,#apples do local a=apples[i]; applesM = applesM + ellipse(a[1],a[2],a[3],a[3]*0.95) end
curtainM = poly({{805,-5},{1005,-5},{1005,805},{812,805},{790,690},{760,560},{752,470},{772,380},{800,250},{786,120}}, true)
local back = below(function(x) if x < 600 then return 410 else return 426 end end)
local front = below(function(x) return 688 + 0.011*x end)
objs = pitcherAll + bottleM + curtainM
wallM = -back - objs
tableM = back - front - clothM - objs
apronM = front - clothM - curtainM
print(wallM:area(), tableM:area(), apronM:area(), clothM:area())

--@ chunk 5
L_wall = pile{{"lead white",1.5},{"cobalt blue",1},{"viridian",0.35},{"yellow ochre",0.5},{"red earth",0.1}, turps=0.5, name="L_wall"}
L_tab = pile{{"yellow ochre",2},{"red earth",1},{"lead white",0.5}, turps=0.5, name="L_tab"}
L_apron = pile{{"red earth",2},{"bone black",0.6},{"ultramarine blue",0.4}, turps=0.5, name="L_apron"}
L_curt = pile{{"ultramarine blue",1.5},{"bone black",0.5},{"red earth",0.8},{"viridian",0.3}, turps=0.5, name="L_curt"}
L_bot = pile{{"viridian",1.5},{"bone black",0.6},{"yellow ochre",0.6}, turps=0.5, name="L_bot"}
work(wallM, {hand="body", tool="filbert 14", pile=L_wall, coverage=1.1, angle=-0.9, angle_jitter=0.3, length={40,90}, edge="firm"})
work(tableM, {hand="body", tool="filbert 12", pile=L_tab, coverage=1.2, angle=-0.15, length={30,70}, edge="firm"})
work(apronM, {hand="body", tool="filbert 14", pile=L_apron, coverage=1.2, angle=0.05, length={40,90}, edge="firm"})
work(curtainM, {hand="body", tool="filbert 14", pile=L_curt, coverage=1.1, angle=1.45, angle_jitter=0.2, length={50,110}, edge="soft"})
work(bottleM, {hand="body", tool="filbert 7", pile=L_bot, coverage=1.3, angle=1.5, length={20,50}, clip=true})

--@ chunk 6
L_shad = pile{{"lead white",2},{"cobalt blue",1},{"ultramarine blue",0.3},{"rose madder",0.2},{"yellow ochre",0.15}, turps=0.5, name="L_shad"}
local sh = ellipse(668, 488, 60, 20) + ellipse(430, 585, 110, 18)
for i,a in ipairs(apples) do if i >= 5 then sh = sh + ellipse(a[1]+16, a[2]+a[3]*0.75, a[3]*1.1, a[3]*0.35) end end
sh = sh + ribbon({{300,700},{330,750},{350,800}}, 26) + ribbon({{470,700},{455,760},{470,800}}, 22) + ribbon({{585,700},{605,750},{595,800}}, 30)
sh = sh + ribbon({{180,520},{230,555},{260,600}}, 16) + ribbon({{470,600},{520,650},{560,690}}, 16) + ribbon({{685,500},{695,560},{675,640}}, 30)
sh = sh + poly({{618,700},{690,690},{672,740},{642,805},{610,805}})
clothShadM = (sh:roughen(4, 30, 3) * clothM) - plateM - applesM
work(clothShadM, {hand="body", tool="filbert 9", pile=L_shad, coverage=1.0, angle=1.1, length={20,45}, edge="soft"})
local ps = pitcherM * mask(function(x,y) return smoothstep(615, 650, x) end)
work(ps + handleM, {hand="body", tool="filbert 7", pile=L_shad, coverage=1.1, angle=1.5, length={20,40}, clip=true})
