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
fgT2 = pile{{"lead white",1},{"cobalt blue",0.55},{"smalt",0.35},{"raw umber",0.24},{"Naples yellow",0.14},{"rose madder",0.05}, name="fgT2"}
fgB2 = pile{{"lead white",0.65},{"cobalt blue",0.42},{"smalt",0.3},{"raw umber",0.42},{"green earth",0.25},{"Naples yellow",0.14},{"red earth",0.04}, name="fgB2"}
wedgeL2 = pile{{"lead white",3},{"cobalt blue",0.35},{"smalt",0.1},{"Naples yellow",0.3},{"raw umber",0.1}, name="wedgeL2"}
mB = pile{{"lead white",0.70},{"cobalt blue",0.14},{"smalt",0.08},{"Naples yellow",0.06},{"rose madder",0.01}, name="mB"}
mA = pile{{"lead white",0.63},{"cobalt blue",0.19},{"smalt",0.13},{"Naples yellow",0.03},{"raw umber",0.03}, name="mA"}
slabG3 = pile{{"lead white",0.6},{"cobalt blue",0.35},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.35},{"yellow ochre",0.08},{"Prussian blue",0.02}, name="slabG3"}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
-- substrate: band left, wedge stripe, slab right, plain above; three test fields
for i=0,2 do
  local x0 = 100 + i*280
  work(rect(x0,250,90,300), {hand="detail", pile=fgT2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=1.3})
  work(poly{{x0+90,250},{x0+110,250},{x0+130,550},{x0+90,550}}, {hand="detail", piles={{wedgeL2,1},{mB,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=1.4})
  work(poly{{x0+110,250},{x0+200,250},{x0+200,550},{x0+130,550}}, {hand="detail", pile=slabG3, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=1.4})
  work(rect(x0,180,200,70), {hand="detail", pile=pl2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=0})
  -- bites
  for j=1,4 do local y=280+j*60; work(poly{{x0+88,y},{x0+97,y+4},{x0+96,y+12},{x0+88,y+14}}, {hand="detail", pile=fgT2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}}) end
end
print(wait(8*24*60))

--@ chunk 3
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
slabCool = pile{{"lead white",0.9},{"cobalt blue",0.5},{"smalt",0.25},{"green earth",0.35},{"raw umber",0.25},{"rose madder",0.03}, name="slabCool"}
local function wedgeAt(x0) return poly{{x0+87,250},{x0+110,250},{x0+130,550},{x0+87,550}} end
for i=0,2 do
  local x0 = 100 + i*280
  local W = wedgeAt(x0)
  local cutY = function(x) return 300 + (x-(x0+87))*0.5 end
  local lit = W * above(function(x) return cutY(x) end)
  local sh = W * below(function(x) return cutY(x) end)
  work(lit, {hand="detail", piles={{wedgeL2,0.5},{mB,0.3},{mA,0.2}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=1.5, seed=11+i})
  local t = function(x,y) return clamp((y-300)/250,0,1) end
  local piles
  if i==2 then
    piles = {{fgT2, 0.5},{edgeG, function(x,y) return 0.45*(1-t(x,y)) + 0.1 end},{slabCool, function(x,y) return 0.35*t(x,y) end},{fgB2, function(x,y) return 0.3*t(x,y) end}}
  else
    piles = {{fgT2, 0.55},{edgeG, function(x,y) return 0.45*(1-t(x,y)) + 0.05 end},{slabCool, function(x,y) return 0.3*t(x,y) end},{fgB2, function(x,y) return 0.2*t(x,y) end}}
  end
  work(sh, {hand="detail", piles=piles, clip=true, coverage=3.5, fill=true, tool={kind="filbert", width=3}, angle=1.5, seed=21+i})
  if i==0 then blend(W, {angle=1.5}) end
end

--@ chunk 4
for i=0,1 do
  local x0 = 100 + i*280
  local y0 = 600
  work(rect(x0,y0,90,300), {hand="detail", pile=fgT2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=1.3})
  work(poly{{x0+90,y0},{x0+110,y0},{x0+130,y0+100},{x0+90,y0+100}}, {hand="detail", piles={{wedgeL2,1},{mB,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=1.4})
  work(poly{{x0+110,y0},{x0+200,y0},{x0+200,y0+100},{x0+130,y0+100}}, {hand="detail", pile=slabG3, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=1.4})
end
print(wait(8*24*60))

--@ chunk 5
for i=0,1 do
  local x0 = 100 + i*280
  local y0 = 600
  local W = poly{{x0+87,y0},{x0+110,y0},{x0+130,y0+100},{x0+87,y0+100}}
  local cutY = function(x) return y0+25 + (x-(x0+87))*0.45 end
  local lit = W * above(cutY)
  local sh = W * below(cutY)
  work(lit, {hand="detail", piles={{wedgeL2,0.5},{mB,0.3},{mA,0.2}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=1.5, seed=31+i})
  local t = function(x,y) return clamp((y-y0-25)/75,0,1) end
  local piles
  if i==0 then
    piles = {{fgT2, 0.4},{edgeG, function(x,y) return 0.35*(1-t(x,y)) + 0.05 end},{slabG3, function(x,y) return 0.15 + 0.15*t(x,y) end},{slabCool, function(x,y) return 0.25*t(x,y) end}}
  else
    piles = {{fgT2, 0.35},{edgeG, function(x,y) return 0.3*(1-t(x,y)) + 0.1 end},{slabCool, function(x,y) return 0.25 + 0.15*t(x,y) end},{fgB2, function(x,y) return 0.2*t(x,y) end}}
  end
  work(sh, {hand="detail", piles=piles, clip=true, coverage=3.5, fill=true, tool={kind="filbert", width=3}, angle=1.5, seed=41+i})
  -- one large bite into the lit part, band colour
  work(poly{{x0+86,y0+8},{x0+95,y0+11},{x0+97,y0+19},{x0+86,y0+22}}, {hand="detail", pile=fgT2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, seed=51+i})
end

--@ chunk 6
litWarm = pile{{"lead white",0.96},{"Naples yellow",0.04}, name="litWarm"}
work(rect(650,600,80,40), {hand="detail", pile=litWarm, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}})
wait(6*24*60)
k45 = pile{{"lead white",8},{"Naples yellow",0.42},{"cobalt blue",0.07},{"rose madder",0.04}, name="k45"}
k45b = pile{{"lead white",8},{"Naples yellow",0.45},{"cobalt blue",0.12},{"rose madder",0.05},{"raw umber",0.02}, name="k45b"}
work(rect(655,605,30,30), {hand="detail", pile=k45, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}})
work(rect(690,605,30,30), {hand="detail", pile=k45b, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}})
