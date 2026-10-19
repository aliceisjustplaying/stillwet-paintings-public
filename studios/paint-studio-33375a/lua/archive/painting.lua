-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{
  size = 900,
  aspect = 4 / 3,
  linen = {16, 14},
  seed = 1881,
  ground = {
    {pile = {{"raw umber", 3}, {"red earth", 2}, {"lead white", 2}}, um = 90, apply = "knife", texture = 0.35},
    {pile = {{"raw umber", 2.5}, {"yellow ochre", 2}, {"lead white", 3}, {"bone black", 0.5}}, um = 70, apply = "knife", texture = 0.2}
  }
}
print("Canvas W=" .. W .. " H=" .. H)

--@ chunk 2
-- 1. Structural underdrawing in black chalk
local ch = chalk()
-- Horizon and mesa
ch:sketch({{0, 480}, {180, 472}, {380, 498}, {550, 505}, {760, 478}, {1000, 468}}, {pressure=0.35})
ch:sketch({{20, 480}, {45, 425}, {140, 418}, {165, 445}, {250, 445}, {270, 485}}, {pressure=0.3})
-- Cowboy contour
ch:sketch({{190, 200}, {245, 160}, {305, 175}, {345, 215}, {275, 220}, {190, 200}}, {pressure=0.45})
ch:sketch({{230, 260}, {305, 275}, {415, 355}, {468, 362}, {468, 378}, {405, 382}, {310, 355}}, {pressure=0.5})
ch:sketch({{220, 265}, {165, 440}, {130, 640}, {240, 650}, {325, 475}, {355, 735}}, {pressure=0.45})
-- Muzzle blast cone
ch:sketch({{468, 362}, {545, 315}, {590, 365}, {540, 420}, {468, 368}}, {pressure=0.4})
-- Zombie contour
ch:sketch({{685, 210}, {745, 220}, {750, 275}, {695, 290}, {670, 255}}, {pressure=0.45})
ch:sketch({{650, 330}, {590, 315}, {540, 295}, {545, 325}, {625, 355}}, {pressure=0.45})
ch:sketch({{630, 335}, {720, 345}, {790, 325}, {840, 285}}, {pressure=0.45})
ch:sketch({{625, 355}, {650, 495}, {605, 735}, {715, 500}, {775, 740}}, {pressure=0.45})
fix()

-- 2. Global masks for major masses
horizon_pts = {{0, 480}, {180, 472}, {380, 498}, {550, 505}, {760, 478}, {1000, 468}}
sky_mask = above(horizon_pts)
ground_mask = below(horizon_pts)

-- Cowboy main body silhouette
cowboy_hat_m = poly({{182, 198}, {218, 188}, {238, 156}, {275, 154}, {302, 178}, {348, 214}, {320, 224}, {245, 215}, {195, 212}}, true)
cowboy_torso_m = poly({{218, 255}, {305, 268}, {328, 365}, {322, 485}, {205, 490}, {195, 365}}, true)
cowboy_duster_m = poly({{218, 265}, {255, 285}, {250, 485}, {235, 655}, {128, 635}, {162, 455}, {195, 330}}, true)
cowboy_leg_l_m = poly({{195, 485}, {248, 488}, {225, 620}, {212, 748}, {165, 748}, {180, 610}}, true)
cowboy_leg_r_m = poly({{268, 480}, {325, 478}, {352, 605}, {372, 748}, {322, 748}, {298, 610}}, true)
cowboy_arm_r_m = poly({{292, 275}, {365, 325}, {418, 352}, {412, 384}, {348, 362}, {285, 322}}, true)
cowboy_arm_l_m = poly({{245, 285}, {315, 368}, {395, 335}, {405, 318}, {382, 312}, {318, 338}, {268, 278}}, true)
cowboy_head_m = poly({{232, 205}, {306, 212}, {302, 258}, {238, 262}}, true)
gun_m = poly({{405, 352}, {470, 356}, {470, 368}, {438, 372}, {425, 392}, {404, 388}})

cowboy_mass = cowboy_hat_m + cowboy_torso_m + cowboy_duster_m + cowboy_leg_l_m + cowboy_leg_r_m + cowboy_arm_r_m + cowboy_arm_l_m + cowboy_head_m + gun_m

-- Zombie main body silhouette
zombie_head_m = poly({{675, 208}, {728, 202}, {752, 235}, {742, 282}, {692, 292}, {665, 268}, {678, 238}}, true)
zombie_torso_m = poly({{628, 325}, {715, 312}, {742, 415}, {725, 505}, {635, 502}, {618, 408}}, true)
zombie_coat_flap_m = poly({{705, 335}, {768, 365}, {825, 455}, {775, 525}, {715, 485}}, true)
zombie_arm_r_m = poly({{642, 325}, {585, 305}, {535, 285}, {528, 315}, {578, 335}, {632, 362}}, true)
zombie_arm_l_m = poly({{712, 332}, {782, 318}, {845, 275}, {858, 302}, {792, 348}, {718, 368}}, true)
zombie_leg_r_m = poly({{632, 492}, {682, 495}, {648, 618}, {628, 748}, {582, 748}, {602, 612}}, true)
zombie_leg_l_m = poly({{688, 495}, {740, 495}, {768, 618}, {798, 748}, {748, 748}, {718, 620}}, true)

zombie_mass = zombie_head_m + zombie_torso_m + zombie_coat_flap_m + zombie_arm_r_m + zombie_arm_l_m + zombie_leg_r_m + zombie_leg_l_m

-- Muzzle blast halo mask
blast_halo_m = ellipse(518, 365, 78, 62):roughen(18, 35, 11)

-- 3. Fast-drying lean mixtures for Campaign 1 Lay-in
p_sky_deep = pile{{"Prussian blue", 3.5}, {"raw umber", 3}, {"burnt sienna", 1}, turps=0.5, name="sky_deep"}
p_sky_mid = pile{{"Prussian blue", 2}, {"cobalt blue", 2}, {"raw umber", 2}, {"lead white", 1.2}, turps=0.45, name="sky_mid"}
p_sky_moon = pile{{"cobalt blue", 2}, {"raw umber", 1.5}, {"lead white", 2.8}, {"yellow ochre", 0.6}, turps=0.45, name="sky_moon"}
p_mesa = pile{{"raw umber", 3}, {"Prussian blue", 1.5}, {"red earth", 1.5}, {"lead white", 0.5}, turps=0.5, name="mesa_dark"}
p_ground_dark = pile{{"raw umber", 3.5}, {"Prussian blue", 1.2}, {"burnt sienna", 1.5}, {"yellow ochre", 1}, turps=0.5, name="ground_dark"}
p_ground_mid = pile{{"raw umber", 2.5}, {"yellow ochre", 2.5}, {"red earth", 1.2}, {"lead white", 0.8}, turps=0.45, name="ground_mid"}
p_ground_spill = pile{{"yellow ochre", 3.5}, {"orange chrome", 2}, {"red lead", 1}, {"lead white", 2}, turps=0.45, name="ground_spill"}
p_blast_fast = pile{{"orange chrome", 2.5}, {"red lead", 1.5}, {"Mars red", 1}, {"lead-tin yellow", 1.2}, turps=0.45, name="blast_fast"}

p_cowboy_shadow = pile{{"raw umber", 3.5}, {"Prussian blue", 1.5}, {"burnt sienna", 1.5}, turps=0.5, name="cowboy_shadow"}
p_cowboy_lit = pile{{"yellow ochre", 2.5}, {"orange chrome", 1.5}, {"burnt sienna", 1}, {"lead white", 1.5}, turps=0.45, name="cowboy_lit"}
p_zombie_shadow = pile{{"green earth", 2.5}, {"raw umber", 2.5}, {"Prussian blue", 1}, {"viridian", 1}, turps=0.45, name="zombie_shadow"}
p_zombie_lit = pile{{"lead white", 2.5}, {"yellow ochre", 1.5}, {"green earth", 2}, {"raw umber", 1}, turps=0.4, name="zombie_lit"}

-- Lay in the night sky
local bg_sky = sky_mask - (cowboy_mass:shrink(6) + zombie_mass:shrink(6) + blast_halo_m:shrink(10))
work(bg_sky, {
  hand = "broad",
  piles = {
    {p_sky_deep, function(x, y) return clamp((x - 200) / 700 + (350 - y) / 450, 0.15, 1.0) end},
    {p_sky_mid, function(x, y) return clamp(1.0 - math.abs(y - 320) / 220, 0.1, 0.9) end},
    {p_sky_moon, function(x, y)
      local d_moon = math.sqrt((x - 135)^2 + (y - 125)^2)
      local moon_w = clamp(1.0 - d_moon / 240, 0, 1)
      local horiz_w = clamp(1.0 - math.abs(y - 445) / 80, 0, 0.5) * clamp((500 - x) / 450, 0, 1)
      return moon_w + horiz_w
    end}
  },
  coverage = 1.35,
  load = 0.85,
  angle = -0.12
})

