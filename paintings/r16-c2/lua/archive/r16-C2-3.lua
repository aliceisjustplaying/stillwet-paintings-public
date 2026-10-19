-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=560, aspect=1.4, linen={16,13}, seed=7, ground={{pile={{"lead white",1}}, um=110, apply="knife", texture=0.3}, {pile={{"lead white",3},{"yellow ochre",1},{"red earth",0.35},{"raw umber",0.3}}, um=20, apply="brush"}}}
print(W,H); print(table.concat(tubes(), ", "))

--@ chunk 2

h = pencil("HB")
h:rule({0,400},{1000,400},{pressure=0.25})
-- spit of land at right
h:sketch({{600,402},{660,396},{720,392},{760,370},{790,330},{830,305},{870,310},{900,330},{930,360},{960,378},{1000,380}}, {pressure=0.3})
-- far shore left
h:sketch({{0,392},{80,388},{160,390},{220,386},{300,392},{420,396},{540,399}}, {pressure=0.2})
-- mud bank foreground left
h:sketch({{0,560},{120,540},{260,548},{380,575},{470,610},{540,660},{600,714}}, {pressure=0.3})
-- middle sandbar
h:sketch({{120,468},{240,458},{380,462},{520,470},{640,478}}, {pressure=0.25})
h:sketch({{700,500},{820,492},{1000,488}}, {pressure=0.25})
-- boat hull
h:sketch({{190,528},{230,540},{280,542},{320,532},{330,520}}, {pressure=0.35})
h:sketch({{190,528},{215,520},{280,518},{330,520}}, {pressure=0.3})
h:line({{262,520},{250,430}}, {pressure=0.35})
-- stakes
for i,p in ipairs({{600,452,18},{640,462,22},{690,476,28},{750,494,36},{830,520,46}}) do h:line({{p[1],p[2]},{p[1]+2,p[2]+p[3]}},{pressure=0.3}) end

--@ chunk 3
sky1 = pile{{"lead white",3},{"smalt",1.2},{"raw umber",0.25},{"red earth",0.1}}
sky2 = pile{{"lead white",4},{"cobalt blue",0.5},{"red earth",0.25},{"raw umber",0.1}}
sky3 = pile{{"lead white",5},{"yellow ochre",0.8},{"vermilion",0.2},{"cobalt blue",0.1}}
sky4 = pile{{"lead white",6},{"chrome yellow",0.7},{"yellow ochre",0.5},{"vermilion",0.12}}
local n = noise{seed=3, period=300, octaves=3}
local function band(y0, y1) return mask(function(x,y) local w = n(x,y)*18; return (y > y0 + w and y < y1 + w) and 1 or 0 end) end
work(band(-20, 150), {hand="body", tool="filbert 14", pile=sky1, angle=function(x,y) return 0.05*math.sin(x/200) end, coverage=2.5, length={40,110}, fill=true})
work(band(140, 255), {hand="body", tool="filbert 14", pile=sky2, angle=0.02, coverage=2.5, length={40,110}, fill=true})
work(band(245, 345), {hand="body", tool="filbert 14", pile=sky3, angle=-0.02, coverage=2.5, length={40,110}, fill=true})
work(rect(0, 335, 1000, 68), {hand="body", tool="filbert 12", pile=sky4, angle=0, coverage=2.5, length={40,120}, fill=true, clip=rect(0,0,1000,401)})

