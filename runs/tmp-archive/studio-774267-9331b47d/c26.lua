-- subtle field patches in the far and middle meadows: thin scumbles of slightly different greens and golds
local sets = {
  {{"lead white", 2.5}, {"green earth", 1.2}, {"pale smalt", 0.6}, {"yellow ochre", 0.3}},
  {{"lead white", 2}, {"yellow ochre", 1.2}, {"chrome yellow", 0.12}, {"green earth", 0.4}},
  {{"lead white", 1.5}, {"green earth", 1.5}, {"yellow ochre", 0.7}, {"Prussian blue", 0.02}},
  {{"lead white", 2}, {"yellow ochre", 0.8}, {"red earth", 0.15}, {"raw umber", 0.15}},
}
local rows = {{398,404},{404,411},{411,419},{419,428},{428,439},{439,452},{452,467}}
local k = 0
for i,r in ipairs(rows) do
  local xs = uneven(3 + (i % 3), 0, 1000, 0.9, 0.3, 2600+i)
  local prev = -30
  table.insert(xs, 1030)
  for j,x in ipairs(xs) do
    k = k + 1
    if (k % 3) ~= 0 then
      local s = sets[(k*5 + i) % 4 + 1]
      local t = (i-1)/6
      local ps = {}
      for _,c in ipairs(s) do ps[#ps+1] = {c[1], c[2]} end
      ps[#ps+1] = {"lead white", 1.5*(1-t)+0.01}
      ps[#ps+1] = {"pale smalt", 0.6*(1-t)+0.01}
      ps.medium = 0.45
      local sl = rand(-1, 1)
      local x0, x1 = prev, x
      local m = mask(function(px, py) local l = x0 + (py-r[1])*sl; local rr = x1 + (py-r[1])*sl; return (py >= r[1] and py < r[2] and px >= l and px < rr) and 1 or 0 end) * LAND
      work(m, {hand="scumble", tool={kind="flat", width=2 + t*4}, pile=pile(ps), angle=0, angle_jitter=0.05, length={10,30}, coverage=1.1, pressure={0.25,0.45}, load=0.5, clip=true, seed=2600+k})
    end
    prev = x
  end
end
print(k)
