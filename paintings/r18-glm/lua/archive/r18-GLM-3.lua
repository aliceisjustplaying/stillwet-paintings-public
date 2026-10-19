-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
-- Canvas: 40x32 cm, medium-fine linen, warm grey-green oil ground
canvas{size=400, aspect=0.8, linen={16, 12}, seed=11,
  ground={
    {pile={{"lead white", 1}, {"raw umber", 0.18}, {"green earth", 0.1}}, um=95, apply="knife", texture=0.55},
    {pile={{"lead white", 1}, {"raw umber", 0.08}, {"green earth", 0.05}}, um=25, apply="brush"},
  }}
print("grooves set")

--@ chunk 2
-- Palette
sunset   = pile{{"vermilion", 1}, {"chrome yellow", 0.55}, {"lead white", 0.7}}                 -- vermilion & yellow pass to lead
gold     = pile{{"chrome yellow", 1}, {"vermilion", 0.22}, {"lead white", 0.9}}                -- gold & one part of its red to lead
peach    = pile{{"lead white", 2.2}, {"vermilion", 0.55}, {"chrome yellow", 0.3}}              -- lead & two parts red, one yellow
rosepink = pile{{"lead white", 2.2}, {"vermilion", 0.65}}
ice      = pile{{"lead white", 2.0}, {"smalt", 0.75}}
warmpale = pile{{"lead white", 2.0}, {"yellow ochre", 0.32}}
landblue = pile{{"cobalt blue", 1}, {"raw umber", 0.5}, {"lead white", 0.65}}                   -- cobalt & half its umber to lead
shoregrey= pile{{"lead white", 1}, {"yellow ochre", 0.2}, {"bone black", 0.16}}
flesh    = pile{{"lead white", 1.6}, {"vermilion", 0.45}, {"yellow ochre", 0.12}}
mistpink = pile{{"lead white", 1.5}, {"vermilion", 0.3}, {"chrome yellow", 0.18}}
skytop   = pile{{"cobalt blue", 1}, {"raw umber", 0.2}, {"lead white", 0.35}}                   -- cobalt & a fifth of umber to lead
print("piles mixed: 12")

--@ chunk 3
-- Sketch: horizon, headland, spit, boat, path of light, birds
h = pencil("HB")
h:rule({30, 515}, {970, 515}, {pressure=0.28})
h:sketch({{30, 446}, {240, 452}, {460, 452}, {700, 440}, {970, 438}}, {pressure=0.3})
h:sketch({{620, 512}, {700, 516}, {800, 528}, {820, 540}}, {pressure=0.26})
h:sketch({{548, 210}, {600, 166}, {620, 128}, {626, 92}, {612, 48}, {586, 30}}, {pressure=0.3})
h:sketch({{520, 176}, {586, 174}, {640, 190}, {668, 232}, {690, 300}, {700, 372}}, {pressure=0.3})
h:sketch({{660, 436}, {690, 444}, {718, 470}, {724, 500}}, {pressure=0.22})
h:sketch({{150, 660}, {176, 656}, {194, 644}}, {pressure=0.2})
h:sketch({{760, 262}, {772, 256}, {788, 252}}, {pressure=0.2})
print("sketched")

