p_reset = pile{{"lead white", 3}, {"raw umber", 5}, {"bone black", 1.5}, {"cobalt blue", 0.4}}
p_r_lit = pile{{"vermilion", 5}, {"red earth", 1.5}, {"yellow ochre", 1.5}, {"lead white", 1.5}}
p_r_mid = pile{{"vermilion", 5}, {"red earth", 3}, {"raw umber", 1.2}, {"yellow ochre", 0.6}}
p_r_sh  = pile{{"vermilion", 2}, {"red earth", 2.5}, {"raw umber", 2}, {"bone black", 1.2}}
p_r_dk  = pile{{"red earth", 2}, {"raw umber", 2}, {"bone black", 2}, {"Prussian blue", 0.5}}
p_g_lit = pile{{"yellow ochre", 3}, {"chrome yellow", 1.5}, {"lead white", 2}, {"green earth", 1.5}}
p_g_mid = pile{{"green earth", 5}, {"yellow ochre", 2}, {"chrome yellow", 1}}
p_g_sh  = pile{{"green earth", 4}, {"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.5}}
p_bo_lit= pile{{"yellow ochre", 5}, {"red earth", 2}, {"lead white", 2.5}}
p_bo_mid= pile{{"yellow ochre", 3.5}, {"red earth", 3}, {"raw umber", 1.2}, {"bone black", 0.5}}

chart = {p_cl_hi, p_clm2, p_cl_sh2, p_cl_dp2, p_r_lit, p_r_mid, p_r_sh, p_r_dk, p_g_lit, p_g_mid}
work(rect(800, 655, 200, 145), {pile=p_reset, hand="broad", coverage=2.6, fill=true,
     load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, clip=true})
for i, p in ipairs(chart) do
  c, r = (i-1) % 5, math.floor((i-1)/5)
  m = rect(800 + c*40, 655 + r*72, 40, 72)
  work(m, {pile=p, hand="body", coverage=2.6, fill=true, load=1.0,
           pressure={1.0,1.0}, dips={1,1.0,0.0}, clip=true})
end
print("chart")
