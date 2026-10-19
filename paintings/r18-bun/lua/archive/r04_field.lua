low = rect(0, 330, 1000, 470)
work(low, {pile=p_wall, tool="flat 20", length={30,70}, coverage=3.5, fill=true,
           load=1.0, pressure={1.0,1.0}, dips={2,1.0,0.0}, edge="soft"})
stipple(low, {pile=p_wall, width=3.2, coverage=2.2, pressure={0.8,0.6}, clip=true})
print("coat 4")
