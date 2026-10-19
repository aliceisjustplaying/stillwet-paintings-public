-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
ld_hz2 = pile{{"lead white", 1}, {"raw umber", 0.6}, {"rose madder", 0.3}, {"ultramarine blue", 0.25}, {"orange chrome", 0.12}, {"Naples yellow", 0.25}}
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}}
land = below({{0,478},{1000,474}})
work(land, {hand="body", tool={kind="flat", width=12, stiffness=0.6},
  piles={{ld_hz2, function(x,y) return 1 - smoothstep(482, 530, y) end},
         {ld_mid2, function(x,y) local t = smoothstep(482, 530, y) return t * (1 - smoothstep(570, 650, y)) end},
         {ld_near2, function(x,y) return smoothstep(570, 650, y) end}},
  angle=0, length={25, 80}, scale_at=function(x,y) return 0.4 + 1.0*smoothstep(476, 714, y) end,
  coverage=1.7, fill=true, clip=land, seed=1})
wait(10*24*60)
-- variant piles: a half-step off the base
v_lt = mix{{ld_hz2, 0.5}, {ld_mid2, 0.5}, name="v_lt"}
v_lt:add{{"Naples yellow", 0.1}, {"lead white", 0.1}}
v_dk = mix{{ld_mid2, 0.5}, {ld_near2, 0.5}, name="v_dk"}
local n = noise{seed=7, period=90, octaves=3, stretch={0, 4}}
local patchL = land * mask(function(x,y) return smoothstep(0.58, 0.68, n:at01(x, (y-476)*2.2 + 476)) end)
local patchD = land * mask(function(x,y) return 1 - smoothstep(0.32, 0.42, n:at01(x, (y-476)*2.2 + 476)) end)
local function sc(x,y) return 0.3 + 1.3*smoothstep(476, 714, y) end
local L = rect(0,0,500,714)
work(patchL * L * above({{0,640},{1000,640}}), {hand="body", tool={kind="flat", width=8, stiffness=0.6}, pile=v_lt, angle=0, angle_jitter=0.05, length={12, 40}, scale_at=sc, coverage=1, edge="soft", load=0.4, seed=2})
work(patchD * L, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, pile=v_dk, angle=0, angle_jitter=0.05, length={12, 40}, scale_at=sc, coverage=1, edge="soft", load=0.4, seed=3})
-- right half: same but blended after
local R = rect(500,0,500,714)
work(patchL * R * above({{0,640},{1000,640}}), {hand="body", tool={kind="flat", width=8, stiffness=0.6}, pile=v_lt, angle=0, angle_jitter=0.05, length={12, 40}, scale_at=sc, coverage=1, edge="soft", load=0.4, seed=4})
work(patchD * R, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, pile=v_dk, angle=0, angle_jitter=0.05, length={12, 40}, scale_at=sc, coverage=1, edge="soft", load=0.4, seed=5})
blend(land * R, {angle=0})

--@ chunk 3
local function sc(x,y) return 0.3 + 1.3*smoothstep(476, 714, y) end
local L = land * rect(0,0,500,714)
-- long, low-load streaks of close values
work(L, {hand="broad", tool={kind="flat", width=10, stiffness=0.6}, pile=v_lt, angle=0, angle_jitter=0.02, length={60, 180}, scale_at=sc,
  coverage=0.5, load=0.25, pressure={0.2, 0.45}, clip=L, seed=21})
work(L, {hand="broad", tool={kind="flat", width=10, stiffness=0.6}, pile=v_dk, angle=0, angle_jitter=0.02, length={60, 180}, scale_at=sc,
  coverage=0.5, load=0.25, pressure={0.2, 0.45}, clip=L, seed=22})
-- right: sage scrub silhouettes at scale and contact darks
sage_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.4}, {"green earth", 0.5}, name="sage_dk"}
sage_lt = pile{{"green earth", 0.6}, {"Naples yellow", 0.5}, {"lead white", 0.4}, {"raw umber", 0.3}, {"orange chrome", 0.1}, name="sage_lt"}
function scrub(x, y, s, seed)
  math.randomseed(seed)
  local m = nil
  for i = 1, 5 do
    local e = ellipse(x + rand(-10, 10)*s, y - rand(2, 7)*s, rand(5, 9)*s, rand(3, 6)*s)
    m = m and (m + e) or e
  end
  m = (m * above({{x-40*s, y+1*s},{x+40*s, y+1*s}})):roughen(2*s, 4*s, seed)
  stipple(m, {pile=sage_dk, width=1.8*s, coverage=2.5, cluster={0.4, 3*s}, pressure={0.4, 0.8}, seed=seed})
  local top = m * above({{x-40*s, y-6*s},{x+40*s, y-6*s}})
  stipple(top, {pile=sage_lt, width=1.2*s, coverage=0.5, cluster={0.6, 2*s}, pressure={0.3, 0.5}, feather=1, seed=seed+1})
end
scrub(600, 640, 2.2, 31)
scrub(700, 560, 1.2, 32)
scrub(780, 520, 0.8, 33)
scrub(880, 500, 0.5, 34)
scrub(950, 492, 0.35, 35)