-- Distant frontier town / desert mesa on the left horizon and graveyard hill on the right
mesa_m = poly({{0, 485}, {0, 428}, {55, 422}, {62, 395}, {128, 395}, {135, 425}, {195, 428}, {215, 452}, {365, 468}, {395, 502}, {0, 502}}) - cowboy_mass:shrink(4)
right_hill_m = poly({{610, 508}, {685, 452}, {825, 435}, {935, 418}, {1000, 425}, {1000, 485}, {610, 512}}, true) - zombie_mass:shrink(4)
work(mesa_m + right_hill_m, {hand="body", pile=p_mesa, coverage=1.3, load=0.8, angle=0.05})

-- Lay in the ground plane with firelight spill pool under the blast
local bg_ground = ground_mask - (cowboy_leg_l_m:shrink(4) + cowboy_leg_r_m:shrink(4) + zombie_leg_r_m:shrink(4) + zombie_leg_l_m:shrink(4))
work(bg_ground, {
  hand = "broad",
  piles = {
    {p_ground_dark, function(x, y)
      local d = math.sqrt(((x - 505) / 1.3)^2 + ((y - 595) / 0.8)^2)
      return smoothstep(140, 360, d)
    end},
    {p_ground_mid, function(x, y)
      local d = math.sqrt(((x - 505) / 1.3)^2 + ((y - 595) / 0.8)^2)
      return clamp(1.0 - math.abs(d - 190) / 130, 0, 0.9)
    end},
    {p_ground_spill, function(x, y)
      local d = math.sqrt(((x - 505) / 1.2)^2 + ((y - 585) / 0.7)^2)
      return clamp(1.0 - d / 195, 0, 1.0)
    end}
  },
  coverage = 1.35,
  load = 0.85,
  angle = 0.04
})

-- Lay in the cowboy's large shadow and blast-lit masses
work(cowboy_mass, {
  hand = "body",
  piles = {
    {p_cowboy_shadow, function(x, y) return clamp((340 - x) / 140, 0.15, 1.0) end},
    {p_cowboy_lit, function(x, y)
      local d = math.sqrt((x - 460)^2 + (y - 365)^2)
      return clamp((x - 265) / 140, 0, 1) * clamp(1.1 - d / 260, 0.1, 1.0)
    end}
  },
  coverage = 1.35,
  load = 0.82,
  angle = 1.35,
  clip = cowboy_mass:grow(4)
})

-- Lay in the zombie's large shadow and blast-lit masses
work(zombie_mass, {
  hand = "body",
  piles = {
    {p_zombie_shadow, function(x, y) return clamp((x - 635) / 130, 0.15, 1.0) end},
    {p_zombie_lit, function(x, y)
      local d = math.sqrt((x - 525)^2 + (y - 365)^2)
      return clamp((700 - x) / 140, 0, 1) * clamp(1.1 - d / 260, 0.1, 1.0)
    end}
  },
  coverage = 1.35,
  load = 0.82,
  angle = -1.25,
  clip = zombie_mass:grow(4)
})

-- Lay in the fiery outer halo of the muzzle blast with fast-drying p_blast_fast
work(blast_halo_m, {hand="body", pile=p_blast_fast, coverage=1.4, load=0.85, edge="soft"})

--@ chunk 3
wait(36 * 60)
print("After 36h — sky:", drying(150, 150), "blast:", drying(518, 365), "cowboy:", drying(280, 350), "zombie:", drying(660, 380), "ground:", drying(500, 600))
-- Wait another 12h if any passage is still tacky
wait(12 * 60)
print("After 48h — sky:", drying(150, 150), "blast:", drying(518, 365), "cowboy:", drying(280, 350), "zombie:", drying(660, 380), "ground:", drying(500, 600))

-- 1. Bridge the neck masses and update figure silhouettes
cowboy_neck_m = poly({{228, 240}, {305, 245}, {318, 292}, {215, 282}}, true)
zombie_neck_m = poly({{675, 268}, {728, 272}, {715, 335}, {648, 338}}, true)

cowboy_mass = cowboy_mass + cowboy_neck_m
zombie_mass = zombie_mass + zombie_neck_m

-- Fill the sky/ground gaps around the necks first so no bare ground halo remains
local neck_gap_sky = poly({{640, 255}, {755, 255}, {755, 345}, {640, 345}}) - zombie_mass
work(neck_gap_sky, {hand="body", pile=p_sky_deep, coverage=1.3, load=0.8, clip=true})

-- 2. Widen the firelit ground spill behind both figures' legs to create crisp dark-against-light leg silhouettes
p_ground_lit_bright = pile{{"yellow ochre", 3}, {"lead-tin yellow", 2}, {"orange chrome", 1.5}, {"lead white", 2.5}, turps=0.25, name="ground_lit_bright"}
p_cast_shadow = pile{{"raw umber", 3.5}, {"Prussian blue", 2}, {"burnt sienna", 1}, turps=0.35, name="cast_shadow"}

local legs_all = cowboy_leg_l_m + cowboy_leg_r_m + cowboy_duster_m:band(0, 500) * below(function(x) return 520 end) + zombie_leg_r_m + zombie_leg_l_m
local wide_spill_m = ellipse(495, 595, 340, 115):roughen(20, 45, 7) * ground_mask - (cowboy_leg_l_m + cowboy_leg_r_m + zombie_leg_r_m + zombie_leg_l_m)

work(wide_spill_m, {
  hand = "broad",
  piles = {
    {p_ground_spill, function(x, y) return clamp(math.sqrt(((x - 500)/320)^2 + ((y - 575)/110)^2), 0.1, 1.0) end},
    {p_ground_lit_bright, function(x, y) return clamp(1.0 - math.sqrt(((x - 500)/220)^2 + ((y - 565)/85)^2), 0, 1.0) end}
  },
  coverage = 1.3,
  load = 0.82,
  angle = 0.03,
  clip = ground_mask - (cowboy_leg_l_m:shrink(2) + cowboy_leg_r_m:shrink(2) + zombie_leg_r_m:shrink(2) + zombie_leg_l_m:shrink(2))
})

-- Long directional cast shadows on the ground radiating away from the blast (x=505, y=365)
cast_sh_cowboy_r = poly({{322, 735}, {368, 738}, {210, 750}, {110, 750}})
cast_sh_cowboy_l = poly({{165, 730}, {212, 735}, {40, 750}, {0, 750}, {0, 715}})
cast_sh_zombie_r = poly({{588, 735}, {632, 738}, {785, 750}, {695, 750}})
cast_sh_zombie_l = poly({{748, 735}, {798, 738}, {995, 750}, {895, 750}})
work(cast_sh_cowboy_r + cast_sh_cowboy_l + cast_sh_zombie_r + cast_sh_zombie_l, {
  hand = "body",
  pile = p_cast_shadow,
  coverage = 1.3,
  load = 0.8,
  angle = 0.08,
  edge = "soft"
})

-- 3. Frontier graveyard fence posts / crooked wooden rails on the right & hitching post on the left
p_wood_dark = pile{{"raw umber", 3}, {"Prussian blue", 1}, {"burnt sienna", 1.5}, turps=0.3, name="wood_dark"}
p_wood_rim = pile{{"yellow ochre", 2.5}, {"orange chrome", 1.5}, {"raw umber", 1.5}, {"lead white", 1}, turps=0.25, name="wood_rim"}

fence_post_1 = poly({{772, 395}, {786, 393}, {798, 515}, {782, 516}})
fence_post_2 = poly({{868, 378}, {884, 382}, {865, 505}, {849, 503}})
fence_cross_bar = poly({{838, 405}, {908, 418}, {905, 430}, {835, 417}})
fence_rail_1 = poly({{745, 438}, {885, 458}, {883, 468}, {742, 448}})
fence_rail_2 = poly({{645, 468}, {785, 428}, {788, 438}, {648, 478}})
left_post = poly({{78, 425}, {92, 425}, {95, 528}, {80, 528}})
left_rail = poly({{0, 452}, {135, 442}, {135, 452}, {0, 462}})

