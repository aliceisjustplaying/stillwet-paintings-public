sepia = pal:only{"raw umber", "bone black", "yellow ochre", "lead white"}
local r1 = rect(0, 450, 250, 200); local r2 = rect(250, 450, 250, 200); local r3 = rect(500,450,250,200); local r4 = rect(750,450,250,200)
work(r1, {hand="broad", tool="flat 10", color="#5e4e3c", angle=0, length={30, 90}, coverage=2.4, medium=0.4, load=0.8, pal=sepia})
work(r2, {hand="broad", tool="flat 10", color="#5e4e3c", angle=0, length={30, 90}, coverage=2.4, medium=0.7, load=0.5, pal=sepia})
blend(r2, {angle=0})
work(r3, {hand="glaze", color="#5e4e3c", angle=0, coverage=2.4, pal=sepia})
work(r4, {hand="body", tool="filbert 8", color="#5e4e3c", angle=0, length={20, 60}, coverage=2.4, medium=0.3, pal=sepia})
