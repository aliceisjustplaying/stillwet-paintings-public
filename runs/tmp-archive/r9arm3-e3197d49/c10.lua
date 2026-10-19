-- the wayside cross, old wood leaning a little right, half buried; a small gable roof over it
local post = brush{kind="flat", width=5.6, stiffness=0.7}
post:load("#3b3530", 1, {medium=0.12})
post:stroke({{606.4, 510}, {603.4, 542}, {600.6, 578}, {598.2, 612}}, {pressure={0.85, 0.9}, ramps={0.0, 0.0}, orient="across", shake=0.25})
post:reload("#403934", 0.9)
post:stroke({{598.4, 612}, {600.8, 580}, {603.6, 545}, {606.2, 512}}, {pressure={0.8, 0.85}, ramps={0.0, 0.02}, orient="across", shake=0.25})
local bar = brush{kind="flat", width=4.4, stiffness=0.7}
bar:load("#3a342f", 1, {medium=0.12})
bar:stroke({{578, 531.5}, {604, 529.8}, {633, 532.4}}, {pressure={0.85, 0.85}, ramps={0.0, 0.02}, orient="across", shake=0.25})
bar:stroke({{633, 532.6}, {604, 530.0}, {578.5, 531.8}}, {pressure={0.8, 0.8}, ramps={0.0, 0.02}, orient="across", shake=0.25})
-- weathered gray on the faces toward the glow
local lit = brush("round", 1.1)
lit:load("#6c645c", 0.6, {medium=0.2})
lit:stroke({{604.2, 513}, {601.8, 545}, {599.2, 580}, {597.6, 602}}, {pressure={0.5, 0.35}, ramps={0.1, 0.4}, shake=0.5})
lit:stroke({{580, 530.0}, {603, 528.6}}, {pressure={0.45, 0.3}, ramps={0.2, 0.4}, shake=0.5})
-- the gable: two short boards, dark underside
local roof = brush{kind="flat", width=2.6, stiffness=0.7}
roof:load("#2f2a26", 1)
roof:stroke({{596.5, 512.5}, {606.5, 502.5}}, {pressure={0.85, 0.85}, ramps={0, 0}, orient="across"})
roof:stroke({{606.5, 502.5}, {616.5, 512.8}}, {pressure={0.85, 0.85}, ramps={0, 0}, orient="across"})
-- snow lying on the roof and the crossbar
local sn = brush("round", 1.5)
sn:load("#e3ddd4", 0.9, {medium=0.1})
sn:stroke({{580, 528.9}, {592, 528.2}, {602, 527.8}}, {pressure={0.7, 0.45}, ramps={0.1, 0.3}, shake=0.6})
sn:stroke({{609, 528.2}, {620, 528.9}, {630, 530.2}}, {pressure={0.65, 0.35}, ramps={0.1, 0.4}, shake=0.6})
sn:stroke({{597, 510.2}, {606.3, 500.8}}, {pressure={0.6, 0.4}, ramps={0.1, 0.3}})
sn:stroke({{606.7, 500.8}, {615.4, 509.6}}, {pressure={0.55, 0.3}, ramps={0.1, 0.4}})
