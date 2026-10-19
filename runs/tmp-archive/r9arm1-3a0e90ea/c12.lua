W0 = {willow(852, 616, -0.07, 95, 100, 0.0)}
-- a split in the old trunk: a dark cleft with a pale torn edge
local cx = 852 - 0.07 * 60
local cleft = outline{pts={{cx - 4, 606}, {cx - 7, 580}, {cx - 3, 548}, {cx - 9, 520, "c"}, {cx - 2, 512}, {cx + 2, 546}, {cx + 1, 580}, {cx + 2, 606}}, char="broken", seed=77}
work(cleft:mask(), {hand="detail", tool="round 1.4", length={4, 12}, coverage=4, medium=0.15, angle=1.6, color="#1f1b1a", edge="firm"})
local tb = brush{kind="round", width=1.2, point=1}
tb:load("#77695c", 0.8)
local pp = cleft:path(1)
tb:stroke({pp[1], pp[2], pp[3], pp[4]}, {pressure={0.5, 0.1}, shake=0.6})
