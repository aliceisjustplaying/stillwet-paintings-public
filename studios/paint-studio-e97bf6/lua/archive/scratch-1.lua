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
slabs = {
  A1 = {{575,390},{598,170},{628,92},{641,100},{655,395}},
  A2 = {{641,100},{652,108},{668,190},{700,400},{655,395}},
  C  = {{652,175},{690,160},{830,360},{865,432},{720,445},{680,330}},
  B  = {{445,420},{505,300},{560,215},{602,200},{596,290},{560,420}},
  D  = {{455,505},{480,400},{560,362},{625,380},{612,470},{540,522}},
  E  = {{650,525},{690,420},{760,408},{822,452},{800,532}},
}
hull_top = {{285,285},{350,310},{430,345},{510,385}}
hull_bot = {{305,340},{380,385},{460,425}}
h = pencil("HB")
local function closed(p) local q = {} for i,v in ipairs(p) do q[#q+1]=v end q[#q+1]=p[1] return q end
for k,p in pairs(slabs) do h:line(closed(p), {pressure=0.5, smooth=false}) end
h:line(hull_top, {pressure=0.6})
h:line(hull_bot, {pressure=0.6})
h:line({{285,285},{292,315},{305,340}}, {pressure=0.6})
h:line({{290,288},{215,255}}, {pressure=0.6})
h:rule({0,horizon},{1000,horizon},{pressure=0.3})
h:line({{0,640},{200,625},{400,610},{560,598},{620,594}}, {pressure=0.4})
h:line({{0,690},{200,668},{400,640},{560,612},{620,596}}, {pressure=0.4})
