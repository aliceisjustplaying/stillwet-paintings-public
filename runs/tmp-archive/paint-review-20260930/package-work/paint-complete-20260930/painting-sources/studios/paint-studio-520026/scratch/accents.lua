p_bgd = pile{{"raw umber",4},{"bone black",4},{"Prussian blue",0.7}}
print(work(rect(660, 0, 340, 130), {hand="body", pile=p_bgd, coverage=6.0, tool="filbert 18", angle=0.2,
  clip=true, fill=true, edge="found", seed=1750}))
print(work(rect(660, 0, 340, 130), {hand="body", pile=p_bgd, coverage=4.0, tool="filbert 12", angle=0.7,
  clip=true, fill=true, edge="found", seed=1751}))

b_rim = pile{{"yellow ochre",1.5},{"lead white",2.5},{"raw umber",0.4}}
stem_p = pile{{"raw umber",4},{"bone black",2.2},{"red earth",0.8}}
r_hot = pile{{"vermilion",1.2},{"yellow ochre",1.6},{"lead white",2.4}}
gr_hot = pile{{"chrome yellow",1},{"lead white",2.6},{"yellow ochre",1.6}}
m_bw = m_bowl:grow(2)
rimlit = m_bw * mask(function(x, y)
  local u = clamp((x - 596) / 158, -1, 1)
  return smoothstep(8, 1, y - (530 + 54 * math.sqrt(1 - u * u))) * smoothstep(0.10, -0.55, (x - 596) / 150)
end)
print(work(rimlit, {hand="body", pile=b_rim, coverage=0.9, tool="filbert 7", angle=-0.3, clip=true, fill=true, edge="soft", seed=1752}))

local fruitq = {{512,516,86,80,r_hot},{696,520,80,75,r_hot},{606,498,92,86,gr_hot},
                {300,690,92,86,r_hot},{478,736,72,66,gr_hot}}
for _, q in ipairs(fruitq) do
  local sb = brush{kind="round", width=6, point=1, stiffness=0.5}
  sb:load(stem_p, 1.0)
  sb:stroke({{q[1] - 0.08 * q[3], q[2] - 0.86 * q[4]},
              {q[1] - 0.16 * q[3], q[2] - 1.02 * q[4]},
              {q[1] - 0.21 * q[3], q[2] - 1.16 * q[4]}},
            {pressure={1.0, 0.7, 0.2}, ramps={0.06, 0.45}, shake=1})
end
-- catchlights: one bright touch on the light side of each apple, one weaker below it
for _, q in ipairs(fruitq) do
  local hb = brush{kind="round", width=8, point=1, stiffness=0.3}
  hb:load(q[5], 1.0)
  hb:touch(q[1] - 0.38 * q[3], q[2] - 0.42 * q[4], {pressure=0.75})
  hb:wipe(0.4)
  hb:touch(q[1] - 0.48 * q[3], q[2] - 0.10 * q[4], {pressure=0.32})
end
-- a few broken reflected lights in the shadow side, to keep the darks alive
local bounce = pile{{"lead white",2},{"red earth",1.4},{"raw umber",0.8}}
for _, q in ipairs{{512,516,86,80},{696,520,80,75},{606,498,92,86},{300,690,92,86},{478,736,72,66}} do
  local rb = brush{kind="round", width=9, point=1, stiffness=0.35}
  rb:load(bounce, 0.75)
  rb:stroke({{q[1] + 0.30 * q[3], q[2] + 0.52 * q[4]}, {q[1] + 0.46 * q[3], q[2] + 0.36 * q[4]}},
            {pressure={0.55, 0.15}, ramps={0.2, 0.6}, shake=1})
end
