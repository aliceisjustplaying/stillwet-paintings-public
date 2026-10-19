local mid2 = pile{{"green earth", 1.5}, {"raw umber", 0.35}, {"pale smalt", 0.45}, {"lead white", 0.5}, {"yellow ochre", 0.2}, {"Prussian blue", 0.03}, medium=0.12}
local dark2 = pile{{"green earth", 1.3}, {"raw umber", 0.7}, {"Prussian blue", 0.07}, {"bone black", 0.08}, {"lead white", 0.1}, medium=0.12}
local lit2 = pile{{"lead white", 2.2}, {"green earth", 0.6}, {"yellow ochre", 0.45}, {"pale smalt", 0.25}, medium=0.1}
local shootp = pile{{"raw umber", 0.8}, {"green earth", 0.6}, {"lead white", 0.3}, {"bone black", 0.08}, medium=0.1}
local fine = brush{kind="round", width=0.7, point=1, stiffness=0.4}
for wi, w in ipairs(WILLOWS) do
  local s = w.h/60
  stipple(w.crown, {pile=mid2, width=1.5*s + 0.6, coverage=1.3, cluster=0.55, clip=true, dips={16, 0.5, 0.5}, seed=6300+wi})
  local shade = w.crown * mask(function(x, y) return ((x - w.hx)*0.75 + (y - (w.hy - w.h*0.3))*0.65 > 1*s) and 1 or 0 end)
  stipple(shade, {pile=dark2, width=1.4*s + 0.6, coverage=1.4, cluster=0.6, clip=true, dips={16, 0.5, 0.5}, seed=6320+wi})
  -- inner hollows
  stipple(w.crown:shrink(2.5*s), {pile=dark2, width=1.2*s + 0.5, coverage=0.35, cluster=0.85, clip=true, seed=6340+wi})
  -- silvery lights on the upper-left of the leaf clumps
  local litm = mask(function(x, y) if w.crown:at(x, y) < 0.5 then return 0 end; return (w.crown:at(x - 3*s, y - 3*s) < 0.5 or ((x - w.hx) < -2 and (y < w.hy - w.h*0.35))) and 1 or 0 end)
  stipple(litm, {pile=lit2, width=1.1*s + 0.5, coverage=0.9, cluster=0.5, clip=true, feather=0.3, seed=6360+wi})
  -- the rods: fine shoots rising from the head, seen at the crown edge
  fine:load(shootp, 0.4)
  for k, pts in ipairs(w.shoots) do
    if k % 2 == 0 then
      local sub = {}
      for j=1,#pts do sub[#sub+1] = pts[j] end
      fine:stroke(sub, {pressure={0.4, 0.02}, ramps={0.05, 0.6}, shake=0.5})
      if k % 6 == 0 then fine:load(shootp, 0.4) end
    end
  end
end
