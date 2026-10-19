-- crotch: the trunk spreads into its boughs instead of ending in a knob
local crotch = poly({{214,322},{220,300},{226,284},{236,272},{246,266},{256,276},{264,292},{270,306},{262,322}}, true)
local flareL = poly({{206,300},{228,290},{236,318},{220,322}}, true)
local burr = ellipse(262, 350, 8, 12) + ellipse(214, 368, 7, 10) + ellipse(258, 392, 6, 8)
local waist = poly({{216,300},{212,330},{214,360},{220,380},{256,380},{262,360},{266,330},{262,300}}, true)
local m = (crotch + flareL + burr + waist):roughen(1.2, 6, 11)
work(m, {hand="detail", pile=bark, load=1, pressure={0.6, 0.9}, coverage=3.5, fill=true, angle=-math.pi/2, angle_jitter=0.4})
oakLive = oakLive + m
