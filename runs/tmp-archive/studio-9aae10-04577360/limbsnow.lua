limbSnow = pile{{"lead white",5},{"smalt",0.35},{"yellow ochre",0.06},{"vermilion",0.03}, medium=0.05}
function limb_snow(T, wmin, seed)
  math.randomseed(seed)
  local b = brush{kind="round", width=2.4, point=1}
  b:load(limbSnow, 0.7)
  local n = 0
  for _,l in ipairs(T.limbs) do
    if l.ws[1] >= wmin and #l.pts >= 2 and not l.dead then
      local run = {}
      local function flush()
        if #run >= 2 then
          if b:fullness() < 0.3 then b:load(limbSnow, 0.7) end
          local wa = run.w or 1
          b:stroke(run, {pressure={b:pressure_for(math.max(0.6, wa)), b:pressure_for(math.max(0.6, wa*0.7))}, ramps={0.25, 0.35}, shake=0.2})
          n = n + 1
        end
        run = {}
      end
      for i=2,#l.pts do
        local a, c = l.pts[i-1], l.pts[i]
        local dx, dy = c[1]-a[1], c[2]-a[2]
        local len = math.sqrt(dx*dx+dy*dy)
        local slope = math.abs(dy)/math.max(len, 0.01)
        local w = l.ws[i]
        if slope < 0.55 and math.random() < 0.75 and w > 1.2 then
          -- normal pointing up
          local nx, ny = -dy/len, dx/len
          if ny > 0 then nx, ny = -nx, -ny end
          local off = l.ws[i-1]*0.5 - 0.25
          if #run == 0 then run[1] = {a[1] + nx*off, a[2] + ny*off} end
          run[#run+1] = {c[1] + nx*(w*0.5-0.25), c[2] + ny*(w*0.5-0.25)}
          run.w = math.min(2.0, 0.3*w + 0.4) * (1 - 0.6*slope)
        else
          flush()
        end
      end
      flush()
    end
  end
  return n
end
print(limb_snow(OAK, 2.0, 1), limb_snow(OAKX, 2.0, 2), limb_snow(OAK2, 2.0, 3))
