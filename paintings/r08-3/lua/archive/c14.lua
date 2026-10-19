-- the walker, from behind: greatcoat to the calves, a low hat, a stick
local fx, fy = 588, 603
coat = poly({{fx-4.4,fy-7.6},{fx-3.5,fy-15},{fx-3.3,fy-21.5},{fx-1.5,fy-23.2},{fx+1.8,fy-23.2},{fx+3.4,fy-21.4},{fx+3.7,fy-15},{fx+4.8,fy-7.9},{fx+2,fy-7.2},{fx-1,fy-7.1}}, true)
head = ellipse(fx + 0.2, fy - 25, 1.5, 1.9)
hat = poly({{fx-2.8,fy-26.4},{fx-1.7,fy-26.8},{fx-1.6,fy-29.6},{fx+1.9,fy-29.8},{fx+2,fy-26.8},{fx+3,fy-26.3},{fx+2.8,fy-25.8},{fx-2.6,fy-25.9}})
figm = coat + head + hat
local fb = brush{kind="round", width=1.2, point=0.5}
work(figm, {hand="detail", tool=fb, pal=barkpal, color="#29272d", angle=1.57, length={2, 6}, coverage=3.2, edge={found=0.6, soft=0.4, period=10}})
-- legs and boots below the hem
local lb = brush{kind="round", width=1.3, point=0.3}
lb:load("#24222a", 0.9)
lb:stroke({{fx-1.5, fy-7.6}, {fx-1.8, fy-3.6}, {fx-2.1, fy+0.2}}, {pressure={0.6, 0.7}})
lb:stroke({{fx+1.4, fy-7.6}, {fx+1.9, fy-4.4}, {fx+2.6, fy-1.6}}, {pressure={0.6, 0.7}})
-- the stick
local sb = brush{kind="rigger", width=0.7, point=1}
sb:load("#3a3330", 0.8)
sb:stroke({{fx+4, fy-12.5}, {fx+5.6, fy-5.5}, {fx+6.9, fy+0.6}}, {pressure={0.7, 0.45}})
-- the dawn catching the right shoulder and the hat brim
local rb = brush{kind="round", width=0.8, point=1}
rb:load("#6e6464", 0.7)
rb:stroke({{fx+2.1, fy-22.9}, {fx+3.3, fy-21.2}, {fx+3.6, fy-16.5}}, {pressure={0.7, 0.15}})
rb:stroke({{fx+0.8, fy-29.6}, {fx+1.9, fy-29.3}}, {pressure={0.5, 0.1}})
