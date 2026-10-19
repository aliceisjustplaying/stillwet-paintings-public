gr_mid2 = pile{{"green earth",5},{"yellow ochre",1.6},{"chrome yellow",0.3},{"raw umber",0.6}}
gr_lt2  = pile{{"chrome yellow",0.5},{"lead white",1.2},{"yellow ochre",2},{"green earth",2.2}}
gr_hot2 = pile{{"lead white",2.2},{"yellow ochre",1.4},{"chrome yellow",0.5},{"green earth",1.2}}
gr_sh2  = pile{{"raw umber",3.5},{"green earth",2},{"bone black",1.4},{"Prussian blue",0.3}}
cx, cy, rx, ry = 606, 498, 92, 86
mfB = m_apB:grow(1.5)
dB = function(x, y) local dx=(x-cx)/rx; local dy=(y-cy)/ry; return 0.80*dx+0.58*dy+0.20*(dx*dx+dy*dy) end
local zt = function(a,b) return mask(function(x,y) return smoothstep(a,b,dB(x,y)) end) end
print(work(mfB, {hand="body", pile=gr_mid2, coverage=3.0, tool="filbert 14", clip=true, edge="found", seed=960}))
print(work(mfB * zt(0.26, 0.58), {hand="body", pile=gr_sh2, coverage=1.1, tool="filbert 12", angle=0.5, clip=true, edge="soft", seed=961}))
print(work(mfB * zt(0.62, 0.96), {hand="body", pile=gr_sh2, coverage=0.9, tool="filbert 10", angle=0.5, clip=true, edge="soft", seed=962}))
print(work(mfB * zt(0.0, -0.20), {hand="body", pile=gr_lt2, coverage=0.8, tool="filbert 12", angle=-0.7, clip=true, edge="soft", seed=963}))
print(work(mfB * zt(-0.34, -0.62), {hand="body", pile=gr_hot2, coverage=0.65, tool="filbert 9", angle=-0.7, clip=true, edge="soft", seed=964}))
print(blend(mfB:shrink(5), {angle=-0.6}))
print("cloth top edge:")
for _, x in ipairs{60, 160, 260, 360, 460, 560, 660, 760, 860} do
  local y = 520
  while y < 800 and m_cloth:at(x, y) < 0.5 do y = y + 4 end
  print(x, y)
end
