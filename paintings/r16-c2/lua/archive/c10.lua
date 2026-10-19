local nz = noise{seed=21, period=40, octaves=3}
local nz2 = noise{seed=22, period=12, octaves=2}
local bumps = {{775,70,30},{835,98,34},{880,82,26},{925,55,28},{975,38,30},{720,26,18},{690,14,14}}
function treeTop(x)
  local h = 0
  if x > 600 then h = 4 + math.min(1,(x-600)/80)*6 end
  for _,b in ipairs(bumps) do local d=(x-b[1])/b[3]; h = math.max(h, b[2]*math.exp(-d*d)) end
  if h > 10 then h = h + nz(x, 0)*6 + nz2(x, 3)*4 end
  return 402 - h
end
spit = mask(function(x,y) if x < 596 then return 0 end; return (y > treeTop(x) and y < 406) and 1 or 0 end):roughen(2.5, 9, 23)
farShore = mask(function(x,y) if x > 640 then return 0 end; local t = 399 - (3 + 3*math.sin(x/37) + 2*nz(x,9)) ; if x > 540 then t = t + (x-540)/25 end; return (y > t and y < 401.5) and 1 or 0 end)
farP = pile{{"lead white",2.5},{"cobalt blue",0.5},{"red earth",0.3},{"raw umber",0.3}}
spitP = pile{{"raw umber",1},{"bone black",0.3},{"cobalt blue",0.4},{"lead white",0.7},{"green earth",0.3}}
work(farShore, {hand="detail", tool="round 3", pile=farP, angle=0, coverage=2, length={8,25}, fill=true})
work(spit, {hand="detail", tool="round 4", pile=spitP, angle=function(x,y) return -1.4 + 0.3*math.sin(x/9) end, coverage=2.5, length={6,16}, fill=true, edge="soft"})
