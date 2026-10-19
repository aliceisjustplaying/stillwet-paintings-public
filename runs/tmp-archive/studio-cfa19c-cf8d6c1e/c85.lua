local mP = pile{{"lead white",2},{"smalt",1.5},{"raw umber",0.7},{"red earth",0.3},{"bone black",0.08}, medium=0.05}
local mL = pile{{"lead white",3.5},{"smalt",0.8},{"raw umber",0.3},{"yellow ochre",0.3}, medium=0.05}
function postmill(x, base, H, rot, seed)
  local bw = 0.3*H
  local bTop, bBot = base - H*0.95, base - H*0.45
  -- trestle and post
  local r = brush{kind="rigger", width=0.7, point=1}
  r:reload(mP, 0.6)
  r:stroke({{x, bBot},{x-0.18*H, base}}, {pressure={0.6,0.6}})
  r:stroke({{x, bBot},{x+0.18*H, base}}, {pressure={0.6,0.6}})
  r:stroke({{x, bBot},{x, base}}, {pressure={0.7,0.7}})
  -- the body with its gabled roof
  local body = poly({{x-bw/2, bBot},{x-bw/2, bTop+0.08*H},{x, bTop-0.02*H},{x+bw/2, bTop+0.08*H},{x+bw/2, bBot}})
  work(body, {hand="detail", pile=mP, tool={kind="round", width=1, point=0.2}, angle=math.pi/2, coverage=3, fill=true, clip=true, seed=seed})
  work(body * rect(x-bw/2, bTop-2, bw*0.4, H), {hand="detail", pile=mL, tool={kind="round", width=0.8, point=0.2}, angle=math.pi/2, coverage=1.5, clip=true, seed=seed+1})
  -- four sails from the hub on the front of the body
  local hx, hy = x - 0.05*H, bTop + 0.15*H
  local R = 0.62*H
  for k=0,3 do
    local a = rot + k*math.pi/2
    local ca, sa = math.cos(a), math.sin(a)
    r:reload(mP, 0.6)
    r:stroke({{hx, hy},{hx + ca*R, hy + sa*R}}, {pressure={0.55,0.45}})
    -- the lattice frame as a narrow blade along the outer part
    local px, py = -sa, ca
    local w = 0.09*H
    local blade = poly({{hx+ca*R*0.25, hy+sa*R*0.25},{hx+ca*R, hy+sa*R},{hx+ca*R+px*w, hy+sa*R+py*w},{hx+ca*R*0.25+px*w, hy+sa*R*0.25+py*w}})
    work(blade, {hand="detail", pile=mP, tool={kind="round", width=0.7, point=0.3}, angle=a, coverage=1.3, clip=true, seed=seed+2+k})
  end
end
postmill(488, 427, 17, 0.35, 700)
postmill(846, 431, 14, 1.05, 710)
