pshadow2 = pile{{"raw umber",2},{"bone black",0.8},{"smalt",1.2},{"lead white",0.5}, medium=0.15}
sh_bot = castshadow(310,614,650,662,50,16)
sh_bowl = castshadow(645,640,910,676,70,26)
sh_lem = castshadow(145,664,345,684,34,12)
sh_pear = castshadow(848,654,1000,672,40,16)
contact = ellipse(302,616,84,20):soften(9) + ellipse(640,644,112,22):soften(10)
        + ellipse(128,678,60,17):soften(8) + ellipse(848,658,58,17):soften(8)
for i,m in ipairs{sh_bot, sh_bowl, sh_lem, sh_pear} do
  work((m:soften(9)) * table_free, {hand="glaze", pile=pshadow2, clip=true, coverage=2.8, seed=300+i})
end
work(contact * table_free, {hand="body", pile=pshadow2, clip=true, coverage=2.6, seed=311})
