grassdark = pile{{"bone black", 0.5}, {"raw umber", 0.65}, {"cobalt blue", 0.2}, {"green earth", 0.25}, {"lead white", 0.2}}
g = brush{kind="rigger", width=2.2, point=1, stiffness=0.45}
print("fullness after load:", g:fullness())
g:load(grassdark, 0.9)
print("fullness after load:", g:fullness())
g:stroke({{500, 1100}, {505, 1080}, {508, 1060}}, {pressure={0.65, 0.03}, ramps={0.12, 0.45}})
print("mark width:", g:mark_width(0.65))
