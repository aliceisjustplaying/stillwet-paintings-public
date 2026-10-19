for i = 2, 3 do
  local a = AP[i]
  local S = ellipse(a.cx, a.cy, a.r, a.r*0.95):roughen(2.5, 70, 3):soften(1.5)
  print(string.format("apple %d  shape %.0f | mid(0..0.55) %.0f | lit(0.45..0.95) %.0f | core(-1..-0.15) %.0f",
    i, S:area(), (S*litf(a,0.0,0.55)):area(), (S*litf(a,0.45,0.95)):area(), (S*litf(a,-1.0,-0.15)):area()))
  local m1 = mask(function(x,y)
    local u=(x-a.cx)/a.r local v=(y-a.cy)/(a.r*0.95) local r=math.sqrt(u*u+v*v)
    if r<1e-6 then return 1 end
    return smoothstep(0.0,0.55,(u*LX+v*LY)/r)
  end)
  print(string.format("   light mask alone: centre %.2f  upper-left point %.2f  right point %.2f  lower %.2f",
    m1:at(a.cx, a.cy), m1:at(a.cx - a.r*0.5, a.cy - a.r*0.4), m1:at(a.cx + a.r*0.7, a.cy), m1:at(a.cx, a.cy + a.r*0.7)))
end
