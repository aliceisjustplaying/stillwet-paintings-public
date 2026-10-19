-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ limbs-join-nearest

--@ chunk 1
canvas{size=700, aspect=1.4, linen={16, 14}, seed=1774,
  ground={
    {pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 3}}, um=70, apply="knife", texture=0.35},
    {pile={{"lead white", 8}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=45, apply="roller"},
  }}
print(W, H)
print(table.concat(tubes(), ", "))

--@ chunk 2
HZ = 468
land_pts = {{-10, 427}, {40, 429}, {95, 433}, {150, 436}, {205, 438}, {260, 440}, {320, 440}, {380, 443}, {440, 450}, {495, 461}, {545, 475}, {600, 492}, {660, 512}, {725, 530}, {795, 546}, {870, 558}, {940, 566}, {1010, 572}}
h = pencil("2H")
-- horizon, ruled, only where sea shows (right of the land crossing)
h:rule({505, HZ}, {1000, HZ}, {pressure=0.3})
-- land crest
h:sketch(land_pts, {pressure=0.3})
-- dolmen: uprights and capstone
dol_cap = {{268, 404}, {285, 391}, {320, 384}, {365, 382}, {405, 386}, {428, 396}, {424, 410}, {390, 414}, {330, 415}, {285, 415}, {268, 404}}
h:sketch(dol_cap, {pressure=0.3})
h:sketch({{288, 415}, {284, 428}, {290, 441}, {312, 441}, {316, 426}, {310, 415}}, {pressure=0.3})
h:sketch({{350, 415}, {346, 430}, {352, 443}, {372, 443}, {374, 428}, {368, 415}}, {pressure=0.3})
h:sketch({{398, 413}, {396, 430}, {402, 447}, {420, 448}, {421, 430}, {414, 410}}, {pressure=0.3})
-- oak trunk and main limbs
oak_trunk = {{140, 436}, {145, 385}, {150, 335}, {157, 295}, {162, 266}}
h:sketch(oak_trunk, {pressure=0.3})
h:sketch({{118, 438}, {125, 400}, {132, 340}, {140, 300}}, {pressure=0.25})
h:sketch({{168, 436}, {166, 390}, {168, 340}, {175, 295}}, {pressure=0.25})
limbA = {{160, 268}, {132, 232}, {98, 207}, {60, 190}, {20, 172}, {-20, 160}}
limbB = {{164, 266}, {176, 216}, {168, 170}, {181, 120}, {173, 76}, {186, 32}}
limbC = {{166, 282}, {210, 257}, {260, 241}, {310, 216}, {352, 200}, {398, 176}}
h:sketch(limbA, {pressure=0.25})
h:sketch(limbB, {pressure=0.25})
h:sketch(limbC, {pressure=0.25})
-- moon
h:sketch({{684, 178}, {678, 190}, {682, 202}, {694, 206}}, {pressure=0.2})
