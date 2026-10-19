cA = pile{{"raw umber", 2}, {"red earth", 1.2}, {"yellow ochre", 1}, {"lead white", 2.2}}
cB = pile{{"raw umber", 2.5}, {"lead white", 3}, {"yellow ochre", 0.6}, {"red earth", 0.5}}
cC = pile{{"raw umber", 3.5}, {"bone black", 1.2}, {"lead white", 1}, {"red earth", 0.8}}
cD = pile{{"bone black", 2}, {"raw umber", 2}, {"lead white", 1.5}, {"Prussian blue", 0.4}}
cand = {cA, cB, cC, cD}
for i, p in ipairs(cand) do
  m = rect(404 + (i-1)*48, 500, 48, 66)
  work(m, {pile=p, hand="body", coverage=3.0, fill=true, load=1.0, pressure={1.0,1.0},
           dips={1,1.0,0.0}, clip=true})
end
print("chart2")
