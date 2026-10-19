seamBand = (rect(300, 334, 710, 24):roughen(4, 30, 211, 0)) - trees:grow(2)
pSeam = pile{{"lead white",6},{"chrome yellow",0.5},{"vermilion",0.3},{"pale smalt",0.35},{"red earth",0.05}}
work(seamBand, {hand="body", tool="filbert 8", pile=pSeam, angle=0, angle_jitter=0.1, coverage=2.5, load=0.7, pressure={0.35,0.6}, length={20,60}, clip=seamBand, fill=true})
blend(seamBand:grow(6) - trees:grow(3), {angle=1.5, angle_jitter=0.25, tool="badger 12", length={12,26}, clip=true})
blend(seamBand:grow(8) - trees:grow(3), {angle=0, angle_jitter=0.03, tool="badger 20", length={50,140}, clip=true, pressure={0.25,0.4}})
