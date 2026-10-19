-- next day: the spire and turret drawn to their points, the two mills
rest(16)
sitting{hours=4}
local dk = "#4a4b5b"
local p = brush{kind="round", width=1.3, point=1}
p:load(dk, 0.8)
-- spire: each flank pulled up from the belfry to the apex, lifting off at the point
for k = 1, 3 do
  p:stroke({{493.2 + 0.4*k, 364}, {496.5 + 0.2*k, 346}, {499.8, 330.5}}, {pressure={0.8, 0.02}, ramps={0.05, 0.8}})
  p:stroke({{506.8 - 0.4*k, 364}, {503.5 - 0.2*k, 346}, {500.2, 330.5}}, {pressure={0.8, 0.02}, ramps={0.05, 0.8}})
end
p:stroke({{500, 362}, {500, 331}}, {pressure={0.7, 0.05}, ramps={0.05, 0.7}})
-- small corner pinnacles on the tower top
for _, x in ipairs({490.8, 509.2}) do p:stroke({{x, 368}, {x, 361.5}}, {pressure={0.55, 0.02}, ramps={0.05, 0.8}}) end
-- the turret of the second church, a thin spike
p:reload(dk, 0.7)
for k = 1, 2 do p:stroke({{576.3 + 0.6*k, 391}, {578, 377}}, {pressure={0.7, 0.02}, ramps={0.05, 0.8}}) end
p:stroke({{580.2, 391}, {578.1, 378}}, {pressure={0.7, 0.02}, ramps={0.05, 0.8}})
-- the mills: a tapered body, a cap, four sails (lattice lost at this distance)
local function mill(M, s, col)
  local body = poly({{M.x - 4.2*s, M.base + 1}, {M.x - 2.6*s, M.top + 1.5*s}, {M.x, M.top - 0.5*s}, {M.x + 2.6*s, M.top + 1.5*s}, {M.x + 4.2*s, M.base + 1}})
  work(body, {hand="detail", tool="round 1", angle=1.57, length={2, 6}, coverage=3.4, medium=0.2, pal=farpal, color=col, edge="firm"})
  local r = brush{kind="round", width=1.0}
  local hx, hy = M.x, M.top + 1.2*s
  local a0 = M.turn
  for k = 0, 3 do
    local a = a0 + k * math.pi / 2
    local L = (13 + rand(-0.8, 0.8)) * s
    r:reload(col, 0.8)
    r:stroke({{hx, hy}, {hx + math.cos(a) * L * 0.5, hy + math.sin(a) * L * 0.5}, {hx + math.cos(a) * L, hy + math.sin(a) * L}},
      {pressure={0.8, 0.6}, ramps={0.02, 0.15}})
    -- the sail cloth: a second, lighter line beside the stock
    local b = a + 0.12
    r:stroke({{hx + math.cos(b) * L * 0.25, hy + math.sin(b) * L * 0.25}, {hx + math.cos(b) * L * 0.95, hy + math.sin(b) * L * 0.95}},
      {pressure={0.55, 0.45}, ramps={0.05, 0.15}})
  end
end
MILL.turn = -0.72; MILL2.turn = -0.35
mill(MILL, 1, "#57586a")
mill(MILL2, 0.72, "#6a6a78")
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
