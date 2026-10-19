plainA = pile{{"lead white",3},{"smalt",1.2},{"raw umber",0.25},{"red earth",0.06},{"yellow ochre",0.08}, medium=0.15}
plainB = pile{{"lead white",3},{"smalt",0.9},{"raw umber",0.2},{"red earth",0.05},{"yellow ochre",0.12}, medium=0.15}
work(rect(518,466,8,6), {hand="detail", pile=plainA, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
work(rect(536,466,8,6), {hand="detail", pile=plainB, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
