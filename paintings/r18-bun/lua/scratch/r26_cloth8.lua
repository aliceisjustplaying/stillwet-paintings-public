p_clm4 = pile{{"lead white", 1.5}, {"raw umber", 4.5}, {"red earth", 1.2}, {"yellow ochre", 0.5}, {"bone black", 1}}
cloth_r = cloth:roughen(9, 70, 12)
work(cloth_r, {pile=p_clm4, hand="broad", coverage=1.0, fill=true, load=1.0,
     pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=0.5, clip=true})
for i = 1, 3 do
  work(rect(786, 634, 214, 166), {pile=p_tbl, hand="broad", coverage=3.0, fill=true,
       load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, clip=true})
end
print("settled", wait(0))
