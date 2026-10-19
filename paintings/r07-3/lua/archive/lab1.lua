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
