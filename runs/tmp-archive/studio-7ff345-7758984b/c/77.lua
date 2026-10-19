-- the dead limbs are too pale and flat against the dusk: glaze them down, and shade their right flanks
deadGlaze = pile{{"raw umber",1},{"smalt",0.6},{"bone black",0.3},{"lead white",0.6}, medium=0.75}
work(oakDead, {hand="detail", tool={kind="round", width=2, point=0.5}, pile=deadGlaze, load=0.3, pressure={0.35, 0.5}, coverage=2, fill=true, clip=true, angle=-1.4, angle_jitter=0.2})
local rightFlank = oakDead * mask(function(x, y) return (oakDead:at(x + 2.2, y) < 0.4) and 1 or 0 end)
work(rightFlank:soften(0.5), {hand="detail", tool={kind="round", width=1.2, point=0.5}, pile=deadGlaze, load=0.55, pressure={0.4, 0.6}, coverage=2.5, fill=true, clip=true, angle=-1.4})
