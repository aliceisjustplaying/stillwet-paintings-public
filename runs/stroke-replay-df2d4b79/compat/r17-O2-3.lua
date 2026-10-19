-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=600, aspect=1.5, linen={16,13}, seed=7, ground={{pile={{"lead white",6},{"yellow ochre",1}}, um=120, apply="knife", texture=0.3},{pile={{"lead white",3},{"red earth",1},{"yellow ochre",1},{"raw umber",0.5}}, um=25, apply="brush"}}}
print(W,H)

--@ chunk 2

h = pencil("2B")
h:rule({0,415},{1000,415},{pressure=0.3})
-- distant shore
h:sketch({{0,392},{60,386},{130,390},{200,384},{260,392},{340,395},{420,400},{520,405},{620,410},{700,414}},{pressure=0.3})
-- spire
h:line({{228,392},{232,352},{236,392}},{pressure=0.4, smooth=false})
-- channel edges
h:sketch({{560,667},{600,600},{660,540},{700,490},{690,455},{650,430},{640,418}},{pressure=0.3})
h:sketch({{1000,560},{930,520},{850,480},{780,450},{720,430},{690,418}},{pressure=0.3})
-- mud near bank lower left
h:sketch({{0,520},{120,505},{260,500},{400,500},{520,480},{600,450},{640,430}},{pressure=0.25})
-- boat
h:sketch({{150,560},{200,585},{300,590},{380,570},{400,545}},{pressure=0.4})
h:sketch({{150,560},{250,548},{400,545}},{pressure=0.35})
h:line({{268,550},{262,330}},{pressure=0.4})
-- posts
h:line({{585,470},{586,432}},{pressure=0.4})
h:line({{615,478},{616,445}},{pressure=0.4})
h:line({{760,500},{761,462}},{pressure=0.4})
-- cloud masses
h:sketch({{0,120},{150,90},{320,140},{480,110},{640,170},{800,150},{1000,200}},{pressure=0.2})
h:sketch({{380,300},{500,260},{640,250},{760,270},{900,300},{1000,290}},{pressure=0.2})

--@ chunk 3

sky_top = pile{{"lead white",5},{"smalt",2},{"raw umber",0.3},{"red earth",0.1}}
sky_mid = pile{{"lead white",7},{"smalt",1},{"red earth",0.35},{"yellow ochre",0.3}}
sky_low = pile{{"lead white",9},{"chrome yellow",0.8},{"yellow ochre",0.6},{"red earth",0.1}}
skyM = rect(0,0,1000,420)
local n = noise{seed=3, period=300, octaves=3}
local b1 = below(function(x) return 170 + 25*n(x,0) end)
local b2 = below(function(x) return 300 + 20*n(x,100) end)
work(skyM - b1, {hand="broad", pile=sky_top, angle=function(x,y) return 0.1*n(x,y) end, coverage=2.5, clip=skyM})
work(skyM * b1 - b2:grow(0), {hand="broad", pile=sky_mid, angle=0.05, coverage=2.5, clip=skyM})
work(skyM * b2, {hand="broad", pile=sky_low, angle=0, coverage=2.5, clip=skyM})

