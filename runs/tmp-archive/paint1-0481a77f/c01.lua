-- "Evening on the shore with erratics": a calm Baltic evening just after sunset. A waxing
-- crescent over the afterglow, a low dark headland on the left, the sea like a mirror, and
-- erratic boulders at the waterline seen against the light.
canvas{style="friedrich", aspect=1.5, seed=417, hand=true}
skypal = pal:only{"lead white","pale smalt","cobalt blue","yellow ochre","raw umber","red earth","chrome yellow","vermilion"}
earthpal = pal:only{"lead white","yellow ochre","raw umber","red earth","bone black","pale smalt"}
HZ = 368                     -- the sea horizon
SUNX = 596                   -- the sun has just gone down here
MOON = {738, 196, 8}         -- a young crescent above the glow
-- the headland on the right: a low wooded ridge running out into the sea, a hump near its end
hn = noise{seed=5, octaves=5, period=90}
headtop = function(x0)
  local x = 1000 - x0
  local up = 30 * (1 - smoothstep(0, 300, x)) + 13 * math.exp(-((x - 188)/46)^2)
     + 7 * math.exp(-((x - 72)/40)^2) + 4 + 5 * hn:at01(x, 0)
  return HZ - up * (1 - smoothstep(262, 352, x)) - 1.2
end
head = mask(function(x, y) return (y >= headtop(x) and y <= HZ + 1 and x > 640) and 1 or 0 end):blur(0.6)
-- a far pale spit on the left, barely above the sea
spittop = function(x) local s = 1 - smoothstep(60, 150, x); return HZ - 4.5 * s - 1.5 * hn:at01(x, 40) * s end
spit = mask(function(x, y) return (x < 160 and y >= spittop(x) and y <= HZ + 0.5) and 1 or 0 end):blur(0.5)
-- the glow: a broad warm swell low over SUNX, uneven along the horizon
gn = noise{seed=17, octaves=3, period=260}
glow = function(x, y)
  local gx = math.exp(-((x - SUNX)/(300 + 70*gn(x, 0)))^2)
  return gx * smoothstep(HZ - 330, HZ - 8, y)
end
-- the sky: deep slate at the top, a cool pale green-gray zone, warm at the horizon over the glow
skycol = function(x, y)
  local t = clamp(y / HZ, 0, 1)
  local c = gradient({{0,"#3f4b63"},{0.28,"#5d6a80"},{0.55,"#8d98a0"},{0.78,"#b3b6a7"},{1,"#c7bca0"}}, t)
  return mix(c, "#e8cf98", 0.66*glow(x, y))
end
-- cloud banks: a long low bank lying over the sea that thins and parts over the glow, and a few
-- thin high streaks
bn = noise{seed=9, octaves=5, period=240, stretch={0, 5}}
bn2 = noise{seed=23, octaves=4, period=120, stretch={0, 4}}
band = function(y, c, th) return 1 - smoothstep(0.55*th, th, math.abs(y - c)) end
c1 = function(x) return 132 + 18*bn(x*0.6, 0) + 0.05*(x - 500) end
c2 = function(x) return 300 + 10*bn(x, 90) - 0.028*(x - 500) end
bank1 = mask(function(x, y)
  local th = 15*smoothstep(0.0, 0.4, bn2(x*1.7, 40)) * (1 - 0.6*smoothstep(560, 760, x))
  return band(y, c1(x), th)
end):blur(1.5)
bank2 = mask(function(x, y)
  local th = (22 + 12*bn2(x, 300)) * (1 - 0.85*math.exp(-((x - SUNX - 20)/120)^2))
  return band(y, c2(x), th) * smoothstep(-0.4, 0.0, bn2(x*1.3, 500))
end):blur(1.5)
clouds = bank1 + bank2
cloudcol = function(x, y)
  local high = y < 220
  local body = high and "#646a7c" or "#77727c"
  local under = high and "#a99990" or "#dcb68c"
  local cc = high and c1(x) or c2(x)
  local lit = smoothstep(cc - 4, cc + 16, y) * (0.3 + 0.7*math.exp(-((x - SUNX)/300)^2))
  return mix(body, under, lit)
end
-- the waterline along the shore, and the shore under it
wn = noise{seed=31, octaves=4, period=120}
WL = function(x) return 572 + 0.02*(x - 500) + 6*wn(x, 0) + 24*math.exp(-((x - 318)/140)^2) end
shore = below(WL)
sea = mask(function(x, y) return (y > HZ and y < WL(x)) and 1 or 0 end)
-- the erratics. E1: the big one standing in the shallows left of center, its crown just over the
-- horizon; a high broken shoulder on the left, a long back falling right to a fracture face
E1 = {{168,598,"c"},{160,556},{168,508,"c"},{186,452},{212,404},{240,370,"c"},{272,352},{306,348,"c"},
      {340,360},{372,380},{408,408,"c"},{438,428},{458,452,"c"},{470,498},{474,548,"c"},{478,596,"c"},
      {400,604},{300,606},{226,603}}
E1_BROW = {{240,372},{290,386},{350,396},{408,410}}
E1_CRACK = {{306,350},{314,398},{306,456},{318,530}}
-- E2: a lower, flatter stone at the water's edge on the right
E2 = {{652,586,"c"},{655,558},{671,536,"c"},{703,524},{737,527,"c"},{761,545},{771,566,"c"},{769,588,"c"},{712,592}}
-- small stones: one half-drowned in the shallows, one far out, two on the near shore
E3 = {{497,582,"c"},{501,568},{514,561,"c"},{529,566},{533,583,"c"}}
E4 = {{872,566,"c"},{880,558},{902,555,"c"},{922,561},{926,568,"c"}}
E5 = {{548,650,"c"},{552,634},{568,625,"c"},{590,628},{604,640,"c"},{606,652,"c"}}
E6 = {{80,660,"c"},{86,646},{104,640,"c"},{124,645},{132,660,"c"}}
print(H, head:area(), spit:area(), bank1:area(), bank2:area(), shore:area())
