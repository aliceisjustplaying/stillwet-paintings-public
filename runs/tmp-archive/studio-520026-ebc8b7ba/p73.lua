allap = BOWL:grow(2)
for _, a in ipairs(AP) do allap = allap + ashape(a):grow(6) end
room = everywhere() - allap:grow(8)      -- the room, but never across the still life
-- one soft light from the upper left, laid by stipple so it stays smooth
stipple(room * pool1, {pile=g_wm, width=5, coverage=8, pressure={0.55, 0.9}, cluster=0.25, dips={7, 1.0, 0.3}})
stipple(room * pool2, {pile=g_wt, width=4, coverage=8, pressure={0.55, 0.9}, cluster=0.25, dips={7, 1.0, 0.3}})
-- and the far side falls away, so the light has somewhere to come from
work(room * (ellipse(920, 420, 430, 300):blur(200)), {hand="glaze", pile=g_dk2, coverage=2.2})
work(room * (ellipse(600, 430, 300, 190):blur(150)), {hand="glaze", pile=g_dk2, coverage=1.6})
work(room * (ellipse(80, 760, 300, 200):blur(150)), {hand="glaze", pile=g_dk2, coverage=1.4})
