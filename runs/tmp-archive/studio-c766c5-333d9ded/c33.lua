function castshadow(bx,by,ex,ey,w0,w1)
  return mask(function(x,y)
    local dx, dy = ex-bx, ey-by
    local L2 = dx*dx+dy*dy
    local t = ((x-bx)*dx + (y-by)*dy)/L2
    local tc = clamp(t,0,1)
    local px, py = bx+dx*tc, by+dy*tc
    local d = math.sqrt((x-px)^2 + (y-py)^2)
    local w = w0 + (w1-w0)*tc
    local a = clamp(1 - (d/w)^2, 0, 1)
    local fade
    if t < 0 then fade = clamp(1 + t*5, 0, 1) else fade = clamp((1-t)*2.5, 0, 1) end
    return a*fade
  end)
end
objall = bottlemask + bowlmask + lemA + lemB + lemC + pear
table_free = tablemask - objall
ptabLight = pile{{"yellow ochre",2.5},{"lead white",2},{"raw umber",0.8}}
ptabDark = pile{{"raw umber",3},{"smalt",1.2},{"bone black",0.3},{"lead white",1}}
tlight = ellipse(390,545,430,150):soften(110) * table_free
work(tlight, {hand="broad", pile=ptabLight, clip=true, coverage=2.0, angle=0.06, seed=271})
tdark = mask(function(x,y)
  local a = clamp((x-780)/320,0,1)
  local b = clamp((y-680)/180,0,1)
  return clamp(a*0.85 + b*0.85, 0, 1)
end):soften(50) * table_free
work(tdark, {hand="broad", pile=ptabDark, clip=true, coverage=2.2, angle=0.06, seed=272})
print("ok")
