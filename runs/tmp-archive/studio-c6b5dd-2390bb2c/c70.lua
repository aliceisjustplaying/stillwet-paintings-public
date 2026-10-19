local b = brush{kind="flat", width=6}
for _, x0 in ipairs({295, 335, 342}) do
  for _, y in ipairs({473, 476}) do
    b:reload(pR1, 1.0)
    b:stroke({{x0, y}, {x0+30, y}}, {pressure={0.9,0.9}, orient="across"})
  end
end
