p_tbl  = pile{{"raw umber", 4.5}, {"red earth", 1.8}, {"yellow ochre", 1.0}, {"bone black", 1.0}}
p_tbll = pile{{"raw umber", 4}, {"red earth", 1.6}, {"yellow ochre", 1.5}, {"lead white", 0.5}, {"bone black", 0.4}}
p_corner = pile{{"bone black", 2.4}, {"raw umber", 2}, {"Prussian blue", 0.6}}

tline = function(x) return 468 - 0.04*x end
tbl = below(tline):soften(8)
work(tbl, {pile=p_tbl, hand="broad", coverage=3.2, fill=true, load=1.0,
           pressure={1.0,0.85}, dips={3,1.0,0.05}, angle=0.2})
work(tbl * ellipse(250, 560, 470, 230):soften(160), {pile=p_tbll, hand="broad", coverage=2.4,
     fill=true, load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}, angle=0.2})

-- the corner where the wall meets the table: a soft dark band, a shade under it
work(below(tline) * below(function(x) return tline(x) + 34 end):soften(26), {pile=p_corner,
     hand="broad", coverage=2.4, fill=true, load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})
corner_line = ribbon({{-10, 470}, {250, 462}, {500, 452}, {760, 441}, {1010, 430}}, 5)
work(corner_line, {pile=p_corner, hand="detail", coverage=1.6, fill=true, pressure=0.9, clip=true})
print("table", wait(0))
