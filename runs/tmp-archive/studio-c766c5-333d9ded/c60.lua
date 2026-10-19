tfree = tablemask - objall
plight_t = pile{{"yellow ochre",3},{"lead white",2.5},{"raw umber",0.4}}
pool = ellipse(300,600,330,155):soften(105) * tfree
work(pool, {hand="broad", pile=plight_t, clip=true, coverage=2.2, angle=0.05, seed=621})
-- far right darker
rdark = mask(function(x,y) return clamp((x-700)/300, 0, 1) end):soften(70) * tfree
work(rdark, {hand="broad", pile=pfront, clip=true, coverage=2.0, angle=0.05, seed=622})
-- clearer cast shadows
pS3 = pile{{"raw umber",1.8},{"bone black",1.2},{"smalt",1.1},{"lead white",0.35}, medium=0.1}
sh_bot = castshadow(300,616,640,662,58,16)
sh_bowl = castshadow(640,644,900,680,78,26)
sh_lem = castshadow(140,666,340,688,38,12)
sh_pear2 = castshadow(848,660,1000,678,44,16)
for i,m in ipairs{sh_bot, sh_bowl, sh_lem, sh_pear2} do
  work((m:soften(10)) * tfree, {hand="body", pile=pS3, clip=true, coverage=3.0, seed=630+i})
end
contact = ellipse(302,616,84,20):soften(9) + ellipse(640,644,112,22):soften(10)
        + ellipse(128,678,60,17):soften(8) + ellipse(852,660,58,17):soften(8)
work(contact * tfree, {hand="body", pile=pS3, clip=true, coverage=3.0, seed=641})
blend((sh_bot + sh_bowl + sh_lem + sh_pear2):soften(16) * tfree, {seed=642, coverage=1.4, pressure={0.3,0.3}})
