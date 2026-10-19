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
S = {
  {name="G", f={{820,340},{868,300},{915,420},{935,500},{840,470}}, v="L"},
  {name="C", f={{660,190},{705,150},{745,215},{860,395},{800,440},{690,420}}, v="M"},
  {name="Ce", f={{800,440},{860,395},{872,410},{812,455}}, v="S"},
  {name="Af", f={{578,395},{600,175},{630,90},{644,98},{652,400}}, v="L"},
  {name="Ae", f={{644,98},{656,112},{676,200},{705,405},{652,400}}, v="S"},
  {name="B", f={{455,430},{520,300},{575,215},{606,195},{600,290},{560,430}}, v="L"},
  {name="Be", f={{455,430},{446,418},{512,292},{568,205},{606,195},{575,215},{520,300}}, v="M"},
}
hullpts = {{290,280},{350,305},{430,340},{520,382},{530,440},{460,428},{380,388},{306,338},{294,312}}
F = {
  {name="I", f={{360,470},{410,420},{470,440},{455,505},{380,505}}, v="M"},
  {name="D", f={{450,510},{470,410},{545,365},{630,385},{625,470},{548,525}}, v="L"},
  {name="De", f={{450,510},{548,525},{625,470},{628,484},{552,542},{446,526}}, v="S"},
  {name="H", f={{600,545},{612,430},{640,400},{660,415},{655,548}}, v="L"},
  {name="E", f={{648,535},{680,430},{745,410},{830,452},{812,535}}, v="M"},
}
sky = pile{{"lead white",4},{"cobalt blue",1}, turps=0.4}
skyl = pile{{"lead white",8},{"cobalt blue",0.5},{"Naples yellow",0.3}, turps=0.4}
iceL = pile{{"lead white",6},{"Naples yellow",0.3}, turps=0.3}
iceM = pile{{"lead white",4},{"smalt",1},{"raw umber",0.1}, turps=0.3}
iceS = pile{{"lead white",2},{"cobalt blue",1},{"smalt",1},{"raw umber",0.3}, turps=0.3}
hullp = pile{{"raw umber",2},{"bone black",1}, turps=0.3}
water = pile{{"Prussian blue",1},{"bone black",1},{"lead white",1}, turps=0.3}
plain = pile{{"lead white",6},{"cobalt blue",0.3},{"Naples yellow",0.2}, turps=0.3}
local skym = above(function(x) return horizon end)
work(skym, {hand="broad", piles={{sky, function(x,y) return 1-y/horizon end},{skyl, function(x,y) return y/horizon end}}, coverage=1.5})
local plm = below(function(x) return horizon end)
work(plm, {hand="broad", pile=plain, coverage=1.5, angle=0})
local cols = {L=iceL, M=iceM, S=iceS}
for _,s in ipairs(S) do work(poly(s.f), {hand="body", pile=cols[s.v], clip=true, coverage=1.5}) end
work(poly(hullpts, true), {hand="body", pile=hullp, clip=true, coverage=1.5})
for _,s in ipairs(F) do work(poly(s.f), {hand="body", pile=cols[s.v], clip=true, coverage=1.5}) end
local wm = poly({{0,600},{200,625},{400,610},{560,598},{620,594},{560,612},{400,640},{200,668},{0,690}})
work(wm, {hand="body", pile=water, clip=true, coverage=1.5, angle=0})
