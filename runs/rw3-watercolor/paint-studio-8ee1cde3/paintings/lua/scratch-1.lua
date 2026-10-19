--@ watercolor-engine 2

paper{width=1100,height=660,kind="cold-press",seed=2023}

local b = brush{name="t1", width=40}
b:load{water=10, pigments={["cobalt-blue"]=0.5, ["cerulean-blue"]=0.3}}
local s = b:status()
for k,v in pairs(s) do print(k, v) end
for k,v in pairs(s.pigments) do print(" ",k,v) end


function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  local any=false
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d); any=true end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
-- fill: rows with segments; mixf(y) returns water, pigments table
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + dy*0.5
  local row = 0
  while y < ymax do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1], sp[2]
      local dir = (row % 2 == 0)
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        if dir then b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5})
        else b:stroke({{x1-(x-x0), y},{x1-(xe-x0), y}}, {pressure=opt.pressure or 0.5}) end
        x = xe
      end
    end
    row = row + 1
    y = y + dy
  end
end
local b = brush{name="sky1", width=36}
local poly = {{200,0},{780,0},{780,300},{200,300}}
fill(b, poly, 22, 60, function(y,x)
  local t = y/300
  return 5, {["cobalt-blue"]=0.5*(1-t)+0.15, ["cerulean-blue"]=0.15*(1-t)+0.08}
end)
print(clock())
