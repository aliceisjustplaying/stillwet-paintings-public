tfree = tablemask - objall
ptabBase2 = pile{{"yellow ochre",2.5},{"raw umber",1.6},{"lead white",1.3},{"red earth",0.3}}
work(tfree, {hand="broad", pile=ptabBase2, clip=true, coverage=3.4, angle=0.05, fill=true, dips={3,0.85}, seed=721})
plight_t = pile{{"yellow ochre",3},{"lead white",2.5},{"raw umber",0.4}}
pool = ellipse(300,600,330,155):soften(105) * tfree
work(pool, {hand="broad", pile=plight_t, clip=true, coverage=2.2, angle=0.05, seed=722})
rdark = mask(function(x,y) return clamp((x-700)/300,0,1) end):soften(70) * tfree
work(rdark, {hand="broad", pile=pfront, clip=true, coverage=2.0, angle=0.05, seed=723})
bottom = mask(function(x,y) return clamp((y-690)/115,0,1) end):soften(55) * tfree
work(bottom, {hand="broad", pile=pfront, clip=true, coverage=2.4, angle=0.03, seed=724})
pS3 = pile{{"raw umber",1.8},{"bone black",1.2},{"smalt",1.1},{"lead white",0.35}, medium=0.1}
for i,m in ipairs{sh_bot,sh_bowl,sh_lem,sh_pear2} do
  work((m:soften(10))*tfree, {hand="body", pile=pS3, clip=true, coverage=3.0, seed=730+i})
end
work(contact*tfree, {hand="body", pile=pS3, clip=true, coverage=3.0, seed=741})
blend((sh_bot+sh_bowl+sh_lem+sh_pear2):soften(16)*tfree, {seed=742, coverage=1.4, pressure={0.3,0.3}})
pjl = pile{{"raw umber",2},{"smalt",1.2},{"bone black",0.4}, medium=0.4}
pjh = pile{{"lead white",2},{"yellow ochre",1.2},{"raw umber",0.5}}
bj = brush{kind="round", width=7, point=0.3, stiffness=0.5}
bj:load(pjl, 0.5)
bj:stroke({{0,446},{120,448},{250,451},{380,453},{500,455},{620,458},{740,461},{860,464},{1000,468}}, {pressure={0.4,0.35}, ramps={0.05,0.1}})
bj:wipe(0.55); bj:load(pjh, 0.45)
bj:stroke({{0,451},{120,453},{250,456},{380,458},{500,460},{620,463},{740,466},{860,469},{1000,473}}, {pressure={0.35,0.3}, ramps={0.05,0.1}})
