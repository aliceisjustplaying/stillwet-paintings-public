r_mid = pile{{"vermilion",3.5},{"red earth",2.5},{"raw umber",0.8}}
r_lt  = pile{{"vermilion",2.5},{"yellow ochre",1.6},{"lead white",1.6},{"red earth",1}}
r_hot = pile{{"lead white",2.6},{"yellow ochre",1.6},{"vermilion",1.2},{"red earth",0.5}}
r_sh  = pile{{"raw umber",3.5},{"red earth",1.5},{"bone black",1.3},{"vermilion",0.4}}
gr_mid = pile{{"green earth",4.5},{"yellow ochre",2},{"chrome yellow",0.4},{"lead white",0.4}}
gr_lt  = pile{{"chrome yellow",0.5},{"lead white",1.6},{"yellow ochre",2.2},{"green earth",2}}
gr_hot = pile{{"lead white",2.6},{"yellow ochre",1.6},{"chrome yellow",0.6},{"green earth",1}}
gr_sh  = pile{{"raw umber",3},{"green earth",2},{"bone black",1.2},{"Prussian blue",0.3}}

function halo(m, r, sd)
  work((m:grow(r) - m):blur(5), {hand="body", pile=p_rs2, coverage=2.0,
        tool="filbert 12", clip=true, edge="found", seed=sd})
end

function apple(m, cx, cy, rx, ry, c_mid, c_lt, c_hot, c_sh, c_rf, sd)
  halo(m, 13, sd)
  local mf = m:grow(1.5)
  local d = function(x, y)
    local dx = (x - cx) / rx
    local dy = (y - cy) / ry
    return 0.80 * dx + 0.58 * dy + 0.20 * (dx * dx + dy * dy)
  end
  local zt = function(a, b) return mask(function(x, y) return smoothstep(a, b, d(x, y)) end) end
  local rf = mf * mask(function(x, y)
    local dy = (y - cy) / ry
    return smoothstep(0.80, 1.20, d(x, y)) * smoothstep(0.30, 0.78, dy)
  end)
  work(mf, {hand="body", pile=c_mid, coverage=3.0, tool="filbert 14", clip=true, edge="found", seed=sd+1})
  work(mf * zt(0.30, 0.62), {hand="body", pile=c_sh, coverage=0.9, tool="filbert 12", angle=0.5, clip=true, edge="soft", seed=sd+2})
  work(mf * zt(0.66, 1.00), {hand="body", pile=c_sh, coverage=0.8, tool="filbert 10", angle=0.5, clip=true, edge="soft", seed=sd+3})
  work(mf * zt(0.06, -0.16), {hand="body", pile=c_lt, coverage=0.85, tool="filbert 12", angle=-0.7, clip=true, edge="soft", seed=sd+4})
  work(mf * zt(-0.24, -0.52), {hand="body", pile=c_hot, coverage=0.7, tool="filbert 9", angle=-0.7, clip=true, edge="soft", seed=sd+5})
  work(rf, {hand="body", pile=c_rf, coverage=0.45, tool="filbert 8", angle=0.2, clip=true, edge="soft", seed=sd+6})
  blend(mf, {angle=-0.6})
end
