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
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
fgT2 = pile{{"lead white",1.0},{"cobalt blue",0.55},{"smalt",0.35},{"raw umber",0.24},{"Naples yellow",0.14},{"rose madder",0.05}, name="fgT2"}
fgB2 = pile{{"lead white",0.65},{"cobalt blue",0.42},{"smalt",0.3},{"raw umber",0.42},{"green earth",0.25},{"Naples yellow",0.14},{"red earth",0.04}, name="fgB2"}
work(rect(0,0,1000,300), {hand="broad", pile=pl2, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 10", seed=1})
local m = rect(0,300,1000,414)
work(m, {hand="broad", piles={{fgT2,function(x,y) return clamp(1-(y-300)/414,0,1)+0.05 end},{fgB2,function(x,y) return clamp((y-320)/394,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 12", seed=2})
blend(m:shrink(1), {angle=0.02, seed=3})
print(wait(7*24*60))

--@ chunk 3
cs0 = pile{{"lead white",1.1},{"cobalt blue",0.7},{"smalt",0.5},{"Naples yellow",0.08},{"rose madder",0.08},{"raw umber",0.12}, name="cs0"}
cs1 = pile{{"lead white",1.8},{"cobalt blue",0.65},{"smalt",0.45},{"Naples yellow",0.12},{"rose madder",0.06},{"raw umber",0.07}, name="cs1"}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
sDeepG = pile{{"lead white",0.7},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.4},{"raw umber",0.25}, name="sDeepG"}
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}, name="litCool"}
crevD = pile{{"lead white",0.35},{"cobalt blue",1},{"Prussian blue",0.15},{"raw umber",0.55},{"rose madder",0.05}, name="crevD"}
npTop = mix{{cs1,0.55},{fgT2,0.3},{edgeG,0.15}, name="npTop"}
-- big near plate: back edge chipped, sloping down to the right; left end raised showing its thickness
npBack = {{330,632},{338,628},{352,629},{361,624},{378,623},{388,626},{402,621},{424,620},{436,623},{450,619},{474,620},{489,624},{503,622},{522,626},{536,625},{552,630},{566,633}}
local pts = {}
for _,p in ipairs(npBack) do pts[#pts+1] = p end
pts[#pts+1] = {578,660}; pts[#pts+1] = {590,716}; pts[#pts+1] = {318,716}; pts[#pts+1] = {322,670}
local top = poly(pts)
local endF = poly({{330,632},{322,670},{318,716},{301,716},{306,672},{316,638}})
local gn = noise{seed=5, period=40, stretch={-0.1, 6}}
work(top, {hand="detail", piles={{npTop,1},{fgT2, function(x,y) return math.max(0,gn(x,y))*0.7 end},{cs1, function(x,y) return clamp(1-(y-620)/30,0,1)*0.5 end},{fgB2, function(x,y) return clamp((y-670)/45,0,1)*0.5 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3.5}, angle=-0.06, seed=41})
blend(top:shrink(1), {angle=-0.06, seed=42})
work(endF, {hand="detail", piles={{edgeG,1},{sDeepG, function(x,y) return clamp((y-640)/60,0,1)+0.3 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.5, seed=43})
-- right end: falls under the snow (soft) -> a low drift line over it
-- strata on end face, broken
local rg = brush{kind="rigger", width=1, point=1}
for i,f in ipairs({0.22,0.41,0.6,0.83}) do
  local y0 = lerp(636, 716, f)
  rg:reload(sDeepG, 0.35)
  rg:stroke({{lerp(316,330,1-f)+0.5, y0-1},{lerp(306,322,1-f)+rand(2,6), y0+rand(1,3)}}, {pressure={0.2,0.06}, shake=0.2, clip=endF})
end
-- dark contact at the foot of the end face and under its top corner
rg:reload(crevD, 0.45)
rg:stroke({{316,638},{307,668},{302,700},{301,716}}, {pressure={0.3,0.35}, shake=0.2})
-- broken sky-lit rim on the back edge
local lb = brush{kind="round", width=1.4, point=0.7}
local runs = {{1,3},{5,7},{9,10},{12,14}}
for _,r in ipairs(runs) do
  local seg = {}
  for k=r[1], r[2] do seg[#seg+1] = {npBack[k][1], npBack[k][2]+0.9} end
  lb:reload(litCool, 0.4)
  lb:stroke(seg, {pressure={0.3,0.18}, shake=0.25})
end
-- crack across the top, in perspective (straight segments), dark wall + snow lodged on its near lip
local crack = {{452,621},{449,640},{452,652},{447,676},{450,697},{446,716}}
rg:reload(crevD, 0.45)
rg:stroke(crack, {pressure={0.22,0.4}, shake=0.1})
lb:reload(litCool, 0.35)
lb:stroke({{451.5,643},{453.5,652},{449,672}}, {pressure={0.25,0.15}, shake=0.2})

--@ chunk 4
litWarm = pile{{"lead white",6},{"Naples yellow",0.26},{"red earth",0.006}, name="litWarm"}
npDark = mix{{fgB2,0.5},{sDeepG,0.25},{fgT2,0.25}, name="npDark"}
wedgeL2 = pile{{"lead white",3},{"cobalt blue",0.35},{"smalt",0.1},{"Naples yellow",0.3},{"raw umber",0.1}, name="wedgeL2"}
local ox = 360
local back = {{330,630},{338,626},{352,627},{361,622},{378,621},{388,624},{402,619},{424,618},{436,621},{450,617},{474,618},{489,622},{503,620},{522,624},{536,623},{552,628},{566,631}}
for _,p in ipairs(back) do p[1] = p[1] + ox end
local pts = {}
for _,p in ipairs(back) do pts[#pts+1] = p end
pts[#pts+1] = {578+ox,660}; pts[#pts+1] = {590+ox,716}; pts[#pts+1] = {318+ox,716}; pts[#pts+1] = {322+ox,668}
local top = poly(pts)
-- lit thickness on the raised far-left edge: a band above the back edge, tapering right
local thick = {}
for i,p in ipairs(back) do local t = (i-1)/(#back-1); thick[#thick+1] = {p[1], p[2] - lerp(7, 0.5, t)} end
local tp = {}
for _,p in ipairs(thick) do tp[#tp+1] = p end
for i=#back,1,-1 do tp[#tp+1] = back[i] end
local thickM = poly(tp)
local endF = poly({{330+ox,630-7},{322+ox,668},{318+ox,716},{302+ox,716},{307+ox,670},{316+ox,632}})
local gn = noise{seed=7, period=35, stretch={-0.1, 5}}
work(top, {hand="detail", piles={{npDark,1},{fgT2, function(x,y) return clamp(1-(y-618)/40,0,1)*0.8 + math.max(0,gn(x,y))*0.4 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3.5}, angle=-0.06, seed=51})
blend(top:shrink(1), {angle=-0.06, seed=52})
work(thickM, {hand="detail", piles={{wedgeL2,1},{litWarm, function(x,y) return clamp(1-(x-ox-330)/120,0,1) end},{edgeG, function(x,y) return clamp((x-ox-420)/100,0,1) end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-0.05, seed=53})
work(endF, {hand="detail", piles={{edgeG,1},{sDeepG, function(x,y) return clamp((y-640)/60,0,1)+0.2 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.5, seed=54})
local rg = brush{kind="rigger", width=1, point=1}
rg:reload(crevD, 0.45)
rg:stroke({{316+ox,632},{307+ox,668},{302+ox,700},{301+ox,716}}, {pressure={0.3,0.35}, shake=0.2})
-- crack with snow lodged
local crack = {{452+ox,619},{449+ox,638},{452+ox,650},{447+ox,676},{450+ox,697},{446+ox,716}}
rg:reload(crevD, 0.45)
rg:stroke(crack, {pressure={0.22,0.4}, shake=0.1})
-- snow lodged in hollows of the top (small lighter patches)
local sn = brush{kind="round", width=3, point=0.5}
for _,p in ipairs({{380,640,8},{410,660,12},{470,646,6},{520,690,14},{545,655,7}}) do
  sn:reload(fgT2, 0.5); sn:touch(p[1]+ox, p[2], {pressure=0.5, drag={p[3], 0.5}})
end
