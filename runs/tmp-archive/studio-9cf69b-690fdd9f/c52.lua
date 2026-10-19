fieldTop = {{-10,492},{540,492},{590,486},{630,480},{1010,480}}
local keep = (figM:grow(0.8) + postsM:grow(0.8) + sprM:grow(0.8))
fieldM = land * below(fieldTop) - keep
fieldA = pile{{"lead white",6},{"pale smalt",1.2},{"yellow ochre",0.15},{"vermilion",0.04}, medium=0.12}
fieldB = pile{{"lead white",5},{"pale smalt",1.8},{"smalt",0.35},{"raw umber",0.12},{"vermilion",0.02}, medium=0.12}
fieldC = pile{{"lead white",3.6},{"pale smalt",2.2},{"smalt",0.75},{"raw umber",0.24},{"bone black",0.04}, medium=0.12}
work(fieldM * below({{-10,470},{1010,470}}) * above({{-10,545},{1010,545}}), {hand="body", pile=fieldA, angle=0, coverage=2.5, fill=true, angle_jitter=0.04, pressure={0.5,0.8}, length={40,90}, clip=true})
work(fieldM * below({{-10,535},{1010,535}}) * above({{-10,625},{1010,625}}), {hand="body", pile=fieldB, angle=0, coverage=2.5, fill=true, angle_jitter=0.04, pressure={0.5,0.8}, length={40,90}, clip=true})
work(fieldM * below({{-10,615},{1010,615}}), {hand="body", pile=fieldC, angle=0.02, coverage=2.5, fill=true, angle_jitter=0.06, pressure={0.5,0.8}, length={40,100}, clip=true})
blend(fieldM, {angle=0})
blend(fieldM * below({{-10,520},{1010,520}}), {angle=0.02})
