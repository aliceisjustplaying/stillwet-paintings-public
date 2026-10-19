oak = {thick={}, thin={}, dead={}}
local function env(x, y)
  local e = ((x-212)/190)^2 + ((y-192)/128)^2
  if y > 322 then e = math.max(e, 1 + (y-322)/20) end
  return e
end
oakEnv = env
local function addseg(list, pts, ws) list[#list+1] = {pts=pts, ws=ws} end
function growLimb(x, y, ang, len, w, depth, up)
  local pts, ws = {{x,y}}, {w}
  local nseg = math.max(2, math.floor(len / 12))
  local sl = len / nseg
  local cw = w
  for i = 1, nseg do
    ang = ang + randn(0, 0.24)
    ang = ang + (-math.pi/2 - ang) * up
    local nx = x + math.cos(ang) * sl * rand(0.8, 1.2)
    local ny = y + math.sin(ang) * sl * rand(0.8, 1.2)
    local e = env(nx, ny)
    if e > 1 then
      -- steer back toward the crown's centre
      local ta = math.atan(192 - y, 212 - x)
      local d = ta - ang
      while d > math.pi do d = d - 2*math.pi end
      while d < -math.pi do d = d + 2*math.pi end
      ang = ang + d * clamp((e-1)*2.5, 0.15, 0.7)
      nx = x + math.cos(ang) * sl * 0.7
      ny = y + math.sin(ang) * sl * 0.7
      if env(nx, ny) > 1.12 then break end
    end
    x, y = nx, ny
    if depth > 0 and i < nseg and math.random() < 0.7 then
      local wc = cw * rand(0.45, 0.72)
      local side = (math.random() < 0.5) and -1 or 1
      growLimb(x, y, ang + side * rand(0.45, 1.0), len * rand(0.45, 0.68), wc, depth - 1, up)
      cw = math.max(cw * 0.62, math.sqrt(math.max(cw*cw - wc*wc, 0)))
    else
      cw = cw * 0.9
    end
    pts[#pts+1] = {x, y}; ws[#ws+1] = math.max(cw, 0.4)
  end
  if #pts < 2 then return end
  if w >= 2.2 then addseg(oak.thick, pts, ws) else addseg(oak.thin, pts, ws) end
  if depth > 0 then
    local nk = (w >= 2.2) and 3 or 2
    for k = 1, nk do growLimb(x, y, ang + randn(0, 0.6), len * rand(0.35, 0.6), cw * 0.72, depth - 1, up) end
  end
end
local L = {
  {186,318, math.pi+0.3, 130, 12, 4, 0.03},
  {189,305, -2.1, 140, 13, 4, 0.06},
  {205,304, -1.0, 140, 13, 4, 0.06},
  {209,318, -0.2, 150, 11, 4, 0.02},
  {195,300, -1.62, 85, 15, 3, 0.1},
}
for _,l in ipairs(L) do growLimb(l[1],l[2],l[3],l[4],l[5],l[6],l[7]) end
addseg(oak.dead, {{197,222},{200,185},{194,152},{199,120},{208,92},{206,72}}, {10,9,8,6.5,5,4})
addseg(oak.dead, {{199,168},{222,142},{236,118},{233,104}}, {5,4,3.4,3})
addseg(oak.dead, {{196,130},{178,110},{170,94}}, {4,3.2,2.6})
addseg(oak.dead, {{262,238},{272,200},{268,168},{276,138}}, {7,6,5,4})
addseg(oak.dead, {{184,338},{165,332},{152,322}}, {9,8,7.5})
local x0,x1,y0,y1=1e9,-1e9,1e9,-1e9
local hist={}
for _,s in ipairs(oak.thin) do for _,p in ipairs(s.pts) do x0=math.min(x0,p[1]);x1=math.max(x1,p[1]);y0=math.min(y0,p[2]);y1=math.max(y1,p[2])
local bx=math.floor(p[1]/50); local by=math.floor(p[2]/50); hist[by]=hist[by] or {}; hist[by][bx]=(hist[by][bx] or 0)+1 end end
print(#oak.thick, #oak.thin, x0,x1,y0,y1)
for by=0,7 do local row={} for bx=0,9 do row[#row+1]=string.format("%4d",(hist[by] or {})[bx] or 0) end print(by*50, table.concat(row)) end
