local b = brush{kind="flat", width=14, stiffness=0.4}
local T = table_top - lemons:grow(1)
for pass = 1, 4 do
  for _, seg in ipairs({{{565,642},{600,648},{660,646}}, {{700,594},{740,597},{780,590}}}) do
    for dy = -3, 3, 3 do
      local pts = {}
      for i, p in ipairs(seg) do pts[i] = {p[1], p[2] + dy} end
      b:stroke(pts, {pressure={0.8,0.8}, clip=T})
      b:wipe(1)
    end
  end
end
