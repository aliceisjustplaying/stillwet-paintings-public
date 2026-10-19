paper{width=1056,height=704,kind="cold-press",seed=4127}

local function rows(b, y0, y1, step, water, pigs, dur, p)
  for y=y0,y1,step do
    b:load{water=water, pigments=pigs}
    b:stroke({{-20,y},{1076,y}}, {pressure=p or 0.5, duration=dur or 0.3})
  end
end
local t0=clock()
rows(brush{name="w", width=70}, 0, 330, 45, 80, {}, 0.25)
print("wet done", clock()-t0, balance().max_surface_water)
rows(brush{name="blue", width=70}, 0, 130, 45, 60, {["cerulean-blue"]=0.5, ["french-ultramarine"]=0.4}, 0.25)
rows(brush{name="mid", width=70}, 150, 200, 45, 50, {["cerulean-blue"]=0.15, ["naples-yellow"]=0.1}, 0.25)
rows(brush{name="glow", width=70}, 220, 330, 45, 60, {["naples-yellow"]=0.5, ["quinacridone-rose"]=0.12}, 0.25)
print("color done", clock()-t0, balance().max_surface_water)
for i=1,12 do local t=wait(0.5); local s=balance(); print(t, s.max_surface_water, s.max_wetness, s.dry) end

wait(3); print(balance().dry)