dry()
-- the snow drifted up over the stones' feet: one or two pulls each, loaded with the snow beneath
for i, st in ipairs(STONES) do
  local x0, x1, yb = st.pts[1][1], st.pts[#st.pts][1], st.pts[1][2]
  local b = brush{kind="filbert", width=(i == 1) and 10 or 6, stiffness=0.35}
  b:load(sample((x0 + x1) / 2, yb + 10, 4), 0.95, {medium=0.2})
  b:stroke({{x0 - 10, yb + 3.5}, {x0 + 25, yb + 0.5}, {(x0 + x1) / 2 + 10, yb}, {x1 + 8, yb + 2.5}}, {pressure={0.4, 0.75, 0.2}, ramps={0.15, 0.5}, shake=0.8})
  b:reload(shift(sample((x0 + x1) / 2, yb + 10, 4), -0.02, 0, -0.01), 0.8)
  b:stroke({{x1 + 12, yb + 5}, {(x0 + x1) / 2 + 20, yb + 2.5}, {x0 + 10, yb + 4}}, {pressure={0.5, 0.2}, ramps={0.1, 0.6}, shake=0.8})
end
