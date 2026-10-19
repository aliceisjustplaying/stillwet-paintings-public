dry()
-- a thin young moon high on the right, its lit limb toward the sun that has set (lower left), and the evening star
local cres = ellipse(812, 148, 7.2, 7.2) - ellipse(814.6, 146.0, 6.9, 7.0)
work(cres:soften(0.3), {hand="detail", tool="round 0.9", length={1, 3}, coverage=3.5, angle=2.3, edge="found", color="#ebe3c9", medium=0.2})
local star = brush{kind="round", width=1.3}
star:load("#eee6cf", 0.8)
star:touch(652, 352, {pressure=0.75, twist=0.4})
-- crows: two perched in the oak's upper limbs, three going over toward the far wood
local cr = brush{kind="round", width=1.6, point=0.6}
local function perched(x, y, s, face)
  -- a crow hunched on the limb: a heavy body, the head sunk in, the tail hanging down past the limb
  local body = brush{kind="round", width=2.6 * s, point=0.3}
  body:load("#1c1a1b", 0.95)
  body:stroke({{x - 1.8 * s * face, y - 1.0 * s}, {x, y - 1.9 * s}, {x + 1.6 * s * face, y - 2.1 * s}}, {pressure={0.8, 0.9}, ramps={0.1, 0.15}})
  local hd = brush{kind="round", width=1.7 * s, point=0.4}
  hd:load("#1a1819", 0.95)
  hd:stroke({{x + 1.6 * s * face, y - 2.6 * s}, {x + 2.4 * s * face, y - 3.1 * s}}, {pressure={0.8, 0.7}, ramps={0, 0.2}})
  local bill = brush{kind="round", width=0.7 * s, point=1}
  bill:load("#1a1819", 0.9)
  bill:stroke({{x + 2.8 * s * face, y - 3.0 * s}, {x + 3.9 * s * face, y - 2.7 * s}}, {pressure={0.8, 0.1}, ramps={0, 0.7}})
  local tl = brush{kind="round", width=1.3 * s, point=0.8}
  tl:load("#1e1c1d", 0.9)
  tl:stroke({{x - 1.6 * s * face, y - 1.0 * s}, {x - 2.6 * s * face, y + 0.4 * s}, {x - 3.1 * s * face, y + 1.8 * s}}, {pressure={0.8, 0.2}, ramps={0, 0.6}})
end
perched(368.2, 256.0, 1.6, 1)
perched(470.6, 322.4, 1.4, -1)
local wing = brush{kind="rigger", width=0.8, point=1}
local function flying(x, y, s, up)
  wing:reload("#232124", 0.85)
  wing:stroke({{x - 4 * s, y - up * s}, {x - 1.8 * s, y - 0.8 * s}, {x, y}}, {pressure={0.15, 0.8}, ramps={0.3, 0.1}})
  wing:stroke({{x, y}, {x + 1.8 * s, y - 0.9 * s}, {x + 4.2 * s, y - (up - 0.4) * s}}, {pressure={0.8, 0.15}, ramps={0.1, 0.4}})
  wing:stroke({{x - 0.5 * s, y + 0.1 * s}, {x + 0.6 * s, y + 0.2 * s}}, {pressure={0.9, 0.9}, ramps={0, 0}})
end
flying(598, 332, 1.3, 1.6)
flying(626, 318, 1.0, 0.4)
flying(668, 340, 0.8, 1.2)
