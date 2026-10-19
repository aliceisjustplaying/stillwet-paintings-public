-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
woods = pile{{"raw umber",2},{"red earth",1},{"Prussian blue",0.4},{"yellow ochre",0.5}, name="woods_dark"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
rocklite = pile{{"lead white",2},{"raw umber",1.5},{"smalt",1},{"red earth",0.3}, name="rocklite"}
rockwarm = pile{{"lead white",1.5},{"yellow ochre",1},{"red earth",0.8},{"raw umber",1}, name="rockwarm"}
moss = pile{{"green earth",3},{"chrome yellow",1.2},{"yellow ochre",1},{"raw umber",0.3}, name="moss"}
mossdark = pile{{"green earth",2},{"raw umber",1},{"Prussian blue",0.2},{"yellow ochre",1}, name="mossdark"}
mosslite = pile{{"chrome yellow",2},{"green earth",1},{"lead white",1},{"yellow ochre",0.5}, name="mosslite"}
work(rect(30,30,940,450), {hand="body", coverage=3, fill=true, length={25,60}, angle=1.2, piles={{rock,1},{woods,0.6}}, clip=true})
print(palette())

--@ chunk 3
rocklite:add{{"cobalt blue", 0.2}}
-- 1. knife planes, left third
local k = knife{width=30}
local planes = {
  {{60,120},{140,100},{200,110}}, {{80,180},{120,240}}, {{150,170},{210,150},{260,170}},
  {{60,300},{90,380}}, {{180,280},{240,260}}, {{120,330},{150,420}},
}
for i, p in ipairs(planes) do
  k:load(i%2==1 and rocklite or rockwarm, 0.6)
  k:lay(p, {pressure={0.25, 0.4}, lift=0.1})
end
-- 2. brush planes middle third: flat 12 short strokes
local fb = brush{kind="flat", width=12, stiffness=0.7}
for i=1,30 do
  if i%4==1 then fb:reload(i%8==1 and rocklite or rockwarm, 0.5) end
  local x, y = rand(340, 600), rand(80, 420)
  local a = rand(-0.3, 0.3) + (i%2==0 and 1.4 or 0)
  fb:stroke({{x, y}, {x + 25*math.cos(a), y + 25*math.sin(a)}}, {pressure={0.5, 0.3}, orient="across"})
end
-- 3. moss on a top plane right third: band along a curve
local top = ribbon({{660,150},{760,130},{860,140},{950,160}}, 40)
stipple(top, {pile=mossdark, width=10, coverage=1.2, cluster={0.5, 20}, feather=0.4, drag={3, 0}})
stipple(top:shrink(6), {pile=moss, width=8, coverage=0.8, cluster={0.6, 15}, feather=0.5, drag={3, 0}})
stipple(ribbon({{660,135},{760,115},{860,125},{950,145}}, 14), {pile=mosslite, width=6, coverage=0.6, cluster={0.6, 15}, feather=0.5, drag={3, 0}})
-- 4. moss with body hand short strokes on a second ledge
local top2 = ribbon({{660,320},{760,300},{860,310},{950,330}}, 40)
work(top2, {hand="body", pile=mossdark, tool={kind="filbert", width=7}, length={8,18}, angle=0.1, coverage=1.5})
work(top2:shrink(8), {hand="body", pile=moss, tool={kind="filbert", width=6}, length={6,14}, angle=0.1, coverage=0.9})
work(ribbon({{660,305},{760,285},{860,295},{950,315}}, 10), {hand="detail", pile=mosslite, length={5,12}, angle=0.1, coverage=0.8})

--@ chunk 4
work(rect(30,500,940,450), {hand="body", coverage=3, fill=true, length={25,60}, angle=1.2, piles={{rock,1},{woods,0.6}}, clip=true})
-- boulder A: facets
local top = poly({{80,600},{150,560},{260,555},{330,585},{300,625},{150,640}}, true)
local face = poly({{150,640},{300,625},{330,585},{350,700},{320,850},{170,860},{140,750}}, true)
local side = poly({{80,600},{150,640},{140,750},{170,860},{70,860},{50,700}}, true)
work(top, {hand="body", piles={{rockwarm,0.6},{rocklite,0.4},{rock,0.5}}, coverage=2, length={20,45}, angle=0.15, tool="filbert 12"})
work(side, {hand="body", piles={{rocklite,0.5},{rock,1}}, coverage=1.5, length={25,60}, angle=1.45, tool="filbert 12"})
work(face, {hand="body", piles={{rock,1},{woods,0.4},{rocklite,0.15}}, coverage=1.5, length={25,60}, angle=1.35, tool="filbert 12"})
-- knife thin accents along top edge, pressure high
local k = knife{width=25}
k:load(rockwarm, 0.5)
k:lay({{150,562},{260,557},{325,585}}, {pressure={0.8, 0.9}})
k:load(rocklite, 0.4)
k:lay({{85,605},{60,700}}, {pressure={0.85, 0.9}})
-- moss on top with mossdark body, then moss pile dabs by a soft round, mosslite rim with knife thin
local mtop = top * poly({{80,600},{150,560},{260,555},{330,585},{320,600},{150,600}}, true)
work(top:shrink(4), {hand="body", piles={{mossdark,1},{moss,0.6}}, tool={kind="round", width=8, stiffness=0.4}, length={6,16}, angle=function(x,y) return rand(-0.5,0.5) end, coverage=0.8, broken=0.5})
-- boulder B, right side: same but moss via scumble hand
local topB = poly({{520,620},{620,590},{760,600},{820,640},{700,660},{560,655}}, true)
local faceB = poly({{560,655},{700,660},{820,640},{840,760},{800,880},{560,880},{540,760}}, true)
work(topB, {hand="body", piles={{rockwarm,0.5},{rocklite,0.3},{rock,0.6}}, coverage=2, length={20,45}, angle=0.15, tool="filbert 12"})
work(faceB, {hand="body", piles={{rock,1},{woods,0.4},{rocklite,0.25}}, coverage=1.5, length={25,60}, angle=1.35, tool="filbert 12"})
work(topB, {hand="scumble", pile=moss, coverage=0.7})
work(topB:shrink(10), {hand="scumble", pile=mosslite, coverage=0.4})

--@ chunk 5
work(rect(30,30,940,450), {hand="body", coverage=3, fill=true, length={25,60}, angle=1.2, piles={{rock,1},{woods,0.6}}, clip=true})
local s1 = body.ellipsoid({200, 290, 0}, {170, 120, 90}):rough(14, 70, 2)
local s2 = body.ellipsoid({430, 330, 0}, {110, 90, 70}):turn({430,330,0}, 0, 0.3, 0):rough(10, 50, 3)
local s3 = body.block({720, 300, 0}, {300, 170, 120}, 25):turn({720,300,0}, 0.15, 0.2, 0.1):rough(12, 60, 4)
fA = form{{s1}, {s2}, {s3}, light={from={-1, -0.9}, front=0.4, ambient=0.15}}
local sil = fA:silhouette{}
local lit = fA:lit{soft=0.15}
local sh = fA:shadow{}
-- shadow body
work(sil, {hand="body", piles={{rock,1},{woods,0.5}}, coverage=2.5, fill=true, length={20,45}, angle=fA:field("across"), tool="filbert 10"})
-- lit planes
work(lit, {hand="body", piles={{rocklite, 0.6},{rockwarm,0.5},{rock,0.3}}, coverage=1.5, length={15,35}, angle=fA:field("across"), tool="filbert 10"})
print(sil:area(), lit:area())

--@ chunk 6
work(rect(30,500,940,450), {hand="body", coverage=3, fill=true, length={25,60}, angle=1.2, piles={{rock,1},{woods,0.6}}, clip=true})
-- hand-drawn boulder, three facets
topF = outline{{70,640},{130,585},{230,566},{330,580},{370,610},{300,640},{180,655}, char="broken", seed=5, amount=0.6}:mask()
leftF = outline{{70,640},{180,655},{200,740},{170,860},{60,850},{45,740}, char="broken", seed=6, amount=0.6}:mask() - topF
frontF = outline{{180,655},{300,640},{370,610},{395,700},{380,860},{170,860},{200,740}, char="broken", seed=7, amount=0.6}:mask() - topF - leftF
work(topF, {hand="body", piles={{rockwarm,0.7},{rocklite,0.5},{rock,0.25}}, coverage=3, fill=true, clip=true, length={20,40}, angle=0.1, tool="flat 10"})
work(leftF, {hand="body", piles={{rocklite,0.5},{rock,0.8}}, coverage=3, fill=true, clip=true, length={20,40}, angle=1.6, tool="flat 10"})
work(frontF, {hand="body", piles={{rock,1},{woods,0.5},{rockwarm,0.1}}, coverage=3, fill=true, clip=true, length={25,50}, angle=1.45, tool="flat 12"})
blend(topF:shrink(3):soften(6), {angle=0.1})
blend(leftF:shrink(3):soften(6), {angle=1.6})
local nz = noise{seed=8, period=50}
local mz = topF:grow(6) * mask(function(x,y) return clamp((nz:at01(x,y) - 0.35) * 4, 0, 1) end)
stipple(mz, {pile=mossdark, width=12, coverage=1.0, cluster={0.4, 20}, feather=0.6, drag={4, 0.2}, pressure={0.3,0.6}})
stipple(mz:shrink(4), {pile=moss, width=10, coverage=0.7, cluster={0.5, 20}, feather=0.6, drag={4, 0.2}, pressure={0.3,0.6}})
stipple(mz:shrink(8) * above(function(x) return 610 end), {pile=mosslite, width=7, coverage=0.4, cluster={0.6, 15}, feather=0.7, drag={3, 0.2}, pressure={0.2,0.5}})
-- moss creeping down the left facet edge
local mz2 = leftF * mask(function(x,y) return clamp((nz:at01(x+300,y) - 0.45) * 4, 0, 1) end) * above(function(x) return 760 end)
stipple(mz2, {pile=mossdark, width=10, coverage=0.8, cluster={0.5, 20}, feather=0.6, drag={4, 1.5}, pressure={0.3,0.6}})

--@ chunk 7
-- trial: backlit rocks, soft edges, moss tops
local A = outline{{560,700},{600,640},{680,610},{780,615},{850,650},{880,720},{870,860},{560,860}, char="broken", seed=15, amount=0.7}:mask()
work(A, {hand="body", piles={{rock,1},{woods,0.4}}, coverage=3, fill=true, length={20,50}, angle=1.3, tool="filbert 12", edge="firm"})
-- moss cap: band along the top contour
local cap = A - A:offset(-28)
cap = cap * above(function(x) return 720 end)
work(cap, {hand="body", piles={{mossdark,1},{moss,0.5}}, tool={kind="round", width=9, stiffness=0.4}, length={8,20}, angle=function(x,y) return rand(-0.6,0.6) end, coverage=2, edge="soft"})
work(cap:shrink(5) * above(function(x) return 680 end), {hand="body", pile=moss, tool={kind="round", width=7, stiffness=0.4}, length={6,14}, angle=function(x,y) return rand(-0.6,0.6) end, coverage=1, edge="soft"})
blend(cap:grow(4):soften(8), {angle=0.2})
-- rim light touches along the very top
local rim = A - A:offset(-8)
rim = rim * above(function(x) return 660 end)
work(rim, {hand="detail", pile=mosslite, length={5,12}, angle=0, coverage=0.6, broken=0.6})
