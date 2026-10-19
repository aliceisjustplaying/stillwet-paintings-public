local det = function(m, p, w, seed, cov, ang) work(m, {hand="detail", tool={kind="round", width=w or 0.8, point=0.6}, pile=p, angle=ang or 0, coverage=cov or 3, fill=true, seed=seed}) end
local gx, gy = 884, 470
local hay = pile{{"yellow ochre", 1.4}, {"lead white", 0.8}, {"raw umber", 0.25}, {"green earth", 0.15}, medium=0.08}
local haylit = pile{{"lead white", 1.5}, {"yellow ochre", 1}, {"chrome yellow", 0.1}, {"red earth", 0.05}, medium=0.08}
local hayshade = pile{{"raw umber", 0.8}, {"yellow ochre", 0.6}, {"green earth", 0.4}, {"pale smalt", 0.2}, {"lead white", 0.2}, medium=0.1}
local wood = pile{{"raw umber", 1}, {"bone black", 0.3}, {"red earth", 0.1}, {"lead white", 0.1}, medium=0.08}
local cast = pile{{"green earth", 1.3}, {"raw umber", 0.7}, {"Prussian blue", 0.06}, {"yellow ochre", 0.3}, medium=0.3}
-- shadow to the right
det(poly({{gx - 10, gy - 0.5}, {gx + 12, gy - 1.5}, {gx + 40, gy - 0.5}, {gx + 38, gy + 1.2}, {gx - 10, gy + 1.2}}, true), cast, 1, 7201, 2)
-- load of hay on the wagon
local load = poly({{gx - 13, gy - 5}, {gx - 14, gy - 10}, {gx - 10, gy - 15.5}, {gx + 9, gy - 16}, {gx + 13.5, gy - 11}, {gx + 12.5, gy - 5}}, true):roughen(0.4, 2, 7)
det(load, hay, 0.9, 7202, 3, math.pi/2)
det(load * rect(gx + 2, 0, 20, 700), hayshade, 0.8, 7203, 1.6, math.pi/2)
det(load * rect(gx - 20, gy - 17, 16, 7), haylit, 0.7, 7204, 1.4, math.pi/2)
-- wagon bed, ladder side, wheels
local wb = brush{kind="round", width=0.6, point=1}
wb:load(wood, 0.5)
wb:stroke({{gx - 13, gy - 4.6}, {gx + 12.5, gy - 4.6}}, {pressure={0.6, 0.6}})
wb:stroke({{gx - 12.5, gy - 7.5}, {gx + 12, gy - 7.8}}, {pressure={0.35, 0.3}})
for i=0,6 do local x = gx - 12 + i*4; wb:stroke({{x, gy - 4.6}, {x + 0.3, gy - 8}}, {pressure={0.3, 0.3}}) end
for _,wx in ipairs({gx - 8, gx + 7.5}) do
  local pts = {}
  for k=0,16 do local a = k/16*2*math.pi; pts[#pts+1] = {wx + 2.9*math.cos(a), gy - 2.9 + 2.9*math.sin(a)} end
  wb:stroke(pts, {pressure={0.45, 0.45}})
  wb:stroke({{wx - 2.5, gy - 2.9}, {wx + 2.5, gy - 2.9}}, {pressure={0.2, 0.2}})
  wb:stroke({{wx, gy - 5.4}, {wx, gy - 0.4}}, {pressure={0.2, 0.2}})
end
-- the pole
wb:stroke({{gx - 13, gy - 3.5}, {gx - 24, gy - 5}}, {pressure={0.35, 0.3}})
-- two horses harnessed, facing left
local h1 = horse_mask(gx - 30, gy + 0.5, 12, -1, false)
local h2 = horse_mask(gx - 27, gy + 1, 12, -1, false)
det(h2, pile{{"raw umber", 1}, {"bone black", 0.45}, {"red earth", 0.2}, medium=0.08}, 0.8, 7205)
det(h1, pile{{"red earth", 1}, {"raw umber", 0.9}, {"bone black", 0.1}, {"yellow ochre", 0.2}, medium=0.08}, 0.8, 7206)
-- a man on top of the load with a fork, and one on the ground handing up hay
local shirt = pile{{"lead white", 2}, {"yellow ochre", 0.2}, {"raw umber", 0.1}, medium=0.08}
local dk = pile{{"raw umber", 1}, {"bone black", 0.3}, {"pale smalt", 0.2}, medium=0.08}
local top = poly({{gx - 1.5, gy - 16}, {gx - 1.8, gy - 21}, {gx + 0.2, gy - 22.5}, {gx + 1.6, gy - 21}, {gx + 1.3, gy - 16}}, true)
det(top, shirt, 0.6, 7207, 3, math.pi/2)
det(ellipse(gx + 0.1, gy - 23.5, 1.1, 1.2), pile{{"yellow ochre", 1}, {"lead white", 0.6}, {"red earth", 0.2}, medium=0.08}, 0.5, 7208)
det(rect(gx - 1.5, gy - 16.5, 3, 1.2), dk, 0.5, 7209)
local gm_x = gx + 19
local low = poly({{gm_x - 1.3, gy}, {gm_x - 1.6, gy - 5}, {gm_x - 1.4, gy - 9.5}, {gm_x + 0.3, gy - 10.5}, {gm_x + 1.5, gy - 9.5}, {gm_x + 1.5, gy - 5}, {gm_x + 1.2, gy}}, true)
det(low * rect(0, gy - 11, 2000, 6), shirt, 0.6, 7210, 3, math.pi/2)
det(low * rect(0, gy - 5, 2000, 6), dk, 0.6, 7211, 3, math.pi/2)
det(ellipse(gm_x + 0.1, gy - 11.6, 1.1, 1.2), pile{{"yellow ochre", 1}, {"lead white", 0.6}, {"red earth", 0.2}, medium=0.08}, 0.5, 7212)
wb:load(wood, 0.4)
wb:stroke({{gx + 3, gy - 20}, {gx + 7, gy - 26}}, {pressure={0.25, 0.2}})
wb:stroke({{gm_x - 1, gy - 8}, {gm_x - 6, gy - 20}}, {pressure={0.25, 0.2}})
wb:load(hay, 0.5)
wb:touch(gm_x - 6.4, gy - 21, {pressure=0.6})
