deadWood2 = pile{{"raw umber",1.2},{"bone black",0.8},{"lead white",1.1},{"pale smalt",0.6}, medium=0.1}
deadExt = {
  {pts={{197,222},{200,185},{194,152},{199,120},{208,92},{206,72},{211,52},{207,36},{213,22}}, ws={10.5,9.5,8.5,7,5.5,4.6,4,3.4,3}},
  {pts={{199,168},{222,142},{236,118},{233,104},{241,82},{251,66}}, ws={5.5,4.5,3.8,3.4,3,2.6}},
  {pts={{196,130},{178,110},{170,94},{160,72},{164,56}}, ws={4.5,3.6,3,2.6,2.2}},
  {pts={{262,238},{272,200},{268,168},{276,138},{284,110},{280,86},{289,68}}, ws={7.5,6.5,5.5,4.5,4,3.4,2.8}},
  {pts={{207,36},{198,24}}, ws={2,1.6}},
  {pts={{280,86},{268,72}}, ws={2.4,1.8}},
  {pts={{211,52},{226,40}}, ws={2.4,1.8}},
}
local dm = nil
for _,s in ipairs(deadExt) do local r = ribbon(s.pts, s.ws); dm = dm and (dm + r) or r end
oakDeadM2 = dm:roughen(0.6, 5, 16)
work(oakDeadM2, {hand="detail", pile=deadWood2, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=-math.pi/2, angle_jitter=0.4})
-- the pale stub on the bole becomes a short dark broken stub
local stub = ribbon({{186,338},{168,334},{156,327}}, {11,9,8.5}):roughen(0.6,5,17)
work(stub, {hand="detail", pile=barkDark, coverage=4, pressure={0.6,0.9}, load=1, fill=true})
