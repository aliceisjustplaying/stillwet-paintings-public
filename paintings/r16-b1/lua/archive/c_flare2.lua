barkLow = pile{{"raw umber", 2.6}, {"bone black", 1.25}, {"green earth", 0.9}, {"lead white", 0.3}, {"red earth", 0.12}, {"Prussian blue", 0.04}, medium=0.1}
local fl = poly({{286, 528}, {283, 545}, {278, 558}, {272, 572}, {273, 590}, {326, 590}, {324, 572}, {321, 558}, {319, 545}, {318, 528}}, true)
local col = fl + (oakM2 * rect(262, 478, 90, 60)) + (rootM2 * rect(240, 540, 120, 50))
work(col, {hand="detail", pile=barkLow, angle=-1.5708, coverage=4, fill=true, clip=true, length={8,20}})
work(col * mask(function(x, y) return x < 292 - (y - 480) * 0.1 and 1 or 0 end), {hand="detail", pile=barkD, angle=-1.5708, coverage=1.5, clip=true, length={8,20}, pressure={0.3,0.6}})
blend(col, {angle=-1.5708, coverage=3, length={30,70}, tool="badger 12", clip=true})
local rim = (col - col:shrink(2)) * mask(function(x, y) return x > 312 and 1 or 0 end) - rect(0, 586, 1000, 30)
work(rim, {hand="detail", pile=barkRim, angle=-1.5708, coverage=1.3, clip=true, length={6,16}, pressure={0.3,0.5}})
local fb = brush{kind="round", width=1.4, point=1}
for _, xs in ipairs({{292, 486, 540}, {303, 500, 575}, {312, 482, 530}, {298, 545, 588}}) do
  fb:load(barkDark, 0.7)
  local pts = {}
  for k = 0, 5 do pts[#pts+1] = {xs[1] + randn(0, 1) + (k/5) * ((xs[1] - 300) * 0.15), lerp(xs[2], xs[3], k/5)} end
  fb:stroke(pts, {pressure={fb:pressure_for(1.0), fb:pressure_for(0.4)}, ramps={0.2, 0.3}})
end
