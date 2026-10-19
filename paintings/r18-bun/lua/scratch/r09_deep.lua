p_deep = pile{{"raw umber", 4}, {"bone black", 2.6}, {"red earth", 0.8}, {"yellow ochre", 0.4}, {"cobalt blue", 0.35}}
work(everywhere(), {pile=p_deep, hand="broad", coverage=3.5, fill=true, load=1.0,
                    pressure={1.0,0.85}, dips={3,1.0,0.05}})
work(everywhere(), {pile=p_deep, hand="broad", coverage=3.0, fill=true, load=1.0,
                    pressure={1.0,0.85}, dips={3,1.0,0.05}})
print("deep field", wait(0))
