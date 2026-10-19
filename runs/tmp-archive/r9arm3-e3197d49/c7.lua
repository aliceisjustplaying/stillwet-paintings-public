-- snow dragged across the far trees' feet: a few short horizontal pulls, not a band
local feet = rect(545, 471, 470, 6):roughen(1.5, 14, 72, 1)
work(feet, {hand="body", tool="round 1.6", coverage=1.2, angle=function(x, y) return 0.03 * drift(x, y) end, length={6, 22}, hug=false,
  color="#bdb9c2", medium=0.2})
