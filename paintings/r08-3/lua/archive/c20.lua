-- snow lying along the upper faces of the oak's level limbs
local snb = brush{kind="round", width=1.2, point=0.8}
local cnt = 0
for _, s in ipairs(oak:wood_strokes{min=1.4}) do
  local run = {}
  for k = 1, #s.pts - 1 do
    local a, b = s.pts[k], s.pts[k + 1]
    local dx, dy = b[1] - a[1], b[2] - a[2]
    local level = math.abs(dy) < 0.6 * math.abs(dx)
    if level then
      local w = s.w[k] or 2
      run[#run + 1] = {a[1], a[2] - 0.42 * w}
    elseif #run >= 2 then
      cnt = cnt + 1
      snb:reload(mix("#c5c2cb", "#ddd3d0", rand()), 0.7)
      snb:stroke(run, {pressure={0.45, 0.2}, ramps={0.2, 0.4}, shake=0.2}); run = {}
    else run = {} end
  end
  if #run >= 2 then cnt = cnt + 1; snb:reload(mix("#c5c2cb", "#ddd3d0", rand()), 0.7); snb:stroke(run, {pressure={0.45, 0.2}, ramps={0.2, 0.4}}) end
end
print(cnt, "snow runs")
