function ditchY(x) return 577 + 0.12*(x-480) end
local post = pile{{"raw umber",1.4},{"lead white",0.9},{"bone black",0.25},{"yellow ochre",0.2}, medium=0.05}
local postL = pile{{"lead white",2},{"raw umber",0.5},{"yellow ochre",0.35}, medium=0.05}
local pb = brush{kind="round", width=1.3, point=0.3}
local lb = brush{kind="rigger", width=0.8, point=1}
local xs = uneven(18, 600, 995, 0.3, 0.2, 77)
fenceTops = {}
for i,x in ipairs(xs) do
  local y = ditchY(x) + 7 + 0.004*(x-600)
  local h = 7.5 + 0.004*(x-600) + rand(-0.8,0.8)
  local lean = rand(-0.5,0.5)
  pb:reload(post, 0.6)
  pb:stroke({{x+lean, y-h},{x, y}}, {pressure={0.75,0.85}})
  lb:reload(postL, 0.4)
  lb:stroke({{x-0.35+lean, y-h+0.3},{x-0.35, y-1.5}}, {pressure={0.3,0.2}})
  fenceTops[#fenceTops+1] = {x+lean, y-h, y}
end
-- two rails, sagging a little between posts
local rail = pile{{"raw umber",1.2},{"lead white",1.0},{"bone black",0.2}, medium=0.06}
local rb = brush{kind="round", width=0.9, point=0.6}
for k,f in ipairs({0.12, 0.5}) do
  for i=1,#fenceTops-1 do
    local a, b = fenceTops[i], fenceTops[i+1]
    if not (i == 7 and k == 1) then
      local ya = a[2] + f*(a[3]-a[2]); local yb = b[2] + f*(b[3]-b[2])
      rb:reload(rail, 0.45)
      rb:stroke({{a[1], ya},{(a[1]+b[1])/2, (ya+yb)/2 + 0.5},{b[1], yb}}, {pressure={0.45,0.45}, shake=0.3})
    end
  end
end
