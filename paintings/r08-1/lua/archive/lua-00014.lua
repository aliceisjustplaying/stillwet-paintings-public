-- the woman seen from behind: a long dark cloak from the shoulders to the snow, a close hood
FIG.x = 530; FIG.foot = bank(530) + 22
local fx, fy = FIG.x, FIG.foot
local cloak = outline{pts={{fx-12.5,fy+0.5,"c"},{fx-10.5,fy-16},{fx-8.6,fy-33},{fx-7.6,fy-44},{fx-6.6,fy-49.5},{fx-3.5,fy-51.8},
  {fx+0.5,fy-52.2},{fx+4.6,fy-51.5},{fx+7.6,fy-48.8},{fx+8.8,fy-43},{fx+10,fy-31},{fx+11.8,fy-15},{fx+13.4,fy+0.5,"c"},{fx+3,fy+1.5},{fx-6,fy+1.2}},
  char="firm", seed=141, amount=0.5}
local head = ellipse(fx + 0.6, fy - 56.8, 3.7, 5.2) + ellipse(fx + 0.3, fy - 52.5, 2.6, 2.5)
FIGM = cloak:mask() + head:soften(0.3)
work(FIGM, {hand="body", tool="round 1.2", length={3, 10}, coverage=4.4, medium=0.1, load=0.9, angle=-1.57, angle_jitter=0.12,
  color=function(x, y) return mix("#262224", "#312c2c", smoothstep(fy - 30, fy, y)) end, edge={found=0.75, soft=0.25, period=16, seed=14}})
