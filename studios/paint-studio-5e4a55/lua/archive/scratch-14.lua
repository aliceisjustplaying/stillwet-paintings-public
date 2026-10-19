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
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
waterdark = pile{{"raw umber",2},{"Prussian blue",0.5},{"red earth",0.7},{"green earth",0.4}, name="waterdark"}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, name="foamsh"}
local tries = {
  {mix{{waterdark,0.5},{amber,0.2},{haze,0.3}}},
  {mix{{waterdark,0.45},{amber,0.25},{haze,0.3}}},
  {mix{{waterdark,0.4},{amber,0.2},{haze,0.4}}},
  {mix{{haze,0.6},{amber,0.15},{waterdark,0.25}}},
  {mix{{haze,0.7},{amber,0.15},{waterdark,0.15}}},
  {mix{{haze,0.55},{foamsh,0.2},{amber,0.1},{waterdark,0.15}}},
}
for i, t in ipairs(tries) do
  work(rect(20 + (i-1)*160, 50, 140, 140), {hand="body", pile=t[1], coverage=4, fill=true, clip=true})
end
for i = 1, 6 do print(i) end

--@ chunk 3
local a = mix{{waterdark,0.7},{amber,0.15},{haze,0.15}}
local b = mix{{waterdark,0.65},{amber,0.2},{haze,0.15}}
local c = mix{{haze,0.55},{amber,0.12},{waterdark,0.3},{foamsh,0.03}}
work(rect(20, 250, 140, 140), {hand="body", pile=a, coverage=4, fill=true, clip=true})
work(rect(180, 250, 140, 140), {hand="body", pile=b, coverage=4, fill=true, clip=true})
work(rect(340, 250, 140, 140), {hand="body", pile=c, coverage=4, fill=true, clip=true})
