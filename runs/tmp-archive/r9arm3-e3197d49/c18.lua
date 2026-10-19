-- dry grass through the snow, laid over the finished snow in fine upturning strokes
local clumps = {}
local function add(x, y, s) clumps[#clumps + 1] = {x, y, s} end
-- by the stones
add(86, 680, 1.2); add(118, 684, 1.0); add(208, 679, 1.1); add(226, 690, 0.8); add(296, 702, 1.0); add(60, 700, 1.3); add(30, 668, 1.1)
-- along the mound's crest and face, small with distance
for i, x in ipairs(uneven(14, 20, 520, 0.6, 0.5, 181)) do add(x, mound(x) + rand(2, 26), 0.45 + rand(0, 0.25)) end
-- round the cross and in the right foreground
add(590, 612, 0.5); add(612, 613, 0.45); add(574, 616, 0.4)
for i, x in ipairs(uneven(9, 840, 990, 0.6, 0.4, 182)) do add(x, rand(640, 708), 0.8 + rand(0, 0.5)) end
for i, x in ipairs(uneven(6, 380, 560, 0.6, 0.4, 183)) do add(x, rand(660, 710), 0.9 + rand(0, 0.4)) end
local g = brush{kind="rigger", width=0.7, point=1}
local cols = {"#7b6a4c", "#8e7b58", "#5b4e3b", "#a08a62", "#4a4136"}
for i, c in ipairs(clumps) do
  local x, y, s = c[1], c[2], c[3]
  local nb = math.floor(4 + 7 * s * rand(0.6, 1.2))
  local lean = randn(0.15, 0.25)
  for k = 1, nb do
    if k % 3 == 1 then g:reload(cols[1 + (i + k) % #cols], 0.7) end
    local bx = x + randn(0, 2.2 * s)
    local h = (5 + rand(0, 9)) * s
    local a = -1.57 + lean + randn(0, 0.28)
    local bend = randn(0, 0.25)
    local mx, my = bx + math.cos(a) * h * 0.5, y + math.sin(a) * h * 0.5
    local tx, ty = bx + math.cos(a + bend) * h, y + math.sin(a + bend) * h
    g:stroke({{bx, y + rand(0, 1.2)}, {mx, my}, {tx, ty}}, {pressure={clamp(0.35 + 0.35 * s, 0.25, 0.85), 0}, ramps={0.05, 0.7}})
  end
end
print(#clumps, "clumps")
