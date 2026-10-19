--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local dark={["hookers-green"]=0.5, ["sap-green"]=0.4, ["burnt-sienna"]=0.08, ["hansa-yellow"]=0.08}
for y=40,140,8 do local b=brush{name="d"..y, width=16} b:load{water=2,pigments=dark} b:stroke({{0,y},{1100,y}},{pressure=0.5,duration=0.3}) end
wait(12)
local mixes={
 {["indian-red"]=0.5, ["burnt-sienna"]=0.3, ["burnt-umber"]=0.2},
 {["indian-red"]=0.8, ["burnt-umber"]=0.4, ["quinacridone-burnt-orange"]=0.1},
 {["burnt-sienna"]=0.6, ["burnt-umber"]=0.4, ["indian-red"]=0.3, ["ultramarine-violet"]=0.05},
 {["indian-red"]=1.2, ["burnt-umber"]=0.5, ["buff-titanium"]=0.4},
 {["indian-red"]=0.4, ["raw-umber"]=0.3, ["burnt-sienna"]=0.2, ["buff-titanium"]=0.6},
}
for i,mm in ipairs(mixes) do
  local x=40+(i-1)*210
  for j,y in ipairs({80,120,220,260,320}) do
    local b=brush{name="s"..i.."_"..j, width=30}
    b:load{water=3, pigments=mm}
    b:stroke({{x,y},{x+170,y}},{pressure=0.5,duration=0.1})
  end
end
wait(12) print(balance().dry)
