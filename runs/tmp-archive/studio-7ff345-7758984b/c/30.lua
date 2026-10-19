-- leaders: a thin spire above each spruce, with the last small whorl
local r = brush{kind="round", width=2, point=1}
for _, s in ipairs(spruces) do
  local top = s.base - s.h
  r:load(spruceP, 0.8)
  r:stroke({{s.cx + 0.3, top + 8}, {s.cx, top - 1}, {s.cx - 0.2, top - 7}}, {pressure={0.8, 0.02}, ramps={0, 0.7}})
  for _, side in ipairs({-1, 1}) do
    r:stroke({{s.cx, top + 1}, {s.cx + side * 3, top + 2.5}}, {pressure={0.5, 0.05}})
    r:stroke({{s.cx, top + 5}, {s.cx + side * 4.5, top + 7}}, {pressure={0.6, 0.05}})
  end
end