local fences_m = (fence_post_1 + fence_post_2 + fence_cross_bar + fence_rail_1 + fence_rail_2 + left_post + left_rail) - (zombie_mass + cowboy_mass)
work(fences_m, {hand="detail", pile=p_wood_dark, coverage=1.4, load=0.8, clip=true})
-- Warm firelit left edges on the graveyard fence posts
local fence_lit_m = (poly({{772, 395}, {778, 394}, {788, 515}, {782, 516}}) + poly({{868, 378}, {875, 380}, {856, 504}, {849, 503}}) + poly({{645, 468}, {785, 428}, {786, 433}, {646, 473}})) - zombie_mass
work(fence_lit_m, {hand="detail", pile=p_wood_rim, coverage=1.3, load=0.75, clip=true})

-- 4. Cowboy: Moonlit cool half-light on back duster/hat + warm blast-lit planes on front
p_duster_moon = pile{{"cobalt blue", 1.5}, {"yellow ochre", 2}, {"raw umber", 2}, {"lead white", 2.2}, name="duster_moon"}
p_duster_warm = pile{{"yellow ochre", 3}, {"burnt sienna", 2}, {"orange chrome", 1.2}, {"lead white", 1.2}, name="duster_warm"}
p_bandana_red = pile{{"Mars red", 2.5}, {"orange chrome", 1.5}, {"burnt sienna", 1}, {"lead white", 0.4}, name="bandana_red"}
p_hat_underbrim = pile{{"orange chrome", 2}, {"yellow ochre", 2.5}, {"burnt sienna", 1.5}, {"lead white", 1.2}, name="hat_underbrim"}

-- Cool moonlit rim/plane along the cowboy's left back edge (hat crown left, shoulder, duster sweep)
local duster_moon_m = poly({{182, 198}, {238, 156}, {258, 155}, {235, 192}, {198, 208}}, true)
  + poly({{212, 262}, {238, 272}, {212, 435}, {182, 638}, {128, 635}, {162, 455}, {195, 330}}, true)
  + poly({{165, 748}, {180, 610}, {195, 488}, {210, 488}, {195, 615}, {182, 748}})
work(duster_moon_m, {hand="body", pile=p_duster_moon, coverage=1.3, load=0.8, angle=1.4, clip=cowboy_mass})

-- Warm firelit planes on cowboy's front torso, right leg, arms, under-brim, and bandana
local cowboy_front_lit_m = poly({{265, 268}, {308, 268}, {328, 365}, {322, 485}, {275, 485}, {278, 365}}, true)
  + poly({{292, 480}, {325, 478}, {352, 605}, {372, 748}, {345, 748}, {322, 605}}, true)
  + cowboy_arm_r_m + cowboy_arm_l_m
work(cowboy_front_lit_m, {hand="body", pile=p_duster_warm, coverage=1.35, load=0.82, angle=0.6, clip=cowboy_mass})

-- Red neckerchief / bandana bridging neck and chest
work(cowboy_neck_m, {hand="detail", pile=p_bandana_red, coverage=1.5, load=0.85, clip=cowboy_mass})

-- Warm glow on underside of Stetson brim and cowboy's face profile
local underbrim_m = poly({{225, 202}, {298, 185}, {348, 214}, {318, 224}, {242, 214}}, true)
local face_lit_m = poly({{262, 212}, {306, 214}, {302, 256}, {265, 252}}, true)
work(underbrim_m + face_lit_m, {hand="detail", pile=p_hat_underbrim, coverage=1.4, load=0.85, clip=cowboy_mass})

-- Re-state deep shadow core down the middle of the cowboy's duster and trousers so he has full 3D turn of form
local cowboy_core_sh = poly({{222, 280}, {268, 285}, {275, 485}, {235, 645}, {185, 638}, {212, 445}}, true)
  + poly({{205, 488}, {248, 488}, {225, 620}, {212, 748}, {182, 748}, {195, 615}})
  + poly({{268, 482}, {298, 482}, {325, 610}, {345, 748}, {322, 748}, {298, 610}})
work(cowboy_core_sh, {hand="body", pile=p_cowboy_shadow, coverage=1.3, load=0.8, angle=1.45, clip=cowboy_mass})

-- 5. Reshape Muzzle Blast into a sharp directional jet + cylinder vents
p_blast_mid = pile{{"orange chrome", 2.5}, {"lead-tin yellow", 2.5}, {"lead white", 1.5}, name="blast_mid"}
blast_jet_m = poly({{466, 358}, {525, 325}, {622, 355}, {638, 368}, {615, 388}, {528, 408}, {466, 368}}, true):roughen(10, 25, 19)
blast_vent_up = poly({{435, 356}, {465, 312}, {482, 322}, {445, 358}}, true):roughen(6, 18, 23)
blast_vent_dn = poly({{435, 368}, {475, 412}, {492, 402}, {445, 366}}, true):roughen(6, 18, 29)

work(blast_jet_m + blast_vent_up + blast_vent_dn, {hand="body", pile=p_blast_fast, coverage=1.4, load=0.85, angle=0.05, edge="soft"})
work(blast_jet_m:shrink(12), {hand="body", pile=p_blast_mid, coverage=1.4, load=0.85, angle=0.05, edge="soft"})

-- 6. Zombie: Bridge neck, define recoiling ribcage/chest impact cavity, and blast-lit front planes vs gangrenous shadow planes
p_zombie_flesh_lit = pile{{"lead white", 2.5}, {"yellow ochre", 2}, {"green earth", 2}, {"orange chrome", 0.6}, name="zombie_flesh_lit"}
p_zombie_coat_sh = pile{{"raw umber", 3}, {"Prussian blue", 1.8}, {"green earth", 1.5}, name="zombie_coat_sh"}
p_wound_dark = pile{{"Mars red", 2.5}, {"raw umber", 2}, {"burnt sienna", 1.5}, name="wound_dark"}

work(zombie_neck_m, {hand="detail", pile=p_zombie_flesh_lit, coverage=1.5, load=0.85, clip=zombie_mass})

-- Lit planes on zombie's outstretched right arm, face/jaw, chest edge, and front right leg
local zombie_lit_planes = zombie_arm_r_m
  + poly({{665, 232}, {715, 212}, {712, 285}, {665, 272}}, true)
  + poly({{618, 330}, {675, 325}, {678, 488}, {628, 492}}, true)
  + poly({{582, 748}, {602, 612}, {632, 492}, {655, 495}, {622, 615}, {605, 748}})
work(zombie_lit_planes, {hand="body", pile=p_zombie_flesh_lit, coverage=1.35, load=0.82, angle=-0.4, clip=zombie_mass})

-- Deep tattered coat & shadow planes on zombie's back, flung left arm, and back leg
local zombie_dark_planes = zombie_coat_flap_m + zombie_arm_l_m
  + poly({{675, 325}, {725, 315}, {742, 415}, {725, 505}, {675, 500}}, true)
  + zombie_leg_l_m
work(zombie_dark_planes, {hand="body", pile=p_zombie_coat_sh, coverage=1.35, load=0.82, angle=-1.2, clip=zombie_mass})

-- Blast impact cavity on the zombie's left chest/shoulder (x=622..682, y=342..415)
zombie_wound_m = poly({{622, 348}, {668, 338}, {685, 372}, {665, 412}, {625, 398}}, true):roughen(6, 16, 31)
work(zombie_wound_m, {hand="detail", pile=p_wound_dark, coverage=1.5, load=0.85, clip=zombie_mass})

--@ chunk 4
wait(96 * 60)
print("Before Campaign 3 — cowboy:", drying(280, 350), "zombie:", drying(660, 380), "ground:", drying(500, 600), "blast:", drying(518, 365))

-- Campaign 3 piles for the Cowboy
p_hat_felt_dark = pile{{"raw umber", 3}, {"burnt sienna", 1.5}, {"Prussian blue", 0.8}, name="hat_felt_dark"}
p_hat_moon = pile{{"cobalt blue", 1.5}, {"raw umber", 2}, {"yellow ochre", 1.5}, {"lead white", 2.5}, name="hat_moon"}
p_underbrim_glow = pile{{"orange chrome", 2.2}, {"yellow ochre", 2.5}, {"lead white", 1.8}, {"Mars red", 0.5}, name="underbrim_glow"}
p_flesh_shadow = pile{{"burnt sienna", 2.2}, {"raw umber", 2}, {"Mars red", 1}, name="flesh_shadow"}
p_flesh_fire = pile{{"orange chrome", 2}, {"yellow ochre", 2}, {"vermilion", 0.8}, {"lead white", 2.2}, name="flesh_fire"}
p_flesh_high = pile{{"lead white", 3}, {"lead-tin yellow", 2}, {"orange chrome", 1.2}, blot=0.2, name="flesh_high"}

