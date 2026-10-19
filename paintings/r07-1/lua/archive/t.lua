-- evening streaks: a long thin one low on the left, a broken one on the right, a faint one higher
STREAKS = {
  {x0=-20, x1=390, y=409, th=5, tilt=-0.012, dark="#9a8b8e", lit="#e6c99a"},
  {x0=600, x1=1020, y=393, th=4, tilt=0.008, dark="#968a90", lit="#e3c69b"},
  {x0=700, x1=860, y=402, th=2.5, tilt=0.0, dark="#a0939a", lit="#e6cba0"},
  {x0=90, x1=520, y=338, th=3, tilt=0.01, dark="#a79ea0", lit="#d6c0a2"},
}
local fb = brush{kind="flat", width=5, stiffness=0.4}
local lb = brush("round", 1.8)
for k, s in ipairs(STREAKS) do
  local x = s.x0
  while x < s.x1 do
    local len = rand(50, 140)
    local x2 = math.min(s.x1, x + len)
    local yy = s.y + (x - s.x0) * s.tilt + randn(0, s.th * 0.35)
    local mid = (x + x2) / 2
    fb:reload(mix(s.dark, sample(mid, yy - 12, 4), rand(0.1, 0.35)), rand(0.35, 0.6))
    fb:stroke({{x, yy}, {mid, yy + randn(0, 0.8)}, {x2, yy + randn(0, 1)}},
      {pressure={rand(0.25, 0.45), rand(0.1, 0.3)}, ramps={0.3, 0.4}, swell={0.7, s.th / 4, 0.6}, orient=0, shake=0.4})
    -- the underside catches the glow, here and there
    if rand() < 0.7 then
      lb:reload(s.lit, 0.4)
      local a, b = x + rand(5, 20), x2 - rand(5, 20)
      if b > a + 10 then
        lb:stroke({{a, yy + s.th * 0.55}, {(a + b) / 2, yy + s.th * 0.6 + randn(0, 0.4)}, {b, yy + s.th * 0.55}},
          {pressure={0.3, 0.15}, ramps={0.35, 0.45}, shake=0.3})
      end
    end
    if x2 >= s.x1 then break end
    x = x2 - rand(10, 40)
  end
end
local t = timesheet(); print(t.sitting, t.strokes, t.reloads, t.piles)
