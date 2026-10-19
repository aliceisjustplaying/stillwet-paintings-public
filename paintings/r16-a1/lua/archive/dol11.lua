-- openings under the capstone: the misty plain and the knoll's snow seen through
local o1 = outline{{588,472,"c"},{597,470},{604,473,"c"},{606,482},{605,489,"c"},{589,489,"c"},{587,481}, closed=true, char="broken", seed=401, amount=0.6}
local o2 = outline{{631,473,"c"},{641,471},{650,473,"c"},{651,481},{650,488,"c"},{632,488,"c"},{630,481}, closed=true, char="broken", seed=402, amount=0.6}
local o3 = outline{{680,472,"c"},{688,470},{694,472,"c"},{695,480},{694,488,"c"},{681,488,"c"},{679,480}, closed=true, char="broken", seed=403, amount=0.6}
OPEN = o1:mask() + o2:mask() + o3:mask()
local far = OPEN * above(function(x) return 479 end)
local near = OPEN * below(function(x) return 479 end)
work(far, {hand="detail", pile=dist2, coverage=4, fill=true, angle=0, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.5, point=0.5}})
work(near, {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.5, point=0.5}})