p_bandana_sh = pile{{"Mars red", 3}, {"raw umber", 2}, {"carmine lake", 1.5}, name="bandana_sh"}
p_bandana_lit = pile{{"vermilion", 2.5}, {"orange chrome", 1.8}, {"lead white", 0.8}, name="bandana_lit"}

p_vest_dark = pile{{"raw umber", 3}, {"burnt sienna", 2}, {"bone black", 1}, name="vest_dark"}
p_vest_lit = pile{{"burnt sienna", 2.5}, {"yellow ochre", 2}, {"orange chrome", 1.2}, {"lead white", 0.8}, name="vest_lit"}
p_sleeve_lit = pile{{"yellow ochre", 2.5}, {"orange chrome", 2}, {"lead white", 2.2}, name="sleeve_lit"}
p_duster_fold_lit = pile{{"yellow ochre", 3}, {"orange chrome", 1.5}, {"burnt sienna", 1}, {"lead white", 1.6}, name="duster_fold_lit"}

p_steel_dark = pile{{"Prussian blue", 2.5}, {"raw umber", 2}, {"bone black", 1.5}, name="steel_dark"}
p_steel_glint = pile{{"lead white", 3.5}, {"lead-tin yellow", 2}, {"orange chrome", 1}, blot=0.25, name="steel_glint"}

-- 1. Stetson Hat modeling
local hat_crown_dark = poly({{235, 156}, {288, 155}, {302, 182}, {295, 198}, {225, 196}}, true)
work(hat_crown_dark, {hand="detail", pile=p_hat_felt_dark, coverage=1.4, load=0.85, angle=0.2, clip=cowboy_hat_m})

local hat_crown_moon = poly({{218, 188}, {238, 156}, {258, 156}, {242, 192}}, true)
  + poly({{182, 198}, {218, 188}, {232, 196}, {195, 210}}, true)
work(hat_crown_moon, {hand="detail", pile=p_hat_moon, coverage=1.35, load=0.8, angle=-0.5, clip=cowboy_hat_m})

local hat_underbrim = poly({{232, 198}, {302, 186}, {348, 214}, {318, 224}, {245, 214}}, true)
work(hat_underbrim, {hand="detail", pile=p_underbrim_glow, coverage=1.5, load=0.85, angle=0.35, clip=cowboy_hat_m})

-- Upper edge of front brim & crown pinch shadow
local b_det = brush{kind="round", width=3, point=0.9, stiffness=0.65}
b_det:reload(p_hat_felt_dark, 0.85)
b_det:gesture({{245, 168, 0.5}, {268, 174, 0.8}, {288, 168, 0.4}})
b_det:gesture({{225, 196, 0.6}, {298, 186, 0.85}, {346, 212, 0.5}})

-- Firelit hatband & front crown rim
b_det:reload(p_flesh_fire, 0.8)
b_det:gesture({{232, 194, 0.4}, {268, 190, 0.7}, {298, 186, 0.8}})
b_det:gesture({{286, 160, 0.4}, {298, 175, 0.75}, {302, 188, 0.6}})

-- 2. Cowboy Face: shadowed eye socket under brim, sharp firelit nose, cheekbone, mustache, and jaw
work(cowboy_head_m, {hand="detail", pile=p_flesh_shadow, coverage=1.4, load=0.82, clip=cowboy_head_m})
local face_fire_planes = poly({{268, 216}, {308, 218}, {304, 240}, {296, 258}, {265, 254}}, true)
work(face_fire_planes, {hand="detail", pile=p_flesh_fire, coverage=1.5, load=0.85, clip=cowboy_head_m})

-- Nose bridge, cheekbone highlight, mustache shadow, and chin highlight
local b_fine = brush{kind="round", width=2.2, point=1.0, stiffness=0.7, lay=4}
b_fine:reload(p_flesh_high, 0.85)
b_fine:gesture({{294, 216, 0.5}, {307, 228, 0.9}, {298, 234, 0.6}}) -- nose bridge & tip
b_fine:gesture({{274, 226, 0.6}, {292, 232, 0.85}, {285, 240, 0.4}}) -- cheekbone
b_fine:gesture({{276, 248, 0.5}, {294, 252, 0.85}, {288, 258, 0.5}}) -- lower lip / chin

b_fine:reload(p_vest_dark, 0.85)
b_fine:gesture({{272, 214, 0.7}, {292, 217, 0.85}, {300, 216, 0.4}}) -- shadowed eye slit under brim
b_fine:gesture({{280, 238, 0.6}, {296, 240, 0.9}, {304, 246, 0.5}}) -- drooping mustache

-- 3. Red Bandana folds & knot
local bandana_full = poly({{212, 252}, {308, 250}, {322, 285}, {285, 302}, {205, 285}}, true)
work(bandana_full, {hand="detail", pile=p_bandana_sh, coverage=1.4, load=0.85, clip=bandana_full})
local bandana_lit_m = poly({{265, 252}, {308, 250}, {320, 282}, {282, 292}}, true)
work(bandana_lit_m, {hand="detail", pile=p_bandana_lit, coverage=1.4, load=0.85, clip=bandana_full})
b_det:reload(p_flesh_high, 0.75)
b_det:gesture({{292, 258, 0.4}, {312, 268, 0.8}, {302, 282, 0.3}}) -- hot firelight edge on bandana knot

-- 4. Leather Vest, Cartridge Belt, Holster, and Windblown Duster Folds
local vest_m = poly({{235, 282}, {312, 278}, {324, 375}, {316, 462}, {238, 462}, {232, 370}}, true)
work(vest_m, {hand="body", pile=p_vest_dark, coverage=1.35, load=0.82, angle=1.5, clip=cowboy_mass})
local vest_lit_edge = poly({{282, 280}, {312, 278}, {324, 375}, {316, 462}, {292, 460}, {295, 370}}, true)
work(vest_lit_edge, {hand="detail", pile=p_vest_lit, coverage=1.4, load=0.82, angle=1.5, clip=cowboy_mass})

-- Duster coat billowing back to the left (cool moonlit upper folds + warm reflected light on lower front lapel)
local b_med = brush{kind="filbert", width=7, stiffness=0.7, lay=3}
b_med:reload(p_hat_moon, 0.85)
b_med:gesture({{215, 285, 0.7}, {185, 420, 0.85}, {142, 625, 0.5}})
b_med:gesture({{228, 330, 0.6}, {198, 465, 0.8}, {168, 635, 0.4}})

b_med:reload(p_duster_fold_lit, 0.85)
b_med:gesture({{258, 360, 0.6}, {252, 485, 0.85}, {232, 645, 0.6}})
b_med:gesture({{312, 482, 0.7}, {342, 595, 0.85}, {365, 735, 0.5}}) -- firelit front edge of right leg/chaps
b_med:gesture({{222, 495, 0.6}, {215, 610, 0.75}, {205, 735, 0.4}}) -- firelit inner edge of left leg

-- Heavy gunbelt & holster with brass cartridge glints
local belt_m = poly({{202, 456}, {328, 468}, {326, 492}, {200, 480}})
local holster_m = poly({{302, 482}, {338, 485}, {332, 578}, {298, 572}}, true)
work(belt_m + holster_m, {hand="detail", pile=p_vest_dark, coverage=1.5, load=0.85, clip=cowboy_mass})
b_fine:reload(p_flesh_high, 0.85)
for i = 0, 6 do
  local bx = 225 + i * 14
  local by = 462 + i * 1.5
  b_fine:stroke({{bx, by}, {bx - 1, by + 11}}, {pressure=0.7})
end
-- Brass belt buckle glint
b_fine:stroke({{292, 466}, {304, 468}, {302, 482}, {290, 480}, {292, 466}}, {pressure=0.8})

-- 5. Both Arms & Hands (Extended right arm + fanning left arm/hand)
work(cowboy_arm_r_m, {hand="detail", pile=p_vest_dark, coverage=1.3, load=0.8, angle=0.5, clip=cowboy_arm_r_m})
local arm_r_upper_lit = poly({{292, 275}, {365, 325}, {415, 352}, {412, 368}, {355, 344}, {288, 298}}, true)
work(arm_r_upper_lit, {hand="detail", pile=p_sleeve_lit, coverage=1.45, load=0.85, angle=0.5, clip=cowboy_arm_r_m})

work(cowboy_arm_l_m, {hand="detail", pile=p_vest_dark, coverage=1.3, load=0.8, angle=-0.4, clip=cowboy_arm_l_m})
local arm_l_lit = poly({{312, 352}, {382, 312}, {408, 318}, {398, 338}, {320, 366}}, true)
work(arm_l_lit, {hand="detail", pile=p_sleeve_lit, coverage=1.45, load=0.85, angle=-0.4, clip=cowboy_arm_l_m})

