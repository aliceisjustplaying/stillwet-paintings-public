-- water: a thin veil to lower its value and cool it, heavier toward the near left
local veil = pile{{"lead white", 1.4}, {"pale smalt", 1.1}, {"smalt", 0.5}, {"raw umber", 0.12}, medium=0.4}
work(LWATER, {hand="detail", tool={kind="round", width=2, point=0.3}, pile=veil, angle=-0.1, coverage=1.6, fill=true, seed=6501})
-- reflections of the trunks, dark, broken by ripples
local refl = pile{{"raw umber", 0.8}, {"green earth", 0.7}, {"bone black", 0.15}, {"pale smalt", 0.4}, {"lead white", 0.2}, medium=0.12}
local rb = brush{kind="round", width=1.3, point=0.5}
for wi, w in ipairs(WILLOWS) do
  local sy, sw = STREAMY(w.x)
  local s = w.h/60
  rb:load(refl, 0.6)
  local x0 = w.x - 3.5*s
  local x1 = w.x + 3.5*s
  local y = sy - sw/2 + 0.2
  while y < sy + sw/2 do
    local jit = rand(-0.8, 0.8)
    rb:stroke({{x0 + jit, y}, {x1 + jit + rand(-0.5, 1), y + rand(-0.1, 0.1)}}, {pressure={0.4, 0.3}, clip=LWATER})
    y = y + rand(0.6, 1.1)
  end
  -- the crown's reflection just tinges the water to the right of each trunk
  rb:load(refl, 0.25)
  rb:stroke({{w.x + 4*s, sy + sw*0.2}, {w.x + 12*s, sy + sw*0.25}}, {pressure={0.3, 0.1}, clip=LWATER})
end
-- trunks: grayer, darker bark, a knobbly head
local bark = pile{{"raw umber", 0.9}, {"bone black", 0.25}, {"lead white", 0.35}, {"pale smalt", 0.2}, medium=0.1}
local barkl = pile{{"lead white", 1.2}, {"raw umber", 0.5}, {"yellow ochre", 0.35}, {"pale smalt", 0.15}, medium=0.1}
for wi, w in ipairs(WILLOWS) do
  local s = w.h/60
  work(w.trunk - w.crown, {hand="detail", tool={kind="round", width=1.1, point=0.6}, pile=bark, angle=math.pi/2, coverage=2.2, fill=true, seed=6510+wi})
  local lx = w.x - 3.5*s
  work((w.trunk - w.crown) * rect(lx - 3, 0, 3.2*s + 1, 700), {hand="detail", tool={kind="round", width=0.8, point=0.6}, pile=barkl, angle=math.pi/2, coverage=1.3, seed=6520+wi})
  -- knobs at the head
  local knob = ellipse(w.hx - 2.5*s, w.hy - 1.5*s, 2.6*s, 2*s) + ellipse(w.hx + 2.8*s, w.hy - 1.8*s, 2.4*s, 1.9*s)
  work(knob, {hand="detail", tool={kind="round", width=0.9, point=0.6}, pile=bark, angle=0, coverage=2, fill=true, seed=6530+wi})
end
