cloudD = pile{{"lead white",2},{"smalt",1},{"red earth",0.45},{"raw umber",0.45},{"bone black",0.08}}
cloudM = pile{{"lead white",3},{"smalt",0.8},{"red earth",0.5},{"raw umber",0.25}}
local n1 = noise{seed=11, octaves=5, period=160, stretch={0, 3.5}}
local n2 = noise{seed=12, octaves=4, period=90, stretch={0, 4}}
-- main bank: denser to the right, thinning left
bank = mask(function(x,y)
  local c = 205 + 25*math.sin(x/260+0.5) - 0.02*(x-500)
  local prof = 1 - ((y-c)/70)^2
  if prof <= 0 then return 0 end
  local v = n1(x,y)*0.9 + prof*0.9 + (x/1000)*0.35 - 0.55
  return clamp(v*4, 0, 1)
end)
-- high wisps
wisps = mask(function(x,y)
  local prof = 1 - ((y-60)/55)^2
  if prof <= 0 then return 0 end
  local v = n2(x,y) + prof*0.6 - 0.62
  return clamp(v*4,0,1)
end)
work(bank, {hand="body", pile=cloudD, angle=function(x,y) return -0.04 end, coverage=2, length={30,90}, pressure={0.4,0.8}})
work(wisps, {hand="body", pile=cloudM, angle=-0.05, coverage=1.5, length={30,80}, pressure={0.3,0.6}})
