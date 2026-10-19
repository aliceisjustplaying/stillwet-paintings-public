-- the oak, by hand: trunk and scaffold limbs placed, then limbs and twigs drawn stroke by stroke.
-- An oak: crooked, level limbs that change direction at elbows; twigs short and stiff.
OAKC = "#3d393a"
local ox, oy = OAK.x, OAK.foot
-- the trunk as a body of paint, flared at the foot
local trunkpts = {{ox-1, oy+2}, {ox, oy-20}, {ox-2, oy-45}, {ox-3, oy-62}, {ox-4, oy-72}}
TRUNK = ribbon(trunkpts, {11, 8.5, 7.5, 7, 6}):roughen(0.5, 6, 3, 0.3)
work(TRUNK, {hand="body", tool="round 2", length={5, 14}, coverage=3.4, medium=0.12, angle=-1.55, angle_jitter=0.2,
  color=function(x, y) return mix("#3a3637", "#57504b", smoothstep(ox-2, ox+5, x)*0.6) end, edge={found=0.6, soft=0.4, period=12, seed=3}})
-- scaffold limbs (from the trunk, placed by eye): {points, width at start, width at end}
OAKLIMBS = {
  {{{ox-4,oy-70},{ox-18,oy-92},{ox-36,oy-116},{ox-58,oy-138},{ox-84,oy-150},{ox-110,oy-156}}, 5.5, 1.6},
  {{{ox-3,oy-72},{ox+3,oy-104},{ox-1,oy-134},{ox+6,oy-162},{ox+2,oy-190}}, 5.5, 1.5},
  {{{ox-2,oy-52},{ox+22,oy-74},{ox+48,oy-92},{ox+72,oy-100},{ox+96,oy-112}}, 4.5, 1.4},
  {{{ox-1,oy-128},{ox-20,oy-150},{ox-30,oy-174},{ox-46,oy-190}}, 3.2, 1.1},
  {{{ox+2,oy-142},{ox+26,oy-166},{ox+50,oy-176},{ox+66,oy-192}}, 3.2, 1.1},
  {{{ox-36,oy-116},{ox-56,oy-110},{ox-80,oy-114},{ox-100,oy-108}}, 2.8, 1.0},
  {{{ox+48,oy-92},{ox+56,oy-118},{ox+52,oy-134}}, 2.4, 0.9},
  {{{ox+22,oy-74},{ox+30,oy-90},{ox+26,oy-100}}, 2.0, 1.2},   -- a broken stub
}
local function bend(pts, amt)   -- the hand's small wander between elbows
  local o = {}
  for i, p in ipairs(pts) do o[i] = {p[1] + (i > 1 and randn(0, amt) or 0), p[2] + (i > 1 and randn(0, amt) or 0)} end
  return o
end
local lb = brush{kind="round", width=3, point=0.6}
for i, L in ipairs(OAKLIMBS) do
  lb:reload(OAKC, 0.9)
  local pts = bend(L[1], 0.8)
  local w = {} for k = 1, #pts do w[k] = lerp(L[2], L[3], (k-1)/(#pts-1)) end
  local rib = ribbon(pts, w)
  work(rib, {hand="detail", tool="round 1.5", length={4, 10}, coverage=3, medium=0.12, color=OAKC, edge={found=0.7, soft=0.3, period=10, seed=i}})
end
