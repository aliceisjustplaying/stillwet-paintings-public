ptabBase = pile{{"yellow ochre",2.5},{"lead white",1.6},{"raw umber",1}}
ptabDark2 = pile{{"raw umber",2.5},{"smalt",1},{"lead white",0.8}}
ptabLight = pile{{"yellow ochre",2.5},{"lead white",2},{"raw umber",0.7}}
tfree = tablemask - objall
work(tfree, {hand="broad", pile=ptabBase, clip=true, coverage=3.4, angle=0.06, fill=true, dips={3,0.85}, seed=411})
tdark2 = mask(function(x,y)
  local a = clamp((x-700)/340,0,1)
  local b = clamp((y-620)/200,0,1)
  return clamp(a*0.9 + b*0.9, 0, 1)
end):soften(60) * tfree
work(tdark2, {hand="broad", pile=ptabDark2, clip=true, coverage=2.0, angle=0.06, seed=412})
tlight2 = ellipse(400,545,430,150):soften(120) * tfree
work(tlight2, {hand="broad", pile=ptabLight, clip=true, coverage=1.7, angle=0.06, seed=413})
sh_bot = castshadow(310,614,650,662,50,16)
sh_bowl = castshadow(645,640,910,676,70,26)
sh_lem = castshadow(145,664,345,684,34,12)
sh_pear2 = castshadow(848,656,1000,674,40,16)
for i,m in ipairs{sh_bot, sh_bowl, sh_lem, sh_pear2} do
  work((m:soften(9)) * tfree, {hand="glaze", pile=pshadow2, clip=true, coverage=2.6, seed=420+i})
end
contact = ellipse(302,616,84,20):soften(9) + ellipse(640,644,112,22):soften(10)
        + ellipse(128,678,60,17):soften(8) + ellipse(852,660,58,17):soften(8)
work(contact * tfree, {hand="body", pile=pshadow2, clip=true, coverage=2.6, seed=431})
