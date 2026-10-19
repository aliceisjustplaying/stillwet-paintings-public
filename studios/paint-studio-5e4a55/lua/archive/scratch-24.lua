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
waterdark = pile{{"raw umber",2},{"Prussian blue",.5},{"red earth",.7},{"green earth",.4}, name="waterdark"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",.3},{"smalt",.6}, name="haze"}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
rock = pile{{"raw umber",2},{"Prussian blue",.6},{"bone black",.5},{"red earth",.5}, name="rock"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lent"}
-- substrate: dark rock field top, water-ish field bottom
work(rect(80,80,700,160), {hand="body", tool="flat 10", piles={{rock,1},{lent,.4},{waterdark,.4}}, angle=math.pi/2, coverage=3, fill=true, clip=true})
mA = mix{{waterdark,.8},{haze,.14},{amber,.06}, name="mA"}
work(rect(80,240,700,160), {hand="body", tool="flat 10", pile=mA, angle=0, coverage=3, fill=true, clip=true})
print(wait(60*24*60))

--@ chunk 3
m1 = mix{{waterdark,.9},{haze,.07},{amber,.03}, name="m1"}
m2 = mix{{waterdark,.86},{haze,.10},{amber,.04}, name="m2"}
m3 = mix{{waterdark,.83},{haze,.12},{amber,.05}, name="m3"}
local ps = {m1,m2,m3}
for i,p in ipairs(ps) do
  local x0 = 100 + (i-1)*200
  work(rect(x0,100,120,280), {hand="body", tool="flat 8", pile=p, angle=0, coverage=3, fill=true, clip=true})
end
print(wait(60*24*60))

--@ chunk 4
m4 = mix{{waterdark,.9},{haze,.05},{amber,.05}, name="m4"}
m5 = mix{{waterdark,.91},{haze,.03},{amber,.06}, name="m5"}
work(rect(100,450,120,200), {hand="body", tool="flat 8", pile=m4, angle=0, coverage=3, fill=true, clip=true})
work(rect(300,450,120,200), {hand="body", tool="flat 8", pile=m5, angle=0, coverage=3, fill=true, clip=true})
print(wait(60*24*60))

--@ chunk 5
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
palette{scrape={m1,m2,m3}}
m6 = mix{{waterdark,.84},{deeprust,.08},{haze,.04},{amber,.04}, name="m6"}
m7 = mix{{waterdark,.8},{deeprust,.12},{haze,.05},{amber,.03}, name="m7"}
work(rect(500,450,120,200), {hand="body", tool="flat 8", pile=m6, angle=0, coverage=3, fill=true, clip=true})
work(rect(700,450,120,200), {hand="body", tool="flat 8", pile=m7, angle=0, coverage=3, fill=true, clip=true})
print(wait(60*24*60))

--@ chunk 6
palette{scrape={m4,m5}}
m8 = mix{{waterdark,.87},{deeprust,.09},{haze,.02},{amber,.02}, name="m8"}
work(rect(100,700,120,200), {hand="body", tool="flat 8", pile=m8, angle=0, coverage=3, fill=true, clip=true})
print(wait(60*24*60))

--@ chunk 7
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",.8},{"Prussian blue",.1}, name="mossdeep"}
palette{scrape={m6,m7,m8,mA}}
local bg = mix{{deeprust,.6},{amber,.25},{haze,.15}, name="bg"}
work(rect(50,950,900,250), {hand="body", tool="flat 10", pile=bg, angle=0, coverage=3, fill=true, clip=true})
print(wait(60*24*60))

--@ chunk 8
print(palette())
tA = mix{{mossdeep,.55},{haze,.3},{amber,.15}, name="tA"}
tB = mix{{mossdeep,.35},{deeprust,.2},{haze,.25},{amber,.2}, name="tB"}
tC = mix{{rock,.5},{waterdark,.3},{deeprust,.2}, name="tC"}
local ps = {tA,tB,tC}
for i,p in ipairs(ps) do
  work(rect(80+(i-1)*150,980,110,190), {hand="body", tool="flat 8", pile=p, angle=0, coverage=3, fill=true, clip=true})
end
print(wait(60*24*60))

--@ chunk 9
palette{scrape={tA,tB,tC}}
tA2 = mix{{mossdeep,.72},{rock,.16},{amber,.12}, name="tA2"}
tB2 = mix{{mossdeep,.45},{deeprust,.2},{rock,.25},{amber,.1}, name="tB2"}
tC2 = mix{{rock,.5},{waterdark,.3},{deeprust,.1},{lent,.1}, name="tC2"}
local ps = {tA2,tB2,tC2}
for i,p in ipairs(ps) do
  work(rect(530+(i-1)*140,980,110,190), {hand="body", tool="flat 8", pile=p, angle=0, coverage=3, fill=true, clip=true})
end
print(wait(60*24*60))

--@ chunk 10
gD2 = pile{{"raw umber",1},{"smalt",.8},{"lead white",.3},{"red earth",.2}, medium=.82, name="gD2"}
work(rect(600,1180,120,40):roughen(3,20,7), {hand="glaze", pile=gD2, coverage=1})
print(wait(30*24*60))

--@ chunk 11
work(rect(100,953,400,24), {hand="glaze", pile=gD2, coverage=1})
print(wait(30*24*60))

--@ chunk 12
palette{scrape={tA2,tB2,tC2,bg}}
foamsh = pile{{"lead white",8},{"cobalt blue",.8},{"raw umber",.9},{"yellow ochre",.3}, name="foamsh"}
p1 = mix{{waterdark,.55},{haze,.35},{amber,.10}, name="p1"}
p2 = mix{{waterdark,.5},{haze,.4},{amber,.10}, name="p2"}
p3 = mix{{waterdark,.6},{haze,.3},{amber,.07},{deeprust,.03}, name="p3"}
local ps={p1,p2,p3}
for i,p in ipairs(ps) do
  work(rect(80+(i-1)*150,1060,110,40), {hand="body", tool="flat 4", pile=p, angle=math.pi/2, coverage=3, fill=true, clip=true})
end
print(wait(60*24*60))

--@ chunk 13
palette{scrape={p1,p2}}
q1 = mix{{waterdark,.68},{haze,.23},{amber,.09}, name="q1"}
q2 = mix{{waterdark,.72},{haze,.20},{amber,.08}, name="q2"}
work(rect(530,1060,110,40), {hand="body", tool="flat 4", pile=q1, angle=math.pi/2, coverage=3, fill=true, clip=true})
work(rect(680,1060,110,40), {hand="body", tool="flat 4", pile=q2, angle=math.pi/2, coverage=3, fill=true, clip=true})
print(wait(60*24*60))
