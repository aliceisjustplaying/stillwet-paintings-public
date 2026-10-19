p_mid4 = pile{{"red earth", 4}, {"vermilion", 1.2}, {"raw umber", 2}, {"bone black", 0.6}, {"yellow ochre", 0.3}}
p_lit4 = pile{{"red earth", 3}, {"vermilion", 1.6}, {"yellow ochre", 0.7}, {"lead white", 0.4}, {"raw umber", 0.6}}
p_tr4  = pile{{"red earth", 2.5}, {"raw umber", 1.5}, {"bone black", 1}, {"vermilion", 0.8}}
p_sh4  = pile{{"raw umber", 2}, {"bone black", 2.4}, {"red earth", 1}, {"Prussian blue", 0.3}}
p_refl4= pile{{"red earth", 1.2}, {"lead white", 1.2}, {"vermilion", 0.3}, {"yellow ochre", 0.4}}
p_hi4  = pile{{"lead white", 3}, {"vermilion", 0.8}, {"red earth", 0.4}, {"yellow ochre", 0.3}}
p_grn_mid = pile{{"green earth", 4}, {"chrome yellow", 1.6}, {"yellow ochre", 1.2}}
p_grn_lit = pile{{"yellow ochre", 2.6}, {"chrome yellow", 1.2}, {"lead white", 1.4}, {"green earth", 1.6}}
p_grn_sh  = pile{{"green earth", 3}, {"raw umber", 1.6}, {"bone black", 1.6}, {"Prussian blue", 0.4}}
p_grn_dk  = pile{{"bone black", 2.6}, {"green earth", 1.6}, {"Prussian blue", 0.6}}

-- value chart, hidden in the bowl's interior
chart = {p_mid4, p_lit4, p_tr4, p_sh4, p_refl4, p_hi4, p_grn_mid, p_grn_lit, p_grn_sh, p_grn_dk}
for i, p in ipairs(chart) do
  work(rect(482 + (i-1)*28, 498, 28, 48), {pile=p, hand="body", coverage=3.0, fill=true,
       load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, clip=true})
end

D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
work(D, {pile=p_mid4, hand="broad", coverage=3.2, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(268, 622, 66, 62):soften(28), {pile=p_lit4, tool="filbert 16", length={40,90},
     coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(326, 676, 86, 82):soften(24), {pile=p_tr4, tool="filbert 16", length={40,90},
     coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(360, 710, 72, 68):soften(18), {pile=p_sh4, tool="filbert 16", length={40,90},
     coverage=1.9, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(304, 744, 76, 24):soften(12), {pile=p_refl4, tool="filbert 12", length={30,64},
     coverage=1.3, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
work(ellipse(260, 608, 19, 15):soften(7) * D:grow(6), {pile=p_hi4, tool="filbert 5",
     length={10,20}, coverage=1.6, fill=false, load=1.0, pressure={0.8,0.6}, clip=true})
print("apple D 4", wait(0))
