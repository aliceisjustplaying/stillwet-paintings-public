-- a row of firs standing at the water in front of the wooded slope, so the slope doesn't end in a line of
-- spire bottoms: fir_wood along the waterline, two rows, dark, the back row a little aired
FRONTTOP = {{-10,352},{40,334},{80,360},{120,346},{165,372},{205,366},{245,392},{280,404},{310,430},{326,452}}
front = fir_wood{skyline=outline{pts=FRONTTOP, open=true, char="soft", lobe=12, seed=61},
  foot={{-10, PWL(-10) - 1}, {160, PWL(160) - 1}, {330, PWL(330) - 1}}, depth=2, count=11, horizon=HZ, seed=62}
print(front)
local air = "#5a6064"
local function row(r)
  local h, s, nd = front:haze(r), front:scale(r), front:needles(r)
  work(nd, {hand="hatch", tool=string.format("round %.1f", math.max(0.9, 1.7*s)), length={2, 6*s + 1}, coverage=2.5,
    clip=nd, angle=1.57, angle_jitter=0.5, color=mix("#1a1f1b", air, 0.5*h), medium=0.2})
  local rb = brush("rigger", math.max(0.6, 1.3*s))
  for n, f in ipairs(front:trees(r)) do
    if n % 5 == 1 then rb:reload(mix("#1c1a17", air, 0.5*h), 0.85) end
    rb:stroke(f.leader.pts, {pressure={0.9, 0.2}, ramps={0.02, 0.3}})
  end
  front:paint(brush("round", 1.9*s + 0.3), r, {color=mix("#141916", air, 0.5*h), lit={0, 0.7}})
  front:paint(brush("round", 1.5*s + 0.3), r, {color=mix("#262d2b", air, 0.4*h), lit={0.7, 1}, every=9})
end
row(2)
row(1)
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))
