-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{size=900, aspect=1.5, linen={16,14}, seed=4417,
  ground={
    {pile={{"lead white",8},{"yellow ochre",0.3}}, um=110, apply="knife", texture=0.25},
    {pile={{"lead white",3},{"red earth",1.2},{"raw umber",1.0},{"yellow ochre",0.6}}, um=22, apply="brush"},
  }}
print(W, H)

--@ chunk 2
-- the drawing: key contours as globals
D = {}
D.horizon = {{0,455},{200,452},{420,457},{600,452},{1000,455}}
D.mesa = {{0,412},{40,404},{70,398},{230,396},{262,402},{300,420},{340,440},{380,455}}
D.hill = {{520,457},{600,440},{700,428},{820,420},{920,424},{1000,432}}
D.moon = {150,110,30}
-- cowboy
D.hat = {{210,262},{232,260},{236,236},{246,224},{258,228},{268,222},{276,232},{278,258},{302,266}}
D.face = {{272,266},{276,276},{283,285},{277,290},{278,296},{272,302},{256,304},{246,296}}
D.cb_back = {{238,272},{232,300},{226,330},{210,380},{185,440},{150,505},{122,560}}
D.cb_hem = {{122,560},{180,568},{240,566},{298,562}}
D.cb_front = {{268,318},{286,340},{290,400},{292,470},{298,562}}
D.gunarm_top = {{258,326},{300,322},{340,320},{384,316}}
D.gunarm_bot = {{282,348},{330,342},{386,334}}
D.gun = {{386,312},{450,312},{450,322},{420,324},{412,346},{398,346},{396,330},{386,334}}
D.farhand = {{300,370},{350,352},{394,326}}
D.leg_rear = {{232,560},{210,590},{186,606},{166,620},{212,622},{212,606},{232,575}}
D.leg_front = {{262,562},{290,590},{302,604},{334,620},{290,622},{286,606},{266,580}}
-- zombie
D.z_head = {{700,312},{706,296},{722,292},{734,302},{736,320},{726,336},{712,340},{700,330}}
D.z_back = {{732,336},{752,370},{768,420},{772,470}}
D.z_front = {{702,342},{690,372},{700,420},{712,470}}
D.z_arm1 = {{700,370},{650,374},{600,366},{586,360}}
D.z_arm2 = {{712,358},{662,350},{620,338},{604,332}}
D.z_leg_rear = {{760,470},{775,530},{790,596},{760,604}}
D.z_leg_front = {{725,470},{712,530},{705,600},{676,606}}
D.cross1 = {870,480,870,580,846,505,896,505}
D.grave = {{800,606},{840,582},{920,584},{970,600},{940,616},{830,616}}
D.flash = {470,318}
c = chalk()
local function L(pts, pr) c:line(pts, {pressure=pr or 0.35}) end
L(D.horizon, 0.25); L(D.mesa, 0.3); L(D.hill, 0.3)
c:line({{120,110},{150,80},{180,110},{150,140},{120,110}}, {pressure=0.25})
L(D.hat); L(D.face); L(D.cb_back); L(D.cb_hem); L(D.cb_front)
L(D.gunarm_top); L(D.gunarm_bot); c:line(D.gun, {pressure=0.4, smooth=false}); L(D.farhand, 0.3)
c:line(D.leg_rear, {pressure=0.35, smooth=false}); c:line(D.leg_front, {pressure=0.35, smooth=false})
L(D.z_head); L(D.z_back); L(D.z_front); L(D.z_arm1); L(D.z_arm2); L(D.z_leg_rear); L(D.z_leg_front)
c:line({{870,480},{870,580}}, {pressure=0.3}); c:line({{846,505},{896,505}}, {pressure=0.3})
L(D.grave, 0.3)

--@ chunk 3
erase(everywhere(), {strength=0.9})
local s, cx, cy = 1.2, 480, 640
function T(pts)
  local o = {}
  for i, p in ipairs(pts) do o[i] = {cx + (p[1]-cx)*s, cy + (p[2]-cy)*s} end
  return o
end
for _, k in ipairs({"hat","face","cb_back","cb_hem","cb_front","gunarm_top","gunarm_bot","gun","farhand","leg_rear","leg_front",
  "z_head","z_back","z_front","z_arm1","z_arm2","z_leg_rear","z_leg_front"}) do D[k] = T(D[k]) end
D.horizon = {{0,500},{300,497},{600,502},{1000,498}}
D.mesa = {{0,470},{30,462},{60,458},{170,456},{200,462},{230,478},{270,492},{300,500}}
D.hill = {{560,503},{650,488},{760,476},{880,472},{1000,480}}
D.moon = {850,118,34}
D.cross1 = {890,515,890,600,868,535,912,535}
D.grave = {{820,612},{860,594},{935,596},{985,608},{955,624},{850,624}}
D.flash = T({{470,318}})[1]
local c2 = chalk()
local function L(pts, pr) c2:line(pts, {pressure=pr or 0.35}) end
L(D.horizon, 0.25); L(D.mesa, 0.3); L(D.hill, 0.3)
c2:line({{816,118},{850,84},{884,118},{850,152},{816,118}}, {pressure=0.25})
L(D.hat); L(D.face); L(D.cb_back); L(D.cb_hem); L(D.cb_front)
L(D.gunarm_top); L(D.gunarm_bot); c2:line(D.gun, {pressure=0.4, smooth=false}); L(D.farhand, 0.3)
c2:line(D.leg_rear, {pressure=0.35, smooth=false}); c2:line(D.leg_front, {pressure=0.35, smooth=false})
L(D.z_head); L(D.z_back); L(D.z_front); L(D.z_arm1); L(D.z_arm2); L(D.z_leg_rear); L(D.z_leg_front)
c2:line({{890,515},{890,600}}, {pressure=0.3}); c2:line({{868,535},{912,535}}, {pressure=0.3})
L(D.grave, 0.3)
print(D.flash[1], D.flash[2])
