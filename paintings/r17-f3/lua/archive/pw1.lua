PW = {
 {x=15,  y=545,   H=219, lean=-0.10, seed=1},
 {x=100, y=535,   H=191, lean=0.06,  seed=2},
 {x=262, y=515.7, H=136, lean=-0.04, seed=3},
 {x=330, y=507.7, H=113, lean=0.08,  seed=4},
 {x=382, y=501.5, H=95,  lean=-0.02, seed=5},
}
local barkD = pile{{"raw umber",1},{"bone black",0.35},{"green earth",0.5},{"lead white",0.45},{"pale smalt",0.2}, medium=0.08}
local barkM = pile{{"lead white",1.3},{"raw umber",0.7},{"green earth",0.5},{"pale smalt",0.4},{"bone black",0.1},{"yellow ochre",0.2}, medium=0.08}
local barkL = pile{{"lead white",2.6},{"raw umber",0.4},{"yellow ochre",0.4},{"pale smalt",0.4},{"green earth",0.2}, medium=0.08}
PWTR = {}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local th = 0.42*H
  local function P(u, v) -- u across (in H), v up (in H)
    local yy = y0 - v*H
    local xx = x0 + u*H + t.lean*(v*H)
    return {xx, yy}
  end
  local pts = {P(-0.085,0.0), P(-0.07,0.03), P(-0.058,0.12), P(-0.055,0.25), P(-0.07,0.33), P(-0.1,0.38), P(-0.095,0.43), P(-0.05,0.445), P(-0.01,0.43), P(0.03,0.45), P(0.08,0.435), P(0.1,0.39), P(0.07,0.34), P(0.055,0.25), P(0.058,0.12), P(0.068,0.03), P(0.09,0.0)}
  local m = poly(pts, true):roughen(math.max(0.8, H*0.006), math.max(4, H*0.03), 1300+i)
  m = m * above(function(x) return y0 + 1.5 end)
  PWTR[i] = m
  local wbr = math.max(1.2, H*0.012)
  work(m, {hand="detail", pile=barkM, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, length={3,12}, coverage=3, clip=true, fill=true, edge="found"})
  local sh = m * mask(function(xx,yy) local v = (y0 - yy)/H; local cx = x0 + t.lean*(y0-yy); return smoothstep(cx - 0.005*H, cx + 0.04*H, xx) end)
  work(sh, {hand="detail", pile=barkD, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, length={3,12}, coverage=2.5, clip=true, fill=true})
  local lit = m * mask(function(xx,yy) local cx = x0 + t.lean*(y0-yy); return smoothstep(cx - 0.03*H, cx - 0.06*H, xx) end)
  work(lit, {hand="detail", pile=barkL, tool={kind="round", width=wbr*0.8, point=0.4}, angle=math.pi/2, length={3,10}, coverage=1.5, clip=true})
end
print(wait(0))
