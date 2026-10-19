-- the trodden path: from the bottom edge up the slope to the figure, then over the flat to the ice
PATH = {{668,716},{672,694},{662,668},{640,644},{612,622},{594,608},{580,592},{560,574},{540,556},{530,540},{526,528},{524,520}}
local wds = {}
for i, p in ipairs(PATH) do wds[i] = 1.5 + 11 * smoothstep(520, 716, p[2]) end
pathm = ribbon(PATH, wds):roughen(2, 10, 91, 1.5)
glaze(pathm:blur(1.5), {color="#7a7f9c", coats=0.16})
stipple(pathm, {width=1.8, pal=snowpal, color="#c9c8d0", coverage=0.35, pressure={0.4, 0.8}, dips={16, 0.4, 0.7}, medium=0.4, feather=0.6})
-- footprints: small darker hollows, pairs staggered, shrinking with distance
local fb = brush{kind="round", width=2.2, point=0.3}
for t = 0.02, 0.98, 0.034 do
  local n = #PATH - 1
  local u = t * n; local i = math.floor(u) + 1; local f = u - (i - 1)
  local a, b = PATH[i], PATH[i + 1]
  local x, y = a[1] + (b[1] - a[1]) * f, a[2] + (b[2] - a[2]) * f
  if y > 610 or y < 590 then
    local s = 0.25 + 0.9 * smoothstep(520, 716, y)
    local side = (math.floor(t / 0.034) % 2 == 0) and -1 or 1
    fb:reload(mix("#707592", "#80849e", rand()), 0.9)
    fb:reload(mix("#7f839c", "#8d90a6", rand()), 0.5)
    fb:stroke({{x + side * 1.6 * s, y - 1.2 * s}, {x + side * 1.6 * s + 0.3, y + 1.4 * s}}, {pressure={0.15 + 0.35 * s, 0.1}, ramps={0.2, 0.5}})
  end
end
