local clipW = rect(0,452,1000,220) - spit3:grow(2) - hull2:mask():grow(1)
local b = brush("filbert", 4)
function ripple_lines(n, y0, y1, piles, Lmin, Lmax, pmin, pmax, xs0, xs1)
  for i = 1, n do
    local y = rand(y0, y1)
    local x = rand(xs0 or -50, xs1 or 1000)
    local L = rand(Lmin, Lmax)
    local p = piles[math.random(#piles)]
    b:reload(p, rand(0.3, 0.55))
    local dy = rand(-0.8, 0.8)
    b:stroke({{x, y}, {x + L*0.5, y + dy}, {x + L, y + rand(-0.5,0.5)}}, {pressure={rand(pmin,pmax), rand(0.05,0.2)}, ramps={0.15,0.5}, clip=clipW})
  end
end
ripple_lines(45, 470, 492, {Wa2, WbC, Wb2}, 40, 160, 0.2, 0.4)
ripple_lines(45, 548, 575, {WbC, Wd, Wb2}, 40, 180, 0.2, 0.45)
ripple_lines(30, 500, 545, {Wb2, WbC}, 60, 200, 0.15, 0.35)
ripple_lines(40, 580, 667, {Wd, WbC, Wb2}, 60, 220, 0.2, 0.45)
