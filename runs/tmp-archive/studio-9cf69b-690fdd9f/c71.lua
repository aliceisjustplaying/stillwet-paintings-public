local fx, fy = FX, FY
local m = (ribbon({{fx+0.8,fy-30},{fx+1.2,fy-20},{fx+1.6,fy-8}}, 2.4) + ribbon({{fx-6.2,fy-21.5},{fx,fy-21},{fx+6.4,fy-21.6}}, 2.4)) * figM:shrink(0.3)
work(m, {hand="detail", pile=coatP, coverage=5, pressure={0.7,1.0}, load=1, fill=true, tool={kind="round", width=1.2}})
