-- the walker, seen from behind, going toward the church
coatP = pile{{"bone black",1},{"raw umber",1},{"smalt",0.3},{"red earth",0.1}, medium=0.1}
local fx, fb = 478, 533
local coat = poly({{fx-3.2,fb-21},{fx+3.4,fb-21},{fx+4.2,fb-14},{fx+5.2,fb-5.5},{fx+3.5,fb-4.2},{fx-3.8,fb-4.4},{fx-5,fb-5.8},{fx-4.2,fb-14}}, true)
local shoulders = ellipse(fx, fb-20.5, 4.2, 2.2)
local head = ellipse(fx + 0.2, fb - 24.2, 2.1, 2.5)
local hat = ellipse(fx + 0.2, fb - 26.2, 3.0, 1.0) + ellipse(fx + 0.2, fb - 27.3, 1.9, 1.3)
local legL = poly({{fx-2.4,fb-5},{fx-0.6,fb-5},{fx-0.9,fb},{fx-2.6,fb}})
local legR = poly({{fx+0.8,fb-5},{fx+2.6,fb-5},{fx+2.9,fb-1.2},{fx+1.2,fb-1.2}})
local arm = poly({{fx+3,fb-19},{fx+5.2,fb-15},{fx+6.2,fb-12},{fx+4.8,fb-11.5},{fx+3.2,fb-15}}, true)
figM = coat + shoulders + head + hat + legL + legR + arm
work(figM, {hand="detail", tool={kind="round", width=1.2, point=0.8}, pile=coatP, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, angle=math.pi/2, clip=true})
-- the staff
local r = brush{kind="rigger", width=0.8, point=1}
r:load(coatP, 0.8)
r:stroke({{fx + 5.8, fb - 16}, {fx + 7.5, fb - 8}, {fx + 9.2, fb + 0.5}}, {pressure={0.9, 0.7}})
