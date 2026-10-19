paper{width=1056,height=704,kind="cold-press",seed=3117}


local t0=clock()
for y=30,330,90 do for x=40,1056,118 do drop{x=x,y=y,water=14,radius=85} end end
local function mix(t)
  -- t 0 top .. 1 horizon
  local p = {}
  local u = 0.10*(1-t)^1.5
  if u>0.002 then p["french-ultramarine"]=u end
  local r = 0.025*math.exp(-((t-0.55)/0.25)^2)
  if r>0.002 then p["quinacridone-rose"]=r end
  local s = 0.06*math.max(0,(t-0.45)/0.55)
  if s>0.002 then p["raw-sienna"]=s end
  if t<0.4 then p["burnt-sienna"]=0.01 end
  return p
end
local ys = {}
for y=10,340,42 do ys[#ys+1]=y end
for i,y in ipairs(ys) do
  local t=(y-10)/330
  local b = brush{name="row"..i, width=80}
  b:load{water=30, pigments=mix(t)}
  local path={}
  local dir = (i%2==1) and 1 or -1
  for k=0,30 do
    local x = dir==1 and (-20+k*37) or (1090-k*37)
    path[#path+1]={x, y + 4*math.sin(k*0.7+i)}
  end
  b:stroke(path,{pressure=0.7, duration=0.25})
  print(i, clock()-t0, b:status().water)
end
for i=1,12 do wait(0.5); local s=balance(); print(clock()-t0, s.max_surface_water, s.dry) end