-- Gloved right hand gripping gun & fanning left hand above hammer
local hand_r_m = poly({{392, 350}, {424, 354}, {422, 384}, {390, 378}}, true)
local hand_l_m = poly({{378, 312}, {416, 316}, {418, 342}, {382, 338}}, true)
work(hand_r_m + hand_l_m, {hand="detail", pile=p_flesh_fire, coverage=1.5, load=0.85})
b_fine:reload(p_flesh_high, 0.9)
b_fine:gesture({{386, 320, 0.5}, {408, 322, 0.9}, {416, 334, 0.7}}) -- hot blast glare on fanning palm/fingers
b_fine:gesture({{398, 354, 0.6}, {418, 358, 0.9}, {416, 374, 0.7}}) -- hot glare on right knuckles

-- 6. The Colt Peacemaker Revolver (x=404..472, y=348..392)
work(gun_m, {hand="detail", pile=p_steel_dark, coverage=1.6, load=0.9, clip=gun_m})
-- Walnut grip
local grip_m = poly({{404, 366}, {420, 366}, {414, 392}, {398, 388}})
work(grip_m, {hand="detail", pile=p_vest_lit, coverage=1.5, load=0.85, clip=grip_m})
-- Searing specular highlight along top of barrel, cylinder flutes, and frame
b_fine:reload(p_steel_glint, 0.95)
b_fine:stroke({{414, 354}, {470, 357}}, {pressure=0.85}) -- top edge of barrel & frame
b_fine:stroke({{420, 361}, {435, 362}}, {pressure=0.75}) -- cylinder flute highlight
b_fine:stroke({{438, 363}, {468, 364}}, {pressure=0.65}) -- lower barrel ejector rod housing glint
b_fine:stroke({{410, 347}, {416, 354}}, {pressure=0.75}) -- hammer spur

--@ chunk 5
wait(72 * 60)
print("Before Campaign 4 — cowboy:", drying(395, 340), "zombie:", drying(660, 380), "blast:", drying(518, 365))

-- 1. Refine the negative space between the cowboy's fanning left hand and extended right wrist/gun
local hand_gap_sky = poly({{348, 336}, {412, 338}, {408, 353}, {352, 348}})
work(hand_gap_sky, {hand="detail", pile=p_sky_deep, coverage=1.5, load=0.85, clip=true})

local b_fine = brush{kind="round", width=2.0, point=1.0, stiffness=0.75, lay=4}
-- Articulated fingers of the cowboy's fanning left hand (catching hot flash from below-right)
b_fine:reload(p_flesh_fire, 0.85)
b_fine:gesture({{382, 326, 0.7}, {405, 314, 0.6}, {418, 312, 0.3}}) -- index finger
b_fine:gesture({{384, 330, 0.7}, {408, 320, 0.6}, {422, 319, 0.3}}) -- middle finger
b_fine:gesture({{385, 334, 0.7}, {408, 327, 0.6}, {420, 327, 0.3}}) -- ring finger
b_fine:gesture({{384, 337, 0.6}, {404, 334, 0.5}, {414, 335, 0.3}}) -- little finger
b_fine:reload(p_flesh_high, 0.85)
b_fine:gesture({{392, 334, 0.6}, {408, 328, 0.85}, {418, 326, 0.4}}) -- hot rim on palm/fingers

-- 2. Campaign 4 Piles for the Zombie
p_z_skull_sh = pile{{"green earth", 2.5}, {"raw umber", 2.5}, {"viridian", 1.2}, {"Prussian blue", 0.8}, name="z_skull_sh"}
p_z_mid = pile{{"green earth", 2.5}, {"yellow ochre", 1.5}, {"lead white", 2.0}, {"raw umber", 1.2}, name="z_mid"}
p_z_fire_lit = pile{{"lead white", 2.8}, {"yellow ochre", 2.2}, {"orange chrome", 1.4}, {"green earth", 1.0}, name="z_fire_lit"}
p_z_bone_high = pile{{"lead white", 3.5}, {"lead-tin yellow", 2.0}, {"orange chrome", 0.8}, {"yellow ochre", 0.8}, blot=0.2, name="z_bone_high"}
p_z_cavity = pile{{"raw umber", 3.0}, {"Prussian blue", 1.5}, {"Mars red", 1.5}, name="z_cavity"}
p_z_wound_blood = pile{{"Mars red", 3.0}, {"carmine lake", 2.0}, {"raw umber", 1.5}, name="z_wound_blood"}
p_z_wound_fire = pile{{"vermilion", 2.5}, {"orange chrome", 2.0}, {"lead-tin yellow", 1.5}, {"lead white", 1.0}, name="z_wound_fire"}
p_z_coat_dark = pile{{"raw umber", 3.0}, {"Prussian blue", 2.0}, {"bone black", 1.0}, name="z_coat_dark"}
p_z_coat_rim = pile{{"burnt sienna", 2.5}, {"yellow ochre", 2.0}, {"orange chrome", 1.2}, {"lead white", 0.8}, name="z_coat_rim"}

-- 3. Zombie Head, Skull Planes, Hollow Eye Sockets, Shrieking Jaw, and Strained Neck
work(zombie_head_m, {hand="detail", pile=p_z_skull_sh, coverage=1.4, load=0.85, clip=zombie_head_m})
local z_face_lit = poly({{668, 212}, {718, 206}, {715, 255}, {702, 288}, {665, 272}}, true)
work(z_face_lit, {hand="detail", pile=p_z_fire_lit, coverage=1.45, load=0.85, clip=zombie_head_m})

-- Deep hollow eye sockets, nasal cavity, and wide screaming mouth
local z_eye_l = ellipse(685, 228, 8, 7)
local z_eye_r = ellipse(708, 222, 8, 7)
local z_nose = poly({{684, 235}, {695, 234}, {692, 246}, {682, 245}})
local z_mouth = poly({{670, 250}, {705, 248}, {702, 278}, {668, 272}}, true)
work(z_eye_l + z_eye_r + z_nose + z_mouth, {hand="detail", pile=p_z_cavity, coverage=1.6, load=0.9, clip=zombie_head_m})

-- Highlighted brow ridge, zygomatic arch, teeth, and eerie eye-socket glints
b_fine:reload(p_z_bone_high, 0.9)
b_fine:gesture({{675, 218, 0.6}, {692, 216, 0.9}, {714, 212, 0.5}}) -- brow ridge
b_fine:gesture({{672, 236, 0.5}, {688, 240, 0.85}, {706, 236, 0.6}}) -- cheekbone / maxilla
b_fine:gesture({{668, 270, 0.6}, {686, 282, 0.9}, {704, 276, 0.5}}) -- lower jaw / chin
-- Upper & lower teeth glints inside the screaming mouth
for i = 0, 3 do
  b_fine:stroke({{674 + i * 6, 251}, {674 + i * 6, 257}}, {pressure=0.75})
  b_fine:stroke({{673 + i * 6, 268}, {674 + i * 6, 263}}, {pressure=0.7})
end
-- Pinpoint eerie yellow-green catchlights in eye sockets
b_fine:touch(686, 228, {pressure=0.65})
b_fine:touch(709, 222, {pressure=0.65})

-- Stringy matted hair flying back from the zombie's skull (upper right)
local b_rig = brush{kind="rigger", width=2.2, point=1.0, stiffness=0.6}
b_rig:reload(p_z_skull_sh, 0.85)
b_rig:gesture({{718, 204, 0.7}, {748, 196, 0.5}, {774, 192, 0.1}})
b_rig:gesture({{728, 212, 0.7}, {762, 208, 0.5}, {788, 206, 0.1}})
b_rig:gesture({{736, 224, 0.7}, {768, 224, 0.5}, {792, 228, 0.1}})
b_rig:gesture({{740, 240, 0.6}, {768, 245, 0.4}, {785, 252, 0.1}})

-- Strained neck tendons & hollows
work(zombie_neck_m, {hand="detail", pile=p_z_mid, coverage=1.35, load=0.8, clip=zombie_neck_m})
b_fine:reload(p_z_cavity, 0.8)
b_fine:gesture({{682, 282, 0.6}, {675, 312, 0.8}, {668, 334, 0.5}})
b_fine:gesture({{702, 285, 0.6}, {696, 315, 0.8}, {690, 335, 0.5}})
b_fine:reload(p_z_fire_lit, 0.85)
b_fine:gesture({{672, 278, 0.6}, {664, 308, 0.85}, {656, 334, 0.6}})
b_fine:gesture({{690, 282, 0.6}, {684, 312, 0.85}, {678, 335, 0.6}})

