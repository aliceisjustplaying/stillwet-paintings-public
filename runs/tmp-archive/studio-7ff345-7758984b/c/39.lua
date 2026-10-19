-- the oak's foot: root flares running out into the snow
local rl = poly({{214,420},{206,434},{194,446},{180,455},{196,456},{214,451},{226,447}}, true)
local rr = poly({{262,420},{268,434},{280,446},{298,454},{284,456},{266,452},{252,447}}, true)
local rc = poly({{214,436},{216,452},{236,458},{258,454},{264,436}}, true)
local rs = poly({{230,448},{226,462},{240,463},{246,450}}, true)
footM = (rl + rr + rc + rs):roughen(1.0, 5, 13)
work(footM, {hand="detail", pile=bark, load=1, pressure={0.6, 0.9}, coverage=3.5, fill=true, angle=-math.pi/2, angle_jitter=0.5})
