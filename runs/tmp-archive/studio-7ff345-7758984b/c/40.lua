-- a low drifted bank across the foreground, its face in shadow; the path cuts through it
function bankY(x)
  local y = 650 + 10 * math.sin(x / 130 + 0.5) + 4 * math.sin(x / 37) + 1.5 * math.sin(x / 9)
  y = y + 16 * math.exp(-((x - 335) / 38)^2)
  return y
end
bankM = below(bankY)
fgGlaze = pile{{"smalt",2.5},{"bone black",0.35},{"lead white",0.7},{"vermilion",0.06}, medium=0.72}
work(bankM, {hand="glaze", pile=fgGlaze, angle=function(x, y) return 0.05 * math.sin(x / 90) end, angle_jitter=0.05,
   load_at=function(x, y) local t = smoothstep(bankY(x), bankY(x) + 40, y); return 0.1 + 0.55 * t end,
   pressure={0.3, 0.5}, coverage=1.6, clip=true, seed=401})
blend(bankM, {angle=0})
