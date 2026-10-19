-- glaze the path down, warmer and darker
local pg = pile{{"raw umber",1},{"yellow ochre",1},{"green earth",0.6},{"lead white",0.3}, medium=0.55}
work(PATH:grow(1), {hand="detail", pile=pg, tool={kind="filbert", width=4}, angle=-1.0, length={10,25}, coverage=1.2, clip=true, load=0.35})
blend(PATH:grow(1), {angle=-1.0, coverage=1.5, tool={kind="badger", width=10}})
-- two ruts: darker lines along the path
local rutP = pile{{"raw umber",1.2},{"yellow ochre",0.6},{"bone black",0.1},{"lead white",0.4}, medium=0.15}
local function offs(k)
  local out = {}
  for i=1,#PC-2 do
    local a = PC[math.max(1,i-1)]; local b = PC[math.min(#PC,i+1)]
    local dx, dy = b[1]-a[1], b[2]-a[2]; local d = math.sqrt(dx*dx+dy*dy)
    local hw = lerp(52, 1.5, ((i-1)/(#PC-1))^0.7)
    out[#out+1] = {PC[i][1] - dy/d*hw*k, PC[i][2] + dx/d*hw*k}
  end
  return out
end
RUT1, RUT2 = offs(0.55), offs(-0.5)
local rb = brush{kind="round", width=4, point=0.5}
for _,r in ipairs({RUT1, RUT2}) do
  rb:reload(rutP, 0.6)
  rb:stroke(r, {pressure={0.8,0.1}, ramps={0.02,0.5}, shake=0.6})
end
print(wait(0))
