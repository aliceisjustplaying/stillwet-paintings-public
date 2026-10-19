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
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}, name="fs1"}
fg1 = pile{{"lead white",1.6},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.22},{"Naples yellow",0.12},{"rose madder",0.04}, name="fg1"}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
-- substrate: shadow band like the painting's, and a lit plain strip above
work(rect(40,60,920,120), {hand="broad", pile=pl2, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 10", seed=1})
work(rect(40,180,920,500), {hand="broad", piles={{fs1,1},{fg1,function(x,y) return clamp((y-180)/300,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 10", seed=2})
blend(rect(42,182,916,496), {angle=0.02, seed=3})
print(wait(6*24*60))

--@ chunk 3
fgT = pile{{"lead white",1.2},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.22},{"Naples yellow",0.12},{"rose madder",0.05}, name="fgT"}
fgB = pile{{"lead white",0.8},{"cobalt blue",0.5},{"smalt",0.35},{"raw umber",0.35},{"green earth",0.2},{"Naples yellow",0.1},{"red earth",0.03}, name="fgB"}
slabG = pile{{"lead white",0.8},{"cobalt blue",0.45},{"smalt",0.2},{"green earth",0.45},{"raw umber",0.3},{"Prussian blue",0.03}, name="slabG"}
slabG2 = pile{{"lead white",1.2},{"cobalt blue",0.5},{"smalt",0.2},{"green earth",0.4},{"raw umber",0.2}, name="slabG2"}
wedgeL = pile{{"lead white",4},{"cobalt blue",0.3},{"Naples yellow",0.3},{"raw umber",0.06}, name="wedgeL"}
local m = rect(60,200,400,300)
work(m, {hand="broad", piles={{fgT,function(x,y) return clamp(1-(y-200)/300,0,1)+0.05 end},{fgB,function(x,y) return clamp((y-220)/280,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 12", seed=11})
blend(m:shrink(1), {angle=0.02, seed=12})
work(rect(520,200,180,140), {hand="broad", pile=slabG, clip=true, coverage=2.5, fill=true, angle=-0.2, tool="filbert 8", seed=13})
blend(rect(521,201,178,138), {angle=-0.2, seed=14})
work(rect(720,200,180,140), {hand="broad", pile=slabG2, clip=true, coverage=2.5, fill=true, angle=-0.2, tool="filbert 8", seed=15})
blend(rect(721,201,178,138), {angle=-0.2, seed=16})
work(rect(520,380,100,120), {hand="detail", pile=wedgeL, clip=true, coverage=3, fill=true, angle=-1.1, tool={kind="filbert",width=2.5}, seed=17})

--@ chunk 4
fgT2 = pile{{"lead white",1.0},{"cobalt blue",0.55},{"smalt",0.35},{"raw umber",0.24},{"Naples yellow",0.14},{"rose madder",0.05}, name="fgT2"}
fgB2 = pile{{"lead white",0.65},{"cobalt blue",0.42},{"smalt",0.3},{"raw umber",0.42},{"green earth",0.25},{"Naples yellow",0.14},{"red earth",0.04}, name="fgB2"}
slabG3 = pile{{"lead white",0.6},{"cobalt blue",0.35},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.35},{"yellow ochre",0.08},{"Prussian blue",0.02}, name="slabG3"}
wedgeL2 = pile{{"lead white",3},{"cobalt blue",0.35},{"smalt",0.1},{"Naples yellow",0.3},{"raw umber",0.1}, name="wedgeL2"}
local m = rect(60,520,400,150)
work(m, {hand="broad", piles={{fgT2,function(x,y) return clamp(1-(y-520)/150,0,1)+0.05 end},{fgB2,function(x,y) return clamp((y-530)/140,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 12", seed=21})
blend(m:shrink(1), {angle=0.02, seed=22})
work(rect(720,380,180,120), {hand="broad", pile=slabG3, clip=true, coverage=2.5, fill=true, angle=-0.2, tool="filbert 8", seed=23})
blend(rect(721,381,178,118), {angle=-0.2, seed=24})
work(rect(640,380,60,120), {hand="detail", pile=wedgeL2, clip=true, coverage=3, fill=true, angle=-1.1, tool={kind="filbert",width=2.5}, seed=25})

--@ chunk 5
print("noop")

--@ chunk 6
palette{scrape={fs1, fg1, fgT, fgB, slabG, slabG2, wedgeL, slabG3, wedgeL2}}
print(wait(4*24*60))
cs0 = pile{{"lead white",1.1},{"cobalt blue",0.7},{"smalt",0.5},{"Naples yellow",0.08},{"rose madder",0.08},{"raw umber",0.12}, name="cs0"}
cs1 = pile{{"lead white",1.8},{"cobalt blue",0.65},{"smalt",0.45},{"Naples yellow",0.12},{"rose madder",0.06},{"raw umber",0.07}, name="cs1"}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
sDeepG = pile{{"lead white",0.7},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.4},{"raw umber",0.25}, name="sDeepG"}
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}, name="litCool"}
crevD = pile{{"lead white",0.35},{"cobalt blue",1},{"Prussian blue",0.15},{"raw umber",0.55},{"rose madder",0.05}, name="crevD"}
local top = poly({{120,600},{150,590},{200,592},{260,582},{330,578},{360,584},{372,640},{110,650}})
local leftF = poly({{120,600},{110,650},{100,652},{112,604}})
work(top, {hand="detail", piles={{cs1,1},{cs0,0.6},{edgeG,0.25}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=-0.05, seed=31})
blend(top:shrink(1), {angle=-0.05, seed=32})
work(leftF, {hand="detail", piles={{edgeG,1},{sDeepG,0.8}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.4, seed=33})
local lb = brush{kind="round", width=1.6, point=0.7}
lb:reload(litCool, 0.5)
lb:stroke({{122,600},{150,590.5},{200,592.5}}, {pressure={0.4,0.25}, shake=0.3})
lb:reload(litCool, 0.5)
lb:stroke({{262,582.5},{300,580},{330,578.5}}, {pressure={0.35,0.25}, shake=0.3})
local rg = brush{kind="rigger", width=1, point=1}
rg:reload(crevD, 0.4)
rg:stroke({{110,651},{240,647},{372,641}}, {pressure={0.3,0.25}, shake=0.3})

--@ chunk 7
fgT2 = pile{{"lead white",1.0},{"cobalt blue",0.55},{"smalt",0.35},{"raw umber",0.24},{"Naples yellow",0.14},{"rose madder",0.05}, name="fgT2"}
npTop = mix{{cs1,0.55},{fgT2,0.3},{edgeG,0.15}, name="npTop"}
local back = {{520,612},{534,606},{548,607},{556,601},{574,600},{590,603},{606,596},{628,594},{640,597},{652,591},{676,589},{690,592},{704,588}}
local pts = {}
for _,p in ipairs(back) do pts[#pts+1] = p end
pts[#pts+1] = {716,612}; pts[#pts+1] = {730,672}; pts[#pts+1] = {520,672}; pts[#pts+1] = {516,640}
local top = poly(pts)
local endF = poly({{520,612},{516,640},{520,672},{505,672},{502,646},{507,618}})
local gn = noise{seed=5, period=40, stretch={-0.1, 6}}
work(top, {hand="detail", piles={{npTop,1},{fgT2, function(x,y) return math.max(0,gn(x,y))*0.8 end},{cs1, function(x,y) return clamp(1-(y-595)/25,0,1)*0.6 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=-0.08, seed=41})
blend(top:shrink(1), {angle=-0.08, seed=42})
work(endF, {hand="detail", piles={{edgeG,1},{sDeepG,0.9}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.5, seed=43})
-- strata on end face
local rg = brush{kind="rigger", width=1, point=1}
for _,f in ipairs({0.3,0.55,0.78}) do
  rg:reload(sDeepG, 0.35)
  rg:stroke({{lerp(507,520,0.1), lerp(618,612,0.1)+f*50},{lerp(502,516,0.6), 646+f*20},{lerp(505,520,0.9), 672-(1-f)*10}}, {pressure={0.18,0.08}, shake=0.3, clip=endF})
end
-- contact dark under end and along back foot
rg:reload(crevD, 0.45)
rg:stroke({{503,646},{505,660},{506,672}}, {pressure={0.35,0.3}, shake=0.2})
-- broken light lip on the back edge (skylight on the rim)
local lb = brush{kind="round", width=1.5, point=0.7}
for i=1,#back-1,2 do
  if i % 4 ~= 3 then
  lb:reload(litCool, 0.45)
  lb:stroke({{back[i][1], back[i][2]+0.8},{back[i+1][1], back[i+1][2]+0.8}, back[i+2] and {back[i+2][1], back[i+2][2]+0.8} or {back[i+1][1]+3, back[i+1][2]+0.8}}, {pressure={0.35,0.2}, shake=0.3})
  end
end
-- a crack across the top in perspective, with snow lodged (light) and its shadowed wall (dark)
rg:reload(crevD, 0.45)
rg:stroke({{600,597},{604,612},{598,628},{606,648},{602,672}}, {pressure={0.3,0.15}, shake=0.4})
lb:reload(litCool, 0.4)
lb:stroke({{602,606},{600,618},{601,632}}, {pressure={0.3,0.15}, shake=0.4})
