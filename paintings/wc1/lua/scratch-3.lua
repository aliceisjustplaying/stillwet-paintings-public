paper{width=1056,height=704,kind="cold-press",seed=4127}

local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local function seg_row(b, y, x0, x1, seglen, water, pigs, dur)
  local x=x0
  while x < x1 do
    topup(b, water, pigs)
    b:stroke({{x,y},{x+seglen+10,y}}, {pressure=0.5, duration=dur})
    x = x + seglen
  end
end
-- trial A: width 60, target 20uL, 120 seglen
local b=brush{name="A", width=60}
local t0=clock()
seg_row(b, 60, 0, 1056, 120, 20, {["cerulean-blue"]=0.2}, 0.08)
print("A", clock()-t0, b:status().water)
local b2=brush{name="B", width=60}
seg_row(b2, 200, 0, 1056, 120, 8, {["cerulean-blue"]=0.08}, 0.08)
print("B", b2:status().water)
local b3=brush{name="C", width=60}
seg_row(b3, 340, 0, 1056, 60, 8, {["cerulean-blue"]=0.08}, 0.05)
print("C", b3:status().water)
wait(8); print(balance().dry)