-- darker hull reflection right under the hull
local hr2 = outline{{226,462,"c"},{320,466},{410,461,"c"},{400,470},{320,474},{240,470}, closed=true, char="soft", amount=0.4, seed=151}:mask()
work(hr2, {hand="hatch", pile=reflHull, angle=0, length={8,24}, coverage=2.5, pressure={0.5,0.8}})
-- dull the puddles: thin glaze of mud over them
puddleGlaze = pile{{"raw umber",1},{"smalt",0.3},{"red earth",0.2}, medium=0.55}
local pz = ellipse(76,606,45,8) + ellipse(172,625,52,8) + ellipse(52,641,50,8)
work(pz*spit3, {hand="glaze", tool="filbert 8", pile=puddleGlaze, angle=0.05, coverage=1.3, clip=spit3})
-- light ripple breaks across the reflection
local b = brush("filbert", 3)
local rl = {{250,488,120},{280,503,90},{230,519,100},{300,534,80},{260,551,110},{315,566,70},{275,583,90},{330,598,60}}
for _, s in ipairs(rl) do
  b:reload(Wb2, 0.35)
  b:stroke({{s[1],s[2]},{s[1]+s[3]*0.5,s[2]+0.5},{s[1]+s[3],s[2]}}, {pressure={0.3,0.1}, ramps={0.2,0.4}, clip=rect(0,470,1000,200)-spit3:grow(2)})
end
