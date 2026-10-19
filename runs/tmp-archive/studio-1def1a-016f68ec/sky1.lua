skyA = pile{{"lead white",3},{"smalt",1.5},{"raw umber",0.2}}
skyB = pile{{"lead white",3},{"smalt",0.7},{"red earth",0.35},{"raw umber",0.2}}
skyC = pile{{"lead white",4},{"yellow ochre",0.5},{"red earth",0.12},{"smalt",0.1}}
skyD = pile{{"lead white",5},{"chrome yellow",0.9},{"yellow ochre",0.3}}
local function band(y0,y1,seed)
  return below(function(x) return y0 + 14*math.sin(x/130+seed) end) * above(function(x) return y1 + 12*math.sin(x/110+seed*2) end)
end
local skyAll = rect(0,0,1000,446)
local ang = function(x,y) return 0.05*math.sin(x/200) end
work(band(-20,150,1)*skyAll, {hand="broad", pile=skyA, angle=ang, coverage=2.5, fill=true})
work(band(130,270,2)*skyAll, {hand="broad", pile=skyB, angle=ang, coverage=2.5, fill=true})
work(band(255,360,3)*skyAll, {hand="broad", pile=skyC, angle=ang, coverage=2.5, fill=true})
work(band(345,460,4)*skyAll, {hand="broad", pile=skyD, angle=ang, coverage=2.5, fill=true})
