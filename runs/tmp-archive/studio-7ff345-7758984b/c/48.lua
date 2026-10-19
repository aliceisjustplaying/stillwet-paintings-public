-- model the dead limbs: shadowed left flank, grain, splintered broken tops
local deadShade = pile{{"raw umber",1},{"bone black",0.8},{"smalt",0.3},{"lead white",0.5}, medium=0.35}
local grain = pile{{"raw umber",1},{"bone black",0.6},{"lead white",0.8}, medium=0.3}
local r = brush{kind="round", width=4, point=0.8}
local g = brush{kind="rigger", width=0.8, point=1}
for _, k in ipairs({"L3", "L4", "L6"}) do
  local b = oakB[k]
  local left, mid = {}, {}
  for i = 1, #b.pts do
    local p = b.pts[i]
    local q = b.pts[math.min(i + 1, #b.pts)]
    local o = b.pts[math.max(i - 1, 1)]
    local a = math.atan(q[2] - o[2], q[1] - o[1])
    local nx, ny = math.sin(a), -math.cos(a)   -- normal pointing to the left of travel
    if nx > 0 then nx, ny = -nx, -ny end        -- keep it on the canvas-left side
    left[#left+1] = {p[1] + nx * b.w[i] * 0.28, p[2] + ny * b.w[i] * 0.28}
  end
  r:load(deadShade, 0.9)
  local wm = b.w[1] * 0.45
  r:stroke(left, {pressure={r:pressure_for(math.min(wm, 4)), r:pressure_for(b.w[#b.w] * 0.4)}, clip=oakDead})
  for j = 1, 4 do
    g:load(grain, 0.5)
    local off = rand(-0.3, 0.3)
    local pts = {}
    for i = 1, #b.pts do
      local p = b.pts[i]
      pts[#pts+1] = {p[1] + off * b.w[i] + rand(-0.4, 0.4), p[2]}
    end
    g:stroke(pts, {pressure={0.4, 0.1}, ramps={0.2, 0.3}, clip=oakDead})
  end
end
-- splintered tops of L3 and L4: jagged points of bare wood, dark in the break
local sp = poly({{234,82},{237,70},{239,76},{241,64},{244,74},{247,68},{248,82}}) + poly({{316,108},{318,95},{321,101},{324,90},{326,104},{329,108}})
work(sp, {hand="detail", tool={kind="round", width=1.2, point=0.8}, pile=deadwood, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=-math.pi/2})
