local keep = rect(505, 0, 16, 700) + rect(762, 0, 9, 700)
local cover = (WATER:grow(1.8) * mask(function(x, y) return x > 336 + 6*math.sin(y) and 1 or 0 end)) - keep
local segs = {
  {336, 480, pile{{"green earth", 2}, {"yellow ochre", 1.3}, {"chrome yellow", 0.18}, {"lead white", 0.95}, {"Prussian blue", 0.03}, medium=0.15}},
  {480, 640, pile{{"green earth", 1.9}, {"yellow ochre", 1.3}, {"chrome yellow", 0.16}, {"lead white", 1.0}, {"Prussian blue", 0.02}, medium=0.15}},
  {640, 820, pile{{"green earth", 1.7}, {"yellow ochre", 1.25}, {"chrome yellow", 0.13}, {"lead white", 1.0}, {"pale smalt", 0.12}, medium=0.15}},
  {820, 1010, pile{{"green earth", 1.6}, {"yellow ochre", 1.2}, {"lead white", 1.0}, {"chrome yellow", 0.1}, {"pale smalt", 0.2}, medium=0.15}},
}
for i,s in ipairs(segs) do
  local m = cover * rect(s[1], 0, s[2]-s[1], 700)
  work(m, {hand="detail", tool={kind="round", width=2.4, point=0.3}, pile=s[3], angle=0, angle_jitter=0.1, coverage=3, fill=true, seed=4600+i})
end
blend(cover:grow(2), {angle=0, length={10,30}, coverage=0.8, seed=4605})
