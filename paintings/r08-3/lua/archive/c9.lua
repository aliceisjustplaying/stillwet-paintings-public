local sx = SPIRE[1]
tower = poly({{sx-3.2,447},{sx-3.2,414},{sx-3.8,412.5},{sx-0.25,386},{sx+0.25,386},{sx+3.8,412.5},{sx+3.2,414},{sx+3.2,447}})
nave = poly({{sx+3,447},{sx+3,432},{sx+9,426},{sx+25,426},{sx+29,431},{sx+29,447}})
local b = brush{kind="round", width=1.1, point=0.8}
work(tower + nave, {hand="detail", tool=b, pal=skypal, color="#9d97a4", angle=1.57, length={2, 6}, coverage=3, clip=true})
local lit = poly({{sx+0.2,387},{sx+3.6,412},{sx+1.2,412}}) + poly({{sx+9,426},{sx+25,426},{sx+26.5,428},{sx+10,428}})
work(lit, {hand="detail", tool=b, pal=skypal, color="#b9aca8", angle=1.2, length={2, 4}, coverage=2, clip=true})
local mistn = noise{seed=61, period=80, octaves=4, stretch={0, 4}}
stipple(above(function(x) return 462 end) * below(function(x) return 425 end), {width=2.2, pal=skypal, color="#d8ccc2",
  coverage=function(x, y) local u = (y - 436) / 26 + 0.4 * mistn(x, y); return 1.8 * smoothstep(0.15, 0.95, u) end,
  pressure={0.4, 0.8}, dips={16, 0.3, 0.7}, medium=0.7, cluster={0.2, 5}, feather=0.7, aim=false})
