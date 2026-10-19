-- Cover cream blobs, calm the reflection, crisp the post, birds
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

patches = ellipse(180, 1210, 100, 34) + ellipse(420, 1180, 80, 28) + ellipse(700, 1140, 90, 30) + ellipse(880, 1090, 80, 28)
work(patches, {hand="body", pile=spitdark, coverage=2.6, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

-- calm the boat's reflection: blend, then break with water
halo = rect(370, 930, 80, 120)
blend(halo, {coverage=0.9})
refl2 = ribbon({{398, 946}, {404, 985}, {408, 1020}}, {16, 22, 28})
work(refl2, {hand="scumble", pile=watermid, coverage=0.5, angle=0.02, edge=1})

-- crisper post
pb = brush{kind="round", width=8, point=1, stiffness=0.55}
pb:load(postdark, 0.95)
pb:stroke({{594, 1008}, {591, 978}, {589, 950}}, {pressure={0.9, 0.35}, ramps={0.08, 0.4}})

-- birds in the glow gap right of the trees
bird = brush{kind="round", width=6, point=1, stiffness=0.5}
birdpile = pile{{"bone black", 0.6}, {"raw umber", 0.5}, {"cobalt blue", 0.3}, {"lead white", 0.2}}
bird:load(birdpile, 0.95)
birds = {{788, 352}, {826, 366}, {862, 344}, {842, 384}}
for _, p in ipairs(birds) do
  local s = rand(0.8, 1.3)
  bird:stroke({{p[1] - 7 * s, p[2] - 3 * s}, {p[1], p[2]}, {p[1] + 7 * s, p[2] - 4 * s}},
    {pressure={0.55, 0.06}, ramps={0.15, 0.4}})
end
print("tidied, birds in")
