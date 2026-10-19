--@ watercolor-engine 2

paper{width=1200,height=710,kind="cold-press",seed=2013}

-- pre-wet sky with drops
for y=20,260,90 do for x=40,1200,110 do drop{x=x,y=y,water=7,radius=75} end end
local b = brush{name="sky", width=46}
local function ld(c) local s=b:status(); local need = 5 - (s.water or 0); if need>0 then b:load{water=need, pigments={["cobalt-blue"]=0.12*c, ["french-ultramarine"]=0.03*c, ["burnt-sienna"]=0.015*c}} end end
-- streaks: list of polylines
local streaks = {
 {{-20,20},{150,10},{330,30},{430,15}},
 {{-20,70},{120,80},{260,95},{380,120}},
 {{-20,140},{90,135},{200,150}},
 {{-20,175},{60,185},{140,170}},
 {{150,55},{260,60},{350,75}},
 {{820,10},{1000,30},{1220,20}},
 {{880,120},{1050,105},{1220,95}},
 {{960,160},{1100,150},{1220,160}},
 {{560,10},{700,0}},
}
for _,s in ipairs(streaks) do
  -- break into segments for top-ups
  for i=1,#s-1 do ld(1); b:stroke({s[i],s[i+1]},{pressure=0.45}) end
end
local t=clock()
for i=1,10 do wait(0.5); local s=balance(); print(clock(), s.max_surface_water, s.dry) end