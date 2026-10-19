local pt = pile{{"lead white", 8}, {"smalt", 0.9}, {"pale smalt", 1}, {"cobalt blue", 0.1}, {"yellow ochre", 0.08}, medium=0.2}
work(rect(-10, 245, 1020, 70), {hand="body", tool="flat 12", pile=pt, angle=0, angle_jitter=0.05, length={80,200}, coverage=1.8, fill=true, pressure={0.4,0.7}, seed=301})
for k=1,3 do
  blend(SKY, {angle=0, ruler=true, length={150,400}, coverage=2, seed=310+k})
end
