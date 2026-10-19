p_bo_lit = pile{{"yellow ochre", 5}, {"red earth", 2}, {"lead white", 2.5}}
p_bo_mid = pile{{"yellow ochre", 3.5}, {"red earth", 3}, {"raw umber", 1.2}, {"bone black", 0.5}}
p_bo_sh  = pile{{"red earth", 2.5}, {"raw umber", 2}, {"bone black", 1.2}}
p_bo_dk  = pile{{"raw umber", 1.5}, {"bone black", 2.5}, {"Prussian blue", 0.5}, {"lead white", 0.2}}
tline = function(x) return 468 - 0.04*x end
R = function(pts, w, s) return ribbon(pts, w):soften(s) end
print("piles ok")
