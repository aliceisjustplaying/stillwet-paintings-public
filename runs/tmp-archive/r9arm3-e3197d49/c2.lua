HZ = 468
-- the drawing: horizon ruled, the mound, oak trunk, the cross, the walker
MOUND = {{-10,588},{60,572},{140,556},{220,546},{300,540},{370,546},{430,560},{500,582},{570,598},{650,606},{760,610},{880,606},{1010,600}}
local h = pencil("2H")
h:rule({0, HZ}, {1000, HZ}, {pressure=0.25})
h:sketch(MOUND, {pressure=0.3})
h:sketch({{318,548},{314,470},{322,390},{312,300},{330,220}}, {pressure=0.3})
local b = pencil("HB")
b:line({{596,604},{598,530},{600,488}}, {pressure={0.4,0.5,0.4}})
b:line({{582,512},{616,510}}, {pressure=0.45})
b:sketch({{700,622},{702,600},{704,580},{703,566}}, {pressure=0.35})
