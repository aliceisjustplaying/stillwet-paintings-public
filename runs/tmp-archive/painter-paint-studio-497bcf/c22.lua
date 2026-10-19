-- far river: flattened meanders, thinning, broken by banks and scrub
wfar = pile{{"lead white", 5}, {"pale smalt", 1.2}, {"cobalt blue", 0.2}, {"yellow ochre", 0.15}, {"raw umber", 0.15}, medium=0.1}
bankF = pile{{"green earth", 2}, {"raw umber", 1.3}, {"lead white", 0.9}, {"pale smalt", 0.5}, medium=0.1}
local segs = {
  {pts={{229,504.2},{246,503.2},{262,502.6},{276,501.2},{283,499.4}}, w=2.4},
  {pts={{283,499.4},{278,497.6},{266,496.6},{258,495.4},{266,494.0},{288,493.4},{312,493.0}}, w=1.9},
  {pts={{330,492.5},{352,491.6},{368,490.4},{372,489.0},{362,487.9},{350,487.2},{356,486.2},{378,485.6}}, w=1.5},
  {pts={{396,485.0},{420,484.2},{438,483.0},{444,481.8},{436,480.9},{442,480.0},{462,479.4}}, w=1.2},
  {pts={{478,478.6},{500,478.0},{516,477.2}}, w=0.9},
}
local bk = brush{kind="round", width=1.4, point=0.5}
local wb = brush{kind="round", width=2.2, point=0.6}
for i, s in ipairs(segs) do
  -- dark cut bank just below the water
  local bp = {} for k, p in ipairs(s.pts) do bp[k] = {p[1], p[2] + s.w * 0.55} end
  bk:load(bankF, 0.5)
  bk:stroke(bp, {pressure={0.45 - i*0.04, 0.4 - i*0.04}, ramps={0.05,0.1}})
  wb:load(wfar, 0.5)
  local pr = clamp(0.25 + s.w * 0.12, 0.2, 0.6)
  wb:stroke(s.pts, {pressure={pr, pr * 0.85}, ramps={0.1,0.15}})
end
print(wait(0))
