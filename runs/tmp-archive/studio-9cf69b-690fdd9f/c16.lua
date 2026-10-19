-- the oak: a skeleton of designed limbs, grown further by rule
oak = {thick={}, thin={}, dead={}, snow={}}
local function addseg(list, pts, ws) list[#list+1] = {pts=pts, ws=ws} end
function growLimb(x, y, ang, len, w, depth, dead, up)
  local pts, ws = {{x,y}}, {w}
  local nseg = math.max(2, math.floor(len / 14))
  local sl = len / nseg
  local cw = w
  for i = 1, nseg do
    ang = ang + randn(0, 0.22)
    -- mild upward tendency, stronger on upright limbs
    ang = ang + (-math.pi/2 - ang) * (up or 0.06)
    x = x + math.cos(ang) * sl * rand(0.8, 1.2)
    y = y + math.sin(ang) * sl * rand(0.8, 1.2)
    local wc = nil
    if depth > 0 and i < nseg and math.random() < 0.75 then
      wc = cw * rand(0.45, 0.72)
      local side = (math.random() < 0.5) and -1 or 1
      local ca = ang + side * rand(0.45, 1.0)
      if not dead then
        growLimb(x, y, ca, len * rand(0.45, 0.7), wc, depth - 1, false, up)
      end
      cw = math.max(cw * 0.6, math.sqrt(math.max(cw*cw - wc*wc, 0)))
    else
      cw = cw * 0.9
    end
    pts[#pts+1] = {x, y}; ws[#ws+1] = math.max(cw, 0.4)
  end
  if dead then
    addseg(oak.dead, pts, ws)
  elseif w >= 2.2 then
    addseg(oak.thick, pts, ws)
    if depth > 0 then
      -- twig brush at the tip
      for k = 1, 3 do growLimb(x, y, ang + randn(0, 0.6), len * rand(0.35, 0.6), cw * 0.7, depth - 1, false, up) end
    end
  else
    addseg(oak.thin, pts, ws)
    if depth > 0 then
      for k = 1, 2 do growLimb(x, y, ang + randn(0, 0.55), len * rand(0.45, 0.7), cw * 0.75, depth - 1, false, up) end
    end
  end
end
-- trunk and designed limbs
oakTrunk = {pts={{190,446},{191,425},{193,400},{192,370},{194,340},{197,312}}, ws={46,32,28,27,26,29}}
local L = {
  -- x, y, angle, length, width, depth, dead, up
  {186,318, math.pi+0.25, 150, 12, 4, false, 0.02},  -- low left sweep
  {189,305, -2.05, 170, 13, 4, false, 0.05},          -- left up
  {205,304, -1.0, 170, 13, 4, false, 0.05},           -- right up
  {209,318, -0.18, 180, 11, 4, false, 0.0},           -- right long horizontal
  {195,300, -1.62, 90, 15, 3, false, 0.1},            -- central leader (living part)
}
for _,l in ipairs(L) do growLimb(l[1],l[2],l[3],l[4],l[5],l[6],l[7],l[8]) end
-- dead stag-head limbs, bare and broken
addseg(oak.dead, {{197,215},{200,180},{194,150},{199,120},{208,92},{206,74}}, {10,9,8,6.5,5,4})
addseg(oak.dead, {{199,165},{222,140},{236,116},{233,104}}, {5,4,3.4,3})
addseg(oak.dead, {{196,128},{178,108},{170,92}}, {4,3.2,2.6})
addseg(oak.dead, {{262,238},{272,200},{268,168},{276,140}}, {7,6,5,4})
addseg(oak.dead, {{184,338},{165,332},{152,322}}, {9,8,7.5})
print(#oak.thick, #oak.thin, #oak.dead)
