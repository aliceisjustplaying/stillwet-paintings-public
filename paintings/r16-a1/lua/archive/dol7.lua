local rockbits = poly({{542,455},{546,447},{553,442},{559,444},{562,451},{558,458},{548,459}}, true)
  + poly({{709,441},{719,438},{729,441},{737,448},{740,456},{729,458},{716,455},{710,448}}, true)
  + poly({{586,457},{590,449},{598,446},{606,448},{611,456}}, true)
  + poly({{655,458},{659,450},{668,447},{678,449},{683,457}}, true)
  + poly({{690,456},{694,452},{700,452},{703,456}}, true)
work(rockbits, {hand="detail", pile=rkA, coverage=3.5, fill=true, angle=0.2, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.8, point=0.6}})
-- cool skylight on the upper faces of the exposed rock
local lit = (rockbits * above(function(x) return 447 + 0.03*(x-640) end))
work(lit, {hand="detail", pile=rkC, coverage=1.5, fill=false, angle=0.1, pressure={0.3,0.5}, tool={kind="round", width=1.5, point=0.6}})
-- extra snow: a heavier mound on the left-center top, and a long drip
local mound = poly({{565,440},{578,431},{596,425},{618,423},{640,425},{652,429},{640,432},{610,433},{585,437}}, true)
work(mound, {hand="detail", pile=snowTop, coverage=3, fill=true, angle=0, load=1, pressure={0.5,0.8}, tool={kind="round", width=2, point=0.6}})
local drip = poly({{619,452},{624,452},{630,453},{636,452},{633,458},{629,461},{625,459}}, true) + poly({{566,452},{572,452},{570,457},{567,456}}, true)
work(drip, {hand="detail", pile=capShade, coverage=3, fill=true, angle=math.pi/2, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.3, point=0.8}})
