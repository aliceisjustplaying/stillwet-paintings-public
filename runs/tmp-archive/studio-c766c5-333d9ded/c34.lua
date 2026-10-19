pshadow = pile{{"raw umber",2.5},{"smalt",1.5},{"bone black",0.5},{"lead white",0.9}, medium=0.25}
sh_bot = castshadow(310,614,650,662,54,18)
sh_bowl = castshadow(645,640,910,676,74,30)
sh_lem = castshadow(145,664,345,684,36,14)
sh_pear = castshadow(848,654,1000,672,42,18)
for i,m in ipairs{sh_bot, sh_bowl, sh_lem, sh_pear} do
  work((m:soften(7)) * table_free, {hand="glaze", pile=pshadow, clip=true, coverage=2.2, seed=280+i})
end
