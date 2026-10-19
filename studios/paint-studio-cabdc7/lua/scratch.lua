-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.35, um=45}, {apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.5}}, texture=0.5, um=40}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.3}}, um=55}}, linen={14, 16}, seed=11, size=1200}

--@ chunk 2
-- scratch test: does a long single gesture leave pale bands? chunked vs single
local bg = pile{{"lead white", 2}, {"pale smalt", 1}, {"raw umber", 0.3}, turps=0.5}
work(rect(0, 300, 1000, 414), {hand="body", pile=bg, coverage=1.5, fill=true, angle=0})
local dk = pile{{"raw umber", 2}, {"bone black", 1.1}}

local function ramp(pts, p0)
  local g = {}
  for i, pt in ipairs(pts) do
    local t = (i - 1) / math.max(1, #pts - 1)
    g[i] = {pt[1], pt[2], p0 * (1 - 0.87 * t)}
  end
  return g
end
-- single long gesture (like the original trunk/limb strokes)
local p1 = {{80, 340}, {140, 352}, {200, 372}, {260, 400}, {320, 436}, {380, 478}}
local b1 = brush{kind="round", width=11, point=0.85, stiffness=0.55}
b1:load(dk, 1.0)
b1:gesture(ramp(p1, 0.9), {wobble=2})
-- same path, chunked with a fresh full load per chunk
local p2 = {{80, 560}, {140, 572}, {200, 592}, {260, 620}, {320, 656}, {380, 698}}
local b2 = brush{kind="round", width=11, point=0.85, stiffness=0.55}
for c = 1, 3 do
  b2:reload(dk, 1.0)
  local pts = {}
  local i0 = 1 + (c - 1) * 2
  for i = i0, math.min(#p2, i0 + 2) do pts[#pts + 1] = p2[i] end
  b2:gesture(ramp(pts, 0.9), {wobble=2})
end
-- a third: long gesture with lay=3 (more paint per full brush)
local p3 = {{560, 340}, {620, 352}, {680, 372}, {740, 400}, {800, 436}, {860, 478}}
local b3 = brush{kind="round", width=11, point=0.85, stiffness=0.55, lay=3}
b3:load(dk, 1.0)
b3:gesture(ramp(p3, 0.9), {wobble=2})
-- a fourth: chunked with lay=3
local p4 = {{560, 560}, {620, 572}, {680, 592}, {740, 620}, {800, 656}, {860, 698}}
local b4 = brush{kind="round", width=11, point=0.85, stiffness=0.55, lay=3}
for c = 1, 3 do
  b4:reload(dk, 1.0)
  local pts = {}
  local i0 = 1 + (c - 1) * 2
  for i = i0, math.min(#p4, i0 + 2) do pts[#pts + 1] = p4[i] end
  b4:gesture(ramp(pts, 0.9), {wobble=2})
end
print("stroke test laid")
