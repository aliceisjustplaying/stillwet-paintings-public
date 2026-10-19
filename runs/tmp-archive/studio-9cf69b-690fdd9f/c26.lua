extra = {thick={}, thin={}}
local function env(x, y)
  local e = ((x-212)/240)^2 + ((y-185)/150)^2
  if y > 330 then e = math.max(e, 1 + (y-330)/20) end
  if x < 4 then e = math.max(e, 1.2) end
  return e
end
local function grow(x, y, ang, len, w, depth, up)
  local pts, ws = {{x,y}}, {w}
  local nseg = math.max(2, math.floor(len / 10))
  local sl = len / nseg
  local cw = w
  for i = 1, nseg do
    ang = ang + randn(0, 0.3)
    ang = ang + (-math.pi/2 - ang) * up
    local nx = x + math.cos(ang) * sl * rand(0.8, 1.2)
    local ny = y + math.sin(ang) * sl * rand(0.8, 1.2)
    if env(nx, ny) > 1 then break end
    x, y = nx, ny
    if depth > 0 and i < nseg and math.random() < 0.7 then
      local wc = cw * rand(0.45, 0.72)
      grow(x, y, ang + ((math.random()<0.5) and -1 or 1) * rand(0.5, 1.1), len * rand(0.4, 0.65), wc, depth - 1, up)
      cw = math.max(cw * 0.62, math.sqrt(math.max(cw*cw - wc*wc, 0)))
    else cw = cw * 0.9 end
    pts[#pts+1] = {x, y}; ws[#ws+1] = math.max(cw, 0.4)
  end
  if #pts < 2 then return end
  if w >= 2.2 then extra.thick[#extra.thick+1] = {pts=pts, ws=ws} else extra.thin[#extra.thin+1] = {pts=pts, ws=ws} end
  if depth > 0 then for k = 1, 2 do grow(x, y, ang + randn(0, 0.6), len * rand(0.35, 0.6), cw * 0.72, depth - 1, up) end end
end
grow(300,150, -0.55, 95, 3.6, 3, 0.03)
grow(130,112, -2.05, 70, 3.0, 3, 0.04)
grow(345,262, 0.05, 95, 3.4, 3, -0.02)
grow(62,236, -2.6, 60, 2.6, 3, 0.03)
grow(250,100, -0.9, 60, 2.4, 2, 0.02)
local m = nil
for _,s in ipairs(extra.thick) do local r = ribbon(s.pts, s.ws); m = m and (m + r) or r end
if m then work(m, {hand="detail", pile=twigDark, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true}) end
local b = brush{kind="round", width=3, point=1, stiffness=0.5}
b:load(twigP, 0.8)
for i,s in ipairs(extra.thin) do
  local p0 = math.max(b:pressure_for(s.ws[1]), 0.15)
  b:stroke(s.pts, {pressure={p0, 0.02}, ramps={0.0, 0.5}})
  if i % 12 == 0 then b:load(twigP, 0.7) end
end
print(#extra.thick, #extra.thin)
