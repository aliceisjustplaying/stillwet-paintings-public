-- dry grass and sedge through the snow: fine upturning strokes laid last over the snow
local gb = brush{kind="rigger", width=0.9, point=1}
local gf = brush{kind="rigger", width=0.55, point=1}
local GRASS = {"#4d4337", "#5b4f3f", "#6a5b45", "#433a32", "#7a6a4e", "#504740"}
function tuft(x, y, h, n, lean, seed)
  for i = 1, n do
    local b = (rand() < 0.3) and gb or gf
    if b:fullness() < 0.35 or rand() < 0.15 then b:reload(mix(GRASS[math.random(#GRASS)], "#8e9098", rand(0, 0.2)), rand(0.6, 0.9)) end
    local bx = x + randn(0, h*0.12)
    local a = -math.pi/2 + lean + randn(0, 0.28)
    local L = h * rand(0.45, 1.05)
    local bend = randn(0.12, 0.18) * ((a > -math.pi/2) and 1 or -1)
    local p = {{bx, y + rand(0, 1.5)}}
    for k = 1, 3 do
      local aa = a + bend*(k/3)^1.6
      p[#p+1] = {p[#p][1] + L/3*math.cos(aa), p[#p][2] + L/3*math.sin(aa)}
    end
    b:stroke(p, {pressure={clamp(0.35 + h/60, 0.3, 0.95), 0}, ramps={0.03, rand(0.55, 0.85)}, shake=0.3})
  end
end
-- near left corner: a big clump and a few smaller ones
local spots = {{40, 692, 78, 60}, {84, 704, 60, 44}, {14, 664, 52, 34}, {126, 710, 44, 26}, {168, 680, 30, 16}, {58, 640, 30, 14},
  {226, 700, 22, 10}, {930, 704, 70, 52}, {972, 676, 58, 40}, {884, 692, 36, 20}, {992, 636, 40, 22}, {846, 710, 28, 14}, {790, 690, 18, 8}}
for i, s in ipairs(spots) do tuft(s[1], s[2], s[3], s[4], randn(0.05, 0.12), 170 + i) end
-- along the crest of the bank, small and sparse, leaving the middle clear
for i = 1, 26 do
  local x = (i <= 13) and rand(10, 380) or rand(730, 995)
  local y = bank(x) + rand(2, 12)
  tuft(x, y, rand(9, 20), math.random(4, 9), randn(0.08, 0.1), 200 + i)
end
-- reeds at the far shore's edge, a hazed thin fringe
local rf = brush{kind="rigger", width=0.45, point=1}
for i = 1, 70 do
  local x = rand(420, 1000)
  if i % 6 == 1 then rf:reload(mix("#8a7c68", "#b8b0a8", 0.35), 0.7) end
  local y = shore(x) + rand(0.5, 2.5)
  rf:stroke({{x, y}, {x + randn(0.3, 0.4), y - rand(3, 7)}}, {pressure={0.35, 0}, ramps={0.05, 0.7}})
end
