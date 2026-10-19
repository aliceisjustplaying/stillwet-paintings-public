-- more rods: the crown fuller, a broom, not a few spikes; some older ones bowed outward
local brushes = {}
local function pick(w)
  local key = string.format("%.1f", math.max(0.6, math.floor(w * 5 + 0.5) / 5))
  if not brushes[key] then brushes[key] = brush{kind="round", width=tonumber(key), point=1} end
  return brushes[key]
end
local added = 0
for k, kn in ipairs(KNOBS) do
  for i = 1, math.random(9, 14) do
    local a = kn[4] + randn(0, kn[5] * 1.3)
    local len = rand(120, 300) * (1 - 0.28 * math.abs(a + 1.57))
    local x0, y0 = kn[1] + rand(-7, 7), kn[2] + rand(-3, 4)
    local bow = randn(0, 0.12) + 0.08 * (a + 1.57)
    local pts = {{x0, y0}}
    local ax = a
    for s = 1, 6 do
      ax = ax + bow / 6 + randn(0, 0.02)
      pts[#pts + 1] = {pts[#pts][1] + math.cos(ax) * len / 6, pts[#pts][2] + math.sin(ax) * len / 6}
    end
    local ok = pts[#pts][2] < y0 - 40
    for _, p in ipairs(pts) do if p[2] > y0 + 2 then ok = false end end
    if ok then
    local w = clamp(len / 110, 0.8, 2.4) * rand(0.8, 1.15)
    local b = pick(w * 0.75)
    b:reload(rand() < 0.4 and RODP.old or (rand() < 0.6 and RODP.mid or RODP.young), rand(0.6, 0.85))
    b:stroke(pts, {pressure={rand(0.7, 0.9), rand(0.2, 0.35), 0}, ramps={0.03, rand(0.25, 0.4)}, shake=0.25})
    RODS[#RODS + 1] = {pts = pts, len = len, w = w, depth = 3}
    added = added + 1
    end
  end
end
print(added, #RODS)
local t = timesheet(); print(t.sitting)
