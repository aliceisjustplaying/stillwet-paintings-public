wall = everywhere() - below(tline)
table_ = below(tline)
print(string.format("wall %.0f  table %.0f  canvas %.0f", wall:area(), table_:area(), everywhere():area()))
-- the wall: a dark warm brown, lighter toward the upper left where the light is
work(wall, {hand="broad", tool="filbert 24", pile=g_wl, length={110, 250},
            coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0},
            angle=0.3, edge="soft"})
