local cL = pile{{"yellow ochre",2},{"lead white",2.5},{"raw umber",0.2},{"green earth",0.3}, medium=0.05}
local cM = pile{{"yellow ochre",2},{"lead white",1},{"raw umber",0.6},{"green earth",0.6}, medium=0.05}
local cD = pile{{"raw umber",1.4},{"green earth",1},{"yellow ochre",0.5},{"bone black",0.15},{"lead white",0.3}, medium=0.05}
local shP = pile{{"green earth",1.5},{"raw umber",0.8},{"Prussian blue",0.2},{"yellow ochre",0.5},{"lead white",0.4}, medium=0.08}
cocks = {}
for i,c in ipairs({{468,0.55},{532,0.3},{606,0.62},{688,0.33},{752,0.72},{842,0.42},{934,0.64}}) do
  local x, f = c[1], c[2]
  local y = hayY(x, f)
  local s = 3.2 + 0.009*(x-350)
  cocks[#cocks+1] = {x, y, s}
  -- cast shadow to the right on the stubble
  local sh = ellipse(x + 0.9*s, y + 0.1*s, 1.2*s, 0.28*s)
  work(sh, {hand="detail", pile=shP, tool={kind="round", width=math.max(1,0.3*s), point=0.3}, angle=0.1, coverage=2.5, fill=true, seed=500+i})
  -- the cock: a rounded cone, lit from the left
  local body = poly({{x-1.0*s, y+0.1*s},{x-0.85*s, y-0.5*s},{x-0.45*s, y-1.05*s},{x, y-1.3*s},{x+0.45*s, y-1.05*s},{x+0.85*s, y-0.5*s},{x+1.0*s, y+0.1*s}}, true):roughen(0.08*s, 0.4*s, 510+i)
  work(body, {hand="detail", pile=cM, tool={kind="round", width=math.max(1,0.28*s), point=0.3}, angle=math.pi/2, coverage=3, fill=true, clip=true, seed=520+i})
  local dark = body * mask(function(px,py) return smoothstep(x-0.05*s, x+0.45*s, px + 0.3*(py-y)) end)
  work(dark, {hand="detail", pile=cD, tool={kind="round", width=math.max(1,0.22*s), point=0.3}, angle=math.pi/2-0.3, coverage=2.5, clip=true, seed=530+i})
  local lit = body * mask(function(px,py) return smoothstep(x-0.1*s, x-0.6*s, px + 0.4*(py-y)) end)
  work(lit, {hand="detail", pile=cL, tool={kind="round", width=math.max(0.9,0.18*s), point=0.4}, angle=math.pi/2+0.4, coverage=2.0, clip=true, seed=540+i})
end
