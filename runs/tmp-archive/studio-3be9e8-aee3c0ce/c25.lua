local segs = {}
local nstrip = 20
for s = 0, nstrip - 1 do
  local t = (s + 0.5) / nstrip + rand(-0.01, 0.01)
  local y = 198 + rand(0, 6)
  local cur, pts = nil, {}
  local function flush()
    if cur and #pts >= 2 then segs[#segs+1] = {idx=cur, pts=pts} end
  end
  while y <= 600 do
    local xl, xr = edgeX(jugL, y), edgeX(jugR, y)
    local x = lerp(xl, xr, t)
    local i = jIdx(t + rand(-0.015, 0.015), y)
    if i ~= cur or #pts > 7 + math.random(0, 3) then
      local last = pts[#pts]
      flush()
      pts = last and {last} or {}
      cur = i
    end
    pts[#pts+1] = {x, y}
    y = y + 9
  end
  flush()
end
local order = {6, 5, 7, 4, 3, 2, 1}
local big = brush("filbert", 13)
local small = brush("filbert", 7)
local clipm = (jugBody + spout):grow(1)
local n = 0
for _, k in ipairs(order) do
  for _, sg in ipairs(segs) do
    if sg.idx == k then
      local b = (sg.pts[1][2] < 290) and small or big
      b:reload(jp[k], 0.75)
      b:stroke(sg.pts, {pressure={0.65, 0.55}, ramps={0.1, 0.25}, orient="across", clip=clipm})
      n = n + 1
    end
  end
end
print(n)
