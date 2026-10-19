dry()
-- two stones pushing through the snow, painted by hand: dark body, a snow cap, snow over the base
STONES = {
  {pts={{92,678},{98,662},{116,649},{146,642},{174,646},{198,657},{214,676}}, cap={{100,660},{120,647.5},{146,641.5},{172,645},{190,652}}, lean=0.2},
  {pts={{236,700},{244,689},{258,683},{276,684},{290,700}}, cap={{245,688},{258,682.5},{274,683}}, lean=0.1},
}
local shade = noise{seed=171, period=9, octaves=3}
for i, st in ipairs(STONES) do
  local m = poly(st.pts, true):roughen(1.0, 8, 170 + i, 0.4)
  local x0, x1 = st.pts[1][1], st.pts[#st.pts][1]
  work(m, {hand="body", tool="filbert 2.5", length={4, 10}, coverage=3.4, medium=0.18, edge="firm",
    angle=function(x, y) return 1.2 + 0.9 * (x - (x0 + x1) / 2) / (x1 - x0) + 0.3 * shade(x, y) end,
    color=function(x, y)
      local t = (x - x0) / (x1 - x0)
      local c = mix("#6c675f", "#3c3c44", smoothstep(0.15, 0.7, t))
      return mix(c, "#2e2e34", 0.35 * smoothstep(0.2, 0.7, shade(x, y)))
    end})
  -- the cap: long pulls along the top, heavy in the middle, cool where it turns away
  local b = brush{kind="filbert", width=(i == 1) and 5.5 or 3.5, stiffness=0.4}
  b:load("#d8d3cc", 0.95, {medium=0.1})
  b:stroke(st.cap, {pressure={0.55, 0.85, 0.3}, ramps={0.2, 0.45}, shake=0.8})
  b:reload("#c3c3cc", 0.8)
  local tail = {}
  for k = math.max(1, #st.cap - 2), #st.cap do tail[#tail + 1] = {st.cap[k][1] + 2, st.cap[k][2] + 1.5} end
  tail[#tail + 1] = {st.pts[#st.pts - 1][1] + 2, st.pts[#st.pts - 1][2] + 2}
  b:stroke(tail, {pressure={0.5, 0.2}, ramps={0.1, 0.6}, shake=0.8})
end
