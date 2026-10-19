-- the walker seen from behind, in a long dark greatcoat and a hat, a stick, going toward the cross
COAT = outline{pts={{695.5,575,"c"},{699,572.6},{704.5,572.8},{708.6,575.4,"c"},{709.8,584},{711.4,596},{713.2,607.5,"c"},
  {706,608.6},{700,608.2},{692.6,607,"c"},{694,596},{694.4,584}}, char="firm", seed=111}
coatm = COAT:mask()
work(coatm, {hand="body", tool="round 1.6", length={3, 9}, coverage=3.2, angle=1.62, angle_jitter=0.25, edge="firm",
  color=function(x, y) return mix("#262b29", "#2f3431", smoothstep(575, 606, y)) end, medium=0.15})
-- legs: the left planted, the right stepping off, heel up
local leg = brush("round", 2.2)
leg:load("#24211f", 1)
leg:stroke({{698.2, 606}, {698.0, 612}, {697.6, 618.2}}, {pressure={0.8, 0.8}, ramps={0, 0.05}})
leg:stroke({{705.6, 606}, {706.6, 611}, {708.4, 615.6}}, {pressure={0.75, 0.7}, ramps={0, 0.05}})
-- head (hair seen from behind), a high collar, and a round-crowned hat
local headm = ellipse(702.1, 570.2, 2.9, 3.4):roughen(0.3, 3, 112, 0.3)
work(headm, {hand="detail", tool="round 1.2", coverage=3, color="#2b2623", edge="firm", length={1, 3}})
local collar = poly({{697.4,575.2},{698.6,571.8},{702,573.2},{705.6,571.8},{707,575.4}}):roughen(0.3, 3, 113, 0.3)
work(collar, {hand="detail", tool="round 1.2", coverage=3, color="#232826", edge="firm", length={1, 3}})
local hatm = (ellipse(702.1, 563.6, 3.6, 3.4) + ellipse(702.1, 567.0, 6.2, 1.3)):roughen(0.25, 3, 114, 0.3)
work(hatm, {hand="detail", tool="round 1.2", coverage=3.5, color="#1b1b1c", edge="firm", length={1, 3}, angle=0})
-- the right arm reaching forward to the stick, and the stick planted ahead
local arm = brush("round", 2.4)
arm:load("#272b29", 1)
arm:stroke({{708.4, 577}, {710.4, 585}, {711.2, 591.5}}, {pressure={0.8, 0.7}, ramps={0, 0.1}})
local st = brush{kind="rigger", width=0.9, point=0.5}
st:load("#2e2823", 0.9)
st:stroke({{710.8, 588}, {713.6, 603}, {716.4, 619}}, {pressure={0.7, 0.6}, ramps={0, 0.1}})
-- the glow catching the coat's left shoulder and back edge
local rim = brush{kind="round", width=1.0, point=0.6}
rim:load("#6e675f", 0.6, {medium=0.2})
rim:stroke({{698.6, 573.4}, {696, 576}, {695.2, 586}, {694.4, 598}}, {pressure={0.5, 0.15}, ramps={0.1, 0.6}, shake=0.4})
