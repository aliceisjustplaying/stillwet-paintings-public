rkK = pile{{"bone black",1},{"raw umber",1},{"smalt",0.3},{"lead white",0.1}, medium=0.05}
rkD2 = pile{{"raw umber",2},{"bone black",0.6},{"smalt",0.8},{"lead white",0.4}, medium=0.05}
rkL2 = pile{{"lead white",2},{"raw umber",0.8},{"smalt",0.6},{"yellow ochre",0.1}, medium=0.05}
-- chamber, darker
local ch = poly({{572,462},{712,460},{710,486},{574,488}})
work(ch, {hand="detail", pile=rkK, coverage=3, fill=true, angle=0})
-- uprights restated, darker, varied
local defs = {
 {{558,462,"c"},{553,476},{551,490,"c"},{585,492,"c"},{586,476},{581,461,"c"}},
 {{605,466,"c"},{600,479},{602,490,"c"},{627,489,"c"},{629,475},{623,465,"c"}},
 {{652,466,"c"},{648,479},{651,488,"c"},{676,489,"c"},{678,476},{672,465,"c"}},
 {{697,462,"c"},{694,474},{696,489,"c"},{724,488,"c"},{726,472},{717,460,"c"}},
}
UPM = nil
for i,d in ipairs(defs) do d.char="broken"; d.seed=60+i; d.closed=true; local o = outline(d); UPM = UPM and (UPM + o:mask()) or o:mask() end
work(UPM, {hand="detail", pile=rkD2, coverage=2.5, fill=true, angle=math.pi/2})
-- capstone: massive, irregular
CAP = outline{{546,456,"c"},{553,446},{570,441},{600,437},{640,436},{680,437},{712,441},{730,448},{735,457,"c"},{728,466},{705,470},{660,472},{615,471},{575,469},{552,465}, closed=true, char="broken", seed=91, amount=0.8}
CAPM = CAP:mask()
work(CAPM, {hand="detail", pile=rkD2, coverage=3, fill=true, angle=0.08})
