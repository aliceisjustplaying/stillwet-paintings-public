--@ watercolor-engine 2

paper{width=1100,height=660,kind="cold-press",seed=2023}


function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
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
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + dy*0.5
  local row = 0
  while y < ymax do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1], sp[2]
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    row = row + 1
    y = y + dy
  end
end
for y=30,300,90 do for x=240,760,100 do drop{x=x,y=y,water=8,radius=60} end end
local b = brush{name="sky2", width=50}
local poly = {{200,0},{780,0},{780,300},{200,300}}
fill(b, poly, 30, 70, function(y,x)
  local t = y/300
  return 5, {["cobalt-blue"]=0.2*(1-t)+0.06, ["cerulean-blue"]=0.06*(1-t)+0.03}
end)
print(clock())
for i=1,10 do local t=wait(0.5); local s=balance(); print(t, s.max_surface_water, s.dry) end



local mixes = {
 {["french-ultramarine"]=0.3},
 {["french-ultramarine"]=0.2, ["cobalt-blue"]=0.15},
 {["cobalt-blue"]=0.3, ["phthalo-blue"]=0.03},
 {["french-ultramarine"]=0.2, ["cerulean-blue"]=0.08},
 {["french-ultramarine"]=0.1},
 {["french-ultramarine"]=0.06, ["cobalt-blue"]=0.05},
}
for i,m in ipairs(mixes) do
  local b = brush{name="sw"..i, width=40}
  b:load{water=6, pigments=m}
  local x = 60 + (i-1)*170
  b:stroke({{x,400},{x+120,400}}, {pressure=0.6, duration=0.1})
  b:load{water=6, pigments=m}
  b:stroke({{x,430},{x+120,430}}, {pressure=0.6, duration=0.1})
end
wait(5)
print(balance().dry)
