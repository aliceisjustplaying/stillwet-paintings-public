--@ chunk 1
canvas{style="friedrich", aspect=1.4, seed=7}
for _, k in ipairs({"rigger", "round"}) do
  for _, pt in ipairs({0, 1}) do
    local w = k == "rigger" and 0.55 or 3
    local b = brush{kind=k, width=w, point=pt}
    print(k, w, pt, b:mark_width(0), b:mark_width(0.4), b:mark_width(1))
  end
end
