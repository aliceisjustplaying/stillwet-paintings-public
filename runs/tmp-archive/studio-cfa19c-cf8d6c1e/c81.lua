local topP = {{350,474},{460,480},{560,490},{660,508},{760,528},{880,552},{1010,578}}
local botP = {{350,490},{460,500},{560,516},{660,538},{760,560},{880,586},{1010,612}}
function hayY(x, f) return lerp(interp(topP,x), interp(botP,x), f) end
local rowL = pile{{"yellow ochre",2},{"lead white",2.2},{"raw umber",0.3},{"green earth",0.4}, medium=0.05}
local rowD = pile{{"raw umber",1},{"green earth",1.2},{"yellow ochre",0.6},{"lead white",0.6}, medium=0.05}
for r,f in ipairs({0.2, 0.42, 0.64, 0.86}) do
  local x0 = 380 + r*12 + rand(-5,5)
  local x = x0
  while x < 1005 do
    local segL = rand(40, 110)
    local x1 = math.min(1005, x + segL)
    local pts, pts2 = {}, {}
    for xx = x, x1, 6 do
      local y = hayY(xx, f) + rand(-0.4, 0.4)
      pts[#pts+1] = {xx, y}
      pts2[#pts2+1] = {xx + 0.5, y + 0.9 + 0.0015*(xx-350)}
    end
    if #pts >= 2 then
      local w = 1.0 + 0.0035*(x-350)
      local bd = brush{kind="round", width=w*1.1, point=0.3}
      bd:reload(rowD, 0.5)
      bd:stroke(pts2, {pressure={0.5,0.6}, ramps={0.15,0.2}, shake=0.4, clip=M1})
      local bl = brush{kind="round", width=w, point=0.3}
      bl:reload(rowL, 0.6)
      bl:stroke(pts, {pressure={0.55,0.65}, ramps={0.15,0.2}, shake=0.4, clip=M1})
    end
    x = x1 + rand(6, 18)
  end
end
