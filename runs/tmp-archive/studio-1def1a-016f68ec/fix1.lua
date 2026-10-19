skyFix = pile{{"lead white",5},{"chrome yellow",0.7},{"yellow ochre",0.7},{"vermilion",0.04}}
local blob = (ellipse(220,418,26,24) * rect(0,390,1000,48)) - foresail:mask():grow(1)
work(blob, {hand="detail", pile=skyFix, angle=0, coverage=3, fill=true})
local sh = rect(190,436,40,10) - foresail:mask()
work(sh, {hand="detail", pile=shoreP, angle=0, coverage=2.5, fill=true})
-- restate foresail edge crisp
work(foresail:mask(), {hand="detail", pile=sailDark, angle=-1.25, coverage=1.2, clip=true, threshold=0.5})
