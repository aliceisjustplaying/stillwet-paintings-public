--@ watercolor-engine 2

paper{width=1200,height=710,kind="cold-press",seed=2013}

for y=15,245,70 do for x=20,1200,90 do drop{x=x+((y//70)%2)*45,y=y,water=7,radius=65} end end
local b = brush{name="sky", width=50}
local function ld(c) local s=b:status(); local need = 5 - (s.water or 0); if need>0 then b:load{water=need, pigments={["cobalt-blue"]=0.06*c, ["french-ultramarine"]=0.015*c, ["burnt-sienna"]=0.008*c}} end end
local function streak(pts, c)
  for i=1,#pts-1 do ld(c); b:stroke({pts[i],pts[i+1]},{pressure=pts[i+1][3] or 0.4}) end
end
streak({{-20,25,0.5},{150,15,0.5},{330,35,0.4},{430,22,0.2}},1.2)
streak({{-20,80,0.5},{120,90,0.5},{260,105,0.4},{380,125,0.15}},1.0)
streak({{-20,150,0.5},{90,145,0.4},{200,160,0.15}},1.0)
streak({{160,55,0.3},{260,60,0.35},{350,72,0.1}},0.8)
streak({{840,15,0.2},{1000,30,0.45},{1220,20,0.5}},1.0)
streak({{900,120,0.15},{1050,108,0.4},{1220,98,0.5}},0.9)
streak({{980,165,0.15},{1100,155,0.35},{1220,165,0.4}},0.7)
streak({{570,8,0.2},{700,0,0.3}},0.6)
wait(8)
print(balance().dry)