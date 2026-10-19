dright = ellipse(880, 700, 400, 250):blur(180)
dfront = ellipse(430, 830, 640, 120):blur(80)
cllit  = CLOTH * (-(dright + dfront))
print(string.format("cloth %.0f  lit part %.0f", CLOTH:area(), cllit:area()))
work(cllit, {hand="body", tool="filbert 15", pile=g_cl, length={50, 130},
             coverage=3.5, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
blend((cllit:shrink(6)):soften(6), {angle=0.2})
