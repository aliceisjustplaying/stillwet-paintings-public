-- Marry patch edges into horizontal streaks
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}
darker = pile{{"lead white", 0.7}, {"cobalt blue", 1.05}, {"raw umber", 0.55}, {"bone black", 0.45}, {"green earth", 0.3}, {"vermilion", 0.08}}
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}

for _, band in ipairs({rect(0, 826, 266, 30), rect(0, 940, 266, 30)}) do
  work(band, {hand="scumble", pile=watermid3, coverage=0.8, angle=0.0, edge=1})
  work(band, {hand="scumble", pile=darker, coverage=0.5, angle=0.0, edge=1})
  blend(band, {coverage=0.8})
end
for _, band in ipairs({rect(296, 712, 235, 26), rect(296, 996, 235, 26), rect(292, 760, 24, 260), rect(517, 760, 20, 260)}) do
  work(band, {hand="scumble", pile=watermid3, coverage=0.7, angle=0.0, edge=1})
  work(band, {hand="scumble", pile=darker, coverage=0.4, angle=0.0, edge=1})
  blend(band, {coverage=0.7})
end

-- bank top patch where the slate spilled
bp = ellipse(400, 1005, 60, 18) + ellipse(430, 1012, 40, 14)
work(bp, {hand="body", pile=spitdark, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.4, clip=true})
print("edges married")
