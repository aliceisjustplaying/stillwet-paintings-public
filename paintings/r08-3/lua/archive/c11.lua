firs = {}
local specs = {{268, 150, 44, "spire", 41}, {318, 96, 32, "young", 42}, {236, 70, 24, "young", 43}, {352, 58, 20, "old", 44}}
for i, s in ipairs(specs) do
  local x, h, wd, habit, sd = s[1], s[2], s[3], s[4], s[5]
  local fy = bankY(x) + 5
  firs[i] = fir{x=x, y=fy, height=h, width=wd, habit=habit, seed=sd, sun={0.55, -0.15, -0.6}, gap=0.22, pad=0.85, droop=1.2}
  print(firs[i])
end
firpal = pal:only{"lead white", "smalt", "yellow ochre", "raw umber", "bone black"}
for i = #firs, 1, -1 do
  local f = firs[i]
  local nd = f:needles()
  work(nd, {hand="hatch", tool="round 0.9", length={2, 5}, coverage=1.6, clip=nd, pal=firpal,
    angle=function(x, y) return 1.57 + 0.5 * clamp((f.foot[1] - x) / 10, -1, 1) end, color="#1e2524"})
  local st = brush{kind="round", width=math.max(1.2, f.hatch * 1.6), point=0.6}
  st:load("#211f1d", 0.9)
  st:stroke(f.leader.pts, {pressure={0.9, 0.05}, ramps={0.01, 0.5}, shake=0.4})
  local rb = brush("rigger", 0.9)
  for k, b in ipairs(f.boughs) do
    if k % 6 == 1 or b.dead then rb:reload(b.dead and "#5d5853" or "#1c1f1e", 0.8) end
    rb:stroke(b.pts, {pressure={0.6, 0.05}, ramps={0.05, 0.6}})
  end
  local hb = brush{kind="round", width=math.max(0.6, f.hatch), point=0.7}
  f:paint(hb, {color="#171d1c", lit={0, 0.5}})
  f:paint(hb, {color="#2e3632", lit={0.5, 0.75}})
  f:paint(hb, {color="#5a5f5c", lit={0.75, 1}, every=6})
  -- snow lying along the upper faces of some boughs
  local sb = brush{kind="round", width=math.max(0.7, f.hatch * 1.1), point=0.5}
  local k = 0
  for _, s in ipairs(f:strokes{kind="top"}) do
    k = k + 1
    if k % 3 ~= 0 then
      if k % 9 == 1 then sb:reload(mix("#c3c2cf", "#dcd5d3", rand()), 0.7) end
      sb:stroke(s.pts, {pressure={0.55, 0.1}, ramps={0.1, 0.5}})
    end
  end
end
