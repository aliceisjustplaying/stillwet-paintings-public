CAPTOP = {{543,454},{550,446},{560,440},{585,431},{612,426},{640,425},{668,427},{695,431},{716,436},{731,443},{739,451},{741,456}}
function captop(x)
  for i=1,#CAPTOP-1 do local a,b = CAPTOP[i], CAPTOP[i+1]; if x>=a[1] and x<=b[1] then return lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end
  return nil
end
function capbot(x)
  local t = captop(x); if not t then return nil end
  local b = 451.5 + 1.6*math.sin(x/9.7) + 1.0*math.sin(x/4.1 + 1)
  -- the snow thins toward the rounded ends
  local e = math.min(x - 543, 741 - x)
  local th = clamp(e/22, 0.25, 1) * (b - t)
  return t + th
end
SNOWM = mask(function(x,y) local t = captop(x); if not t then return 0 end; local b = capbot(x); if y >= t and y <= b then return 1 end; return 0 end)
work(SNOWM, {hand="detail", pile=capShade, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.5}})
local LIT = mask(function(x,y) local t = captop(x); if not t then return 0 end; if y >= t and y <= t + 5 + 1.5*math.sin(x/13) then return 1 end; return 0 end)
work(LIT, {hand="detail", pile=snowTop, coverage=3.5, fill=true, angle=0, load=1, pressure={0.5,0.85}, tool={kind="round", width=1.8, point=0.5}})
