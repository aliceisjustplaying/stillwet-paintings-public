print(wait(1440))
for _, p in ipairs(posts) do print(p[1], p[2], p[3], p[4], drying(p[3], p[4])) end
-- snow caps on the stakes, and two slack strands of wire from post to post
local wire = brush{kind="rigger", width=0.5, point=1}
wire:load(pile{{"bone black",1},{"raw umber",1},{"smalt",0.3}, medium=0.2}, 0.5)
for i = 1, #posts - 1 do
  local a, b = posts[i], posts[i + 1]
  if not (i == 2) then  -- the wire hangs broken past the leaning post
    for k, f in ipairs({0.3, 0.62}) do
      local ax, ay = lerp(a[1], a[3], 1 - f), lerp(a[2], a[4], 1 - f)
      local bx, by = lerp(b[1], b[3], 1 - f), lerp(b[2], b[4], 1 - f)
      local sag = math.abs(bx - ax) * 0.07 + 1
      wire:stroke({{ax, ay}, {(ax + bx) / 2, (ay + by) / 2 + sag}, {bx, by}}, {pressure={0.25, 0.2}, ramps={0.05, 0.05}})
    end
  else
    -- a broken end dangling
    local ax, ay = lerp(a[1], a[3], 0.7), lerp(a[2], a[4], 0.7)
    wire:stroke({{ax, ay}, {ax + 6, ay + 5}, {ax + 9, ay + 11}}, {pressure={0.25, 0.1}})
  end
end
work(posts.cap, {hand="detail", tool={kind="round", width=1, point=0.8}, pile=capP, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=0})
