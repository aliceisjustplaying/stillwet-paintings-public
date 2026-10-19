woodP = pile{{"lead white",2},{"yellow ochre",0.4},{"raw umber",0.5},{"smalt",0.15}, medium=0.05}
-- new broken top: dark bark with a tall splinter at left
local top = poly({{52,634},{53,622},{55,611},{57.5,603},{60,611},{62,620},{66,617},{70,621},{75,616.5},{80,620},{86,623},{88,634}}, true)
work(top, {hand="detail", pile=barkK, coverage=4, fill=true, angle=math.pi/2, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.6}})
-- pale broken wood on the right face of the break and inside the splinter
local wood = poly({{71,622},{75,618.5},{80,621.5},{85,624.5},{84,627},{78,625},{73,625}}, true) + poly({{57.5,606},{59.3,611},{60.5,619},{58.8,619}}, true)
work(wood, {hand="detail", pile=woodP, coverage=4, fill=true, angle=math.pi/2, load=1, pressure={0.5,0.8}, tool={kind="round", width=1, point=0.8}})
-- bark fissures on the stump
local f = brush{kind="round", width=1.4, point=1}
f:load(barkL, 0.4)
for i=1,10 do local x = rand(55, 85); f:stroke({{x, rand(628,634)}, {x + rand(-1,1), rand(640,650)}}, {pressure={0.3,0.1}}) end
