blade = poly({{518,650},{560,654},{620,661},{700,672},{766,681},{766,695},{700,688},{630,678},{575,668},{540,659}}, true)
bolster = poly({{764,679},{779,681},{779,698},{764,696}})
kHandle = ribbon({{779,690},{830,697},{880,704},{930,711}}, {17,18,18,16})
knife = blade + bolster + kHandle
bBase = pile{{"lead white",1.5},{"bone black",0.45},{"raw umber",0.3},{"pale smalt",0.4}}
bHi = pile{{"lead white",3},{"pale smalt",0.2},{"yellow ochre",0.05}}
bDark = pile{{"bone black",1},{"lead white",0.6},{"raw umber",0.4}}
hWood = pile{{"raw umber",1},{"bone black",0.7},{"red earth",0.4}}
hLight = pile{{"raw umber",1},{"lead white",0.7},{"yellow ochre",0.3},{"red earth",0.2}}
kShadow = pile{{"bone black",1},{"raw umber",1.2},{"lead white",0.15}}
-- cast shadow of the blade on the table, and of the handle on the front face
local b = brush("filbert", 6)
b:reload(kShadow, 0.6)
b:stroke({{540,664},{620,680},{700,692}}, {pressure={0.3,0.6}, ramps={0.3,0.1}, clip=table_top})
b:reload(kShadow, 0.6)
b:stroke({{690,690},{760,698}}, {pressure={0.6,0.6}, clip=table_top})
local fsh = poly({{790,700},{940,720},{950,748},{800,730}}, true):blur(6) * front
local fb = brush("filbert", 10)
for i = 0, 3 do
  fb:reload(kShadow, 0.6)
  fb:stroke({{795, 708 + i*6},{870, 718 + i*6},{945, 728 + i*6}}, {pressure={0.6,0.5}, clip=fsh})
end
-- blade
local bb = brush("filbert", 5)
for i = 0, 3 do
  bb:reload(bBase, 0.7)
  bb:stroke({{522 + i*6, 652 + i*1.5}, {620, 664 + i*2.5}, {700, 676 + i*3}, {766, 684 + i*3}}, {pressure={0.4,0.6}, ramps={0.3,0.1}, clip=blade})
end
bb:reload(bDark, 0.6)
bb:stroke({{560,665},{640,677},{766,693}}, {pressure={0.3,0.5}, ramps={0.3,0.1}, clip=blade})
local r = brush{kind="round", width=3, point=0.5}
r:reload(bHi, 0.8)
r:stroke({{530,652},{620,662},{700,673},{764,682}}, {pressure={0.2,0.6}, ramps={0.4,0.1}, clip=blade:grow(1)})
-- bolster
local s = brush("flat", 5)
s:reload(bBase, 0.7)
s:stroke({{771,680},{771,697}}, {pressure={0.6,0.6}, clip=bolster})
s:reload(bHi, 0.5)
s:stroke({{768,681},{768,690}}, {pressure={0.4,0.2}, clip=bolster})
-- handle
local h = brush("filbert", 8)
for i = -1, 1 do
  h:reload(hWood, 0.8)
  h:stroke({{780, 690 + i*5}, {855, 700.5 + i*5}, {930, 711 + i*5}}, {pressure={0.6,0.6}, ramps={0.1,0.1}, clip=kHandle})
end
local hl = brush{kind="round", width=4, point=0.3}
hl:reload(hLight, 0.7)
hl:stroke({{784,685},{850,694},{925,705}}, {pressure={0.5,0.3}, ramps={0.2,0.4}, clip=kHandle})
