wait(60*24*2)
local tw4 = pile{{"lead white",2.2},{"smalt",2},{"raw umber",0.6},{"red earth",0.35},{"Prussian blue",0.06}, medium=0.06}
work(townM3, {hand="detail", pile=tw4, tool={kind="round", width=1.0, point=0.5}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, pressure={0.5,0.8}, seed=1211})
-- lit west faces, warm and faint
local lit = pile{{"lead white",4},{"smalt",1.2},{"red earth",0.35},{"yellow ochre",0.35},{"raw umber",0.3}, medium=0.06}
local faces = poly({{599.5,440},{599.5,362},{602.5,362},{602.5,440}}, true)
  + poly({{601.2,362},{601.6,354},{603.4,354},{603.4,362}}, true)
  + poly({{601.4,353},{604.7,324},{604.8,353}}, true)
  + poly({{540.4,440},{540.4,406},{543.2,406},{543.2,440}}, true)
  + poly({{540.6,405.5},{545.6,372},{545.7,405.5}}, true)
  + poly({{722.2,440},{722.2,387},{725.5,387},{725.5,440}}, true)
  + poly({{722.3,386},{728.4,375},{728.4,386}}, true)
work(faces, {hand="detail", pile=lit, tool={kind="round", width=0.9, point=0.5}, angle=math.pi/2, coverage=2.5, clip=true, pressure={0.4,0.7}, seed=1212})
-- belfry openings
local dk = pile{{"smalt",1.5},{"raw umber",1},{"lead white",0.6},{"bone black",0.1}, medium=0.05}
local op = poly({{602.3,370},{602.3,365.5},{603.3,365.5},{603.3,370}}, true) + poly({{606.2,370},{606.2,365.5},{607.2,365.5},{607.2,370}}, true)
  + poly({{727.5,395},{727.5,391},{729.5,391},{729.5,395}}, true)
  + poly({{544.8,414},{544.8,410.5},{546.4,410.5},{546.4,414}}, true)
work(op, {hand="detail", pile=dk, tool={kind="round", width=0.7, point=0.5}, angle=math.pi/2, coverage=3, clip=true, pressure={0.4,0.6}, seed=1213})
