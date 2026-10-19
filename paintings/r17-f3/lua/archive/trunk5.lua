local tS = pile{{"bone black",0.8},{"green earth",0.8},{"yellow ochre",0.3},{"lead white",0.35},{"raw umber",0.2}, medium=0.08}
local tuft = pile{{"green earth",1.3},{"yellow ochre",1},{"Prussian blue",0.2},{"raw umber",0.4},{"lead white",0.6}, medium=0.08}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local t = TR2 * ellipse(x, y - 15*s, 12*s + 1, 20*s + 3)
  local sh = t * mask(function(xx,yy) return smoothstep(x + 0.5*s, x + 3*s, xx) end)
  work(sh, {hand="detail", pile=tS, tool={kind="round", width=math.max(0.7, 1.4*s), point=0.4}, angle=math.pi/2, length={2,7}, coverage=2.5, clip=true, fill=true, load=0.9})
  -- underside shadow of crown on the head of the trunk
  local hd = t * mask(function(xx,yy) return smoothstep(y - 24*s, y - 30*s, yy) end)
  work(hd, {hand="detail", pile=tS, tool={kind="round", width=math.max(0.7, 1.4*s), point=0.4}, angle=0, length={2,6}, coverage=2, clip=true, load=0.8})
  -- bark fissures
  if s > 0.3 then
    local r = brush{kind="rigger", width=math.max(0.45, 0.7*s), point=1}
    r:load(tS, 0.5)
    for k=1,math.floor(3 + 4*s) do
      local xx = x + rand(-4.5,3.5)*s
      local y0 = y - rand(1,8)*s
      r:stroke({{xx, y0}, {xx + rand(-0.8,0.8)*s, y0 - rand(6,14)*s}, {xx + rand(-1.2,1.2)*s, y0 - rand(14,22)*s}}, {pressure={0.45,0.1}})
    end
  end
  -- grass tufts over the foot
  local g = brush{kind="rigger", width=math.max(0.5, 1.0*s), point=1}
  g:load(tuft, 0.6)
  for k=1,math.floor(6 + 12*s) do
    local xx = x + rand(-9,9)*s
    local yb = y + rand(0.5, 3)*s
    g:stroke({{xx, yb}, {xx + rand(-2,2)*s, yb - rand(4,10)*s}}, {pressure={0.55,0.0}})
    if g:fullness() < 0.25 then g:reload(tuft, 0.6) end
  end
end
print(wait(0))
