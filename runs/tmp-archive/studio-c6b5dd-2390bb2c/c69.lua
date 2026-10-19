local b = brush{kind="flat", width=7}
for i, y in ipairs({471, 475, 478}) do
  b:reload(pR1, 0.95)
  b:stroke({{285, y}, {340, y+rand(-0.5,0.5)}, {390, y}}, {pressure={0.8,0.7}, orient="across"})
  b:reload(pR1, 0.95)
  b:stroke({{380, y}, {420, y+rand(-0.5,0.5)}, {462, y}}, {pressure={0.8,0.7}, orient="across"})
end
