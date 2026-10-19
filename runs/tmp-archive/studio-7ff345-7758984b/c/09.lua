churchp = pile{{"lead white",3},{"smalt",1},{"pale smalt",1},{"vermilion",0.1},{"bone black",0.12}, medium=0.2}
local tower = rect(634, 426, 12, 46)
local spire = poly({{632.5, 427}, {640, 396}, {647.5, 427}})
local nave = poly({{646, 472}, {646, 449}, {668, 441}, {692, 449}, {692, 472}})
local apse = poly({{692, 472}, {692, 452}, {700, 455}, {703, 462}, {703, 472}})
churchm = tower + spire + nave + apse
work(churchm, {hand="detail", pile=churchp, load=0.9, pressure={0.5, 0.8}, coverage=3.5, fill=true, angle=math.pi/2})
