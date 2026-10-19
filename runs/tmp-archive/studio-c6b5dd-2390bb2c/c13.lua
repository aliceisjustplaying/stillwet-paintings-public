local top = {{280,440},{330,441},{380,443},{430,442},{460,436},{470,428},{482,424},{495,427},{505,433},{520,430},{532,434},{545,441},{600,444},{680,445},{740,443},{770,446},{830,445},{862,438},{870,430},{884,426},{896,429},{905,436},{915,440},{960,443},{1000,442}}
local bot = function(x) return 458 + 2*math.sin(x/60) end
bank = below(top) * above(bot)
bank = bank:roughen(2.5, 25, 13, 0)
pBank = pile{{"raw umber",2},{"green earth",1},{"yellow ochre",0.5},{"lead white",0.8},{"smalt",0.4}}
work(bank, {hand="body", tool="filbert 5", pile=pBank, angle=0, angle_jitter=0.2, coverage=3, fill=true, length={15,50}, edge="firm"})
