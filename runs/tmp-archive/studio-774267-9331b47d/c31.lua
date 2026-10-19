local t3 = TW[3]
local spl = poly({{719.4, 352}, {724.6, 325.5}, {725.6, 323.6}, {725.6, 352}})
local spr = poly({{725.6, 352}, {725.6, 323.6}, {726.4, 324.2}, {732.4, 352}})
local litp = pile{{"lead white", 2.2}, {"pale smalt", 0.9}, {"red earth", 0.25}, {"yellow ochre", 0.3}, {"raw umber", 0.1}, medium=0.1}
local shp = pile{{"pale smalt", 1.2}, {"smalt", 0.7}, {"lead white", 0.9}, {"raw umber", 0.45}, {"red earth", 0.15}, {"bone black", 0.08}, medium=0.1}
work(spl, {hand="detail", pile=litp, tool={kind="round", width=1.2, point=0.8}, coverage=2.5, fill=true, seed=3101})
work(spr, {hand="detail", pile=shp, tool={kind="round", width=1.2, point=0.8}, coverage=2.5, fill=true, seed=3102})
-- belfry openings and nave windows, small dark marks
local dk = pile{{"smalt", 1}, {"raw umber", 0.8}, {"bone black", 0.35}, {"lead white", 0.3}, medium=0.15}
local r = brush{kind="round", width=1.0, point=1, stiffness=0.4}
r:load(dk, 0.5)
local function slit(x, y0, y1, pr)
  r:stroke({{x, y0}, {x, y1}}, {pressure={pr or 0.45, pr or 0.45}, ramps={0.1,0.1}})
end
for _,t in ipairs(TW) do
  local yb = t.body + 4
  local n = (t.w > 13) and 3 or 2
  for i=1,n do
    local x = t.x - t.w/2 + t.w*(i)/(n+1)
    slit(x, yb, yb + 7)
    slit(x, yb + 14, yb + 19, 0.35)
  end
  r:load(dk, 0.3)
end
-- nave windows
for _,nv in ipairs({{608,650,6},{677,714,6},{733,762,5}}) do
  local y1 = far((nv[1]+nv[2])/2) - 2
  for x = nv[1]+4, nv[2]-3, nv[3] do slit(x, y1 - 9, y1 - 3, 0.35) end
  r:load(dk, 0.3)
end
