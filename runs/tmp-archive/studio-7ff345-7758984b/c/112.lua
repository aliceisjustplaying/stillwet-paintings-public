print(wait(3*24*60)); print(drying(330, 480), drying(250, 470))
-- the drift swallowed the fallen limb: lay it again, a little further down the slope, with only a hair of snow on it
local r = brush{kind="round", width=2.2, point=0.7}
r:load(barkDark, 1)
r:stroke({{318, 488}, {334, 485}, {350, 486.5}, {368, 482}}, {pressure={0.75, 0.35}, ramps={0.05, 0.3}})
local t = brush{kind="rigger", width=0.8, point=1}
t:load(barkDark, 0.9)
t:stroke({{333, 485}, {337, 479}, {342, 475}}, {pressure={0.6, 0.05}})
t:stroke({{352, 486}, {358, 490}, {363, 491.5}}, {pressure={0.5, 0.05}})
t:stroke({{320, 487.5}, {314, 484}, {310, 483.5}}, {pressure={0.5, 0.05}})
-- its shadow
local s = brush{kind="round", width=2, point=0.5}
s:load(duskLand, 0.4)
s:stroke({{316, 491}, {336, 489.5}, {352, 490.5}, {370, 486}}, {pressure={0.4, 0.2}, ramps={0.2, 0.4}})
