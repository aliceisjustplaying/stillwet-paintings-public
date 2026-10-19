townp = pile{{"lead white", 4}, {"pale smalt", 2}, {"smalt", 0.5}, {"red earth", 0.3}, {"raw umber", 0.45}, medium=0.1}
-- houses and roofs, a jagged row of gables
local hp = {{228,440},{228,426},{234,420},{240,426},{246,426},{246,422},{252,416},{258,422},{262,422}, {262,390},{272,390},{272,420},{280,420},{286,414},{292,420},{300,420},{300,418},{306,412},{312,418},{322,418},
  {322,378},{331,378},{331,410},{345,396},{420,396},{420,372},{446,372},{446,402},{452,398},{500,398},{508,410},{516,410},{522,404},{528,410},{540,412},{546,407},{552,412},{566,414},{575,418},{582,422},{590,440}}
town = poly(hp)
-- spires and caps
spJ = poly({{261.5,391},{267,351},{272.5,391}})
spN1 = poly({{323.5,379},{323.5,366},{329.5,366},{329.5,379}})
spN2 = poly({{323,367},{326.5,316},{330,367}})
capM = poly({{418,373},{433,356},{448,373}})
town_all = town + spJ + spN1 + spN2 + capM
work(town_all, {hand="detail", pile=townp, angle=math.pi/2, coverage=2.5, length={4,10}, pressure={0.5,0.8}, fill=true, edge="found", clip=true})
-- windmill
mill_body = poly({{729,436},{731.5,406},{742.5,406},{745,436}})
mill_cap = poly({{728,407},{730,401},{737,398},{744,401},{746,407}})
work(mill_body + mill_cap, {hand="detail", pile=townp, angle=math.pi/2, coverage=2.5, length={3,8}, fill=true, edge="found", clip=true})
print(wait(0))
