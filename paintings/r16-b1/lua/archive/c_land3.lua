meadLight = pile{{"green earth", 3}, {"yellow ochre", 2}, {"lead white", 1.5}, {"raw umber", 0.7}, medium=0.15}
meadLight2 = pile{{"green earth", 3}, {"yellow ochre", 1.5}, {"lead white", 0.6}, {"raw umber", 1.2}, medium=0.15}
local mA = (meadowM * rect(0, 488, 1000, 45):soften(10)) - riverM
local mB = meadowM * rect(0, 525, 1000, 80):soften(10)
work(mA, {hand="body", pile=meadLight, angle=0.0, coverage=2.5, fill=true, length={25,60}, clip=true})
work(mB, {hand="body", pile=meadLight2, angle=0.0, coverage=2.5, fill=true, length={25,60}, clip=true})
blend(meadowM * rect(0, 460, 1000, 140), {angle=0, coverage=1.5})
