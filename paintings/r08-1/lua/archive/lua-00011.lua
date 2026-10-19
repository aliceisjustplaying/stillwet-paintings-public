-- the oak's finer wood: each branch a run of straight pieces changing direction at nodes (elbows),
-- twigs short and stiff, spreading outward and a little up; drawn thick to thin with pointed brushes
OAKB = {big=brush{kind="round", width=2.2, point=0.8}, mid=brush{kind="rigger", width=1.2, point=1}, fine=brush{kind="rigger", width=0.6, point=1}}
function oakbranch(x, y, ang, len, w, depth, col)
  local b = (w > 1.6) and OAKB.big or ((w > 0.7) and OAKB.mid or OAKB.fine)
  if b:fullness() < 0.35 then b:reload(col, 0.85) end
  local pts, n = {{x, y}}, math.max(2, math.floor(len / 9) + 1)
  local a, px, py = ang, x, y
  local nodes = {}
  for k = 1, n do
    a = a + randn(0, 0.35)                       -- an elbow at each node
    a = a + 0.15 * (math.atan(-1, 0.25*(math.cos(ang) > 0 and 1 or -1)) - a) * 0.3   -- a slight pull upward/outward
    local seg = len / n * rand(0.75, 1.25)
    px, py = px + seg*math.cos(a), py + seg*math.sin(a)
    pts[#pts+1] = {px, py}
    nodes[#nodes+1] = {px, py, a, k/n}
  end
  local p0 = b:pressure_for(w)
  b:stroke(pts, {pressure={p0, depth == 0 and 0 or p0*0.35}, ramps={0.02, 0.5}, shake=0.3})
  if depth > 0 then
    for _, nd in ipairs(nodes) do
      if rand() < 0.95 - 0.25*nd[4] then
        local side = (rand() < 0.5) and -1 or 1
        local ca = nd[3] + side * rand(0.45, 1.1)
        oakbranch(nd[1], nd[2], ca, len * rand(0.45, 0.7) * (1 - 0.35*nd[4]), math.max(0.3, w * rand(0.5, 0.75) * (1 - 0.4*nd[4])), depth - 1, col)
      end
    end
  end
end
OAKB.big:load(OAKC, 0.9); OAKB.mid:load(OAKC, 0.9); OAKB.fine:load(OAKC, 0.9)
-- from each scaffold limb: its tip runs on, and side branches leave along it
for i, L in ipairs(OAKLIMBS) do
  local pts = L[1]
  local n = #pts
  if i ~= 8 then
    local a = math.atan(pts[n][2] - pts[n-1][2], pts[n][1] - pts[n-1][1])
    oakbranch(pts[n][1], pts[n][2], a, 40 + rand(0, 18), L[3] * 1.0, 3, OAKC)
  end
  for k = 2, n - 1 do
    if rand() < 0.85 then
      local a = math.atan(pts[k+1][2] - pts[k][2], pts[k+1][1] - pts[k][1])
      local side = (k % 2 == 0) and -1 or 1
      oakbranch(pts[k][1], pts[k][2], a + side*rand(0.5, 1.0), rand(30, 52), lerp(L[2], L[3], k/n) * 0.5, 3, OAKC)
    end
  end
end