-- 4. Zombie Outstretched Right Arm & Gnarled Claw Hand (x=520..642, y=278..362)
work(zombie_arm_r_m, {hand="detail", pile=p_z_mid, coverage=1.4, load=0.82, angle=-0.35, clip=zombie_arm_r_m})
local z_arm_r_lower_lit = poly({{530, 302}, {585, 318}, {635, 342}, {632, 362}, {578, 336}, {528, 316}}, true)
work(z_arm_r_lower_lit, {hand="detail", pile=p_z_fire_lit, coverage=1.5, load=0.85, angle=-0.35, clip=zombie_arm_r_m})

-- Gnarled skeletal fingers of the right hand reaching toward the cowboy (x=512..555, y=272..328)
b_fine:reload(p_z_fire_lit, 0.9)
b_fine:gesture({{548, 292, 0.8}, {528, 278, 0.6}, {516, 282, 0.3}}) -- thumb/upper claw
b_fine:gesture({{542, 298, 0.8}, {520, 290, 0.65}, {508, 296, 0.3}}) -- index claw
b_fine:gesture({{538, 305, 0.8}, {516, 302, 0.65}, {506, 310, 0.3}}) -- middle claw
b_fine:gesture({{538, 312, 0.75}, {518, 314, 0.6}, {510, 322, 0.3}}) -- ring claw
b_fine:gesture({{542, 318, 0.7}, {525, 324, 0.5}, {518, 332, 0.25}}) -- pinky claw
b_fine:reload(p_z_bone_high, 0.9)
b_fine:gesture({{538, 308, 0.5}, {520, 304, 0.85}, {508, 310, 0.4}}) -- hot blast rim on lower fingers

-- 5. Zombie Flung-Back Left Arm & Hand (x=712..865, y=268..368)
work(zombie_arm_l_m, {hand="detail", pile=p_z_skull_sh, coverage=1.4, load=0.82, angle=-0.45, clip=zombie_arm_l_m})
b_fine:reload(p_z_mid, 0.85)
b_fine:gesture({{722, 336, 0.7}, {782, 322, 0.8}, {842, 282, 0.6}})
-- Splayed fingers on flung-back left hand (x=838..872, y=262..305)
b_fine:gesture({{842, 282, 0.7}, {856, 264, 0.5}, {864, 258, 0.2}})
b_fine:gesture({{846, 286, 0.7}, {865, 274, 0.5}, {874, 270, 0.2}})
b_fine:gesture({{848, 292, 0.7}, {868, 286, 0.5}, {876, 285, 0.2}})
b_fine:gesture({{848, 298, 0.6}, {865, 298, 0.4}, {872, 302, 0.2}})

-- 6. Zombie Torso: Exposed Ribcage, Searing Blast Wound Cavity, and Flying Tattered Coat
-- Deep wound interior
work(zombie_wound_m, {hand="detail", pile=p_z_wound_blood, coverage=1.6, load=0.9, clip=zombie_mass})
-- Searing fire-lit rim on the left edge of the chest wound where the blast jet hits
local wound_fire_rim = poly({{618, 344}, {648, 338}, {642, 375}, {652, 408}, {622, 402}}, true)
work(wound_fire_rim, {hand="detail", pile=p_z_wound_fire, coverage=1.5, load=0.88, clip=zombie_mass})

-- Shattered rib arcs visible across the wound and lower ribcage
local b_rib = brush{kind="round", width=2.8, point=0.9, stiffness=0.75, lay=4}
b_rib:reload(p_z_bone_high, 0.9)
b_rib:gesture({{626, 352, 0.8}, {652, 348, 0.7}, {665, 354, 0.3}}) -- broken upper rib 1
b_rib:gesture({{624, 368, 0.85}, {648, 366, 0.6}, {658, 370, 0.2}}) -- shattered rib 2
b_rib:gesture({{626, 386, 0.85}, {654, 384, 0.7}, {672, 392, 0.4}}) -- rib 3
b_rib:reload(p_z_fire_lit, 0.85)
b_rib:gesture({{632, 406, 0.7}, {668, 405, 0.85}, {695, 416, 0.4}}) -- lower ribcage arc 4
b_rib:gesture({{636, 424, 0.7}, {670, 424, 0.8}, {694, 435, 0.4}}) -- lower ribcage arc 5
b_rib:gesture({{640, 442, 0.65}, {672, 443, 0.75}, {692, 454, 0.3}}) -- lower ribcage arc 6

-- Tattered coat flapping violently to the right & torn trouser legs
local coat_shreds_m = zombie_coat_flap_m
  + poly({{745, 360}, {818, 385}, {848, 425}, {785, 415}}, true)
  + poly({{755, 435}, {835, 468}, {855, 505}, {772, 488}}, true)
work(coat_shreds_m, {hand="body", pile=p_z_coat_dark, coverage=1.4, load=0.85, angle=-0.5, clip=coat_shreds_m})

-- Warm firelit edges along the torn coat lapels & trouser legs
b_rib:reload(p_z_coat_rim, 0.85)
b_rib:gesture({{698, 338, 0.7}, {712, 415, 0.85}, {725, 495, 0.6}})
b_rib:gesture({{728, 445, 0.6}, {768, 485, 0.8}, {805, 515, 0.3}})
b_rib:gesture({{628, 495, 0.75}, {602, 612, 0.85}, {585, 738, 0.6}}) -- front right leg firelit edge
b_rib:gesture({{712, 502, 0.65}, {732, 618, 0.75}, {755, 738, 0.5}}) -- back left leg firelit edge

-- Exposed bony knee on the zombie's front right leg (x=602..630, y=585..632)
local z_knee_m = ellipse(615, 608, 12, 20)
work(z_knee_m, {hand="detail", pile=p_z_fire_lit, coverage=1.5, load=0.85, clip=zombie_leg_r_m})

--@ chunk 6
wait(96 * 60)
print("Before Campaign 5 — blast:", drying(518, 365), "zombie wound:", drying(645, 370), "sky above blast:", drying(520, 250))

-- 1. Gunsmoke Veils (using verified Trial 2A recipes & hand="glaze" soft filbert handling)
p_smoke_warm = pile{{"yellow ochre", 2}, {"Mars orange", 1}, {"raw umber", 1.5}, {"lead white", 1.2}, thinner=0.68, name="smoke_warm"}
p_smoke_cool = pile{{"ultramarine ash", 2.5}, {"raw umber", 1.5}, {"yellow ochre", 0.8}, {"lead white", 1.2}, thinner=0.70, name="smoke_cool"}

local smoke_protect = gun_m + cowboy_arm_r_m + cowboy_arm_l_m + zombie_arm_r_m:shrink(2)
local smoke_warm_m = (ellipse(505, 330, 62, 38) + ellipse(545, 398, 55, 30) + ellipse(450, 325, 35, 28)):roughen(14, 28, 41) - smoke_protect
local smoke_cool_m = (ellipse(495, 265, 68, 52) + ellipse(548, 225, 58, 48) + ellipse(445, 235, 45, 38)):roughen(18, 35, 43) - smoke_protect

work(smoke_warm_m, {hand="glaze", tool="filbert 16", pile=p_smoke_warm, coverage=0.9, load=0.55, pressure={0.2, 0.35}, angle=-0.3})
work(smoke_cool_m, {hand="glaze", tool="filbert 18", pile=p_smoke_cool, coverage=0.9, load=0.50, pressure={0.18, 0.32}, angle=-0.45})

-- Also add a subtle pale moonlit cloud veil in the upper-left sky (around x=135, y=125) and pale moon disc
p_moon_disc = pile{{"lead white", 3.5}, {"lead-tin yellow", 1.0}, {"cobalt blue", 0.4}, {"raw umber", 0.4}, thinner=0.35, name="moon_disc"}
local moon_m = ellipse(132, 118, 26, 25):soften(6)
work(moon_m, {hand="glaze", tool="filbert 12", pile=p_moon_disc, coverage=1.1, load=0.65, pressure={0.25, 0.45}})
local moon_cloud_m = (ellipse(105, 132, 55, 18) + ellipse(172, 108, 48, 15)):roughen(10, 25, 53)
work(moon_cloud_m, {hand="glaze", tool="filbert 16", pile=p_smoke_cool, coverage=0.85, load=0.5, pressure={0.2, 0.32}, angle=0.08})

