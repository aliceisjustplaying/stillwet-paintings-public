-- an old fence running out of the near right toward the spruces: posts leaning, one down, snow caps
postP = pile{{"raw umber",1.5},{"bone black",0.5},{"smalt",0.3},{"lead white",0.25}, medium=0.15}
postL = pile{{"raw umber",1},{"yellow ochre",0.3},{"lead white",1.2},{"smalt",0.2}, medium=0.15}
capP = pile{{"lead white",5},{"pale smalt",1},{"smalt",0.2}, medium=0.1}
local A, B = {604, 700}, {836, 614}
posts = {}
local ts = {0, 0.2, 0.37, 0.52, 0.66, 0.79, 0.91}
local pm, cm, hm = nil, nil, nil
for i, t in ipairs(ts) do
  local x, y = lerp(A[1], B[1], t), lerp(A[2], B[2], t)
  local sc = lerp(1, 0.38, t ^ 0.8)
  local h, w = 38 * sc * rand(0.8, 1.15), 3.2 * sc
  local lean = randn(0, 0.12) + (i == 3 and 0.35 or 0)
  if i ~= 5 then
    local tx, ty = x + math.sin(lean) * h, y - math.cos(lean) * h
    local p = poly({{x - w / 2, y + 1}, {x + w / 2, y + 1}, {tx + w * 0.42, ty + w * 0.3}, {tx + w * 0.1, ty - w * 0.15}, {tx - w * 0.45, ty}})
    pm = pm and (pm + p) or p
    local lit = ribbon({{x - w * 0.35, y}, {tx - w * 0.3, ty + 1}}, w * 0.3)
    hm = hm and (hm + lit) or lit
    local c = ellipse(tx, ty - w * 0.1, w * 0.72, w * 0.42)
    cm = cm and (cm + c) or c
    posts[#posts+1] = {x, y, tx, ty, w}
  else
    -- the fallen post lying in the snow, half buried
    local p = poly({{x - 16 * sc, y - 1}, {x + 14 * sc, y - 3}, {x + 14 * sc, y - 3 + w * 0.8}, {x - 16 * sc, y + w * 0.6}})
    pm = pm + p
    cm = cm + ribbon({{x - 12 * sc, y - 1.2}, {x - 1 * sc, y - 2.3}, {x + 10 * sc, y - 3.2}}, {w * 0.3, w * 0.5, w * 0.2})
  end
end
postM = pm:roughen(0.3, 2, 91)
work(postM, {hand="detail", tool={kind="round", width=1.5, point=0.6}, pile=postP, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=-1.5, angle_jitter=0.1})
work(hm * postM:shrink(0.3), {hand="detail", tool={kind="round", width=0.8, point=0.6}, pile=postL, load=0.5, pressure={0.4, 0.6}, coverage=1.5, clip=true, angle=-1.5, angle_jitter=0.1})
postCapM = cm:roughen(0.3, 1.5, 93)
posts.cap = postCapM
