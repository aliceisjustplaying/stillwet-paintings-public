-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
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
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 2}, {"red earth", 1}, {"yellow ochre", 1}}, texture=0.35, um=90}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.25}, {"raw umber", 0.08}}, texture=0.4, um=45}}, linen={15, 13}, seed=6, size=1050}

--@ chunk 2
horizon = 440
back = {
  {{{830,330},{875,290},{915,415},{940,505},{850,480}}, "L"},
  {{{875,290},{886,300},{955,505},{940,505},{915,415}}, "S"},
  {{{790,300},{830,262},{850,330},{820,345}}, "M"},
  {{{740,225},{770,195},{790,255},{760,262}}, "L"},
  {{{660,190},{705,150},{748,212},{775,215},{800,270},{860,395},{800,440},{690,420}}, "S"},
  {{{578,395},{600,175},{630,90},{644,98},{652,400}}, "L"},
  {{{644,98},{656,112},{676,200},{705,405},{652,400}}, "D"},
  {{{455,430},{520,300},{575,215},{606,195},{600,290},{560,430}}, "L"},
  {{{446,418},{512,292},{568,205},{606,195},{575,215},{520,300},{455,430}}, "M"},
}
front = {
  {{{285,392},{330,345},{410,362},{470,402},{455,475},{360,485},{300,455}}, "M"},
  {{{285,392},{330,345},{410,362},{470,402},{466,412},{410,374},{332,357},{292,398}}, "L"},
  {{{350,425},{385,318},{405,326},{420,415}}, "L"},
  {{{405,326},{414,334},{430,416},{420,415}}, "S"},
  {{{240,480},{255,440},{290,425},{315,450},{305,490}}, "S"},
  {{{450,510},{470,410},{545,365},{630,385},{625,470},{548,525}}, "M"},
  {{{450,510},{548,525},{625,470},{628,484},{552,542},{446,526}}, "D"},
  {{{600,545},{612,430},{640,400},{660,415},{655,548}}, "L"},
  {{{660,415},{672,425},{668,550},{655,548}}, "S"},
  {{{648,535},{680,430},{745,410},{830,452},{812,535}}, "M"},
  {{{680,430},{745,410},{830,452},{826,462},{745,422},{684,442}}, "L"},
  {{{820,540},{835,470},{900,455},{950,520},{930,550}}, "S"},
  {{{700,714},{745,630},{1000,575},{1000,714}}, "L"},
  {{{700,714},{745,630},{756,640},{716,714}}, "D"},
}
hull = {{300,272},{360,296},{440,334},{520,378},{532,442},{470,412},{390,372},{318,330},{300,316},{293,295}}
k1 = pile{{"lead white",1.2},{"cobalt blue",1.2},{"Prussian blue",0.08}}
k2 = pile{{"lead white",2.2},{"cobalt blue",1},{"Prussian blue",0.04}}
k3 = pile{{"lead white",5},{"cobalt blue",1},{"Prussian blue",0.02}}
k4 = pile{{"lead white",8},{"Naples yellow",0.35},{"cobalt blue",0.15}}
plain = pile{{"lead white",5},{"cobalt blue",0.4},{"smalt",0.2},{"Naples yellow",0.1}}
far = pile{{"lead white",5},{"cobalt blue",0.6},{"rose madder",0.2}}
cols = {
 L = pile{{"lead white",6},{"Naples yellow",0.25}},
 M = pile{{"lead white",4},{"cobalt blue",0.4},{"smalt",0.6},{"raw umber",0.1},{"Naples yellow",0.1}},
 S = pile{{"lead white",2},{"cobalt blue",1},{"smalt",0.8},{"raw umber",0.3}},
 D = pile{{"lead white",1},{"cobalt blue",1},{"Prussian blue",0.2},{"raw umber",0.4}},
}
hullp = pile{{"raw umber",2},{"bone black",1}}
water = pile{{"Prussian blue",1},{"bone black",1},{"lead white",1.5}}
local function wgt(c, w) return function(x,y) local t=y/horizon; return math.max(0, 1-math.abs(t-c)/w) end end
local sp = {{k1, wgt(0,0.38)},{k2, wgt(0.3,0.38)},{k3, wgt(0.62,0.38)},{k4, wgt(1.0,0.4)}}
work(above(function(x) return horizon end), {hand="body", piles=sp, coverage=2, fill=true, angle=0})
work(below(function(x) return horizon end), {hand="broad", pile=plain, coverage=2, angle=0, fill=true})
work(poly({{20,440},{60,425},{110,428},{150,418},{200,430},{250,440}}), {hand="body", pile=far, clip=true, coverage=2, fill=true})
work(poly({{870,440},{880,412},{990,410},{1000,415},{1000,440}}), {hand="body", pile=far, clip=true, coverage=2, fill=true})
work(poly({{40,485},{40,478},{70,462},{100,466},{130,450},{155,458},{185,447},{210,458},{225,485}}), {hand="body", pile=cols.M, clip=true, coverage=2, fill=true})
work(poly({{850,505},{1000,490},{1000,560},{880,565}}), {hand="body", pile=cols.M, clip=true, coverage=2, fill=true})
for _,s in ipairs(back) do work(poly(s[1]), {hand="body", pile=cols[s[2]], clip=true, coverage=2, fill=true}) end
work(poly(hull, true), {hand="body", pile=hullp, clip=true, coverage=2, fill=true})
local bb = brush("round", 7)
bb:load(hullp, 1)
bb:stroke({{304,276},{212,232}}, {pressure={0.9,0.6}})
bb:load(hullp, 1)
bb:stroke({{400,315},{464,170}}, {pressure={1,0.7}})
for _,s in ipairs(front) do work(poly(s[1]), {hand="body", pile=cols[s[2]], clip=true, coverage=2, fill=true}) end
local wm = poly({{0,600},{60,606},{130,612},{180,609},{250,617},{330,612},{420,606},{500,601},{580,597},{640,594},{590,603},{520,610},{450,618},{380,626},{300,632},{240,642},{150,648},{80,658},{0,664}})
work(wm, {hand="body", pile=water, clip=true, coverage=2, angle=0, fill=true})
