function horse_mask(x, yf, H, f, grazing)
  local m = ellipse(x, yf - 0.68*H, 0.55*H, 0.22*H)
  m = m + ellipse(x + f*0.42*H, yf - 0.68*H, 0.2*H, 0.24*H) + ellipse(x - f*0.42*H, yf - 0.7*H, 0.22*H, 0.25*H)
  if grazing then
    m = m + ribbon({{x + f*0.5*H, yf - 0.78*H}, {x + f*0.78*H, yf - 0.42*H}, {x + f*0.9*H, yf - 0.12*H}}, {0.24*H, 0.13*H, 0.1*H})
    m = m + ellipse(x + f*0.93*H, yf - 0.1*H, 0.08*H, 0.12*H)
  else
    m = m + ribbon({{x + f*0.5*H, yf - 0.8*H}, {x + f*0.72*H, yf - 1.08*H}}, {0.26*H, 0.14*H})
    m = m + ribbon({{x + f*0.7*H, yf - 1.12*H}, {x + f*0.98*H, yf - 0.9*H}}, {0.13*H, 0.08*H})
  end
  local lw = 0.075*H
  for _,lx in ipairs({0.46, 0.34}) do
    m = m + ribbon({{x + f*lx*H, yf - 0.55*H}, {x + f*(lx+0.02)*H, yf - 0.25*H}, {x + f*(lx+0.01)*H, yf}}, {lw*1.3, lw, lw*0.9})
  end
  for _,lx in ipairs({-0.42, -0.52}) do
    m = m + ribbon({{x + f*lx*H, yf - 0.6*H}, {x + f*(lx-0.06)*H, yf - 0.3*H}, {x + f*(lx-0.02)*H, yf}}, {lw*1.8, lw, lw*0.9})
  end
  m = m + ribbon({{x - f*0.64*H, yf - 0.82*H}, {x - f*0.72*H, yf - 0.6*H}, {x - f*0.7*H, yf - 0.36*H}}, {0.06*H, 0.09*H, 0.05*H})
  return m
end
local bay = pile{{"red earth", 1}, {"raw umber", 0.9}, {"bone black", 0.1}, {"yellow ochre", 0.2}, medium=0.08}
local dark = pile{{"raw umber", 1}, {"bone black", 0.45}, {"red earth", 0.2}, medium=0.08}
local gray = pile{{"lead white", 1.6}, {"raw umber", 0.4}, {"pale smalt", 0.3}, {"yellow ochre", 0.2}, medium=0.08}
local chest = pile{{"red earth", 0.8}, {"yellow ochre", 0.7}, {"raw umber", 0.4}, {"lead white", 0.2}, medium=0.08}
HORSES = {
  {x=452, y=476, H=13, f=1, g=true, p=bay},
  {x=487, y=472, H=12, f=-1, g=false, p=gray},
  {x=522, y=478, H=13.5, f=1, g=true, p=dark},
  {x=556, y=471, H=11, f=1, g=true, p=chest},
}
HORSEM = nil
for i,h in ipairs(HORSES) do
  local m = horse_mask(h.x, h.y, h.H, h.f, h.g)
  h.m = m
  HORSEM = HORSEM and (HORSEM + m) or m
  work(m, {hand="detail", tool={kind="round", width=0.9, point=0.6}, pile=h.p, angle=0, coverage=3, fill=true, seed=5700+i})
end
