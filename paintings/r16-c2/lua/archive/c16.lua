local nzc = noise{seed=41, period=60, octaves=3}
function lens(x0, x1, yc, th, tilt, seed)
  local nn = noise{seed=seed, period=50, octaves=3}
  return mask(function(x,y)
    if x < x0 or x > x1 then return 0 end
    local t = (x - x0)/(x1 - x0)
    local w = th * math.sin(math.pi*t)^0.6 * (0.8 + 0.4*nn(x, 0))
    local c = yc + tilt*(x-x0) + 4*nn(x, 50)
    return (math.abs(y - c) < w) and 1 or 0 end):roughen(3, 14, seed+1)
end
cloudA = lens(-40, 720, 222, 16, -0.012, 101) + lens(480, 1040, 205, 11, 0.01, 103)
cloudB = lens(40, 380, 300, 5, 0.004, 105) + lens(430, 820, 312, 4, -0.004, 107) + lens(600, 1000, 285, 6, 0, 109)
cloudC = lens(-40, 420, 70, 22, 0.02, 111) + lens(560, 1040, 110, 18, -0.01, 113) + lens(250, 700, 150, 8, 0, 115)
cloudDark = pile{{"lead white",2},{"cobalt blue",0.5},{"red earth",0.4},{"raw umber",0.3}, medium=0.15}
cloudHi = pile{{"lead white",2.2},{"cobalt blue",0.6},{"red earth",0.3},{"raw umber",0.35}, medium=0.15}
cloudWarm = pile{{"lead white",3},{"vermilion",0.25},{"yellow ochre",0.5},{"cobalt blue",0.1}, medium=0.1}
work(cloudC, {hand="body", tool="filbert 8", pile=cloudHi, angle=0.02, coverage=2, length={25,70}, fill=true, edge={soft=0.5, lost=0.4, found=0.1, period=40}})
work(cloudA, {hand="body", tool="filbert 7", pile=cloudDark, angle=-0.01, coverage=2.2, length={25,70}, fill=true, edge={soft=0.5, lost=0.3, found=0.2, period=40}})
work(cloudB, {hand="detail", tool="round 4", pile=cloudWarm, angle=0, coverage=2, length={15,40}, fill=true, edge="soft"})
