-- the fruit was sitting at the wall's own value: lift its lights, deepen its cores
for _, a in ipairs(AP) do
  local S = ashape(a)
  work(S * litf(a, 0.40, 0.95), {hand="glaze", pile=a.k == "g" and g_hg or g_hl,
       coverage=1.3, pressure={0.55, 0.3}, angle=0.4, edge="soft"})
  work(S * corem(a, -0.95, -0.10), {hand="glaze", pile=g_cool,
       coverage=1.4, pressure={0.6, 0.3}, angle=0.4, edge="soft"})
end
-- deeper darks in the room, and a brighter note on the cloth under the light
work(ellipse(960, 380, 380, 300):blur(180), {hand="glaze", pile=g_dk2, coverage=2.4})
work(ellipse(560, 440, 280, 170):blur(140), {hand="glaze", pile=g_dk2, coverage=1.5})
work(ellipse(960, 760, 320, 220):blur(160), {hand="glaze", pile=g_dk2, coverage=1.8})
work(CLOTH * (ellipse(215, 630, 260, 130):blur(120)), {hand="body", tool="filbert 16", pile=g_cl,
     length={40, 110}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
