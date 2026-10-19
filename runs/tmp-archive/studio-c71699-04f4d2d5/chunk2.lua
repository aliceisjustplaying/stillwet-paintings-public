-- Underdrawing: establishing composition with chalk and pencil
local ch = chalk()
local p = pencil("HB")

-- Table edge lines
ch:line({{0, 525}, {1000, 520}}, {pressure = 0.35, smooth = false})
ch:line({{0, 675}, {1000, 675}}, {pressure = 0.45, smooth = false})

-- Pitcher contours
-- Lip and rim
ch:sketch({{545, 310}, {590, 303}, {635, 310}, {640, 320}, {590, 327}, {540, 320}, {545, 310}}, {passes = 2, wander = 1.5, pressure = 0.35})
-- Neck
ch:line({{550, 320}, {552, 370}}, {pressure = 0.4})
ch:line({{630, 320}, {628, 370}}, {pressure = 0.4})
-- Belly contour left
ch:sketch({{552, 370}, {515, 420}, {500, 480}, {510, 550}, {535, 605}, {550, 625}}, {passes = 2, wander = 2, pressure = 0.4})
-- Belly contour right
ch:sketch({{628, 370}, {665, 420}, {680, 480}, {670, 550}, {645, 605}, {630, 625}}, {passes = 2, wander = 2, pressure = 0.4})
-- Base
ch:sketch({{550, 625}, {590, 632}, {630, 625}}, {passes = 2, wander = 1.5, pressure = 0.4})
-- Handle
ch:sketch({{628, 355}, {675, 365}, {695, 410}, {690, 460}, {665, 490}}, {passes = 2, wander = 2, pressure = 0.4})
ch:sketch({{628, 370}, {660, 380}, {675, 415}, {672, 455}, {655, 485}}, {passes = 2, wander = 1.5, pressure = 0.35})

-- Napkin draped on left
ch:sketch({{150, 545}, {210, 555}, {260, 580}, {280, 630}, {270, 675}, {265, 735}, {230, 745}, {210, 730}, {180, 675}, {140, 660}}, {passes = 2, wander = 2.5, pressure = 0.35})
-- Fold creases in napkin
p:sketch({{180, 550}, {220, 620}, {250, 675}, {245, 735}}, {passes = 2, wander = 1.5, pressure = 0.3})
p:sketch({{220, 565}, {255, 630}, {265, 675}}, {passes = 2, wander = 1.5, pressure = 0.3})

-- Whole lemon (left-center)
ch:sketch({{305, 625}, {320, 605}, {365, 595}, {415, 615}, {425, 640}, {405, 665}, {355, 672}, {315, 655}, {305, 625}}, {passes = 3, wander = 2, pressure = 0.4})
-- Lemon half (cut face tilted)
ch:sketch({{445, 650}, {470, 625}, {515, 625}, {540, 650}, {535, 680}, {495, 700}, {455, 685}, {445, 650}}, {passes = 3, wander = 2, pressure = 0.4})
-- Inner pith circle for lemon half
p:sketch({{455, 652}, {475, 635}, {510, 635}, {528, 652}, {523, 675}, {492, 690}, {462, 678}, {455, 652}}, {passes = 2, wander = 1, pressure = 0.3})

-- Walnut on right
ch:sketch({{725, 655}, {740, 642}, {760, 650}, {765, 665}, {745, 672}, {730, 668}, {725, 655}}, {passes = 2, wander = 1.5, pressure = 0.35})
p:line({{742, 643}, {744, 671}}, {pressure = 0.4}) -- seam

-- Light shadow indications
p:hatch(ellipse(620, 645, 120, 25), {angle = 0.2, spacing = 8, pressure = 0.25})
p:hatch(ellipse(380, 670, 70, 18), {angle = 0.2, spacing = 8, pressure = 0.2})
p:hatch(ellipse(500, 695, 60, 15), {angle = 0.2, spacing = 8, pressure = 0.2})

print("Underdrawing completed.")
