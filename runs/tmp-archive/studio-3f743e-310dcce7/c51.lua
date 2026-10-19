-- Reflection area unified with the darker water; post firm
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

work(rect(378, 936, 64, 108), {hand="body", pile=waterdeep, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1})

pb = brush{kind="round", width=14, point=1, stiffness=0.55}
pb:load(postdark, 0.95)
pb:stroke({{594, 1012}, {591, 980}, {589, 948}}, {pressure={0.9, 0.4}, ramps={0.08, 0.4}})
print("reflection and post")
