-- far off on the left, under the glow: the plain's edge as a broken line of low hedges and copses,
-- and a village church, all nearly lost in the air
local hn = noise{seed=193, period=18, octaves=3}
local hedge = mask(function(x, y)
  if x > 560 then return 0 end
  local top = 467 - 4.2 * smoothstep(-0.3, 0.7, hn(x, 0)) - 1.6 * smoothstep(0, 0.8, hn(x * 4, 17)) - 3 * math.exp(-((x - 205) / 16)^2) - 3.5 * math.exp(-((x - 40) / 22)^2)
  local on = smoothstep(-0.3, 0.05, hn(x * 0.7, 40)) * (0.35 + 0.65 * smoothstep(-0.2, 0.3, hn(x * 2.3, 71)))
  return on * smoothstep(top - 0.4, top + 0.4, y) * (1 - smoothstep(467.5, 468.5, y))
end) * (-oak:mask():grow(0.6))
work(hedge, {hand="hatch", tool="round 0.8", length={1, 3}, coverage=1.8, angle=1.45, angle_jitter=0.7, edge="soft", hug=false,
  color=function(x, y) return mix("#9c95a2", "#bab1b4", smoothstep(60, 540, x)) end, medium=0.25})
local tower = rect(124.6, 452.5, 3.4, 15)
local nave = poly({{128, 468}, {128, 461.2}, {133.5, 458.6}, {140.5, 461.4}, {140.5, 468}})
work(tower + nave, {hand="detail", tool="round 0.8", length={1, 3}, coverage=3, angle=1.57, edge="firm", color="#8e8794", medium=0.2})
local sp = brush{kind="round", width=1.6, point=1}
sp:load("#8a8390", 0.9)
sp:stroke({{126.3, 453.2}, {126.3, 449}, {126.3, 443.5}}, {pressure={0.9, 0.0}, ramps={0, 0.95}})
