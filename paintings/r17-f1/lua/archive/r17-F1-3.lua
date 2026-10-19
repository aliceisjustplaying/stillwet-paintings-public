-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=700, aspect=1.4, linen={15,13}, seed=1822,
 ground={{pile={{"red earth",2},{"yellow ochre",3},{"lead white",1}}, um=80, apply="knife", texture=0.35},
         {pile={{"lead white",10},{"yellow ochre",0.4},{"raw umber",0.15}}, um=45, apply="roller"}}}
print(W,H)

--@ chunk 2
HZ = 445
h = pencil("2H")
-- horizon
h:line({{0,446},{200,444},{400,445},{700,446},{1000,445}}, {pressure=0.3})
-- town: St Jacobi (slender spire)
h:line({{388,445},{388,392},{402,392},{402,445}}, {pressure=0.35, smooth=false})
h:line({{386,392},{395,352},{404,392}}, {pressure=0.35, smooth=false})
-- St Nikolai (tall, stepped lantern)
h:line({{460,445},{460,378},{482,378},{482,445}}, {pressure=0.35, smooth=false})
h:line({{463,378},{465,362},{471,352},{477,362},{479,378}}, {pressure=0.35, smooth=false})
h:line({{471,352},{471,330}}, {pressure=0.3})
-- St Marien (massive, low cap)
h:line({{548,445},{548,395},{578,395},{578,445}}, {pressure=0.35, smooth=false})
h:line({{546,395},{563,378},{580,395}}, {pressure=0.35, smooth=false})
-- roofs
h:line({{350,445},{352,432},{375,428},{388,430}}, {pressure=0.3})
h:line({{402,428},{430,422},{460,425}}, {pressure=0.3})
h:line({{482,425},{510,420},{530,418},{548,424}}, {pressure=0.3})
h:line({{578,424},{600,428},{625,433},{650,440},{660,445}}, {pressure=0.3})
-- windmills
h:line({{712,445},{712,425}}, {pressure=0.3}); h:line({{700,410},{724,440}}, {pressure=0.3}); h:line({{724,410},{700,440}}, {pressure=0.3})
h:line({{795,445},{795,428}}, {pressure=0.3}); h:line({{784,414},{806,442}}, {pressure=0.3}); h:line({{806,414},{784,442}}, {pressure=0.3})
-- water strip
h:line({{0,458},{150,456},{330,460},{420,463}}, {pressure=0.25})
h:line({{0,470},{160,468},{300,470},{420,463}}, {pressure=0.25})
-- willows along ditch (left)
for _,t in ipairs({{110,575,95},{178,552,80},{236,535,64},{286,522,50}}) do
  local x,y,s = t[1],t[2],t[3]
  h:line({{x-6*s/80,y},{x-5*s/80,y-s*0.55}}, {pressure=0.35})
  h:line({{x+6*s/80,y},{x+5*s/80,y-s*0.55}}, {pressure=0.35})
  h:sketch({{x-s*0.45,y-s*0.6},{x-s*0.5,y-s*1.05},{x,y-s*1.3},{x+s*0.5,y-s*1.05},{x+s*0.45,y-s*0.6}}, {pressure=0.25})
end
-- ditch line
h:line({{60,600},{150,568},{250,540},{340,520},{420,505}}, {pressure=0.25})
-- haycocks
for _,t in ipairs({{330,503,9},{372,508,8},{612,497,8},{655,505,10},{560,515,11}}) do
  h:line({{t[1]-t[3],t[2]},{t[1]-t[3]*0.6,t[2]-t[3]*1.1},{t[1],t[2]-t[3]*1.4},{t[1]+t[3]*0.6,t[2]-t[3]*1.1},{t[1]+t[3],t[2]}}, {pressure=0.3})
end
-- path
h:line({{360,714},{420,660},{470,625},{520,600},{560,585}}, {pressure=0.3})
h:line({{520,714},{540,660},{560,625},{580,595},{590,585}}, {pressure=0.3})
-- figures
h:line({{503,610},{505,572},{511,562}}, {pressure=0.35})
h:line({{518,610},{517,572},{511,562}}, {pressure=0.35})
h:line({{531,612},{527,585},{534,570},{541,585},{544,612}}, {pressure=0.35})

--@ chunk 3
erase(everywhere(), {strength=1})

