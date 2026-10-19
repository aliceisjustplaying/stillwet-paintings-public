-- the near foreground: denser stubble and dry stalks along the bottom, thicker in the corners
local g = brush{kind="rigger", width=0.8, point=1}
local cols = {"#6d5d43", "#8a7654", "#4d4337", "#9c8660", "#3f372f", "#7c6c50"}
local n = 0
local xs = uneven(46, 0, 1000, 0.7, 0.6, 211)
for i, x in ipairs(xs) do
  local corner = math.max(1 - smoothstep(0, 340, x), smoothstep(780, 1000, x))
  if rand() < 0.35 + 0.65 * corner then
    local y = 714 - rand(0, 14 + 22 * corner)
    local s = 1.0 + 0.8 * corner * rand(0.5, 1.2)
    local nb = math.floor((6 + 16 * corner) * rand(0.6, 1.2))
    local lean = randn(0.2, 0.25)
    for k = 1, nb do
      if k % 3 == 1 then g:reload(cols[1 + (i * 3 + k) % #cols], 0.75) end
      local bx = x + randn(0, 3 * s)
      local h = (6 + rand(0, 12)) * s
      local a = -1.57 + lean + randn(0, 0.3)
      local bend = randn(0.05, 0.3)
      g:stroke({{bx, y + rand(0, 2)}, {bx + math.cos(a) * h * 0.5, y + math.sin(a) * h * 0.5},
        {bx + math.cos(a + bend) * h, y + math.sin(a + bend) * h}}, {pressure={clamp(0.45 + 0.25 * s, 0.3, 0.95), 0}, ramps={0.05, 0.7}})
      n = n + 1
    end
  end
end
-- a few seed heads and bent-over stalks, and two bramble arcs in the left corner
local br = brush{kind="rigger", width=1.0, point=0.8}
br:load("#3c322b", 0.85)
br:stroke({{36, 712}, {44, 690}, {60, 680}, {76, 684}, {84, 694}}, {pressure={0.7, 0.1}, ramps={0.05, 0.6}, shake=0.8})
br:stroke({{58, 713}, {70, 696}, {90, 690}, {102, 697}}, {pressure={0.6, 0.05}, ramps={0.05, 0.6}, shake=0.8})
br:reload("#4a3d33", 0.8)
br:stroke({{930, 713}, {938, 694}, {952, 686}, {968, 690}}, {pressure={0.6, 0.05}, ramps={0.05, 0.6}, shake=0.8})
print(n, "stalks")
