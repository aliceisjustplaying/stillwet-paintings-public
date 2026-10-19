local g = pile{{"raw umber",1},{"green earth",0.8},{"pale smalt",0.15},{"bone black",0.05}, medium=0.7}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local function cx(yy) return x0 + t.lean*(y0-yy) end
  local m = PWTR[i]
  -- a thin glaze all over, heavier to the right and toward the foot
  local mm = m * mask(function(xx,yy) local v = (y0-yy)/H; return 0.45 + 0.55*smoothstep(cx(yy) - 0.04*H, cx(yy) + 0.05*H, xx) end)
  work(mm, {hand="detail", pile=g, tool={kind="filbert", width=math.max(2, H*0.025)}, angle=math.pi/2, length={6,20}, coverage=1.3, clip=true, load=0.35, threshold=0.3})
end
print(wait(0))
