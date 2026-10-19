skyapr = pile{{"lead white",7},{"chrome yellow",0.3},{"yellow ochre",0.35},{"vermilion",0.12}, medium=0.25}
RING = (TOWN2:grow(5) - TOWN2) * rect(330,330,340,116)
work(RING * rect(420,395,40,20), {hand="detail", pile=skyapr, tool={kind="round", width=1.2, point=0.6}, angle=0, coverage=4, fill=true, length={2,5}, seed=941})
