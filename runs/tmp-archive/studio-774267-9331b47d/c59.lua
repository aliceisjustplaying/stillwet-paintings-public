local hay = pile{{"yellow ochre", 1.4}, {"lead white", 0.8}, {"raw umber", 0.25}, {"green earth", 0.15}, medium=0.08}
local haylit = pile{{"lead white", 1.5}, {"yellow ochre", 1}, {"chrome yellow", 0.1}, {"red earth", 0.05}, medium=0.08}
local hayshade = pile{{"raw umber", 0.8}, {"yellow ochre", 0.6}, {"green earth", 0.4}, {"pale smalt", 0.2}, {"lead white", 0.2}, medium=0.1}
local cast = pile{{"green earth", 1.3}, {"raw umber", 0.7}, {"Prussian blue", 0.06}, {"yellow ochre", 0.3}, medium=0.3}
HAY = {}
local spots = {{712,449},{748,452},{786,447},{822,455},{858,450},{905,457},{945,452},{770,462},{840,468},{690,462},{960,466},{620,455}}
for i,s in ipairs(spots) do
  local x, y = s[1], s[2]
  local sc = (y - 392)/60
  local H = 7.5*sc*rand(0.9, 1.1)
  local Wd = H*1.25
  local m = poly({{x - Wd/2, y}, {x - Wd*0.42, y - H*0.55}, {x - Wd*0.2, y - H*0.92}, {x, y - H}, {x + Wd*0.2, y - H*0.92}, {x + Wd*0.42, y - H*0.55}, {x + Wd/2, y}}, true):roughen(0.35, 2, 100 + i)
  HAY[#HAY+1] = {x=x, y=y, H=H, W=Wd, m=m}
  local sh = poly({{x, y - 0.3}, {x + Wd*0.5, y - 0.8}, {x + Wd*1.6, y - 0.2}, {x + Wd*1.5, y + 0.9}, {x, y + 0.9}}, true)
  work(sh, {hand="detail", tool={kind="round", width=0.9, point=0.6}, pile=cast, angle=0, coverage=2, fill=true, seed=5900+i})
  work(m, {hand="detail", tool={kind="round", width=0.9, point=0.6}, pile=hay, angle=math.pi/2, coverage=3, fill=true, seed=5920+i})
  work(m * rect(x + Wd*0.08, 0, Wd, 700), {hand="detail", tool={kind="round", width=0.8, point=0.6}, pile=hayshade, angle=math.pi/2, coverage=1.6, fill=true, seed=5940+i})
  work(m * rect(x - Wd, 0, Wd*0.72, 700) * rect(0, y - H, 2000, H*0.75), {hand="detail", tool={kind="round", width=0.7, point=0.6}, pile=haylit, angle=math.pi/2 + 0.3, coverage=1.3, seed=5960+i})
end
