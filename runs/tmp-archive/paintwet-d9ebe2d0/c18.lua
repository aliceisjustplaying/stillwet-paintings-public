-- the young moon, a thin crescent lit on the side toward the set sun (down and a little left), laid with short
-- touches clipped to its mask on the dry sky so the horns come to points
local mx, my, R = MOON[1], MOON[2], 8.5
local dx, dy = SUNX - mx, HZ - my
local l = math.sqrt(dx*dx + dy*dy); dx, dy = dx/l, dy/l
moonM = (ellipse(mx, my, R, R) - ellipse(mx - 3.4*dx, my - 3.4*dy, R*1.02, R*1.02)):soften(0.4)
work(moonM, {hand="detail", tool="round 1.2", color="#efe5c8", angle=math.atan(dy, dx) + math.pi/2, angle_jitter=0.3,
  length={2, 5}, coverage=4, medium=0.15, load=1.0, aim="masstone", clip=moonM})
print(moonM:area())
