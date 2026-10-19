local det = function(m, p, w, seed, cov, ang) work(m, {hand="detail", tool={kind="round", width=w or 0.7, point=0.6}, pile=p, angle=ang or 0, coverage=cov or 3, fill=true, seed=seed}) end
function cow_mask(x, yf, H, f)
  local m = ellipse(x, yf - 0.62*H, 0.62*H, 0.26*H)
  m = m + ellipse(x - f*0.45*H, yf - 0.66*H, 0.22*H, 0.27*H) + ellipse(x + f*0.4*H, yf - 0.6*H, 0.22*H, 0.28*H)
  m = m + ribbon({{x + f*0.55*H, yf - 0.62*H}, {x + f*0.8*H, yf - 0.3*H}}, {0.26*H, 0.16*H})
  m = m + ellipse(x + f*0.84*H, yf - 0.22*H, 0.1*H, 0.14*H)
  local lw = 0.09*H
  for _,lx in ipairs({0.42, 0.3, -0.38, -0.5}) do
    m = m + ribbon({{x + f*lx*H, yf - 0.45*H}, {x + f*lx*H, yf}}, {lw*1.2, lw})
  end
  m = m + ribbon({{x - f*0.66*H, yf - 0.8*H}, {x - f*0.7*H, yf - 0.35*H}}, {0.05*H, 0.05*H})
  return m
end
local red = pile{{"red earth", 1}, {"raw umber", 0.6}, {"yellow ochre", 0.3}, {"lead white", 0.15}, medium=0.08}
local blk = pile{{"bone black", 0.6}, {"raw umber", 0.6}, {"lead white", 0.15}, medium=0.08}
local wht = pile{{"lead white", 2}, {"yellow ochre", 0.15}, {"raw umber", 0.1}, medium=0.08}
local cast = pile{{"green earth", 1.3}, {"raw umber", 0.7}, {"Prussian blue", 0.06}, {"yellow ochre", 0.3}, medium=0.3}
COWS = {{x=376, y=460, H=8.5, f=1, p=red}, {x=399, y=457, H=7.8, f=-1, p=blk}, {x=421, y=462, H=8.8, f=1, p=red}}
local sb = brush{kind="round", width=1, point=0.5}
for i,c in ipairs(COWS) do
  local m = cow_mask(c.x, c.y, c.H, c.f)
  sb:load(cast, 0.5)
  sb:stroke({{c.x - 0.5*c.H, c.y + 0.3}, {c.x + 2*c.H, c.y}}, {pressure={0.5, 0.05}, ramps={0.1, 0.6}, clip=-m})
  det(m, c.p, 0.7, 8500+i)
  if c.p == blk then
    det(ellipse(c.x + 0.1*c.H, c.y - 0.62*c.H, 0.22*c.H, 0.14*c.H) + ellipse(c.x - 0.4*c.H, c.y - 0.7*c.H, 0.12*c.H, 0.1*c.H), wht, 0.5, 8510+i)
  else
    det(ellipse(c.x - 0.1*c.H, c.y - 0.5*c.H, 0.18*c.H, 0.1*c.H), wht, 0.5, 8510+i)
  end
end
-- a white stork in the meadow on the near side of the ditch
local sx, sy = 238, 501
local body = ellipse(sx, sy - 6.2, 2.6, 1.5):offset(0)
local neck = ribbon({{sx + 1.8, sy - 6.8}, {sx + 2.6, sy - 9}, {sx + 2.4, sy - 10.6}}, {0.9, 0.7, 0.8})
local tail = poly({{sx - 2.4, sy - 6.9}, {sx - 3.8, sy - 5.6}, {sx - 1.5, sy - 5.2}})
det(body + neck, wht, 0.5, 8521)
det(tail + ellipse(sx - 0.8, sy - 5.6, 1.8, 0.7), blk, 0.4, 8522)
local rb = brush{kind="round", width=0.35, point=1}
rb:load(pile{{"vermilion", 1}, {"red earth", 0.4}, medium=0.08}, 0.4)
rb:stroke({{sx - 0.2, sy - 5}, {sx - 0.3, sy}}, {pressure={0.4, 0.4}})
rb:stroke({{sx + 0.6, sy - 5}, {sx + 0.9, sy - 0.2}}, {pressure={0.4, 0.4}})
rb:stroke({{sx + 2.9, sy - 10.6}, {sx + 5.2, sy - 9.4}}, {pressure={0.45, 0.1}})
