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
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}}
sC2 = pile{{"lead white",1.6},{"cobalt blue",0.8},{"smalt",0.5},{"Naples yellow",0.15},{"rose madder",0.08},{"raw umber",0.1}}
sG = pile{{"lead white",1},{"cobalt blue",0.7},{"Prussian blue",0.06},{"green earth",0.3},{"raw umber",0.15}}
local C = {{100,190},{145,150},{188,212},{215,215},{240,270},{300,395},{240,440},{130,420}}
work(poly(C), {hand="body", piles={{sC1,1},{sC2,1},{sG,0.5}}, clip=true, coverage=2, fill=true, angle=1.0})
wait(8*24*60)
local gn = noise{seed=7, period=70, stretch={1.0, 5}}
local C2 = {} for i,p in ipairs(C) do C2[i] = {p[1]+300, p[2]} end
local C3 = {} for i,p in ipairs(C) do C3[i] = {p[1]+600, p[2]} end
-- A: repaint longer strokes along fall line + blend
local function piles(ox) return {{sC1, function(x,y) return clamp(1-(y-150)/290,0,1)*0.9+0.1 end},{sC2, function(x,y) return clamp((y-150)/290,0,1)*0.9 end},{sG, function(x,y) return math.max(0, gn(x-ox,y))*0.8 end}} end
work(poly(C2), {hand="body", piles=piles(300), clip=true, coverage=2, fill=true, angle=1.0, length={40,90}, tool="filbert 6"})
blend(poly(C2), {angle=1.0})
-- B: same with broad hand
work(poly(C3), {hand="broad", piles=piles(600), clip=true, coverage=2, fill=true, angle=1.0, tool="filbert 10"})
blend(poly(C3), {angle=1.0})

--@ chunk 3
local gn = noise{seed=7, period=70, stretch={1.0, 5}}
local C = {{100,190},{145,150},{188,212},{215,215},{240,270},{300,395},{240,440},{130,420}}
local half = poly(C) * rect(0,0,180,714)
work(half, {hand="broad", piles={{sC1, function(x,y) return clamp(1-(y-150)/290,0,1)*0.9+0.1 end},{sC2, function(x,y) return clamp((y-150)/290,0,1)*0.9 end},{sG, function(x,y) return math.max(0, gn(x,y))*0.8 end}}, clip=true, coverage=2, fill=true, angle=1.0, tool="filbert 10"})
blend(half, {angle=1.0})
