coatP = pile{{"bone black",1.2},{"raw umber",0.8},{"smalt",0.25},{"lead white",0.2}, medium=0.06}
FX, FY = 560, 548
local fx, fy = FX, FY
local coat = poly({{fx-5.2,fy-32.5},{fx-2,fy-34},{fx+2.5,fy-34},{fx+5.5,fy-32},{fx+6.5,fy-24},{fx+7.2,fy-14},{fx+8.2,fy-6.5},{fx+3,fy-5.5},{fx-2,fy-6},{fx-7.8,fy-6.8},{fx-7,fy-16},{fx-6.4,fy-25}}, true)
local head = ellipse(fx-0.2, fy-36.8, 2.9, 3.4)
local hat = poly({{fx-4.2,fy-39},{fx-2.5,fy-42.4},{fx+2.2,fy-42.6},{fx+4.0,fy-39.6},{fx+1,fy-38.6},{fx-2,fy-38.5}}, true)
local legs = rect(fx-4.2, fy-7, 2.8, 7.2) + rect(fx+1.2, fy-7, 2.8, 7)
local arm = ribbon({{fx-5.4,fy-31},{fx-7.8,fy-24},{fx-8.6,fy-19}}, {3.2,3.0,2.8})
figM = coat + head + hat + legs + arm
work(figM, {hand="detail", pile=coatP, coverage=4, pressure={0.5,0.8}, load=1, fill=true, angle=-math.pi/2, tool={kind="round", width=1.6}})
-- the stick
local r = brush{kind="round", width=2, point=1}
r:load(coatP, 0.7)
r:stroke({{fx-9.6,fy-21},{fx-10.6,fy-10},{fx-11.6,fy+1}}, {pressure={0.55,0.45}})
