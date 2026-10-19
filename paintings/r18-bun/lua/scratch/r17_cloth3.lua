p_gz   = pile{{"raw umber", 3}, {"bone black", 1.6}, {"Prussian blue", 0.4}, medium=0.35}
p_clm2 = pile{{"lead white", 4.5}, {"raw umber", 2.0}, {"yellow ochre", 0.9}, {"cobalt blue", 0.3}}
tline = function(x) return 468 - 0.04*x end
tbl = below(tline):soften(8)
cloth_r = cloth:roughen(9, 70, 12)

-- bury the hairy fringe of strokes that ran past the cloth onto the table
work(tbl * -cloth_r, {pile=p_tbl, hand="broad", coverage=2.5, fill=true, load=1.0,
      pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=0.2, clip=true})
-- a warm dark glaze to sink the whole cloth a step and unify it
work(cloth_r, {hand="glaze", pile=p_gz, coverage=1.2, angle=0.5, clip=true})
print("glazed", wait(0))
