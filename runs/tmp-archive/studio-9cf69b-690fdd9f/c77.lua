local b = brush{kind="flat", width=8, stiffness=0.6}
for pass = 1, 3 do
  for y = 672, 716, 5 do
    b:wipe(1)
    b:stroke({{876, y + pass}, {940, y + pass + 0.5}}, {pressure={0.8,0.8}})
    b:wipe(1)
    b:stroke({{936, y + pass}, {1004, y + pass + 0.5}}, {pressure={0.8,0.8}})
  end
end
print(b:fullness())
