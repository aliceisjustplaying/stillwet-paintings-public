trackPath = {{744,722},{712,680},{676,636},{640,600},{606,574},{580,557},{568,551}}
local ws = {30,24,18,13,8,5,3.5}
furrowM = ribbon(trackPath, ws):roughen(1.5, 6, 101)
local furrowP = pile{{"lead white",4},{"pale smalt",1.8},{"smalt",0.45},{"raw umber",0.2},{"vermilion",0.03}, medium=0.1}
work(furrowM, {hand="detail", pile=furrowP, coverage=3.5, pressure={0.5,0.8}, load=0.9, fill=true, angle=-0.9, angle_jitter=0.6, length={4,10}})
