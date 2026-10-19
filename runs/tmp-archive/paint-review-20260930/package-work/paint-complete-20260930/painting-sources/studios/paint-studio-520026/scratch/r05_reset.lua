p_reset = pile{{"lead white", 3}, {"raw umber", 5}, {"bone black", 1.5}, {"cobalt blue", 0.4}}
low = rect(0, 330, 1000, 470)
work(low, {pile=p_reset, tool="flat 20", length={30,70}, coverage=3.0, fill=true,
           load=1.0, pressure={1.0,1.0}, dips={2,1.0,0.0}, edge="soft"})
work(low, {pile=p_wall, tool="flat 20", length={30,70}, coverage=2.0, fill=true,
           load=1.0, pressure={1.0,1.0}, dips={2,1.0,0.0}, edge="soft"})
print("reset")
