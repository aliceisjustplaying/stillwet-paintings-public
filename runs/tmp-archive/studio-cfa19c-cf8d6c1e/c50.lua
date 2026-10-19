local rg = brush{kind="rigger", width=1.0, point=1}
local wTr2 = pile{{"raw umber",1.2},{"bone black",0.4},{"lead white",1.0},{"green earth",0.3}, medium=0.05}
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local y = interp(farBank, x) + 0.5
  local ky = y - 0.42*s
  rg:reload(wCrD, 0.7)
  local n = math.floor(8 + s*0.3)
  for k=1,n do
    local a = -math.pi/2 + (k/(n+1) - 0.5) * 2.1 + rand(-0.1,0.1)
    local L = s * rand(0.55, 0.78)
    local x0, y0 = x + rand(-0.08,0.08)*s, ky + rand(-0.02,0.04)*s
    local bend = rand(-0.1,0.1)
    rg:stroke({{x0,y0},{x0+math.cos(a)*L*0.5, y0+math.sin(a)*L*0.5},{x0+math.cos(a+bend)*L, y0+math.sin(a+bend)*L}}, {pressure={0.35,0.0}, ramps={0.05,0.6}})
    if k % 4 == 0 then rg:reload(wCrD, 0.7) end
  end
  -- the gnarled grey trunk restated
  local th = 0.42*s
  local tb = brush{kind="round", width=math.max(1.3, 0.12*s), point=0.3}
  tb:reload(wTr2, 0.8)
  tb:stroke({{x, y}, {x+rand(-0.5,0.5), y-th*0.5}, {x+rand(-0.8,0.8), y-th}}, {pressure={0.9,0.8}})
end
