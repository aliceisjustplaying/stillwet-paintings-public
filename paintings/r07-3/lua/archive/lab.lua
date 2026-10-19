-- easel session "lab": a painting replayed chunk by chunk.
--   easel run paintings/lua/lab.lua [--width 3200]
-- Each "--@ chunk" line starts one chunk as it was run at the easel (clock = painting minutes).
-- sittings enforced: a sitting ends at its length; the easel refuses marks until rest(hours) (notes/time.md)

--@ chunk 1 · clock 0
canvas{style="friedrich", aspect=1.45, seed=23}
skypal = pal:only{"lead white", "pale smalt", "cobalt blue", "yellow ochre", "raw umber", "red earth", "vermilion", "chrome yellow"}
local C = "#bcbca8"
work(rect(0,0,250,300), {hand="broad", color=C, angle=0, coverage=4.2, medium=0.3, pal=skypal})
work(rect(250,0,250,300), {hand="broad", tool="flat 12", color=C, angle=0, length={70,200}, coverage=3.6, medium=0.3, pal=skypal})
work(rect(500,0,250,300), {hand="broad", tool="flat 12", color=C, angle=0, length={70,200}, coverage=3.6, medium=0.3, pal=skypal, hug=false})
work(rect(750,0,250,300), {hand="broad", color=C, angle=0, coverage=4.2, medium=0.3, pal=skypal, aim="masstone"})
work(rect(0,350,250,300), {hand="body", tool="filbert 10", color=C, angle=0, coverage=3.5, medium=0.2, pal=skypal})
work(rect(250,350,250,300), {hand="broad", color=C, angle=0, coverage=4.2, medium=0.3})
work(rect(500,350,250,300), {hand="broad", color=C, angle=0, coverage=4.2, medium=0.15, load=1})
work(rect(750,350,250,300), {hand="broad", tool="badger 14", color=C, angle=0, coverage=4.2, medium=0.3, pal=skypal})

--@ chunk 2 · clock 0
work(rect(0,0,1000,690), {hand="broad", color="#e0cf9e", angle=0, coverage=4.2, medium=0.3, pal=skypal})
dry()
local function cl(cx, cy) return ellipse(cx, cy, 90, 14):roughen(2, 20, 3, 2) end
work(cl(150,100):blur(3), {hand="body", tool="filbert 5", color="#948690", angle=0, length={30,90}, coverage=2.4, medium=0.5, load=0.45, pal=skypal, hug=false})
work(cl(400,100):blur(3), {hand="body", tool="filbert 5", color="#948690", angle=0, length={30,90}, coverage=2.4, medium=0.5, load=0.45, pal=skypal, hug=false})
blend(cl(400,100):grow(4):blur(3), {angle=0, coverage=1.4})
work(cl(650,100):blur(3), {hand="body", tool="filbert 5", color="#948690", angle=0, length={30,90}, coverage=2.4, medium=0.25, load=0.8, pal=skypal, hug=false})
work(cl(150,250):blur(3), {hand="glaze", color="#948690", angle=0, coverage=2.4, pal=skypal, hug=false})
stipple(cl(400,250):blur(4), {width=3, color="#948690", coverage=1.8, fade=1, medium=0.5, pal=skypal})
work(cl(650,250):blur(3), {hand="broad", color="#948690", angle=0, length={40,120}, coverage=3, medium=0.3, pal=skypal, hug=false})
work(cl(880,250):blur(3), {hand="scumble", color="#948690", angle=0, coverage=2, medium=0.35, pal=skypal, hug=false})
work(cl(880,100):blur(3), {hand="broad", color="#948690", angle=0, length={40,120}, coverage=3, medium=0.3, pal=skypal, hug=false})
blend(cl(880,100):grow(4):blur(3), {angle=0, coverage=1.4})
