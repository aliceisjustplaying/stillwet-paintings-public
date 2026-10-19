local function sl(x) return 452.5 + 1.8*math.sin(x/9.7) + 1.1*math.sin(x/4.1 + 1) end
local mid = mask(function(x,y) if x < 568 or x > 712 then return 0 end; if y > 440 and y < sl(x) then return 1 end; return 0 end)
work(mid, {hand="detail", pile=capShade, coverage=3.5, fill=true, angle=0, load=1, pressure={0.5,0.85}, tool={kind="round", width=1.8, point=0.6}})
-- right end: snow over the top of the shoulder, following its curve
local rtop = poly({{706,440},{718,437},{728,440},{735,446},{738,451},{732,449},{724,445},{714,444},{706,446}}, true)
local ltop = poly({{548,447},{553,442},{560,441},{566,444},{566,448},{559,446},{553,447}}, true)
work(rtop + ltop, {hand="detail", pile=capShade, coverage=3.5, fill=true, angle=0.2, load=1, pressure={0.5,0.85}, tool={kind="round", width=1.5, point=0.6}})
-- flecks of snow clinging to the rough rock face below the line
local fb = brush{kind="round", width=1.6, point=0.5}
fb:load(capShade, 0.6)
for i=1,40 do
  local x = rand(552, 735); local y = sl(x) + rand(1, 12)
  if CAPM:at(x, y) > 0.5 then
    if fb:fullness() < 0.3 then fb:load(capShade, 0.6) end
    fb:stroke({{x, y}, {x + rand(1,3), y + rand(-0.3,0.3)}}, {pressure={rand(0.2,0.4), 0.1}})
  end
end
