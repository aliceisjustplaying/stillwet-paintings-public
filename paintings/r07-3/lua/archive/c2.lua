-- the drawing: a level horizon, the far shore and its town, the near bank
HZ = 432
G = function(x, c, s) return math.exp(-((x - c) / s)^2) end
sitting{hours=3}
-- far shore profile (land top), a low tongue with the town at the middle
SHORE = {{-5,433},{40,431},{95,428},{150,426},{200,424},{236,423},{300,421},{360,420},{420,419},{470,418},
         {530,418},{590,419},{650,420},{700,421},{760,423},{830,425},{900,427},{960,429},{1005,430}}
-- the town, drawn as a silhouette line (left to right)
TOWN = {{366,421},{372,415},{380,412},{390,412},{396,411},{401,406},{406,411},{412,410},{440,409},{446,403},
        {452,409},{470,408},{472,403},{488,403},{488,370},{491,369},{491,363},{500,330},{509,363},{509,369},
        {512,370},{512,403},{540,403},{546,407},{560,408},{562,398},{576,398},{576,389},{578,380},{580,389},
        {580,398},{596,398},{600,406},{606,407},{612,401},{618,407},{632,409},{640,410},{652,412},{664,417},{674,420}}
MILL = {x=236, base=423, top=404}
BANK = {}
for x = -10, 1010, 30 do
  BANK[#BANK+1] = {x, 626 - 34*G(x, 90, 190) - 26*G(x, 930, 150) + 6*math.sin(x/47)}
end
h = pencil("2H")
h:rule({0, HZ}, {1000, HZ}, {pressure=0.3})
h:sketch(SHORE, {pressure=0.3})
h:sketch(BANK, {pressure=0.3})
b = pencil("3B")
b:line(TOWN, {pressure={0.55, 0.65, 0.6}, smooth=false})
b:rule({500, 334}, {500, 424}, {pressure=0.35})   -- the axis through the tower
b:line({{MILL.x-4, MILL.base}, {MILL.x-3, MILL.top}, {MILL.x+3, MILL.top}, {MILL.x+4, MILL.base}}, {pressure=0.55, smooth=false})
b:line({{MILL.x-14, MILL.top-12}, {MILL.x+14, MILL.top+12}}, {pressure=0.5})
b:line({{MILL.x+13, MILL.top-11}, {MILL.x-13, MILL.top+11}}, {pressure=0.5})
MILL2 = {x=812, base=425, top=412}
b:line({{MILL2.x-3, MILL2.base}, {MILL2.x-2, MILL2.top}, {MILL2.x+2, MILL2.top}, {MILL2.x+3, MILL2.base}}, {pressure=0.5, smooth=false})
b:line({{MILL2.x-9, MILL2.top-6}, {MILL2.x+9, MILL2.top+6}}, {pressure=0.45})
b:line({{MILL2.x+6, MILL2.top-9}, {MILL2.x-6, MILL2.top+9}}, {pressure=0.45})
b:line(BANK, {pressure={0.5, 0.6, 0.5}})
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
