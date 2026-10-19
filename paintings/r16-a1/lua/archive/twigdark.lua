twigD = pile{{"raw umber",2},{"bone black",0.55},{"smalt",0.6},{"lead white",0.22}, medium=0.12}
function tree_restroke(T, p, wmax)
  local bm = brush{kind="round", width=4, point=1}
  local bt = brush{kind="rigger", width=2, point=1}
  bm:load(p, 0.8); bt:load(p, 0.8)
  local n = 0
  for _,l in ipairs(T.limbs) do
    if l.ws[1] < wmax and #l.pts >= 2 then
      local b = (l.ws[1] > 1.6) and bm or bt
      if b:fullness() < 0.35 then b:load(p, 0.7) end
      local p0 = b:pressure_for(math.max(l.ws[1], 0.6))
      local p1 = b:pressure_for(math.max(l.ws[#l.ws], 0.6))
      b:stroke(l.pts, {pressure={p0, p1*0.6}, ramps={0.02, 0.25}, shake=0})
      n = n + 1
    end
  end
  return n
end
local n = 0
for _,T in ipairs({OAK, OAKX, OAKT, OAKXT, OAK2, OAK2T}) do n = n + tree_restroke(T, twigD, 3.5) end
print(n)
