local mB = pile{{"yellow ochre",2.4},{"Prussian blue",0.45},{"raw umber",0.3},{"lead white",0.9},{"green earth",0.4}, medium=0.05}
work(poly({{765,672},{830,676},{900,688},{925,700},{925,714},{765,714}}) - riseM:shrink(2), {hand="hatch", pile=mB, tool={kind="round", width=1.8, point=0.6}, angle=-math.pi/2+0.15, length={5,10}, coverage=2.2, pressure={0.4,0.75}, seed=991})
-- a drainage ditch across the meadow, catching the sky
local dpts = {{470,577},{540,584},{600,591},{680,601},{750,611},{830,622},{900,633},{1005,648}}
local wd = {}
for i,p in ipairs(dpts) do wd[i] = 1.2 + 0.0045*(p[1]-470) end
ditchM = ribbon(dpts, wd) - riseM
local keep2 = rect(496,548,46,24)
ditchM = ditchM - keep2
local dk = pile{{"raw umber",1},{"green earth",1.2},{"Prussian blue",0.3},{"lead white",0.3}, medium=0.05}
local dw = pile{{"lead white",6},{"pale smalt",1.2},{"cobalt blue",0.25},{"yellow ochre",0.1}, medium=0.05}
work(ditchM, {hand="detail", pile=dw, tool={kind="round", width=1.3, point=0.3}, angle=0.13, coverage=3, fill=true, clip=true, seed=992})
-- the shadowed far bank above the water
local b = brush{kind="round", width=1.2, point=0.4}
for i=1,#dpts-1 do
  b:reload(dk, 0.5)
  local a, c = dpts[i], dpts[i+1]
  local wa, wc = wd[i], wd[i+1]
  b:stroke({{a[1], a[2]-wa/2-0.2},{c[1], c[2]-wc/2-0.2}}, {pressure={0.35+0.001*(a[1]-470), 0.35+0.001*(c[1]-470)}, clip=-riseM})
end
