-- bare ice swept clear of snow: long thin darker streaks, reflecting the gray upper sky
local sw = noise{seed=113, period=110, octaves=4, stretch={0.0, 10}, warp={60, 6}}
local clear = (pond:shrink(2) * mask(function(x, y) return smoothstep(0.12, 0.45, sw(x, y)) * smoothstep(466, 490, y) end)):blur(1.2)
glaze(clear, {color="#8d90a8", coats=0.22})
-- reeds and rushes along the near shore and at the pond's two ends, dry and pale where lit, dark against the ice
reedpal = pal:only{"lead white", "raw umber", "yellow ochre", "bone black", "red earth"}
local rb = brush{kind="rigger", width=0.7, point=1}
local clumps = {{338, 500, 22}, {372, 507, 14}, {455, 514, 18}, {690, 522, 10}, {845, 518, 20}, {935, 509, 16}, {985, 500, 12}, {312, 474, 10}, {952, 472, 14}}
for ci, cl in ipairs(clumps) do
  local cx, cy, n = cl[1], cl[2], cl[3]
  local scale = 0.6 + 0.6 * smoothstep(465, 525, cy)
  for k = 1, n do
    local x = cx + randn(0, 7 * scale); local y = cy + rand(-1.5, 2.5)
    local h = rand(6, 16) * scale
    local lean = randn(0.1, 0.25)
    if k % 4 == 1 then rb:reload(mix("#4a4036", "#8a7a60", rand() ^ 1.5), 0.7) end
    local tip = {x + lean * h, y - h}
    local bend = (rand() < 0.15)
    if bend then tip = {x + lean * h + h * 0.5, y - h * 0.6} end
    rb:stroke({{x, y}, {x + lean * h * 0.35, y - h * 0.55}, tip}, {pressure={clamp(0.35 + 0.4 * scale, 0.3, 0.8), 0}, ramps={0.05, 0.7}})
  end
end
