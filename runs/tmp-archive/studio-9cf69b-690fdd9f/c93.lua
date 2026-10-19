local b = brush{kind="flat", width=4, stiffness=0.7}
for pass=1,2 do
  for x = 190, 217, 2 do
    b:wipe(1)
    b:stroke({{x+pass*0.7, 358}, {x+pass*0.7+1, 385}}, {pressure={0.9,0.9}})
  end
end
