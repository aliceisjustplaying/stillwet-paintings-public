hull = outline{{612,544,"c"},{628,549},{660,551},{694,549},{708,543,"c"},{700,547},{690,552},{662,555},{630,554},{618,550}, closed=true, char="firm", seed=151, amount=0.4}
hullM = hull:mask()
fig = body_of{spine={{672,545},{671,532},{670,522},{669,514}}, widths={5.5,5,5.5,4.2}, limbs={{{669,512},{669,506},widths={3.4,3.4}}, {{670,524},{664,530},{659,536},widths={2.2,2,1.8}}, {{670,522},{676,528},{681,531},widths={2,1.8,1.6}}}, char="soft", seed=152}
figM = fig:mask()
pBoat = pile{{"raw umber",1.5},{"bone black",0.7},{"smalt",0.3},{"red earth",0.2}}
work(hullM, {hand="detail", tool={kind="round", width=2.5, point=0.4}, pile=pBoat, coverage=4, load=0.95, fill=true})
work(figM, {hand="detail", tool={kind="round", width=2, point=0.4}, pile=pBoat, coverage=4, load=0.95, fill=true})
local r = brush{kind="rigger", width=1.6, point=1}
r:load(pBoat, 0.8)
r:stroke({{690,488},{676,520},{662,552},{656,566}}, {pressure={0.55,0.45}, ramps={0.05,0.1}})
