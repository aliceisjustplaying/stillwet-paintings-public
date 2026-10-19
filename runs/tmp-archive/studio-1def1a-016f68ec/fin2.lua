local b = brush("filbert", 3)
for i, y in ipairs({487, 499, 514, 528, 541, 556}) do
  local p = (i % 2 == 0) and Wb2 or reflRuss
  b:reload(p, 0.45)
  b:stroke({{292, y}, {302, y+0.4}, {313, y}}, {pressure={0.55,0.3}, ramps={0.1,0.3}})
end
-- restate the stakes
local s = brush("flat", 4.5)
s:reload(stakeP, 0.9)
s:stroke({{118,578},{119.5,545},{121,512}}, {pressure={0.9,0.8}, ramps={0.02,0.05}, orient="across"})
s:reload(stakeP, 0.9)
s:stroke({{168,584},{167,560},{166,536}}, {pressure={0.85,0.75}, ramps={0.02,0.05}, orient="across"})
s:reload(stakeP, 0.8)
s:stroke({{205,590},{206,575},{207,560}}, {pressure={0.75,0.7}, ramps={0.02,0.05}, orient="across"})
-- a touch of the glow on the stake tops
local g = brush{kind="round", width=2, point=0.6}
g:reload(glowThin, 0.4)
g:stroke({{122,513},{122.5,530}}, {pressure={0.3,0.1}})
g:reload(glowThin, 0.4)
g:stroke({{167.5,537},{167.8,550}}, {pressure={0.3,0.1}})
