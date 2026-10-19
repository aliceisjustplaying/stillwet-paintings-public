ptabMid = pile{{"yellow ochre",2.5},{"raw umber",2},{"lead white",1.2},{"red earth",0.4}}
tfree = tablemask - objall
work(tfree, {hand="broad", pile=ptabMid, clip=true, coverage=3.4, angle=0.06, fill=true, dips={3,0.85}, seed=441})
tlight3 = ellipse(420,560,380,140):soften(110) * tfree
work(tlight3, {hand="broad", pile=ptabLight, clip=true, coverage=1.8, angle=0.06, seed=442})
work(tdark2, {hand="broad", pile=ptabDark2, clip=true, coverage=2.2, angle=0.06, seed=443})
pshadow3 = pile{{"raw umber",2},{"bone black",1.1},{"smalt",1.2},{"lead white",0.4}, medium=0.1}
sh_bot = castshadow(300,616,620,660,52,18)
sh_bowl = castshadow(640,644,880,678,72,28)
sh_lem = castshadow(140,666,330,686,36,14)
sh_pear2 = castshadow(848,658,990,676,42,18)
for i,m in ipairs{sh_bot, sh_bowl, sh_lem, sh_pear2} do
  work((m:soften(8)) * tfree, {hand="glaze", pile=pshadow3, clip=true, coverage=3.0, seed=450+i})
end
contact = ellipse(302,616,84,20):soften(9) + ellipse(640,644,112,22):soften(10)
        + ellipse(128,678,60,17):soften(8) + ellipse(852,660,58,17):soften(8)
work(contact * tfree, {hand="body", pile=pshadow3, clip=true, coverage=2.8, seed=461})
