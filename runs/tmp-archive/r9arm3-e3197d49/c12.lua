dry()
-- snow drifted against the feet: each pull loaded with the snow beside it, a touch lighter on the heap's top
local function drag(pts, w, dL, p)
  local x0, y0 = pts[1][1], pts[1][2]
  local base = sample(x0, y0 + 4, 3)
  local b = brush{kind="filbert", width=w, stiffness=0.35}
  b:load(shift(base, dL or 0, 0, 0), 0.9, {medium=0.2})
  b:stroke(pts, {pressure=p or {0.55, 0.15}, ramps={0.15, 0.6}, shake=0.8})
end
for k = 0, 5 do   -- the oak: banked higher on the windward left
  local y = 553 - k * 1.6 + rand(-0.8, 0.8)
  drag({{262 + 6 * k + rand(-3, 3), y + 3}, {292 + 3 * k, y - 1.5}, {316 + rand(-2, 2), y - 2 + 0.5 * k}, {348 - 2 * k, y + 2.5}}, rand(3.5, 5.5), 0.005 * k)
end
drag({{352, 559}, {336, 555.5}, {326, 552.8}}, 3.5, -0.03, {0.5, 0.1})
for k = 0, 2 do   -- the cross
  local y = 609.5 - k * 1.2
  drag({{584 + 3 * k, y + 1}, {596, y - 1.8}, {603, y - 1.5}, {612 - 2 * k, y + 1}}, rand(2.5, 3.5), 0.004 * k)
end
drag({{693, 619.6}, {698, 617.6}, {703, 618}}, 1.8, 0, {0.5, 0.2})    -- the walker's boots
drag({{704.5, 617.4}, {709, 615.8}, {712.5, 616.6}}, 1.6, 0, {0.5, 0.2})
drag({{713, 620.4}, {716.5, 618.8}, {719.5, 619.8}}, 1.5, 0, {0.45, 0.2})