-- Rising dust veil kicked up around the figures' boots on the firelit floor
local dust_veil_m = (ellipse(395, 685, 65, 28) + ellipse(585, 695, 72, 30)):roughen(12, 28, 59)
work(dust_veil_m, {hand="glaze", tool="filbert 16", pile=p_smoke_warm, coverage=0.8, load=0.5, pressure={0.18, 0.32}, angle=0.05})

wait(20) -- let thinner evaporate from smoke and dust veils

-- 2. Incandescent Muzzle Blast Core (using verified Trial 1 recipes over dry underlayer)
p_blast_hot = pile{{"cadmium yellow", 2.5}, {"orange chrome", 1.5}, {"lead white", 2.0}, blot=0.2, name="blast_hot"}
p_blast_core = pile{{"lead white", 4.5}, {"pale cadmium", 2.0}, {"cadmium yellow", 0.5}, blot=0.25, name="blast_core"}

local b_blast_mid = brush{kind="filbert", width=7, lay=5, stiffness=0.75}
b_blast_mid:reload(p_blast_hot, 0.9)
-- Directional forward jet and side cylinder vents
b_blast_mid:gesture({{468, 362, 0.95}, {525, 355, 0.85}, {595, 358, 0.5}, {632, 362, 0.15}})
b_blast_mid:gesture({{468, 364, 0.95}, {530, 372, 0.85}, {598, 375, 0.5}, {635, 372, 0.15}})
b_blast_mid:gesture({{472, 360, 0.85}, {515, 338, 0.65}, {558, 325, 0.2}})
b_blast_mid:gesture({{472, 365, 0.85}, {518, 386, 0.65}, {562, 402, 0.2}})
-- Cylinder-gap vents
b_blast_mid:gesture({{436, 356, 0.8}, {458, 328, 0.5}, {475, 312, 0.15}})
b_blast_mid:gesture({{436, 366, 0.8}, {462, 392, 0.5}, {482, 408, 0.15}})

-- White-hot impasto core right at the muzzle exit and lancing into the zombie's chest
local b_blast_core = brush{kind="filbert", width=5.5, lay=8, stiffness=0.85}
b_blast_core:reload(p_blast_core, 0.95)
b_blast_core:gesture({{468, 362, 1.0}, {512, 362, 0.95}, {565, 364, 0.7}, {622, 366, 0.2}})
b_blast_core:gesture({{468, 360, 0.95}, {502, 354, 0.8}, {542, 348, 0.3}})
b_blast_core:gesture({{468, 364, 0.95}, {505, 370, 0.8}, {545, 376, 0.3}})
b_blast_core:gesture({{435, 358, 0.85}, {452, 340, 0.35}}) -- hot cylinder flash upper
b_blast_core:gesture({{435, 364, 0.85}, {454, 380, 0.35}}) -- hot cylinder flash lower

-- Touch of white-hot impact spark right inside the zombie's chest cavity (x=625..645, y=362..374)
b_blast_core:gesture({{618, 364, 0.8}, {638, 366, 0.9}, {654, 362, 0.3}})

-- 3. Spatter: Flying Gunpowder Embers & Blast-Lit Crimson Ichor Spray (from Trial 2B)
p_ember_spatter = pile{{"lead-tin yellow", 2.5}, {"orange chrome", 2.0}, {"lead white", 1.5}, turps=0.55, name="ember_spatter"}
p_ichor_lit_spatter = pile{{"cadmium red", 2.5}, {"Mars red", 2.0}, {"orange chrome", 1.0}, {"lead white", 0.4}, turps=0.5, name="ichor_lit_spatter"}
p_ichor_dark = pile{{"Mars red", 3.0}, {"burnt sienna", 2.0}, {"raw umber", 1.5}, turps=0.45, name="ichor_dark"}

local b_sp = brush{kind="round", width=4, stiffness=0.7}
-- Clip embers so they don't land on the cowboy's face
local ember_clip = rect(430, 220, 320, 280)
b_sp:reload(p_ember_spatter, 0.9)
local n_e1 = b_sp:spatter{at={475, 362}, toward={115, -22}, spread=0.40, force=0.65, clip=ember_clip}
b_sp:reload(p_ember_spatter, 0.85)
local n_e2 = b_sp:spatter{at={485, 365}, toward={125, 25}, spread=0.38, force=0.60, clip=ember_clip}

-- Clip ichor spray to the zombie's chest/back and night sky to the right of x=615
local ichor_clip = rect(615, 240, 320, 260)
b_sp:reload(p_ichor_lit_spatter, 0.9)
local n_i1 = b_sp:spatter{at={645, 368}, toward={115, -18}, spread=0.42, force=0.58, clip=ichor_clip}
b_sp:reload(p_ichor_lit_spatter, 0.85)
local n_i2 = b_sp:spatter{at={710, 362}, toward={125, 15}, spread=0.40, force=0.55, clip=ichor_clip}
b_sp:reload(p_ichor_dark, 0.85)
local n_i3 = b_sp:spatter{at={695, 372}, toward={130, 28}, spread=0.38, force=0.52, clip=ichor_clip}

-- A few decisive directional streaks of blast-lit crimson and torn cloth flying out the right side of the zombie's shoulder/back
local b_streak = brush{kind="round", width=2.4, point=1.0, stiffness=0.7}
b_streak:reload(p_ichor_lit_spatter, 0.85)
b_streak:gesture({{655, 362, 0.8}, {715, 348, 0.6}, {768, 338, 0.1}})
b_streak:gesture({{662, 376, 0.8}, {728, 372, 0.55}, {785, 375, 0.1}})
b_streak:gesture({{658, 390, 0.75}, {718, 398, 0.5}, {765, 412, 0.1}})

print("Campaign 5 spatters — embers:", n_e1 + n_e2, "ichor:", n_i1 + n_i2 + n_i3)

--@ chunk 7
wait(72 * 60)
print("Before Campaign 6 — blast core:", drying(485, 362), "smoke:", drying(510, 260), "zombie wound:", drying(645, 370))

