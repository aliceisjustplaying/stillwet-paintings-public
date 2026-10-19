local dist = trees:distance()
holesHi, holesMid = nil, nil
local cnt = 0
for k = 1, 400 do
  local x, y = rand(0, 440), rand(40, 420)
  if trees:at(x, y) > 0.9 and cnt < 34 then
    -- depth inside: find edge distance by probing
    local near = false
    for _, d in ipairs({{25,0},{18,-18},{0,-25},{-18,-18},{25,-10}}) do
      if trees:at(x + d[1], y + d[2]) < 0.5 then near = true end
    end
    if near then
      cnt = cnt + 1
      local r = rand(2.5, 6)
      local m = ellipse(x, y, r*rand(1,1.6), r*rand(0.6,1)):roughen(r*0.4, r*0.8, 200+k, 0)
      if y < 170 then holesHi = holesHi and (holesHi + m) or m else holesMid = holesMid and (holesMid + m) or m end
    end
  end
end
print(cnt)
pHoleHi = pile{{"lead white",4},{"smalt",1.5},{"Prussian blue",0.05},{"raw umber",0.1}}
pHoleMid = pile{{"lead white",6},{"pale smalt",0.6},{"vermilion",0.08},{"chrome yellow",0.2},{"raw umber",0.1}}
local t = {kind="round", width=3.5, point=0.3}
if holesHi then work(holesHi, {hand="detail", tool=t, pile=pHoleHi, coverage=3, load=0.6, fill=true}) end
if holesMid then work(holesMid, {hand="detail", tool=t, pile=pHoleMid, coverage=3, load=0.6, fill=true}) end
