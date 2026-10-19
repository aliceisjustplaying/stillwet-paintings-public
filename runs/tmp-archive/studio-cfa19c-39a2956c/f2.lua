print(wait(60*24))
local post2 = pile{{"raw umber",1.6},{"bone black",0.45},{"lead white",0.35},{"green earth",0.3}, medium=0.03}
local postL = pile{{"lead white",2},{"raw umber",0.4},{"yellow ochre",0.4}, medium=0.03}
local pb = brush{kind="round", width=1.5, point=0.2}
local lb = brush{kind="rigger", width=0.8, point=1}
for i,f in ipairs(fenceTops) do
  pb:reload(post2, 0.8)
  pb:stroke({{f[1]+0.2, f[2]},{f[1]+0.25, f[3]+0.3}}, {pressure={0.85,0.9}})
end
for i,f in ipairs(fenceTops) do
  lb:reload(postL, 0.5)
  lb:stroke({{f[1]-0.45, f[2]+0.4},{f[1]-0.4, f[3]-1.8}}, {pressure={0.4,0.25}})
end
local rail = pile{{"raw umber",1.4},{"bone black",0.3},{"lead white",0.5}, medium=0.04}
local rb = brush{kind="round", width=1.0, point=0.5}
for k,fr in ipairs({0.12, 0.5}) do
  for i=1,#fenceTops-1 do
    local a, b = fenceTops[i], fenceTops[i+1]
    if not (i == 7 and k == 1) and not (i == 12) then
      local ya = a[2] + fr*(a[3]-a[2]); local yb = b[2] + fr*(b[3]-b[2])
      rb:reload(rail, 0.55)
      rb:stroke({{a[1], ya},{(a[1]+b[1])/2, (ya+yb)/2 + 0.5},{b[1], yb}}, {pressure={0.55,0.55}, shake=0.3})
    end
  end
end
