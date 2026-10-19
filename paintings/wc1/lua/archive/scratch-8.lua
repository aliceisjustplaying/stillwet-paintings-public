paper{width=1056,height=704,kind="cold-press",seed=4127}

local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
-- steady stroke: path polyline, pieces of len 'step', topping up each
local function steady(b, path, step, water, pigs, opt)
  opt = opt or {}
  local pr = opt.pressure or 0.5
  local speed = opt.speed or 1500
  for i=1,#path-1 do
    local a,c = path[i], path[i+1]
    local dx,dy = c[1]-a[1], c[2]-a[2]
    local L = math.sqrt(dx*dx+dy*dy)
    local n = math.max(1, math.floor(L/step+0.5))
    for k=0,n-1 do
      local x0,y0 = a[1]+dx*k/n, a[2]+dy*k/n
      local x1,y1 = a[1]+dx*(k+1)/n, a[2]+dy*(k+1)/n
      topup(b, water, pigs)
      b:stroke({{x0,y0},{x1,y1}}, {pressure=pr, duration=math.max(0.005, (L/n)/speed)})
    end
  end
end
local t0=clock()
local b=brush{name="s1", width=60}
steady(b, {{0,60},{1056,60}}, 15, 4, {["cerulean-blue"]=0.04})
print(clock()-t0)
local b2=brush{name="s2", width=60}
steady(b2, {{0,160},{1056,160}}, 30, 6, {["cerulean-blue"]=0.06})
local b3=brush{name="s3", width=60}
steady(b3, {{0,260},{1056,260}}, 15, 2, {["cerulean-blue"]=0.02})
local b4=brush{name="s4", width=30}
steady(b4, {{0,360},{1056,360}}, 10, 3, {["raw-umber"]=0.06, ["french-ultramarine"]=0.04})
print(clock()-t0)
wait(10)