local streak = noise{seed=23, period=160, octaves=4, stretch={0.0, 9}}
icecol = function(x, y)
  local t = smoothstep(460, 522, y)
  local c = mix("#e0d4bb", "#c6c0c2", t)
  local g = math.exp(-((x - 690) / 150)^2)
  c = mix(c, "#ece0bf", 0.45 * g * (1 - t))
  local s = smoothstep(0.1, 0.5, streak(x, y))
  return mix(c, "#a3a7b3", 0.6 * s)
end
work(pond, {hand="broad", color=icecol, pal=snowpal, angle=0, length={40, 140}, coverage=4, medium=0.28, edge="found"})
blend(pond, {angle=0, coverage=1.2, clip=true})
local drift = noise{seed=29, period=90, octaves=4}
bankang = function(x, y)
  local s = (bankY(x + 20) - bankY(x - 20)) / 40
  local k = smoothstep(0, 160, y - bankY(x))
  return math.atan(s) * (1 - 0.7 * k) + 0.12 * drift(x, y)
end
work(bank, {hand="body", pal=snowpal, angle=bankang,
  length={25, 70}, coverage=3.8, medium=0.16, edge="soft",
  color=function(x, y)
    local d = y - bankY(x)
    local c = gradient({{0, "#d3cfd2"}, {0.08, "#c4c2cb"}, {0.5, "#b3b3c3"}, {1, "#a5a7ba"}}, smoothstep(0, 220, d))
    return shift(c, 0.025 * drift(x, y), 0.003 * drift(y, x), -0.004 * drift(x, y))
  end})
