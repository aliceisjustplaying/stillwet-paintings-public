local mp = pile{{"pale smalt", 1.3}, {"smalt", 0.5}, {"raw umber", 0.55}, {"lead white", 0.8}, {"red earth", 0.1}, {"bone black", 0.1}, medium=0.1}
local lp = pile{{"lead white", 2.2}, {"pale smalt", 0.8}, {"red earth", 0.15}, {"yellow ochre", 0.35}, {"raw umber", 0.1}, medium=0.1}
MILLS = {{x=150, s=1.0, rot=0.35}, {x=872, s=0.85, rot=0.9}}
local fine = brush{kind="round", width=0.9, point=1, stiffness=0.4}
for _,ml in ipairs(MILLS) do
  local s = ml.s
  local base = far(ml.x) + 1.2
  local post = base - 5*s
  -- trestle legs and post
  fine:load(mp, 0.5)
  fine:stroke({{ml.x - 3*s, base}, {ml.x, post}}, {pressure={0.35,0.3}})
  fine:stroke({{ml.x + 3*s, base}, {ml.x, post}}, {pressure={0.35,0.3}})
  fine:stroke({{ml.x, base}, {ml.x, post}}, {pressure={0.45,0.4}})
  -- body with pitched roof
  local bx0, bx1 = ml.x - 3*s, ml.x + 3*s
  local by0, by1 = post - 7.5*s, post
  local body = poly({{bx0, by1}, {bx0, by0}, {ml.x, by0 - 2.5*s}, {bx1, by0}, {bx1, by1}})
  work(body, {hand="detail", tool={kind="round", width=1.2, point=0.6}, pile=mp, coverage=3, fill=true, seed=5100 + ml.x})
  work(body * rect(bx0, 0, 2*s, 700), {hand="detail", tool={kind="round", width=1, point=0.6}, pile=lp, coverage=2, fill=true, seed=5110 + ml.x})
  -- sails: four arms in an X from the hub
  local hx, hy = ml.x + 0.5*s, by0 + 2*s
  fine:load(mp, 0.6)
  for k=0,3 do
    local a = ml.rot + k*math.pi/2
    local L = 13*s
    local ex, ey = hx + L*math.cos(a), hy + L*math.sin(a)
    fine:stroke({{hx, hy}, {ex, ey}}, {pressure={0.5,0.35}, ramps={0.05,0.1}})
    -- the lattice of the sail: a thin parallel line and a few cross-bars
    local nx, ny = -math.sin(a), math.cos(a)
    local off = 1.6*s
    fine:stroke({{hx + 3*s*math.cos(a) + off*nx, hy + 3*s*math.sin(a) + off*ny}, {ex + off*nx, ey + off*ny}}, {pressure={0.25,0.2}})
    for j=1,4 do
      local t = 0.3 + 0.17*j
      local px, py = hx + L*t*math.cos(a), hy + L*t*math.sin(a)
      fine:stroke({{px, py}, {px + off*nx, py + off*ny}}, {pressure={0.2,0.2}})
    end
    fine:load(mp, 0.5)
  end
end