-- 1. Resolve Pocket A (behind cowboy's neck/ear under back hat brim, x=195..238, y=210..258)
local neck_sky_pocket = poly({{192, 208}, {238, 208}, {238, 258}, {192, 258}}) - (cowboy_hat_m + cowboy_head_m)
work(neck_sky_pocket, {hand="detail", pile=p_sky_moon, coverage=1.5, load=0.85, clip=true})
-- Extend dark hair/neck shadow & bandana left edge so they meet the moonlit sky cleanly
local hair_nape_m = poly({{224, 208}, {248, 208}, {245, 256}, {220, 256}}, true)
work(hair_nape_m, {hand="detail", pile=p_hat_felt_dark, coverage=1.5, load=0.85, clip=true})

-- 2. Resolve Pocket B (beneath revolver barrel & trigger guard, x=412..470, y=364..396)
local under_gun_pocket = poly({{412, 364}, {470, 364}, {470, 398}, {412, 398}})
work(under_gun_pocket, {hand="detail", pile=p_blast_fast, coverage=1.4, load=0.85, clip=true})
-- Re-state walnut grip, steel trigger guard, and finger on trigger over the filled pocket
local grip_m2 = poly({{400, 366}, {422, 366}, {415, 394}, {396, 390}})
work(grip_m2, {hand="detail", pile=p_vest_lit, coverage=1.5, load=0.85, clip=true})
local b_fine = brush{kind="round", width=2.0, point=1.0, stiffness=0.75, lay=4}
b_fine:reload(p_steel_dark, 0.9)
b_fine:stroke({{418, 366}, {424, 377}, {435, 375}, {436, 366}}, {pressure=0.8}) -- trigger guard bow
b_fine:reload(p_flesh_high, 0.9)
b_fine:stroke({{423, 367}, {429, 373}}, {pressure=0.75}) -- index finger on trigger catching flash
b_fine:reload(p_steel_glint, 0.9)
b_fine:stroke({{420, 376}, {434, 375}}, {pressure=0.7}) -- hot specular glint on bottom of trigger guard

-- 3. Knit figure-to-ground contours along arms and legs so no bare ground/chalk reserve remains
local b_edge = brush{kind="filbert", width=5.5, stiffness=0.65, lay=2}

-- Cowboy legs & boots (knit outer dark and firelit contours + add riding boots & spurs)
local boot_l_m = poly({{158, 695}, {214, 695}, {216, 748}, {152, 748}}, true)
local boot_r_m = poly({{320, 695}, {376, 695}, {384, 748}, {322, 748}}, true)
work(boot_l_m + boot_r_m, {hand="detail", pile=p_vest_dark, coverage=1.5, load=0.85})

b_edge:reload(p_vest_dark, 0.85)
-- Left leg outer & inner contour strokes
b_edge:gesture({{195, 485, 0.8}, {178, 610, 0.85}, {162, 745, 0.8}})
b_edge:gesture({{246, 488, 0.8}, {225, 620, 0.85}, {210, 745, 0.8}})
-- Right leg shadow & inner contour strokes
b_edge:gesture({{268, 482, 0.8}, {296, 610, 0.85}, {322, 745, 0.8}})
-- Duster lower hem & left edge
b_edge:reload(p_duster_moon, 0.85)
b_edge:gesture({{195, 330, 0.7}, {160, 455, 0.85}, {128, 635, 0.75}, {185, 648, 0.6}})
b_edge:reload(p_duster_fold_lit, 0.85)
b_edge:gesture({{324, 480, 0.8}, {352, 605, 0.85}, {375, 742, 0.8}}) -- crisp firelit front edge of right leg/boot

-- Silver spur rowel glints at the cowboy's boot heels
b_fine:reload(p_steel_glint, 0.9)
b_fine:stroke({{150, 736}, {162, 738}}, {pressure=0.8})
b_fine:touch(148, 736, {pressure=0.85})
b_fine:stroke({{314, 738}, {325, 738}}, {pressure=0.8})
b_fine:touch(312, 738, {pressure=0.85})

-- Zombie arms & legs contour knitting
b_edge:reload(p_z_mid, 0.85)
b_edge:gesture({{642, 324, 0.75}, {585, 304, 0.8}, {535, 286, 0.6}}) -- upper edge of zombie's right arm
b_edge:reload(p_z_fire_lit, 0.85)
b_edge:gesture({{632, 360, 0.75}, {578, 336, 0.85}, {528, 316, 0.7}}) -- lower firelit edge of zombie's right arm

b_edge:reload(p_z_skull_sh, 0.85)
b_edge:gesture({{712, 332, 0.75}, {782, 318, 0.8}, {846, 276, 0.65}}) -- upper edge of flung left arm
b_edge:gesture({{718, 368, 0.75}, {792, 348, 0.8}, {856, 302, 0.65}}) -- lower edge of flung left arm

-- Zombie legs & tattered trousers contour knitting
b_edge:reload(p_z_coat_dark, 0.85)
b_edge:gesture({{680, 495, 0.8}, {648, 618, 0.85}, {628, 745, 0.8}}) -- right leg back shadow edge
b_edge:gesture({{688, 495, 0.8}, {718, 620, 0.85}, {748, 745, 0.8}}) -- left leg inner shadow edge
b_edge:gesture({{740, 495, 0.8}, {768, 618, 0.85}, {798, 745, 0.8}}) -- left leg outer shadow edge
b_edge:reload(p_z_coat_rim, 0.85)
b_edge:gesture({{630, 492, 0.8}, {600, 612, 0.85}, {582, 745, 0.8}}) -- right leg firelit front edge

-- Soften outer shadow edges into the night sky and ground with lose()
lose(zombie_coat_flap_m, {pile=p_sky_deep, where=0.7, tool="filbert 5", load=0.25})
lose(zombie_leg_l_m, {pile=p_ground_dark, where=0.6, tool="filbert 5", load=0.25})

-- 4. Foreground desert floor textures: firelit rocks, dry scrub shadows, and glinting brass shell casings
local rock_1 = ellipse(445, 675, 18, 9)
local rock_2 = ellipse(545, 652, 14, 7)
local rock_3 = ellipse(275, 685, 22, 10)
work(rock_1 + rock_2 + rock_3, {hand="detail", pile=p_cast_shadow, coverage=1.4, load=0.8})
b_fine:reload(p_ground_lit_bright, 0.85)
b_fine:gesture({{435, 670, 0.6}, {452, 668, 0.85}, {460, 673, 0.4}}) -- firelit top of rock 1
b_fine:gesture({{536, 648, 0.6}, {550, 647, 0.85}, {556, 652, 0.4}}) -- firelit top of rock 2
b_fine:gesture({{268, 679, 0.4}, {284, 678, 0.8}, {294, 683, 0.5}}) -- firelit right rim of rock 3

-- Glinting brass .45 Colt shell casings in the firelit dust
b_fine:reload(p_blast_core, 0.9)
b_fine:stroke({{418, 642}, {426, 645}}, {pressure=0.8})
b_fine:stroke({{478, 658}, {486, 655}}, {pressure=0.8})

-- 5. Subtle artist signature in lower left ("S." in warm burnt sienna/ochre)
local b_sig = brush{kind="rigger", width=1.6, point=1.0, stiffness=0.65}
b_sig:reload(p_z_coat_rim, 0.8)
b_sig:gesture({{52, 718, 0.5}, {42, 716, 0.6}, {40, 722, 0.6}, {52, 726, 0.6}, {50, 732, 0.6}, {38, 731, 0.4}})
b_sig:touch(58, 731, {pressure=0.6})

--@ chunk 8
print(wait(0))

--@ chunk 9
wait(96 * 60)
print("Before Campaign 7 (after +96h, day 21) — blast core:", drying(485, 362), "zombie wound:", drying(645, 370))

-- 1. Improve Passage 1 (Left frontier town / saloon facade & hitching rail, x=0..250, y=390..535)
local saloon_mesa_patch = poly({{0, 485}, {0, 425}, {55, 420}, {60, 394}, {132, 394}, {138, 424}, {202, 428}, {215, 455}, {205, 492}, {0, 492}}) - cowboy_mass
work(saloon_mesa_patch, {hand="body", pile=p_mesa, coverage=1.4, load=0.85, angle=0.02, clip=true})

-- Subtle warm kerosene-lamp window glow in the distant saloon & cool moonlit roofline
p_saloon_window = pile{{"yellow ochre", 3.0}, {"orange chrome", 1.5}, {"raw umber", 1.5}, {"lead white", 1.0}, name="saloon_window"}
local win_m = rect(102, 412, 14, 22)
work(win_m, {hand="detail", pile=p_saloon_window, coverage=1.4, load=0.8, clip=true})
local b_fine = brush{kind="round", width=2.0, point=1.0, stiffness=0.7}
b_fine:reload(p_mesa, 0.85)
b_fine:stroke({{109, 412}, {109, 434}}, {pressure=0.6}) -- window muntin vertical
b_fine:stroke({{102, 423}, {116, 423}}, {pressure=0.6}) -- window muntin horizontal

-- Moonlit top edge on distant saloon false-front roof & hitching rail
b_fine:reload(p_hat_moon, 0.8)
b_fine:stroke({{60, 395}, {132, 395}}, {pressure=0.65})
b_fine:stroke({{0, 451}, {132, 442}}, {pressure=0.7})

-- Restate foreground hitching post & warm firelit right rim facing the blast
work(left_post + left_rail, {hand="detail", pile=p_wood_dark, coverage=1.5, load=0.85, clip=true})
b_fine:reload(p_wood_rim, 0.85)
b_fine:stroke({{91, 426}, {94, 526}}, {pressure=0.75}) -- firelit right edge of post
b_fine:reload(p_hat_moon, 0.8)
b_fine:stroke({{0, 452}, {134, 443}}, {pressure=0.65}) -- moonlit top edge of rail

-- 2. Improve Passage 2 (Right coat-to-hill gap at x=715..805, y=470..528)
local coat_hill_gap = poly({{715, 468}, {810, 468}, {810, 528}, {715, 528}}) - zombie_leg_l_m
work(coat_hill_gap, {hand="detail", pile=p_mesa, coverage=1.5, load=0.85, clip=true})
local lower_coat_shred = poly({{718, 455}, {785, 478}, {798, 518}, {732, 505}}, true)
work(lower_coat_shred, {hand="detail", pile=p_z_coat_dark, coverage=1.5, load=0.85, clip=true})

-- 3. Improve Passage 3 (Knit upper contour seam of zombie's outstretched right forearm, x=538..642, y=280..325)
local arm_upper_sky_seam = poly({{535, 276}, {645, 308}, {642, 326}, {532, 292}})
work(arm_upper_sky_seam, {hand="detail", pile=p_sky_deep, coverage=1.5, load=0.85, clip=true})
local b_edge = brush{kind="filbert", width=4.5, stiffness=0.65, lay=2}
b_edge:reload(p_z_mid, 0.85)
b_edge:gesture({{640, 326, 0.8}, {585, 306, 0.85}, {538, 290, 0.7}})
b_edge:reload(p_z_fire_lit, 0.85)
b_edge:gesture({{632, 356, 0.8}, {578, 334, 0.85}, {532, 314, 0.7}})

--@ chunk 10
print(wait(0))
