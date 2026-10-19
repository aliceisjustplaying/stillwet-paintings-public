reflD = pile{{"raw umber",1},{"bone black",0.5},{"cobalt blue",0.3},{"green earth",0.2},{"lead white",0.55}}
local wc = rect(0,402.5,1000,110) - bar - barR
local n = 0
local y = 403.5
while y < 470 do
  local fade = 1 - (y - 403)/70
  local x = 590 + rand(0, 10)
  while x < 1000 do
    local len = rand(8, 40)
    local xm = clamp(x + len/2, 1, 999)
    if trees:at(xm, 804 - y) > 0.5 and rand(0,1) < 0.25 + 0.7*fade and wc:at(xm, y) > 0.5 then
      local b = brush{kind="flat", width=rand(1.2, 2.2), stiffness=0.4}
      b:load(reflD, 0.3 + 0.35*fade)
      b:stroke({{x, y + randn(0,0.2)}, {x + len, y + randn(0,0.2)}}, {pressure={0.3 + 0.3*fade, 0.1}, ramps={0.2,0.4}, clip=wc})
      n = n + 1
    end
    x = x + len + rand(2, 14)
  end
  y = y + 1.6 + 2.2*(1-fade) + rand(0, 1)
end
print(n)
