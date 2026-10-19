local ys = {0, 45, 90, 135, 180, 225, 265}
for i=1,#ys-1 do
  local t = (i-1)/(#ys-2)
  local p = pile{{"lead white", lerp(1.6, 5, t)}, {"smalt", lerp(3, 1.2, t)}, {"cobalt blue", lerp(1.4, 0.2, t)}, {"pale smalt", 0.8}, {"Prussian blue", 0.04*(1-t)+0.001}, medium=0.2}
  local m = rect(-10, ys[i]-4, 1020, ys[i+1]-ys[i]+8)
  work(m, {hand="body", tool="flat 12", pile=p, angle=0, angle_jitter=0.05, length={80,200}, coverage=2.2, fill=true, pressure={0.5,0.8}, seed=200+i})
end
