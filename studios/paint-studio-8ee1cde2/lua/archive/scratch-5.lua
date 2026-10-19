--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local s = brush{name="probe", width=100}
s:load{water=30, pigments={["cobalt-blue"]=0.3}}
s:stroke({{20,650},{600,650}}, {pressure=0.5, duration=0.2})
print("after long stroke", s:status().water)
-- wash trial over pre-wet
for gx=0,5 do for gy=0,3 do drop{x=60+gx*110, y=40+gy*90, water=6, radius=80} end end
local w = brush{name="skywash", width=60}
w:load{water=6, pigments={["cobalt-blue"]=0.10, ["french-ultramarine"]=0.055, ["burnt-sienna"]=0.012}}
local t0 = clock()
w:wash{x=20, y=20, width=640, height=300, grade=0.5}
print("wash time", clock()-t0, w:status().water)
local L = brush{name="liftA", width=24}
L:load{water=6}
L:lift({{100,170},{300,140},{520,110}}, {duration=0.3})
L:load{water=6}
L:lift({{200,250},{420,220},{640,200}}, {duration=0.3})
-- smaller brush wash on dry for comparison
local w2 = brush{name="skywash2", width=60}
w2:load{water=6, pigments={["cobalt-blue"]=0.10, ["french-ultramarine"]=0.055, ["burnt-sienna"]=0.012}}
w2:wash{x=720, y=20, width=420, height=300}
wait(30)
print(balance().dry)
