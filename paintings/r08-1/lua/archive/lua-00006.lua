-- the frozen pond: dull ice that holds a little of the evening, in horizontal strokes
icen = noise{seed=61, octaves=4, period=160, stretch={0.0, 7}}
POND = below(function(x) return shore(x) - 1 end) * above(function(x) return bank(x) + 8 end)
function icecol(x, y)
  local t = clamp((y - shore(x)) / (bank(x) - shore(x)), 0, 1)
  local c = gradient({{0, "#b9ad9f"}, {0.15, "#a9a39c"}, {0.5, "#8f959a"}, {1, "#7d858d"}}, t)
  return shift(c, 0.035*icen(x, y), 0, 0.006*icen(y, x))
end
work(POND, {hand="body", length={30, 90}, coverage=3.4, medium=0.22, angle=function(x, y) return 0.015*icen(x, y*3) end,
  color=icecol, edge="soft"})
-- the far bank's snow, over the pond's edge while it is wet
FARB = below(farbank) * above(function(x) return shore(x) + 1.5 end)
work(FARB:roughen(0.6, 7, 9, 0.3), {hand="body", tool="round 2.5", length={8, 26}, coverage=3.5, medium=0.12, angle=0,
  color=function(x, y) return mix("#d9cabb", "#c3bdbd", smoothstep(farbank(x), shore(x), y)) end, edge={found=0.5, soft=0.4, lost=0.1, period=30, seed=6}})
