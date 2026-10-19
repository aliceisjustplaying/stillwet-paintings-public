meadFar = pile{{"lead white", 2}, {"green earth", 3}, {"smalt", 1}, {"raw umber", 1}, medium=0.15}
meadMid = pile{{"lead white", 1}, {"green earth", 3}, {"yellow ochre", 1.5}, {"raw umber", 1.2}, {"Prussian blue", 0.08}, medium=0.15}
meadNear = pile{{"green earth", 3}, {"yellow ochre", 1}, {"raw umber", 2}, {"Prussian blue", 0.12}, medium=0.15}
bankP = pile{{"raw umber", 3}, {"green earth", 2}, {"bone black", 0.6}, {"Prussian blue", 0.15}, {"yellow ochre", 0.5}, medium=0.15}
local far = (meadowM * rect(0, 430, 1000, 42):soften(8)) - riverM
local mid = (meadowM * rect(0, 465, 1000, 60):soften(10)) - riverM
local near = meadowM * rect(0, 515, 1000, 120):soften(10)
work(far, {hand="body", pile=meadFar, angle=0, coverage=2.5, fill=true, length={20,50}, clip=true})
work(mid, {hand="body", pile=meadMid, angle=0.02, coverage=2.5, fill=true, length={20,50}, clip=true})
work(near, {hand="body", pile=meadNear, angle=0.03, coverage=2.5, fill=true, length={20,60}, clip=true})
work(bankM, {hand="broad", pile=bankP, angle=-0.1, coverage=2.5, fill=true})
