HZ = 392
function far(x) return HZ - 3 - 4*math.sin(x/70+1) - 2*math.sin(x/23) - 7*smoothstep(760,1000,x) end
function mid1(x) return 440 + 6*math.sin(x/120) + 3*math.sin(x/37+2) end   -- far edge of near meadow band
function fg(x) return 520 - 30*smoothstep(0,350,350-x)*0 + 8*math.sin(x/90+0.5) - 22*math.exp(-((x-250)/180)^2) end -- foreground bank top
h = pencil("2H")
-- horizon line, lightly
local pts = {}
for x=0,1000,20 do pts[#pts+1] = {x, far(x)} end
h:sketch(pts, {pressure=0.25, passes=2})
local p2 = {}
for x=0,1000,25 do p2[#p2+1] = {x, fg(x)} end
h:sketch(p2, {pressure=0.25, passes=2})
-- stream (ditch) centre line
STREAM = {{1000,428},{900,433},{800,441},{700,447},{600,452},{520,458},{450,466},{380,474},{310,478},{240,482},{160,490},{80,500},{0,510}}
h:sketch(STREAM, {pressure=0.25, passes=2})
-- towers
TW = {{x=602, top=312, w=9, base=HZ-2, sp=34}, {x=668, top=334, w=12, base=HZ-2, sp=12}, {x=724, top=326, w=8, base=HZ-2, sp=26}}
for _,t in ipairs(TW) do
  local tb = t.top + t.sp
  h:line({{t.x - t.w/2, t.base}, {t.x - t.w/2, tb}}, {pressure=0.35, smooth=false})
  h:line({{t.x + t.w/2, t.base}, {t.x + t.w/2, tb}}, {pressure=0.35, smooth=false})
  h:line({{t.x - t.w/2 - 1, tb}, {t.x, t.top}, {t.x + t.w/2 + 1, tb}}, {pressure=0.35, smooth=false})
end
-- figures, a man and a woman seen from behind
FIG = {man={x=322, feet=583, h=64}, woman={x=338, feet=584, h=57}}
local m = FIG.man
h:sketch({{m.x, m.feet-m.h}, {m.x-2, m.feet-m.h+10}, {m.x-7, m.feet-m.h+16}, {m.x-8, m.feet-30}, {m.x-5, m.feet}}, {pressure=0.3})
h:sketch({{m.x, m.feet-m.h}, {m.x+3, m.feet-m.h+10}, {m.x+7, m.feet-m.h+16}, {m.x+6, m.feet-30}, {m.x+3, m.feet}}, {pressure=0.3})
local wo = FIG.woman
h:sketch({{wo.x, wo.feet-wo.h}, {wo.x-3, wo.feet-wo.h+12}, {wo.x-7, wo.feet-wo.h+20}, {wo.x-11, wo.feet}}, {pressure=0.3})
h:sketch({{wo.x, wo.feet-wo.h}, {wo.x+3, wo.feet-wo.h+12}, {wo.x+7, wo.feet-wo.h+20}, {wo.x+11, wo.feet}}, {pressure=0.3})
-- windmills
MILLS = {{x=150, base=far(150)+1, h=20}, {x=872, base=far(872)+1, h=17}}
for _,ml in ipairs(MILLS) do
  h:sketch({{ml.x-4, ml.base}, {ml.x-3, ml.base-ml.h}, {ml.x+3, ml.base-ml.h}, {ml.x+4, ml.base}}, {pressure=0.3})
end
-- willows along the ditch
WILLOWS = {{x=70, y=500, h=58}, {x=128, y=493, h=50}, {x=196, y=486, h=44}, {x=262, y=481, h=36}, {x=318, y=477, h=30}}
for _,wl in ipairs(WILLOWS) do
  h:sketch({{wl.x-3, wl.y}, {wl.x-2, wl.y-wl.h*0.45}}, {pressure=0.3})
  h:sketch({{wl.x+3, wl.y}, {wl.x+2, wl.y-wl.h*0.45}}, {pressure=0.3})
end
