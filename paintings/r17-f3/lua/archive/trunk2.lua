local tD = pile{{"raw umber",1.2},{"bone black",0.35},{"lead white",0.9},{"pale smalt",0.3},{"green earth",0.3}, medium=0.08}
local tL = pile{{"lead white",2.2},{"raw umber",0.6},{"pale smalt",0.4},{"yellow ochre",0.3}, medium=0.08}
TR2 = nil
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local pts = {{x-6*s, y+1.5}, {x-7.5*s, y+1*s}, {x-6.2*s, y-6*s}, {x-5.6*s, y-18*s}, {x-8*s, y-27*s}, {x-3*s, y-31*s}, {x+3*s, y-30*s}, {x+8.5*s, y-27*s}, {x+6*s, y-18*s}, {x+6*s, y-6*s}, {x+8*s, y+1*s}, {x+6*s, y+1.5}}
  local t = poly(pts, true):roughen(math.max(0.4, 0.8*s), math.max(3, 6*s), 400+i) - CROWN2[i]:shrink(1.5*s)
  TR2 = TR2 and (TR2 + t) or t
  work(t, {hand="detail", pile=tD, tool={kind="round", width=math.max(0.8, 1.8*s), point=0.4}, angle=math.pi/2, length={2,8}, coverage=3, clip=true, fill=true, edge="found"})
  local lit = t * mask(function(xx,yy) return smoothstep(x - 3*s, x - 5.5*s, xx) end)
  work(lit, {hand="detail", pile=tL, tool={kind="round", width=math.max(0.7, 1.2*s), point=0.4}, angle=math.pi/2, length={2,6}, coverage=1.5, clip=true})
  -- bark fissures
  if s > 0.4 then
    local r = brush{kind="rigger", width=0.6, point=1}
    r:load(tD, 0.4)
    for k=1,3 do
      local xx = x + rand(-3,3)*s
      r:stroke({{xx, y - rand(2,6)*s}, {xx + rand(-1,1)*s, y - rand(14,24)*s}}, {pressure={0.4,0.1}})
    end
  end
end
print(wait(0))
