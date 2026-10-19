-- the rods: each drawn from its knob to the tip with a pointed brush, tapering; three piles
RODP = {old="#2c2521", mid="#3a2c26", young="#4e3629"}
-- a crop of thin young shoots among the rods, short and upright
for k, kn in ipairs(KNOBS) do
  for i = 1, math.random(9, 13) do
    local a = -1.57 + 0.55 * (kn[4] + 1.57) + randn(0, 0.3)
    local len = rand(35, 110)
    local x0, y0 = kn[1] + rand(-6, 6), kn[2] + rand(-2, 4)
    local pts = {{x0, y0}}
    local ax = a
    for s = 1, 4 do ax = ax + randn(0, 0.04); pts[#pts + 1] = {pts[#pts][1] + math.cos(ax) * len / 4, pts[#pts][2] + math.sin(ax) * len / 4} end
    RODS[#RODS + 1] = {pts = pts, len = len, w = rand(0.7, 1.1), depth = 2}
  end
end
print(#RODS)
local brushes = {}
local function pick(w)
  local key = string.format("%.1f", math.max(0.6, math.floor(w * 5 + 0.5) / 5))
  if not brushes[key] then brushes[key] = brush{kind="round", width=tonumber(key), point=1} end
  return brushes[key]
end
for i, r in ipairs(RODS) do
  local b = pick(r.w * 0.75)
  local c = r.depth == 2 and RODP.young or (r.len > 200 and RODP.old or (rand() < 0.5 and RODP.mid or RODP.young))
  b:reload(c, rand(0.6, 0.85))
  b:stroke(r.pts, {pressure={rand(0.7, 0.9), rand(0.2, 0.35), 0}, ramps={0.03, rand(0.25, 0.4)}, shake=0.25})
end
local t = timesheet(); print(t.sitting)
