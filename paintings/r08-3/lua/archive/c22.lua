-- his boots sunk in the trodden snow
local sb = brush{kind="round", width=1.6, point=0.3}
for _, p in ipairs({{586, 603.4}, {590.6, 601.6}, {594.7, 603.8}}) do
  sb:reload(sample(p[1] + 5, p[2] + 1.5, 1.5), 0.9)
  sb:stroke({{p[1] - 1.8, p[2] + 0.2}, {p[1], p[2] - 0.3}, {p[1] + 1.8, p[2] + 0.3}}, {pressure={0.6, 0.6}})
end
