p_wall  = pile{{"raw umber", 4}, {"bone black", 4}, {"red earth", 0.7}, {"Prussian blue", 0.4}}
p_walll = pile{{"raw umber", 4}, {"bone black", 2}, {"red earth", 1.3}, {"yellow ochre", 0.6}}
p_tbl   = pile{{"raw umber", 5}, {"red earth", 1.6}, {"yellow ochre", 0.6}, {"bone black", 1.2}}
w = everywhere()
work(w, {pile=p_wall, tool="filbert 12", length={26,64}, coverage=2.2,
         dips={4,1.0,0.1}, fill=true, edge="soft", angle=0.9})
print("base laid")
