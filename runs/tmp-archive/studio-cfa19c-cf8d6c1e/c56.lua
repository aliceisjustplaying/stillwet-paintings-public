local R = riverM
local wRef2 = pile{{"green earth",1.5},{"raw umber",0.7},{"Prussian blue",0.2},{"lead white",0.5}, medium=0.1}
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x) + 0.8
  local yn = interp(nearBank, x) - 0.8
  local b = brush{kind="flat", width=math.max(1.2, 0.1*s), stiffness=0.4}
  b:reload(wRef2, 0.35)
  b:stroke({{x, yb},{x, math.min(yn, yb + 0.42*s)}}, {pressure={0.6,0.35}, orient="across", clip=R})
  local cb = brush{kind="filbert", width=math.max(1.5, 0.16*s), stiffness=0.4}
  cb:reload(wRef2, 0.3)
  local n = 3
  for k=1,n do
    local xx = x + (k-2) * 0.22*s
    local y0 = yb + 0.40*s
    if y0 < yn - 1 then cb:stroke({{xx, y0},{xx, math.min(yn, y0 + 0.4*s)}}, {pressure={0.55,0.15}, orient="across", clip=R}) end
  end
end
-- a thin dark line of shadow beneath the far bank
local bb = brush{kind="round", width=1.6, point=0.3}
local bankP2 = pile{{"raw umber",1},{"green earth",1.5},{"Prussian blue",0.2},{"lead white",0.8}, medium=0.15}
local xs = {}
for x=335,1005,45 do
  local seg = {}
  for xx=x, math.min(x+45,1005), 5 do seg[#seg+1] = {xx, interp(farBank, xx) + 0.9} end
  bb:reload(bankP2, 0.35)
  bb:stroke(seg, {pressure={0.35 + 0.0004*(x-335), 0.45 + 0.0004*(x-335)}, clip=R})
end
