p_corner = pile{{"bone black", 2.4}, {"raw umber", 2}, {"Prussian blue", 0.6}}
tline = function(x) return 468 - 0.04*x end
tbl = below(tline):soften(8)
work(tbl, {pile=p_tbl, hand="broad", coverage=2.6, fill=true, load=1.0,
           pressure={1.0,0.85}, dips={3,1.0,0.05}, angle=0.2})
-- bury the ruled-looking corner line, then lay it again, soft and broken
work(below(function(x) return tline(x) - 22 end) * above(function(x) return tline(x) + 12 end):soften(14),
     {pile=p_tbl, hand="body", coverage=2.2, fill=true, load=1.0, pressure={1.0,0.9}, dips={3,1.0,0.05}})
c2 = ribbon({{-10, 470}, {180, 465}, {380, 458}, {430, 452, "c"}, {520, 456}, {700, 446}, {860, 438, "c"}, {1010, 431}}, 9)
work(c2, {pile=p_corner, hand="detail", coverage=1.2, fill=true, pressure=0.7,
          edge={found=0.5, soft=0.5, period=90, seed=4}})
print("corner", wait(0))
