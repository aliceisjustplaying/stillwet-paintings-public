-- the snow took the whole of the thin limb: put back its dark underside and the stubs' shadowed sides
local r = brush{kind="rigger", width=0.9, point=1}
r:load(barkDark, 0.9)
r:stroke({{300, 475.3}, {318, 472.3}, {334, 474.2}, {352, 469.8}}, {pressure={0.7, 0.2}, ramps={0.05, 0.3}})
r:stroke({{319, 471}, {323.2, 464.5}, {327.8, 460.5}}, {pressure={0.45, 0.05}})
r:stroke({{338, 473}, {344, 476.8}, {350, 478.6}}, {pressure={0.45, 0.05}})
-- its cool shadow on the snow just below
local s = brush{kind="round", width=2, point=0.5}
s:load(landShade2, 0.35)
s:stroke({{298, 478}, {318, 476}, {336, 477}, {354, 473}}, {pressure={0.4, 0.2}, ramps={0.2, 0.4}})
