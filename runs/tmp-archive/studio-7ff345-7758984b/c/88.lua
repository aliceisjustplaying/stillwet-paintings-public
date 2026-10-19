-- the glazes left pale haloes round the stakes: close them
local halo = (postM:grow(2.2) - postM:grow(0.2)) * mask(function(x, y) return y > 600 and 1 or 0 end) - posts.cap:grow(0.5)
work(halo, {hand="detail", tool={kind="round", width=1.2, point=0.5}, pile=landShade2, load=0.5, pressure={0.35, 0.5}, coverage=2.5, fill=true, clip=true, angle=-1.5,
  load_at=function(x, y) return 0.35 + 0.4 * smoothstep(610, 714, y) end})
-- the walker's faint shadow, falling toward us and to the left, very soft at dusk
local sh = poly({{474, 534}, {482, 534}, {470, 541}, {462, 543}}, true):soften(0.8)
work(sh - figM, {hand="detail", tool={kind="round", width=1.2, point=0.5}, pile=landShade2, load=0.45, pressure={0.35, 0.5}, coverage=2.5, fill=true, clip=true, angle=2.8})
