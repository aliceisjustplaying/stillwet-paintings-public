local function U(a,b) return a + (b-a)*math.random() end
local sl = rect(211, 360, 9, 28) * oakThickM:grow(1.5)
work(sl, {hand="detail", pile=barkDark, coverage=3, fill=true, angle=88, pressure={0.6,0.9}, load=0.9, tool={kind="round", width=1.4}})
math.randomseed(77)
local b = brush{kind="round", width=0.9}
for i=1,7 do
  local x = 188 + i*3.6 + U(-1,1)
  b:load(barkLight, 0.5)
  b:stroke({{x, 352 + U(0,4)}, {x + U(-1.5,1.5), 370}, {x + U(-2,2), 392 - U(0,4)}}, {pressure={0.2,0.45,0.15}})
end
