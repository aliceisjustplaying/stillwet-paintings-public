-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=700, aspect=1.4, linen={16,13}, seed=1811,
 ground={{pile={{"red earth",2},{"yellow ochre",2},{"lead white",1}}, um=120, apply="knife", texture=0.35},
         {pile={{"lead white",6},{"yellow ochre",0.4},{"raw umber",0.1}}, um=60, apply="brush"}}}
print(W,H); print(table.concat(tubes(), ", "))

--@ chunk 2
h = pencil("H")
-- horizon and knoll
h:sketch({{0,455},{200,452},{400,456},{600,453},{800,457},{1000,454}}, {pressure=0.25})
h:sketch({{0,522},{150,515},{300,506},{450,492},{560,482},{640,478},{760,483},{880,497},{1000,508}}, {pressure=0.3})
-- dolmen: capstone and uprights
h:line({{552,458},{565,444},{600,438},{650,437},{700,441},{726,452},{722,463},{680,466},{610,466},{560,464},{552,458}}, {pressure=0.4})
for _,u in ipairs({{572,464,568,485},{612,466,615,482},{665,466,662,480},{705,463,708,484}}) do
  h:line({{u[1]-7,u[2]},{u[3]-8,u[4]}}, {pressure=0.35}); h:line({{u[1]+7,u[2]},{u[3]+8,u[4]}}, {pressure=0.35})
end
-- big oak trunk and main limbs
h:line({{385,508},{392,440},{396,380},{392,320},{380,280},{350,220},{320,160},{300,100}}, {pressure=0.35})
h:line({{425,508},{418,440},{414,380},{418,320},{430,280},{470,230},{520,170},{560,120}}, {pressure=0.35})
h:sketch({{400,300},{410,230},{405,160},{415,90},{410,50}}, {pressure=0.25})
h:sketch({{360,240},{300,215},{250,200},{220,170}}, {pressure=0.25})
h:sketch({{450,260},{520,250},{590,230},{620,200}}, {pressure=0.25})
-- right oak
h:line({{838,500},{842,430},{840,360},{830,300},{815,240}}, {pressure=0.35})
h:line({{862,500},{858,430},{862,370},{880,310},{910,250}}, {pressure=0.35})
h:sketch({{835,330},{790,300},{760,260}}, {pressure=0.25})
h:sketch({{870,340},{930,320},{970,280}}, {pressure=0.25})
-- figure
h:sketch({{505,470},{503,480},{500,500},{510,500},{508,480},{505,470}}, {pressure=0.3})
-- far church ruin
h:sketch({{190,455},{190,370},{205,360},{220,370},{220,455}}, {pressure=0.15})
-- moon
h:sketch({{752,100},{745,112},{750,126},{762,130}}, {pressure=0.2})

--@ chunk 3
sk1 = pile{{"lead white",5},{"smalt",2.2},{"raw umber",0.3},{"red earth",0.12}, medium=0.15}
sk2 = pile{{"lead white",7},{"smalt",1.2},{"red earth",0.08}, medium=0.15}
sk3 = pile{{"lead white",8},{"yellow ochre",0.5},{"vermilion",0.12}, medium=0.15}
sk4 = pile{{"lead white",8},{"chrome yellow",0.35},{"yellow ochre",0.3}, medium=0.15}
local hz = function(x) return 460 + 3*math.sin(x/70) end
local function band(a, b) return below(function(x) return a end) * above(function(x) return b end) end
skym = above(hz)
work(band(-10,170), {hand="broad", pile=sk1, angle=0, coverage=2, fill=true, angle_jitter=0.08})
work(band(150,290), {hand="broad", pile=sk2, angle=0, coverage=2, fill=true, angle_jitter=0.08})
work(band(270,395), {hand="broad", pile=sk3, angle=0, coverage=2, fill=true, angle_jitter=0.08})
work(band(380,470) * above(function(x) return 472 end), {hand="broad", pile=sk4, angle=0, coverage=2, fill=true, angle_jitter=0.08})

