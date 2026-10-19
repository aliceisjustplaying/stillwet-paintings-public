local b = brush{kind="flat", width=6, stiffness=0.7}
for pass = 1, 2 do
  for x = 874, 1004, 4 do
    b:wipe(1)
    b:stroke({{x + pass*2, 668}, {x + pass*2 + 1, 716}}, {pressure={0.9,0.9}})
  end
  for y = 670, 716, 3 do
    b:wipe(1)
    b:stroke({{872, y + pass}, {1004, y + pass}}, {pressure={0.9,0.9}})
  end
end
