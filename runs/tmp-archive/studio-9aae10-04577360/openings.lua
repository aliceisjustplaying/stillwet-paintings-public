local kn = below(function(x) return knollf(x) - 0.5 end)
local O1 = poly({{583,470.5},{595,470},{606,469},{606.5,489},{582,489}})
local I1 = poly({{581,469},{585.5,469.5},{589.5,489},{581,489}})
local O2 = poly({{629,471.5},{640,471.2},{651,470.5},{651,489},{629,489}})
local I2 = poly({{631,489.5},{633,485},{637,482.5},{642,482},{646,483.5},{649.5,486.5},{650.5,489.5}}, true)
local O3 = poly({{677,470},{687,470.4},{696,471},{696,489},{677,489}})
local I3 = poly({{689.5,470.5},{697,470.5},{697,489},{693.5,489},{691.5,483},{689,477}})
local light = (O1 - I1) + (O2 - I2) + (O3 - I3)
local op = {hand="detail", coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.2, point=0.5}}
op.pile = plainC; work(light - kn, op)
op.pile = crest; work(light * kn, op)
op.pile = rkBase; op.angle = 1.4; work(I1 + I2 + I3, op)
-- snow on the slab's upper-left edge
local sl = {{739,482},{743,473},{748,464},{752,459},{757,456.5}}
work(ribbon(sl, {1.2,1.8,2.2,2.2,1.6}):roughen(0.4, 4, 7), {hand="detail", pile=capShade, coverage=4, fill=true, load=1, pressure={0.5,0.8}, tool={kind="round", width=1, point=0.8}})
-- low drifts banked against the uprights' feet
local d = ellipse(566,490,13,2.6) + ellipse(617,490.5,11,2.4) + ellipse(664,490,12,2.6) + ellipse(711,490.5,13,2.6) + ellipse(760,491,18,3)
work(d:roughen(0.6, 5, 9), {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.2, point=0.5}})
