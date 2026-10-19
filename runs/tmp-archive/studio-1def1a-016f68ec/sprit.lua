print(wait(30*60)); print(drying(340,300))
glowThin = pile{{"red earth",0.5},{"vermilion",0.35},{"chrome yellow",0.4},{"lead white",0.35}, medium=0.3}
local r = brush{kind="rigger", width=2.4, point=1}
r:reload(lineP, 0.8)
r:stroke({{306,430},{328,345},{350,262},{372,186}}, {pressure={0.65,0.4}, ramps={0.05,0.15}})
-- a thin light along the leech, backlit
local g = brush{kind="round", width=3, point=0.8}
g:reload(glowThin, 0.35)
g:stroke({{372,192},{378,260},{384,340},{389,430}}, {pressure={0.35,0.15}, ramps={0.05,0.5}, clip=mainsail:mask()})
g:reload(glowThin, 0.3)
g:stroke({{305,150},{330,172},{360,190}}, {pressure={0.3,0.15}, ramps={0.05,0.4}, clip=topsail:mask()})
