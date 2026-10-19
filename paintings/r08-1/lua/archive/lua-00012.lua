-- pollard willows on the far bank: a short thick trunk, a knuckled head, rods rising from its knuckles.
-- (moved from the drawing: spacing made uneven, one smaller and one leaning)
WILLOWS = {{112, 0.8, -0.1}, {198, 1.1, 0.04}, {241, 0.72, 0.16}, {352, 0.95, -0.05}}
WILC = "#393536"
local rodb = brush{kind="rigger", width=0.9, point=1}
local rodf = brush{kind="rigger", width=0.5, point=1}
function willow(fx, fy, s, lean, seed)
  local hx, hy = fx + lean*30*s, fy - 34*s
  local tr = ribbon({{fx, fy+2}, {fx + lean*10*s + randn(0, 1), fy - 12*s}, {hx, hy}}, {8*s, 6.2*s, 8*s}):roughen(0.6*s, 5, seed, 0.3)
  -- the head: two or three knuckles
  local knuck = {}
  local nk = 2 + (seed % 2)
  local head = nil
  for k = 1, nk do
    local kx, ky = hx + (k - (nk+1)/2)*6*s + randn(0, 1.2*s), hy - 2*s + randn(0, 1.5*s)
    knuck[k] = {kx, ky}
    local e = ellipse(kx, ky, rand(4, 6)*s, rand(3, 4.5)*s)
    head = head and (head + e) or e
  end
  local m = tr + head:roughen(1*s, 4, seed + 1, 0.3)
  work(m, {hand="body", tool="round 1.5", length={3, 8}, coverage=4.5, medium=0.1, load=0.9, angle=-1.5, angle_jitter=0.5,
    color=function(x, y) return mix(WILC, "#57504d", 0.35*smoothstep(fx-2, fx+6*s, x)) end, edge={found=0.5, soft=0.5, period=8, seed=seed}})
  -- rods: mostly upright, from every knuckle; lengths very uneven, a few thick old ones, a few crossing
  local n = math.floor(26 + 18*s)
  for i = 1, n do
    local kn = knuck[1 + (i % nk)]
    local u = randn(0, 0.42)
    local a = -math.pi/2 + u*0.95 + lean*0.4 + (kn[1] - hx)/(12*s)*0.25
    local L = s*(66 - 30*math.min(1, math.abs(u))) * rand(0.35, 1.1)
    local bx, by = kn[1] + randn(0, 2.2*s), kn[2] - rand(0, 3)*s
    local bow = randn(0, 0.12)
    local pts = {{bx, by}}
    for k = 1, 3 do local aa = a + bow*k/3
      pts[#pts+1] = {pts[#pts][1] + L/3*math.cos(aa), pts[#pts][2] + L/3*math.sin(aa)} end
    local thick = rand() < 0.2
    local b = thick and rodb or rodf
    if b:fullness() < 0.3 or rand() < 0.1 then b:reload(mix(WILC, rand() < 0.5 and "#6e584a" or "#7d6a55", rand(0.2, 0.45)), rand(0.7, 0.95)) end
    b:stroke(pts, {pressure={thick and rand(0.6, 0.85) or rand(0.4, 0.8), 0}, ramps={0.02, rand(0.5, 0.8)}, shake=0.25})
  end
end
rodb:load(WILC, 0.9); rodf:load(WILC, 0.9)
for i, w in ipairs(WILLOWS) do willow(w[1], farbank(w[1]) + 3, w[2], w[3], 120 + i) end
