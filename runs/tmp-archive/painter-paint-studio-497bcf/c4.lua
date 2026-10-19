local ext = {nil, 1.18, 1.5, 1.22, 1.0, 1.42, 1.08, 1.3, 1.12}
local wid = {nil, 1.0, 0.95, 1.1, 0.9, 1.0, 1.12, 0.95, 1.0}
new_heads = {}
for i = 2, 9 do
  local w = willows[i]
  local H = w.H * ext[i]
  local Wd = w.Wd * wid[i]
  local keep = elder2:grow(1)
  local m = paint_pollard(w.kx, w.ky, H, Wd, 400 + i, keep)
  new_heads[i] = {m=m, H=H, Wd=Wd}
end
print(wait(0))
